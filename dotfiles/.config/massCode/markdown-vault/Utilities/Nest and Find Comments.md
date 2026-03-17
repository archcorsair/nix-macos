---
contents:
  - id: 18
    label: Fragment 1
    language: javascript
createdAt: 1752366971089
description: null
folderId: 7
id: 8
isDeleted: 0
isFavorites: 0
name: Nest and Find Comments
tags:
  - 15
  - 19
  - 20
updatedAt: 1752366982972
---

## Fragment: Fragment 1
```javascript
const comments = [
  { id: "c1", text: "This is the first comment", parentId: null },
  { id: "c2", text: "This is a reply to the first", parentId: "c1" },
  { id: "c3", text: "This is another top-level comment", parentId: null },
  { id: "c4", text: "A reply to the reply", parentId: "c2" },
  { id: "c5", text: "Another reply to the first comment", parentId: "c1" },
];

function nestComments(comments) {
  const list = {};
  const result = [];

  comments.forEach((comment) => {
    if (!Object.hasOwn(list, comment.id)) {
      list[comment.id] = { ...comment, children: [] };
    }
  });

  for (const comment in list) {
    const parent = list[comment].parentId;
    if (parent) {
      list[parent].children.push(list[comment]);
    } else {
      result.push(list[comment]);
    }
  }
  return result;
}

const nested = nestComments(comments);

function findCommentById(tree, id) {
  const queue = [...tree];
  while (queue.length) {
    const node = queue.shift();
    if (node?.children?.length) {
      queue.push(...node.children);
    }
    if (node?.id === id) return node;
  }
  return null;
}

console.log(findCommentById(nested, "c1"));

```
