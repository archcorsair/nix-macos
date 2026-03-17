---
contents:
  - id: 21
    label: Fragment 1
    language: javascript
createdAt: 1752390422173
description: null
folderId: 7
id: 11
isDeleted: 0
isFavorites: 0
name: Event Emitter
tags: []
updatedAt: 1763348942544
---

## Fragment: Fragment 1
```javascript
class EventEmitter {
  constructor() {
    this.subscriptions = new Map()
  }

  on(name, func) {
    if (!this.subscriptions.has(name)) {
      this.subscriptions.set(name, [func])
    } else {
      const subscribers = this.subscriptions.get(name)
      subscribers.push(func)
    }
    return this
  }

  emit(event, ...args) {
    if (this.subscriptions.has(event)) {
      const funcs = this.subscriptions.get(event)
      funcs.forEach((func) => {
        func.apply(this, args)
      })
    }
    return this
  }

  off(name, func) {
    if (this.subscriptions.has(name)) {
      const funcs = this.subscriptions.get(name)
      const filtered = funcs.filter((f) => f !== func)
      if (!filtered.length) {
        this.subscriptions.delete(name)
      } else {
        this.subscriptions.set(name, filtered)
      }
    }
    return this
  }

  once(name, func) {
    const onceFunc = (...args) => {
      func.apply(this, args)
      this.off(name, onceFunc)
    }
    this.on(name, onceFunc)
    return this
  }
}

```
