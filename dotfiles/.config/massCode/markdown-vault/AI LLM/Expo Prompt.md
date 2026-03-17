---
contents:
  - id: 27
    label: Fragment 1
    language: markdown
createdAt: 1762045995540
description: null
folderId: 9
id: 16
isDeleted: 0
isFavorites: 0
name: Expo Prompt
tags: []
updatedAt: 1762046057022
---

## Fragment: Fragment 1
```markdown
# Native iOS
- ALWAYS use only Expo modules API.
- Prefer Swift and Kotlin.
- New Architecture only. NEVER support legacy React Native architecture.
- Design native APIs as if you contributing W3C specs for the browser, take inspiration from modern web modules. eg 'std: kv-storage" ,clipboard.
- Prefer string union types for API options instead of boolean flags, enums, or multiple parameters. eg instead of capture(options: {isHighQuality: boolean })', use capture(options: { quality: "high' |
'medium' | 'low' })
- Use optionality for availability checks as opposed to extraneous "isAvailable" functions or constants. eg
"snapshot. capture?. () instead of snapshot. isAvailable && snapshot. capture().

## Views
Prefer functions on views instead of 'useImperativeHandle + 'findNodeHandle.
```swift
AsyncFunction ("capture") { (view, options: Options) -> Ref in
	return try capture(self. appContext, view)
}
```

```
