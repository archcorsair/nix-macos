---
contents:
  - id: 19
    label: Fragment 1
    language: javascript
createdAt: 1752373154088
description: null
folderId: 7
id: 9
isDeleted: 0
isFavorites: 0
name: Debounce
tags:
  - 21
  - 22
updatedAt: 1752373160854
---

## Fragment: Fragment 1
```javascript
function debounce(func, delay, options = { leading: false }) {
  const { leading } = options
  let id = null
  return (...args) => {
    clearTimeout(id)
    if (leading && id === null) {
      func.apply(this, args)
    }

    id = setTimeout(() => {
      if (!leading) {
        func.apply(this, args)
      }
      id = null
    }, delay)
  }
}
```
