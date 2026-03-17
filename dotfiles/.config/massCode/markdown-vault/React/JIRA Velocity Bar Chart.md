---
contents:
  - id: 10
    label: App.jsx
    language: jsx
  - id: 11
    label: style.css
    language: css
createdAt: 1751934327857
description: null
folderId: 2
id: 4
isDeleted: 0
isFavorites: 0
name: JIRA Velocity Bar Chart
tags:
  - 9
  - 10
  - 11
  - 12
updatedAt: 1751934394503
---

## Fragment: App.jsx
```jsx
import { motion } from "framer-motion"
import { useMemo, useState } from "react"
import "./style.css"

const CHART_DATA = [
  { id: "dep-1", name: "Legal", ticketCount: 32, color: "#3F888F" },
  { id: "dep-2", name: "Sales", ticketCount: 20, color: "#FFA420" },
  { id: "dep-3", name: "Engineering", ticketCount: 60, color: "#3a5f12ff" },
  { id: "dep-4", name: "Manufacturing", ticketCount: 5, color: "#2FA2FF" },
  { id: "dep-5", name: "Maintenance", ticketCount: 14, color: "#6F3420" },
  { id: "dep-6", name: "Human Resources", ticketCount: 35, color: "#1D1E33" },
  { id: "dep-7", name: "Events", ticketCount: 43, color: "#E1CC4F" },
]

function Bar({ name, color, ticketCount, height }) {
  return (
    <motion.div
      initial={{ height: 0 }}
      animate={{ height: `${height}%` }}
      exit={{ height: 0 }}
      className="bar"
      style={{ backgroundColor: color }}
    >
      <div className="tooltip">
        {name} - {ticketCount}
      </div>
    </motion.div>
  )
}

function BarChart({ data }) {
  const maxTicketCount = useMemo(() => {
    return Math.max(...data.map((item) => item.ticketCount))
  }, [])

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      transition={{ duration: 0.4 }}
      className="chart-container"
    >
      <div className="chart">
        {data.map((item) => (
          <Bar
            key={item.id}
            {...item}
            height={`${(item.ticketCount / maxTicketCount) * 100}`}
          />
        ))}
      </div>
      <div className="y-axis-label">Number of tickets</div>
      <div className="x-axis-label">Departments</div>
    </motion.div>
  )
}

export default function App() {
  const [showChart, setShowChart] = useState(true)

  return (
    <main className="container">
      <button type="button" onClick={() => setShowChart((s) => !s)}>
        Toggle Chart
      </button>
      {showChart ? <BarChart data={CHART_DATA} /> : null}
    </main>
  )
}

```

## Fragment: style.css
```css
body {
  font-family: sans-serif;
}

.container {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  padding: 30px;
  gap: 20px;
}

.container button {
  border: 0;
  background-color: #2c3e50;
  color: white;
  padding: 10px 15px;
  border-radius: 4px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  gap: 40px;
}

.container button:active {
  transform: scale(0.9);
}

.chart-container {
  position: relative;
  width: 80%;
  height: 500px;
  padding: 10px;
}

.chart {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  height: 100%;
  width: 100%;
  border: 1px solid #414141;
  border-right-width: 0;
  border-top-width: 0;
  gap: 20px;
}

.bar {
  position: relative;
  flex: 1;
  height: 100%;
}

.tooltip {
  position: absolute;
  top: 0;
  right: 50%;
  transform: translate(50%, -120%);
  width: max-content;
  background-color: black;
  color: white;
  padding: 4px;
  border-radius: 4px;
  z-index: 10;
  opacity: 0;
  transition: opacity 0.2s ease-in-out;
}

.bar:hover .tooltip {
  opacity: 1;
}

.y-axis-label {
  position: absolute;
  top: 50%;
  left: 0;
  transform: translateX(-50%) translateY(-50%) rotate(-90deg);
  font-weight: bold;
  margin-left: -10px;
}

.x-axis-label {
  position: absolute;
  font-weight: bold;
  left: 50%;
  transform: translateX(-50%);
  margin-top: 10px;
}
```
