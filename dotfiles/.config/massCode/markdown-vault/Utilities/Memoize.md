---
contents:
  - id: 23
    label: Stable Memoize (With replacer)
    language: javascript
  - id: 24
    label: Standard Memoize
    language: javascript
createdAt: 1752521179318
description: null
folderId: 7
id: 13
isDeleted: 0
isFavorites: 0
name: Memoize
tags:
  - 24
  - 25
updatedAt: 1752521245687
---

## Fragment: Stable Memoize (With replacer)
```javascript
function memoize(func) {
  const cache = new Map()

  const replacer = (_, value) => {
    if (!Array.isArray(value) && typeof value === "object" && value !== null) {
      const sortedValues = {}
      Object.values(value)
        .sort()
        .forEach((sortedKey) => {
          sortedValues[sortedKey] = value[sortedKey]
        })
      return sortedValues
    }
    return value
  }

  return (...args) => {
    const normalized = JSON.stringify(args, replacer)
    if (cache.has(normalized)) {
      return cache.get(normalized)
    }

    const result = func.apply(this, args)
    cache.set(normalized, result)
    return result
  }
}

```

## Fragment: Standard Memoize
```javascript
function memoize(func) {
  const cache = new Map();
  
  return function (arg) {
    if (!cache.has(arg)) {
      const result = func.call(this, arg);
      cache.set(arg, result);
      return result;
    }
    return cache.get(arg);
  };
}
```
