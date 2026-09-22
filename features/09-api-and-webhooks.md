# 开放 API、密钥与 Webhook

- 优先级：P2（集成型产品为 P0）
- 当前基础：已有版本化 API、分页、搜索及文档工具
- 文档状态：设计草案，尚未按本文实现与验收
- 依赖：02、03、06、14。

## 需求

- 组织可创建、轮换和撤销 API Key，并限制用途、权限与有效期。
- 外部应用可订阅业务事件；投递失败可重试并查看记录。
- API 有稳定错误码、分页、版本策略和速率限制。

## 设计

- `ApiKey(organization_id, created_by_id, prefix, secret_digest, scopes, expires_at, revoked_at, last_used_at)`；明文仅创建时展示，日志只记 prefix。
- Key 属于组织服务身份，权限为 key scopes 与组织策略/权益交集；默认创建者被移除时撤销其 key，如需独立服务账号另建显式归属。
- `WebhookEndpoint(organization_id, url, encrypted_secret, event_types, status)` 和 `WebhookDelivery(endpoint_id, event_id, status, attempts, next_attempt_at, response_code)`，endpoint/event 唯一。
- `POST/GET/DELETE .../api_keys`、`POST/GET/PATCH/DELETE .../webhook_endpoints`、`GET .../webhook_deliveries`、`POST .../webhook_deliveries/:id/retry`。
- 事件含 event_id、type、version、occurred_at、data；用 timestamp + 原始正文做 HMAC 签名，接收方按 event_id 去重，提供签名与轮换说明。
- 仅允许 HTTPS；在注册和每次投递时拒绝回环、私网、链路本地及元数据地址，覆盖 IPv4/IPv6、DNS 重绑定；禁用重定向并限制出站网络。
- 投递采用至少一次语义，指数退避加抖动、最大次数和响应超时；手动重试也记录审计。

## 实现步骤

1. 为现有 API 增加 scoped service identity 鉴权、字段过滤、分页上限和稳定错误协议。
2. 实现 Key 摘要验证、到期与撤销；高风险 scopes 单独授权。
3. 业务 outbox 产生事件，GoodJob 负责签名投递；实现失败列表和安全重放。
4. 更新 OpenAPI 和接入样例，说明幂等、版本兼容和限流头。

## 验收标准

- [ ] 撤销、过期、权限不足与跨组织 Key 被拒绝。
- [ ] Webhook 无法访问内部网络；地址变化和跳转也不能绕过限制。
- [ ] 投递重试保持同一 event_id；签名可验证，秘密不出现在查询响应。
- [ ] 高频调用得到 429 和 Retry-After，不阻塞正常租户。

## 实施前确认

- 按 [统一架构约定](00-architecture.md) 核对数据归属、权限、幂等及兼容性。
- 将涉及的产品参数、供应商选择和历史数据处理写入本模块的决策记录；本文默认值可以修改，但需同步依赖模块。
- 开工后补充实际变更文件、迁移结果、测试证据及上线/回滚记录；完成验收后才将状态改为已实现。
