---
contents:
  - id: 29
    label: Fragment 1
    language: markdown
  - id: 31
    label: Token Optimized Skill
    language: markdown
createdAt: 1768081665651
description: null
folderId: 9
id: 18
isDeleted: 0
isFavorites: 0
name: Wide Event Logging
tags: []
updatedAt: 1768180621622
---

## Fragment: Fragment 1
```markdown
Implement wide events / canonical log lines in a service-oriented backend, with tail sampling, using structured JSON logs and (optionally) OpenTelemetry-compatible fields.[page:1]

---

## Goals

- Replace scattered string logs with **one** structured “wide event” per request per service hop.[page:1]  
- Enrich each event with high-cardinality and high-dimensionality business context (user, cart, payment, flags, etc.).[page:1]  
- Implement tail sampling to control cost while keeping all interesting events (errors, slow, VIP, flagged traffic).[page:1]  

---

## Requirements

- Emit structured JSON logs (key-value) for all wide events.[page:1]  
- Exactly one wide event per incoming request per service (log at the end of the request lifecycle, success or error).[page:1]  
- All logs must be query-friendly: no critical information should only exist inside free-form strings.[page:1]  
- Wide events should be compatible with being used as trace spans (trace_id / span_id / parent_id if tracing exists).[page:1]  

---

## Wide Event Schema

Implement a TypeScript type/interface for a wide event containing at least:

```ts
interface WideEvent {
  // Core request / infra context
  timestamp: string;               // ISO8601
  request_id: string;              // Correlates all logs for this request
  trace_id?: string;               // If tracing/OTel is available
  span_id?: string;
  parent_span_id?: string;
  service: string;                 // e.g. "checkout-service"
  version: string;                 // service version
  deployment_id?: string;          // deployment identifier
  region?: string;                 // e.g. "us-east-1"
  method: string;                  // HTTP method
  path: string;                    // HTTP route/path
  status_code: number;             // HTTP status
  duration_ms: number;             // Total request latency

  // Outcome
  outcome: "success" | "error";

  // User context (high-cardinality)
  user?: {
    id: string;
    subscription?: string;         // e.g. "free" | "premium" | "enterprise"
    account_age_days?: number;
    lifetime_value_cents?: number;
  };

  // Business / domain context
  cart?: {
    id: string;
    item_count: number;
    total_cents: number;
    coupon_applied?: string | null;
  };

  payment?: {
    method: string;                // "card" | "paypal" | ...
    provider: string;              // "stripe" | ...
    latency_ms: number;
    attempt: number;
  };

  // Error context
  error?: {
    type: string;                  // error class/type name
    code?: string;                 // application-specific error code
    message?: string;              // safe, non-PII message
    retriable?: boolean;
    // Provider-specific fields
    stripe_decline_code?: string;
  };

  // Feature flags / experiment context
  feature_flags?: Record<string, boolean>;

  // Arbitrary additional dimensions
  [key: string]: unknown;
}

```

## Fragment: Token Optimized Skill
```markdown
# Logging Skill — Actionable Spec (from loggingsucks.com)

## Core Insight

Text logs without context force grep-driven debugging. Prefer **structured, wide events** that capture request + business context in one queryable record.

---

## Invariants (Do / Don’t)

### Do

* **Emit 1 wide event per request per service** (one line/record)
* **Use structured JSON** (stable keys + types)
* **Accumulate context** during execution; **emit once** on completion
* **Capture both**:

  * **request/infra**: `timestamp`, `service`, `env`, `version`, `region`, `host`, `method`, `path`, `status_code`, `duration_ms`
  * **correlation**: `request_id`, `trace_id`, `span_id` (where available)
  * **business**: `user_id`, `account_id`, `plan`, `feature_flags`, `order_id`, `cart_value`, `payment_provider`, etc
  * **outcome**: `success`/`failure`, `error_code`, `error_type`, `retryable`, `dependency` info
* **Design for queries**: filter/group/aggregate via fields (not strings)
* **Tail-sample** after outcome known

### Don’t

* Don’t emit many micro log lines (“entered fn”, “calling db”)
* Don’t encode meaning only in freeform text
* Don’t omit business context (technical-only logs rarely answer “what broke for whom?”)
* Don’t assume OTel fixes semantics (it’s transport; you still choose what to emit)

---

## Definitions

* **Structured log**: machine-readable key/value event (JSON)
* **Wide event**: one record with all relevant request + business context
* **Cardinality**: unique-value count in a field (e.g., `user_id` high)
* **Dimensionality**: number of fields available for querying

---

## Implementation Pattern (middleware-driven)

### 1) Request start (create mutable event)

```json
{
  "timestamp": "2026-01-11T01:23:45.678Z",
  "service": "api",
  "env": "prod",
  "version": "1.2.3",
  "region": "us-west-2",
  "request_id": "req_01H...",
  "trace_id": "4bf92f3577b34da6a3ce929d0e0e4736",
  "method": "POST",
  "path": "/checkout"
}
```

### 2) During handling (enrich, don’t emit)

```json
{
  "user_id": "u123",
  "account_id": "a9",
  "plan": "pro",
  "feature_flags": ["new_pricing"],
  "order_id": "o456",
  "cart_value": 149.99,
  "payment_provider": "stripe"
}
```

### 3) Completion (finalize + emit exactly once)

```json
{
  "status_code": 500,
  "duration_ms": 842,
  "success": false,
  "error_code": "CARD_DECLINED",
  "error_type": "PaymentError",
  "retryable": false
}
```

### Practical notes

* Prefer **one canonical event name** (e.g., `request.completed`) with optional nested objects (`http`, `user`, `order`, `db`, `deps`).
* Keep keys consistent across services; add fields via additive evolution.

---

## Tail Sampling (cost control)

Evaluate sampling after the wide event is complete.

Always keep if any:

* `status_code >= 500` or `success == false`
* `duration_ms` above SLO / p99 threshold
* VIP / high-value user/account
* feature flag in allowlist (risky/rollout)

Else:

* sample at N% (configurable)

---

## Query Model (examples)

* Count failures by `error_code` where `plan="pro"` and `feature_flags` contains `"new_pricing"`
* Find slow requests where `path="/checkout"` and `duration_ms > 1000` grouped by `payment_provider`
* Slice error rates by `region` and `version`

---

## Mental Model

Logs are **queryable records of business events**, not human diary lines. If you can’t answer “who/what/when/how long/why” via fields, the event is under-instrumented.

```
