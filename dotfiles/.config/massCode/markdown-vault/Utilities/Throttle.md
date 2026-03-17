---
contents:
  - id: 20
    label: Fragment 1
    language: javascript
createdAt: 1752384407127
description: null
folderId: 7
id: 10
isDeleted: 0
isFavorites: 0
name: Throttle
tags:
  - 22
  - 21
updatedAt: 1752384430167
---

## Fragment: Fragment 1
```javascript
function throttle(func, delay, options = { trailing: false }) {
  const { trailing } = options
  let throttled = false
  let savedArgs = null
  return (...args) => {
    if (trailing && throttled) {
      savedArgs = args
      return
    }
    if (!throttled) {
      func.apply(this, args)
      throttled = true
      setTimeout(() => {
        throttled = false
        if (savedArgs !== null) {
          func.apply(this, savedArgs)
          savedArgs = null
        }
      }, delay)
    }
  }
}

function log(message) {
  return console.log(message)
}

const throttledLog = throttle(log, 1500, { trailing: true })
```
