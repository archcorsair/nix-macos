---
contents:
  - id: 1
    label: Main Implementation
    language: typescript
  - id: 3
    label: Example Usage
    language: tsx
  - id: 4
    label: Testing Cohort Distribution
    language: typescript
  - id: 5
    label: Testing
    language: tsx
  - id: 6
    label: Remote Flag Loading
    language: tsx
createdAt: 1751863348226
description: Feature Flag Bucketing Implementation and Usage Examples
folderId: 7
id: 1
isDeleted: 0
isFavorites: 0
name: Feature Flag Bucketing
tags:
  - 2
  - 3
  - 4
  - 5
  - 6
updatedAt: 1752373201233
---

## Fragment: Main Implementation
```typescript
/**
 * Hashes a string into a consistent number using a simple hash function.
 * The result is modded into a range of 0–99.
 */

export function getUserBucket(userId: string, salt: string = ''): number {
  const input = `${salt}|${userId}`;
  let hash = 0;

  for (let i = 0; i < input.length; i++) {
    hash = (hash << 5) - hash + input.charCodeAt(i);
    hash |= 0; // Convert to 32bit integer
  }

  return Math.abs(hash) % 100;
}

/**
 * Returns whether a given user falls within the rollout percentage for a given feature.
 *
 * @param userId Unique user identifier (e.g. from auth)
 * @param rolloutPercentage Integer between 0–100
 * @param featureKey Unique string used to isolate cohort (e.g. "enable-new-search")
 */
export function isFeatureEnabledForUser(
  userId: string,
  rolloutPercentage: number,
  featureKey: string
): boolean {
  if (rolloutPercentage <= 0) return false;
  if (rolloutPercentage >= 100) return true;

  const bucket = getUserBucket(userId, featureKey);
  return bucket < rolloutPercentage;
}
```

## Fragment: Example Usage
```tsx
const userId = "user_abc123";
const rollout = 10; // 10%
const feature = "new-dashboard-redesign";

const isEnabled = isFeatureEnabledForUser(userId, rollout, feature);

console.log(`${isEnabled ? "✅" : "❌"} Feature is ${isEnabled ? "ON" : "OFF"} for ${userId}`);

// React Context Example //
// FeatureFlagProvider.tsx
import React, { createContext, useContext, useMemo } from "react";
import { isFeatureEnabledForUser } from "./featureFlags";

type FlagConfig = {
  [featureKey: string]: number; // rollout percentage 0–100
};

type FeatureFlagContextType = {
  isFeatureEnabled: (featureKey: string) => boolean;
};

const FeatureFlagContext = createContext<FeatureFlagContextType | undefined>(undefined);

type FeatureFlagProviderProps = {
  userId: string;
  config: FlagConfig;
  children: React.ReactNode;
};

export const FeatureFlagProvider: React.FC<FeatureFlagProviderProps> = ({ userId, config, children }) => {
  const enabledMap = useMemo(() => {
    const result: Record<string, boolean> = {};
    for (const [key, rollout] of Object.entries(config)) {
      result[key] = isFeatureEnabledForUser(userId, rollout, key);
    }
    return result;
  }, [userId, config]);

  const contextValue = useMemo(() => ({
    isFeatureEnabled: (featureKey: string) => enabledMap[featureKey] === true,
  }), [enabledMap]);

  return (
    <FeatureFlagContext.Provider value={contextValue}>
      {children}
    </FeatureFlagContext.Provider>
  );
};

export const useFeatureFlag = (featureKey: string): boolean => {
  const context = useContext(FeatureFlagContext);
  if (!context) {
    throw new Error("useFeatureFlag must be used within a FeatureFlagProvider");
  }
  return context.isFeatureEnabled(featureKey);
};

// Usage In App //
// App.tsx
import { FeatureFlagProvider } from "./FeatureFlagProvider";

const FEATURE_CONFIG = {
  "enable-new-search": 10,
  "enable-dark-mode": 100,
};

const App = () => {
  const userId = "user_abc123"; // from auth context or cookie

  return (
    <FeatureFlagProvider userId={userId} config={FEATURE_CONFIG}>
      <HomePage />
    </FeatureFlagProvider>
  );
};

// Usage in a component //
// HomePage.tsx
import { useFeatureFlag } from "./FeatureFlagProvider";

const HomePage = () => {
  const showNewSearch = useFeatureFlag("enable-new-search");

  return (
    <div>
      {showNewSearch ? <NewSearch /> : <LegacySearch />}
    </div>
  );
};
```

## Fragment: Testing Cohort Distribution
```typescript
const users = Array.from({ length: 1000 }, (_, i) => `user_${i}`);
const enabledCount = users.filter(userId =>
  isFeatureEnabledForUser(userId, 10, "test-feature")
).length;

console.log(`Enabled for ${enabledCount} out of 1000 users (~${enabledCount / 10}% expected)`);
```

## Fragment: Testing
```tsx
// HomePage.test.tsx
jest.mock('./FeatureFlagProvider', () => ({
  useFeatureFlag: jest.fn(),
}));

import { useFeatureFlag } from './FeatureFlagProvider';
import { render, screen } from '@testing-library/react';
import HomePage from './HomePage';

test('renders new search when flag is on', () => {
  (useFeatureFlag as jest.Mock).mockReturnValue(true);
  render(<HomePage />);
  expect(screen.getByText(/new search/i)).toBeInTheDocument();
});
```

## Fragment: Remote Flag Loading
```tsx
// Assume the API returned this value
// This is a map of featureKey: rolloutPercentage.
const response = {
  "enable-new-search": 10,
  "enable-dark-mode": 100,
  "enable-ai-widget": 5
}

// Or you can trust the backend to do bucketing for you //
// In that case, you can skip local bucketing and just trust the backend - which is useful for server-driven A/B testing or plan-based targeting. You'd slightly modify the provider to accept Record<string, boolean> and remove the hash check.
const response = {
  "enable-new-search": true,
  "enable-dark-mode": false
}


// Hook to fetch remote flag config //
// useRemoteFlags.ts
import { useEffect, useState } from "react";

type FlagConfig = Record<string, number>;

export function useRemoteFlags(userId: string) {
  const [flags, setFlags] = useState<FlagConfig | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchFlags() {
      try {
        const res = await fetch(`/api/flags?userId=${userId}`);
        if (!res.ok) throw new Error("Failed to fetch flags");
        const data = await res.json();
        setFlags(data);
      } catch (err) {
        console.error("Failed to load feature flags:", err);
        setFlags({}); // fallback to empty config
      } finally {
        setLoading(false);
      }
    }

    fetchFlags();
  }, [userId]);

  return { flags, loading };
}

// Feature Flag Provider Integration // 
// App.tsx
import { FeatureFlagProvider } from "./FeatureFlagProvider";
import { useRemoteFlags } from "./useRemoteFlags";

const App = () => {
  const userId = "user_abc123"; // from auth or session
  const { flags, loading } = useRemoteFlags(userId);

  if (loading) return <LoadingScreen />;

  return (
    <FeatureFlagProvider userId={userId} config={flags || {}}>
      <HomePage />
    </FeatureFlagProvider>
  );
};
```
