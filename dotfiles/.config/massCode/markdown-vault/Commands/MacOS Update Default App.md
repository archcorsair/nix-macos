---
contents:
  - id: 26
    label: Fragment 1
    language: sh
createdAt: 1754682524257
description: null
folderId: 8
id: 15
isDeleted: 0
isFavorites: 0
name: MacOS Update Default App
tags:
  - 32
  - 33
updatedAt: 1754682625859
---

## Fragment: Fragment 1
```sh
# This is how I was able to set a no-extension file "config" (Ghostty's config) to open in Zed by default:
defaults write ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist LSHandlers -array-add '{LSHandlerContentType=public.data;LSHandlerRoleAll=dev.zed.Zed;}'
```
