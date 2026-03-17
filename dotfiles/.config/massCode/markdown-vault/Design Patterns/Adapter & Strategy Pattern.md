---
contents:
  - id: 25
    label: Fragment 1
    language: markdown
createdAt: 1753118256395
description: null
folderId: 13
id: 14
isDeleted: 0
isFavorites: 0
name: Adapter & Strategy Pattern
tags:
  - 26
  - 27
  - 28
  - 30
  - 31
updatedAt: 1770884980733
---

## Fragment: Fragment 1
```markdown
# The Adapter Pattern
Its job is to make two incompatible interfaces work together. It acts as a translator. In our case, it translates the unique API response from each photo provider (like Pexels, Unsplash, etc.) into a single, unified format that our application can understand.

# The Strategy Pattern
Its job is to define a family of algorithms (in our case, different ways to fetch photos) and make them interchangeable. It lets the client (our app) choose which algorithm to use at runtime.

# The Problem
Incompatible Providers
Imagine our application needs to fetch photos. We start with two providers, Pexels and a hypothetical Corporate DAM (Digital Asset Management).

Their APIs return similar data, but in different "shapes":

Pexels API Response (GET api.pexels.com/v1/search?query=...):

```json
{
  "photos": [
    {
      "id": 8675309,
      "photographer": "John Doe",
      "src": {
        "original": "...",
        "large2x": "...",
        "medium": "https://images.pexels.com/photos/8675309/..."
      }
    }
  ]
}
```
Corporate DAM API Response (GET api.corp.com/assets?q=...):
```json
{
  "asset_results": [
    {
      "asset_id": "CUID-99a8-b7c6",
      "creator_name": "Jane Smith",
      "renditions": {
        "thumbnail_url": "...",
        "display_url": "https://assets.corp.com/images/99a8..."
      }
    }
  ]
}
```
## The Solution: Combining Adapters and a Strategy Manager

```ts
// src/services/photos/photo.types.ts

export interface IPhoto {
  id: string | number;
  author: string;
  displayUrl: string;
}

// This defines what any photo service adapter must be able to do.
export interface IPhotoAPI {
  searchPhotos(query: string): Promise<IPhoto[]>;
}
```
This is our contract. Every provider adapter must return an array of `IPhoto` objects.

## Pexels Adpter
```ts
// src/services/photos/PexelsAdapter.ts
import { IPhoto, IPhotoAPI } from './photo.types';

export class PexelsAdapter implements IPhotoAPI {
  async searchPhotos(query: string): Promise<IPhoto[]> {
    const response = await fetch(`https://api.pexels.com/v1/search?query=${query}`, {
      headers: { 'Authorization': 'YOUR_PEXELS_API_KEY' }
    });
    const data = await response.json();

    // The "adapting" happens here!
    // We map over the unique Pexels structure to our internal IPhoto structure.
    return data.photos.map((photo: any): IPhoto => ({
      id: photo.id,
      author: photo.photographer,
      displayUrl: photo.src.medium,
    }));
  }
}
```
## Corporate DAM Adapter:
```ts
// src/services/photos/CorporateDamAdapter.ts
import { IPhoto, IPhotoAPI } from './photo.types';

export class CorporateDamAdapter implements IPhotoAPI {
  async searchPhotos(query: string): Promise<IPhoto[]> {
    const response = await fetch(`https://api.corp.com/assets?q=${query}`);
    const data = await response.json();

    // Again, we adapt the unique structure to our internal IPhoto structure.
    return data.asset_results.map((asset: any): IPhoto => ({
      id: asset.asset_id,
      author: asset.creator_name,
      displayUrl: asset.renditions.display_url,
    }));
  }
}
```

# Implement the Strategy Manager (The "Service")
```ts
// src/services/photos/PhotoServiceManager.ts
import { IPhotoAPI } from './photo.types';
import { PexelsAdapter } from './PexelsAdapter';
import { CorporateDamAdapter } from './CorporateDamAdapter';

// Define the available providers
export type PhotoProvider = 'pexels' | 'corporate';

// A registry to hold instances of our adapters
const services: Record<PhotoProvider, IPhotoAPI> = {
  pexels: new PexelsAdapter(),
  corporate: new CorporateDamAdapter(),
};

// This is the public-facing service our app will use
export const PhotoServiceManager = {
  search: (provider: PhotoProvider, query: string) => {
    // 1. Look up the correct strategy (provider) from the registry
    const service = services[provider];

    if (!service) {
      throw new Error(`Provider '${provider}' not found.`);
    }

    // 2. Execute the strategy
    return service.searchPhotos(query);
  },
};
```
# How the UI Component Uses It
```tsx
// src/components/PhotoSearch.tsx
import React, { useState } from 'react';
import { PhotoServiceManager, PhotoProvider } from '../services/photos/PhotoServiceManager';
import { IPhoto } from '../services/photos/photo.types';

const PhotoSearch = () => {
  const [photos, setPhotos] = useState<IPhoto[]>([]);
  const [provider, setProvider] = useState<PhotoProvider>('pexels');
  const [query, setQuery] = useState('nature');

  const handleSearch = async () => {
    // The component simply calls the manager, passing in the desired strategy
    const results = await PhotoServiceManager.search(provider, query);
    setPhotos(results);
  };

  return (
    <div>
      {/* UI to select provider and enter query */}
      <select onChange={(e) => setProvider(e.target.value as PhotoProvider)}>
        <option value="pexels">Pexels</option>
        <option value="corporate">Corporate DAM</option>
      </select>
      <input type="text" value={query} onChange={(e) => setQuery(e.target.value)} />
      <button onClick={handleSearch}>Search</button>

      {/* The rendering logic works for any provider because the data is standardized */}
      <div>
        {photos.map(photo => (
          <div key={photo.id}>
            <img src={photo.displayUrl} alt={`Photo by ${photo.author}`} />
            <p>By: {photo.author}</p>
          </div>
        ))}
      </div>
    </div>
  );
};
```

```
