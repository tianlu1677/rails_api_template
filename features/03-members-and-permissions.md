# 成员、邀请与权限

- 优先级：P0
- 当前基础：待实现
- 文档状态：设计草案，尚未按本文实现与验收
- 依赖：01、02；邀请邮件依赖 07。

## 需求

- 组织可邀请成员、撤销邀请、调整角色、移除成员和转移所有权。
- 默认角色为 owner、admin、member、viewer；用户不能提升自己的权限。
- 至少保留一位 owner；邀请接受前不取得业务权限。

## 设计

- `Membership` 对 `(organization_id, user_id)` 建唯一索引；角色属于成员关系，不能放在全局 User 上。
- `Invitation(organization_id, normalized_email, role, token_digest, expires_at, accepted_at, revoked_at, invited_by_id)`；每个组织每个邮箱至多一个有效待处理邀请。
- owner 可管理账单、所有权和组织删除；admin 管理普通成员与业务资源；member 读写业务资源；viewer 只读。admin 不得授予 owner、管理 owner 或提升自身。
- 使用统一 Policy 对 action 和 scope 鉴权，默认拒绝；前端隐藏按钮仅用于体验。
- 拟新增 `GET .../members`、`PATCH/DELETE .../members/:id`、`POST .../invitations`、`DELETE .../invitations/:id`、`POST /api/v1/invitations/accept`、`POST .../ownership_transfer`；新增成员仅经邀请接受，不开放直接创建成员的公共接口。
- 接受邀请要求登录并持有已验证的目标邮箱；锁定邀请及组织配额记录，事务内创建成员并消耗席位。

## 实现步骤

1. 建立固定权限矩阵和 Policy 类；覆盖所有租户控制器、导出及后台入口。
2. 实现邀请发送、过期、撤销、重发；重发轮换 Token，使旧链接失效。
3. 统一以组织行锁串行处理移除 owner、角色变更和所有权转移，阻止并发删除最后 owner。
4. 权限变更立即失效权限缓存；移除成员不删除该用户及其他组织成员关系。
5. 席位不足时保留邀请待处理并返回明确错误，允许升级后重新接受。

## 验收标准

- [ ] 每个角色的允许与拒绝路径都有请求测试。
- [ ] 其他邮箱、过期、撤销、重复使用的邀请均无法新增成员。
- [ ] 并发接受不会重复成员或超卖席位；并发移除不会留下无 owner 组织。
- [ ] 成员移除后已有 JWT 不能继续访问该组织。

## 实施前确认

- 按 [统一架构约定](00-architecture.md) 核对数据归属、权限、幂等及兼容性。
- 将涉及的产品参数、供应商选择和历史数据处理写入本模块的决策记录；本文默认值可以修改，但需同步依赖模块。
- 开工后补充实际变更文件、迁移结果、测试证据及上线/回滚记录；完成验收后才将状态改为已实现。
