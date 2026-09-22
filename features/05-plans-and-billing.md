# 套餐、订阅与支付

- 优先级：P0（收费产品）
- 当前基础：待实现
- 文档状态：设计草案，尚未按本文实现与验收
- 依赖：02、03、06、07；事件处理基础见架构约定。

## 需求

- 展示免费/付费套餐、月付/年付价格；支持试用、开通、升级、降级和到期取消。
- owner 可查看账单、更新支付方式；支付失败有提醒和宽限期。
- 支付渠道、币种、税务票据及退款规则在接入前确定；免费产品可暂不实现本模块。

## 设计

- 拟新增 `Plan(code, version, entitlements)`、`Price(plan_id, currency, amount_minor, interval, provider_price_id)`、`BillingAccount(organization_id, provider, external_customer_id)`、`Subscription(organization_id, price_id, provider_subscription_id, status, current_period_end, trial_ends_at, cancel_at_period_end)`。
- 套餐价格版本化，历史订阅引用原版本；每组织仅一个当前主订阅，用数据库约束防止并发重复创建。
- 本地访问状态：trialing / active 可用；past_due 在明确宽限截止前保留原权益、之后只读；canceled / expired 回落免费权益；incomplete 不授予付费权限。保留渠道原始状态并单独映射。
- 升级需渠道确认后生效，差价以渠道预览为准；降级和取消默认周期末生效。超额数据保留但限制新增，不自动删除。
- 拟新增 `GET /api/v1/plans`、`GET .../subscription`、`POST .../billing/checkout`、`POST .../billing/portal`、`POST .../subscription/change`、`POST .../subscription/cancel`、`GET .../invoices`。
- 渠道回调 `POST /webhooks/billing/:provider` 验签后持久化为 `BillingEvent(provider, event_id, payload, status)`，联合唯一去重；浏览器支付成功跳转不授予权益。
- 乱序事件通过渠道最新快照或版本校验收敛；定时对账修复遗漏。金额和套餐 ID 由服务端解析，回跳 URL 必须在白名单内。
- 不保存完整卡号/CVV；托管支付页和账单门户通过适配器接入，具体供应商尚未选择。

## 实现步骤

1. 先确定收费规则、宽限期、试用资格、退款及取消规则，保存为套餐配置和测试用例。
2. 实现 Billing 适配器与套餐目录，使用沙盒打通 checkout、portal 和 webhook。
3. 对 checkout、变更、退款等外部写入持久化幂等键；外部请求放在可恢复任务中，不持有长数据库事务。
4. 验签成功且事件可靠落库后应答；任务锁定订阅更新本地状态与权益，并通过 outbox 产生通知。
5. 增加对账任务、人工异常处理、失败提醒与账单只读页面；退款需独立授权和审计。

## 验收标准

- [ ] 回调重复或乱序不重复发放权益、发送扣款请求或产生账单副作用。
- [ ] 伪造回调、伪造价格、其他租户账单请求被拒绝。
- [ ] 支付失败、试用到期、取消续费、升级降级和超限均符合状态规则。
- [ ] 支付渠道超时或回调丢失后可以重试与对账恢复。

## 实施前确认

- 按 [统一架构约定](00-architecture.md) 核对数据归属、权限、幂等及兼容性。
- 将涉及的产品参数、供应商选择和历史数据处理写入本模块的决策记录；本文默认值可以修改，但需同步依赖模块。
- 开工后补充实际变更文件、迁移结果、测试证据及上线/回滚记录；完成验收后才将状态改为已实现。
