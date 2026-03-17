---
contents:
  - id: 33
    label: Fragment 1
    language: nu
createdAt: 1769982852668
description: null
folderId: 8
id: 21
isDeleted: 0
isFavorites: 0
name: Get Homebridge Token
tags:
  - 34
  - 35
updatedAt: 1772954887436
---

## Fragment: Fragment 1
```nu
# get_homebridge_token.nu
#
# Generate a Homebridge UI token from hb.danielshneyder.com using NuShell.

# --- CONFIG: change these values ---
let host = "https://hb.danielshneyder.com"
let username = "archcorsair"              # your Homebridge UI username
let password = "ngj8vzv4ncw.hgn9XDV"   # your Homebridge UI password
let expires_in = (30 * 24 * 60 * 60)
# -----------------------------------

# Compose the login URL
let login_url = $"($host)/api/auth/login"

# Build the JSON body as a NuShell record, then to JSON
let body = {
  username: $username
  password: $password
  expires_in: $expires_in
} | to json

# Call the Homebridge UI login endpoint
let response = (http post $login_url $body --content-type "application/json")

# If the server didn’t return an object with access_token, show error + body and exit
if not ($response | get access_token? | is-not-empty) {
  print "Error: no access_token in response. Full response:"
  print $response
  exit 1
}

# Extract and print just the token
let token = $response.access_token
print $token 
```
