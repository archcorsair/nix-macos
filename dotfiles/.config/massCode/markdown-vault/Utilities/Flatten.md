---
contents:
  - id: 22
    label: Fragment 1
    language: javascript
createdAt: 1752469154543
description: null
folderId: 7
id: 12
isDeleted: 0
isFavorites: 0
name: Flatten
tags:
  - 23
  - 13
updatedAt: 1752469160828
---

## Fragment: Fragment 1
```javascript
const nestedArray = [1, [2, 3], [4, [5, 6, [7]]], 8]

// Recursive Solution
function flatten(input) {
  const result = []

  const helper = (el) => {
    if (Array.isArray(el)) {
      el.forEach((e) => {
        helper(e)
      })
    } else {
      result.push(el)
    }
  }

  helper(input)
  return result
}

// Iterative Solution
function flattenWithQueue(input) {
  const result = []
  for (let i = 0; i < input.length; i++) {
    const queue = []
    if (Array.isArray(input[i])) {
      queue.push(...input[i])
      while (queue.length) {
        const nextEl = queue.shift()
        if (Array.isArray(nextEl)) {
          queue.push(...nextEl)
        } else {
          result.push(nextEl)
        }
      }
    } else {
      result.push(input[i])
    }
  }
  return result
}
// Using a Stack (Most Optimal Iterative Solution)
function flattenWithStack(input) {
  const stack = [...input]
  const result = []

  while (stack.length) {
    const nextEl = stack.pop()
    if (Array.isArray(nextEl)) {
      stack.push(...nextEl)
    } else {
      result.push(nextEl)
    }
  }

  return result.reverse()
}

console.log(flattenWithStack(nestedArray))

```
