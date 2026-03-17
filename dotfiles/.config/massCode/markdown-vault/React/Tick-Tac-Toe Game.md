---
contents:
  - id: 8
    label: App.jsx
    language: jsx
  - id: 9
    label: style.css
    language: css
createdAt: 1751926599088
description: null
folderId: 2
id: 3
isDeleted: 0
isFavorites: 0
name: Tick-Tac-Toe Game
tags:
  - 7
  - 8
updatedAt: 1751926657760
---

## Fragment: App.jsx
```jsx
import { useEffect, useRef, useState } from "react"

import "./style.css"

function Cell({ idx, handleClick, active }) {
  return (
    <div
      onClick={() => handleClick(idx)}
      className={`cell ${idx === 5 - 1 && "hidden"} ${active && "active"}`}
    />
  )
}

function Grid({ handleClick, active }) {
  return (
    <div className="grid">
      {Array(9)
        .fill(null)
        .map((_, i) => {
          const isActive = active.includes(i)
          return (
            <Cell key={i} idx={i} handleClick={handleClick} active={isActive} />
          )
        })}
    </div>
  )
}

function Status({ active }) {
  const computed = [...active].join(", ")
  return <pre>order array: {computed}</pre>
}

export default function App() {
  const [active, setActive] = useState([])
  const interval = useRef(null)

  function deactivate() {
    const original = [...active]
    interval.current = setInterval(() => {
      original.pop()
      setActive([...original])
      if (original.length === 0) {
        clearInterval(interval.current)
      }
    }, 300)
  }

  useEffect(() => {
    if (active.length === 8) {
      deactivate()
    }
  }, [active])

  function handleClick(idx) {
    setActive((a) => [...a, idx])
  }

  return (
    <div className="container">
      <Grid handleClick={handleClick} active={active} />
      <Status active={active} />
    </div>
  )
}

```

## Fragment: style.css
```css
body {
  font-family: sans-serif;
}

.container {
  width: 100vw;
  height: 100vh;
  display: flex;
  flex: 1;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.grid {
  border: 1px solid black;
  padding: 1rem;
  display: grid;
  grid-template-columns: repeat(3, 5rem);
  gap: 0.75rem;
}

.cell {
  border: 1px solid black;
  width: 5rem;
  height: 5rem;
}

.hidden {
  opacity: 0;
  pointer-events: none;
}

.active {
  background-color: green;
  pointer-events: none;
}
```
