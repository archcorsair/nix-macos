---
contents:
  - id: 30
    label: Fragment 1
    language: markdown
createdAt: 1768081702603
description: null
folderId: 9
id: 19
isDeleted: 0
isFavorites: 0
name: AGENTS.md
tags: []
updatedAt: 1769301590866
---

## Fragment: Fragment 1
```markdown
```md
**Last Updated: 01/10/2026**

## Core Philosophy

- Safety → Performance → Developer Experience
- Zero technical debt
- Think twice, code once

## Communication (Ambiguity Handling)

- Ambiguity must be surfaced explicitly; do not invent questions
- Ambiguity blocks planning and coding until resolved
- Hard execution order: **clarify → plan → code**
- For low-impact, non-behavioral ambiguity, call it out and request confirmation
- For high-impact changes (public APIs, behavior, data models, security, performance-sensitive paths, broad refactors), propose a plan and wait for confirmation before coding

## Committing Instructions / Practices

- Use conventional commits
- Commits represent **logical units of change**; one concern per commit
- Refactors must be isolated from functional changes unless inseparable
- Commit messages describe **intent**, not implementation
- Breaking changes must be explicit in commit type or footer
- Prefer smaller commits that preserve narrative readability
- Temporary technical debt must be called out in the commit body
- Generated files are committed only if required by the project
- Squashing is allowed only if it preserves intent and reviewability
- Never amend or rewrite history unless explicitly instructed
- No AI attribution in commits

## Fundamentals

- Prefer minimal, targeted changes; do not refactor opportunistically
- Preserve existing architecture, patterns, and conventions unless explicitly changing them
- Avoid speculative abstractions and magic behavior; prefer explicit design
- No implicit defaults; require explicit configuration or fail loudly
- Never introduce global state or bypass validation, safety checks, or guardrails without approval
- Dependency additions require justification and must go through the package manager
- Remove unused code only if it is provably dead and safe to delete
- Feature-based organization is preferred over layer-based when introducing new structure
- No barrel files unless explicitly configured
- Respect `tsconfig.json` path aliases; do not add, remove, or modify aliases without explicit approval
- When needing to run `grep` instead prefer `rg --vimgrep --smart-case "search_pattern" .`

## Linting & Formatting

- Prefer **Biome** for linting and formatting
- Always respect rules defined in `biome.json` or `biome.jsonc`
- If a Biome config is missing, create it **only** via `biome init`
- Never manually create or guess a Biome configuration file

## Default Tech Stack

*(Apply these defaults unless overridden by project-level configuration)*

- **Language:** TypeScript / Node.js
- **Frontend:** Vite, React, TanStack Query, Tailwind CSS
- **Runtime / Package Manager:** Bun

## Documentation

- Use **context7** only when first interacting with a new or unfamiliar library, framework, package, API, or tool
- Do not over-fetch documentation; avoid context7 for already-validated APIs
- Prefer authoritative and current upstream documentation
- When docs and code disagree, defer to code and call out the discrepancy
- Cite library and version when relying on documented behavior
- Avoid cargo-culting examples; document **why**, not **what**
- Keep documentation concise and colocated with relevant code

## Type Safety

- Never escape the type system; avoid `any`, unsafe casts, and forced coercions
- Prove types via narrowing, control flow, and generics
- Prefer explicit types for function signatures, exports, and public APIs; allow inference for locals
- Use sum types or enums over magic values
- Model invalid states as unrepresentable
- Redesign data structures instead of weakening types
- Prefer optional chaining and proper narrowing over non-null assertions
- Runtime boundaries must not trust static types blindly
- Use the LSP to explore types instead of guessing

## Testing

- Tests verify observable behavior and fail for the right reason
- Prefer deterministic tests; avoid timing, randomness, and global state
- Prefer small, focused tests over brittle ones
- Test edge cases, invalid inputs, and failure modes
- Mock at boundaries only; prefer dependency injection over magic mocks
- Update or remove tests when behavior changes
- Unit tests for business logic and integration tests for APIs are defaults unless overridden
- Follow existing test structure; introduce one only if missing

## Logging

- Log meaningful, goal-aligned events; avoid noise
- Use structured logs (JSON) with consistent fields
- Use appropriate log levels; avoid overuse of `info`
- Include relevant metadata (request ID, user ID, trace or span IDs)
- Never log secrets, credentials, tokens, or PII
- Logs must not change behavior or control flow
- Avoid logging in hot paths without justification
- Errors must include enough context to debug safely
- Allow verbose logging in development/debug builds only; disable in production

## Error Handling

- Use typed/custom errors or explicit Result types
- Never swallow errors; avoid catch-all handlers without handling or rethrow
- Errors must include actionable context and preserve original causes
- Distinguish recoverable vs fatal errors explicitly
- Avoid throwing raw strings or untyped errors
- Errors must not leak secrets, PII, or internal details
- Fail fast when invariants are violated

### Error Typing

- Errors from unknown sources must be typed as `unknown`, never `any`
- Narrow errors using explicit guards or predicates
- Do not assume third-party error shapes without validation
- Normalize external errors into typed internal representations
- Add context before rethrowing unknown errors

## Security / Trust Boundaries

- Treat all external input as untrusted by default
- Validate inputs at system boundaries; never trust types alone
- Do not weaken or bypass auth or authz checks
- Never add network calls, telemetry, or data exfiltration without approval
- Secrets must come from secure configuration, never code
- Preserve least-privilege access patterns
- Avoid dynamic code execution or unsafe deserialization
- Security-relevant changes require explicit callout and confirmation

## Agent Autonomy / Refactor Limits

- Do not perform broad or structural refactors unless explicitly requested or required
- Refactors must be behavior-preserving by default
- Do not rename public APIs, files, or exports without approval
- Do not change observable behavior unless instructed
- Separate refactors from functional changes unless inseparable
- Do not delete code unless provably dead or explicitly requested
- Call out backward-compatibility risks explicitly
- Stop and ask when impact is uncertain

## Performance Discipline

- Do not optimize prematurely; prioritize correctness and safety
- Measure before optimizing; use profiling or benchmarks
- Optimize only proven hot paths or bottlenecks
- Avoid micro-optimizations without data
- Performance changes must not reduce correctness, safety, or clarity
- Call out tradeoffs and regressions explicitly

## Overrides & Precedence

- Global `AGENTS.md` applies by default
- Project-level `AGENTS.md` may extend or specialize global rules
- Project rules override global rules only when explicit
- Project rules may tighten but not weaken safety, security, or correctness
- Conflicts must be explicit
- When uncertain which rule applies, stop and ask
```
```
