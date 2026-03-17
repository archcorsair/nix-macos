---
contents:
  - id: 32
    label: Fragment 1
    language: javascript
createdAt: 1768455208137
description: null
folderId: 7
id: 20
isDeleted: 0
isFavorites: 0
name: Calculate Bearing - 2 points
tags: []
updatedAt: 1769301549176
---

## Fragment: Fragment 1
```javascript
function calculateBearing(from: Position, to: Position): number {
  const toRad = (deg: number) => (deg * Math.PI) / 180;
  const toDeg = (rad: number) => (rad * 180) / Math.PI;

  const lat1 = toRad(from[0]);
  const lat2 = toRad(to[0]);
  const deltaLng = toRad(to[1] - from[1]);

  const x = Math.sin(deltaLng) * Math.cos(lat2);
  const y =
    Math.cos(lat1) * Math.sin(lat2) -
    Math.sin(lat1) * Math.cos(lat2) * Math.cos(deltaLng);

  const bearing = toDeg(Math.atan2(x, y));
  return (bearing + 360) % 360;
}
```
