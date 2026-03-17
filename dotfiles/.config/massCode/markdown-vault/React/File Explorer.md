---
contents:
  - id: 12
    label: App.tsx
    language: tsx
  - id: 13
    label: FileExplorer.tsx
    language: tsx
  - id: 14
    label: styles.css
    language: css
createdAt: 1752172907814
description: null
folderId: 2
id: 5
isDeleted: 0
isFavorites: 0
name: File Explorer
tags:
  - 13
  - 14
updatedAt: 1752175825038
---

## Fragment: App.tsx
```tsx
import FileExplorer from './FileExplorer';

export type Node = {
  id: number;
  name: string;
  children?: Node[];
}

export default function App() {
  const nodes: Node[] = [
    {
      id: 1,
      name: 'README.md',
    },
    {
      id: 2,
      name: 'Documents',
      children: [
        {
          id: 3,
          name: 'Word.doc',
        },
        {
          id: 4,
          name: 'Powerpoint.ppt',
        },
      ],
    },
    {
      id: 5,
      name: 'Downloads',
      children: [
        {
          id: 6,
          name: 'unnamed.txt',
        },
        {
          id: 7,
          name: 'Misc',
          children: [
            {
              id: 8,
              name: 'foo.txt',
            },
            {
              id: 9,
              name: 'bar.txt',
            },
          ],
        },
      ],
    },
  ];

  return <FileExplorer nodes={nodes} />;
}

```

## Fragment: FileExplorer.tsx
```tsx
import { useState } from "react";
import { type Node } from "./App";

function sortNodes(nodes: Node[]) {
  return [...nodes].sort((a, b) => {
    const aIsDir = Array.isArray(a.children);
    const bIsDir = Array.isArray(b.children);
    // Sort dirs first
    if (aIsDir && !bIsDir) return -1;
    if (!aIsDir && bIsDir) return 1;
    // If they're the same, sort alphabetically
    return a.name.localeCompare(b.name);
  });
}

export default function FileExplorer({ nodes }: { nodes: Node[] }) {
  return (
    <ul className="node-list">
      {sortNodes(nodes).map((node) => (
        <NodeItem node={node} />
      ))}
    </ul>
  );
}

function NodeItem({ node, className }: { node: Node; className?: string }) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <li key={node.id}>
      <span className={`node-content ${className}`}>
        {node.children && node.children?.length > 0 ? (
          <button onClick={() => setIsOpen((o) => !o)}>
            {isOpen ? <OpenFolderIcon /> : <FolderIcon />}
          </button>
        ) : (
          ""
        )}
        <span className={node.children?.length ? "bold-text" : ""}>
          {node.children ? "" : "📄 "}
          {node.name}
        </span>
      </span>
      {isOpen
        ? sortNodes(node?.children!).map((node) => (
            <span className={`node-content ${className}`}>
              <NodeItem className="node-child" node={node} />
            </span>
          ))
        : null}
    </li>
  );
}

function FolderIcon({ className }: { className?: string }) {
  return <div className={className}>&#128193;</div>;
}

function OpenFolderIcon({ className }: { className?: string }) {
  return <div className={className}>&#128194;</div>;
}

function DocumentIcon({ className }: { className?: string }) {
  return <div className={className}>&#128196;</div>;
}

```

## Fragment: styles.css
```css
body {
  font-family: sans-serif;
}

button {
  all: unset;
}

.node-content {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.node-list {
  list-style-type: none;
  padding-left: 0;
}

.bold-text {
  font-weight: 800;
}

.node-child {
  margin-left: 1.5rem;
}
```
