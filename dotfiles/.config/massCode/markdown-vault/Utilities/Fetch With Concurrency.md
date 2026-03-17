---
contents:
  - id: 17
    label: Fragment 1
    language: javascript
createdAt: 1752354858646
description: null
folderId: 7
id: 7
isDeleted: 0
isFavorites: 0
name: Fetch With Concurrency
tags:
  - 16
  - 17
  - 18
updatedAt: 1753161420735
---

## Fragment: Fragment 1
```javascript
const urlList = [
  "https://pokeapi.co/api/v2/pokemon?offset=0&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=5&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=10&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=15&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=20&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=25&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=30&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=35&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=40&limit=5",
  "https://pokeapi.co/api/v2/pokemon?offset=45&limit=5",
];

async function fetchAllWithConcurrency(urls, concurrencyLimit) {
  const results = new Array(urls.length);
  const queue = [...urls.map((url, index) => ({ url, index }))];
  let tasksCompleted = 0;

  return new Promise((resolve) => {
    const worker = async () => {
      while (tasksCompleted < urls.length) {
        const task = queue.shift();
        if (!task) break; // Queue is empty

        try {
          const response = await fetch(task.url);
          if (!response.ok)
            throw new Error(`HTTP error! status: ${response.status}`);
          const data = await response.json();
          results[task.index] = { status: "fulfilled", value: data };
        } catch (error) {
          results[task.index] = { status: "rejected", reason: error.message };
        } finally {
          tasksCompleted++;
        }
      }
      if (tasksCompleted === urls.length) {
        resolve(results);
      }
    };

    for (let i = 0; i < concurrencyLimit; i++) {
      worker();
    }
  });
}

const LIMIT = 3

console.log(fetchAllWithConcurrency(urlList, LIMIT).then((result) => console.log(result)));
```
