---
contents:
  - id: 37
    label: Fragment 1
    language: sh
createdAt: 1771297742534
description: null
folderId: 8
id: 25
isDeleted: 0
isFavorites: 0
name: MacOS Remove App from Quarantine
tags:
  - 33
  - 38
updatedAt: 1771297886755
---

## Fragment: Fragment 1
```sh
sudo xattr -r -d com.apple.quarantine /Applications/<name>.app

```
