---
contents:
  - id: 15
    label: App.tsx
    language: tsx
  - id: 16
    label: styles.css
    language: css
createdAt: 1752347392556
description: null
folderId: 2
id: 6
isDeleted: 0
isFavorites: 0
name: '[Partial] React Table'
tags: []
updatedAt: 1752347430552
---

## Fragment: App.tsx
```tsx
import { useQuery } from "@tanstack/react-query";
import { useEffect, useState } from "react";
import "./style.css";

export const ARROW_UP = "↑";
export const ARROW_DOWN = "↓";

export type Person = {
  firstName: string;
  lastName: string;
  age: number;
  country: string;
  favoriteFood: string;
};

// Imagine this is making a network request to fetch data.
export const getData = (): Promise<Person[]> => {
  return new Promise((resolve) => {
    setTimeout(() => resolve(data), 500);
  });
};

const data: Person[] = [
  {
    firstName: "Liam",
    lastName: "Smith",
    age: 28,
    country: "USA",
    favoriteFood: "Pizza",
  },
  {
    firstName: "Olivia",
    lastName: "Johnson",
    age: 34,
    country: "Canada",
    favoriteFood: "Sushi",
  },
  {
    firstName: "Noah",
    lastName: "Williams",
    age: 22,
    country: "UK",
    favoriteFood: "Burger",
  },
  {
    firstName: "Emma",
    lastName: "Brown",
    age: 31,
    country: "Australia",
    favoriteFood: "Salad",
  },
  {
    firstName: "Oliver",
    lastName: "Jones",
    age: 29,
    country: "New Zealand",
    favoriteFood: "Pasta",
  },
  {
    firstName: "Ava",
    lastName: "Garcia",
    age: 27,
    country: "USA",
    favoriteFood: "Steak",
  },
  {
    firstName: "Elijah",
    lastName: "Martinez",
    age: 40,
    country: "Spain",
    favoriteFood: "Paella",
  },
  {
    firstName: "Sophia",
    lastName: "Rodriguez",
    age: 21,
    country: "Mexico",
    favoriteFood: "Tacos",
  },
  {
    firstName: "William",
    lastName: "Davis",
    age: 35,
    country: "USA",
    favoriteFood: "Ribs",
  },
  {
    firstName: "Isabella",
    lastName: "Lopez",
    age: 30,
    country: "Argentina",
    favoriteFood: "Empanadas",
  },
  {
    firstName: "James",
    lastName: "Gonzalez",
    age: 26,
    country: "Chile",
    favoriteFood: "Ceviche",
  },
  {
    firstName: "Mia",
    lastName: "Anderson",
    age: 42,
    country: "South Africa",
    favoriteFood: "Biltong",
  },
  {
    firstName: "Benjamin",
    lastName: "Thomas",
    age: 33,
    country: "USA",
    favoriteFood: "Hot Dogs",
  },
  {
    firstName: "Charlotte",
    lastName: "Taylor",
    age: 24,
    country: "UK",
    favoriteFood: "Fish and Chips",
  },
  {
    firstName: "Lucas",
    lastName: "Hernandez",
    age: 36,
    country: "France",
    favoriteFood: "Croissant",
  },
  {
    firstName: "Amelia",
    lastName: "Moore",
    age: 25,
    country: "Italy",
    favoriteFood: "Gelato",
  },
  {
    firstName: "Mason",
    lastName: "Martin",
    age: 38,
    country: "USA",
    favoriteFood: "Sandwich",
  },
  {
    firstName: "Harper",
    lastName: "Jackson",
    age: 29,
    country: "Canada",
    favoriteFood: "Poutine",
  },
  {
    firstName: "Ethan",
    lastName: "Thompson",
    age: 32,
    country: "Australia",
    favoriteFood: "Vegemite",
  },
  {
    firstName: "Abigail",
    lastName: "White",
    age: 27,
    country: "Ireland",
    favoriteFood: "Stew",
  },
  {
    firstName: "Alexander",
    lastName: "Harris",
    age: 31,
    country: "USA",
    favoriteFood: "Fried Chicken",
  },
  {
    firstName: "Sofia",
    lastName: "Clark",
    age: 23,
    country: "Brazil",
    favoriteFood: "Feijoada",
  },
  {
    firstName: "Daniel",
    lastName: "Lewis",
    age: 39,
    country: "USA",
    favoriteFood: "BBQ",
  },
  {
    firstName: "Ella",
    lastName: "Robinson",
    age: 28,
    country: "Germany",
    favoriteFood: "Bratwurst",
  },
  {
    firstName: "Matthew",
    lastName: "Walker",
    age: 26,
    country: "USA",
    favoriteFood: "Mac 'n' Cheese",
  },
  {
    firstName: "Avery",
    lastName: "Young",
    age: 30,
    country: "Japan",
    favoriteFood: "Ramen",
  },
  {
    firstName: "Aiden",
    lastName: "Allen",
    age: 37,
    country: "Netherlands",
    favoriteFood: "Stroopwafel",
  },
  {
    firstName: "Scarlett",
    lastName: "King",
    age: 34,
    country: "USA",
    favoriteFood: "Apple Pie",
  },
  {
    firstName: "Joseph",
    lastName: "Wright",
    age: 22,
    country: "Italy",
    favoriteFood: "Pizza",
  },
  {
    firstName: "Grace",
    lastName: "Scott",
    age: 25,
    country: "UK",
    favoriteFood: "Shepherd's Pie",
  },
  {
    firstName: "Samuel",
    lastName: "Green",
    age: 41,
    country: "USA",
    favoriteFood: "Clam Chowder",
  },
  {
    firstName: "Chloe",
    lastName: "Baker",
    age: 21,
    country: "France",
    favoriteFood: "Baguette",
  },
  {
    firstName: "David",
    lastName: "Adams",
    age: 33,
    country: "USA",
    favoriteFood: "Fried Shrimp",
  },
  {
    firstName: "Zoey",
    lastName: "Nelson",
    age: 28,
    country: "Australia",
    favoriteFood: "Pavlova",
  },
  {
    firstName: "Carter",
    lastName: "Hill",
    age: 29,
    country: "USA",
    favoriteFood: "Cornbread",
  },
  {
    firstName: "Riley",
    lastName: "Ramirez",
    age: 24,
    country: "Spain",
    favoriteFood: "Tapas",
  },
  {
    firstName: "John",
    lastName: "Campbell",
    age: 38,
    country: "USA",
    favoriteFood: "Chili",
  },
  {
    firstName: "Lily",
    lastName: "Mitchell",
    age: 35,
    country: "UK",
    favoriteFood: "Curry",
  },
  {
    firstName: "Luke",
    lastName: "Perez",
    age: 32,
    country: "Mexico",
    favoriteFood: "Enchiladas",
  },
  {
    firstName: "Hannah",
    lastName: "Roberts",
    age: 27,
    country: "USA",
    favoriteFood: "Pancakes",
  },
  {
    firstName: "Gabriel",
    lastName: "Turner",
    age: 31,
    country: "Italy",
    favoriteFood: "Risotto",
  },
  {
    firstName: "Aria",
    lastName: "Phillips",
    age: 26,
    country: "Japan",
    favoriteFood: "Sashimi",
  },
  {
    firstName: "Henry",
    lastName: "Parker",
    age: 40,
    country: "USA",
    favoriteFood: "Gumbo",
  },
  {
    firstName: "Ella",
    lastName: "Evans",
    age: 36,
    country: "Greece",
    favoriteFood: "Moussaka",
  },
  {
    firstName: "Sebastian",
    lastName: "Edwards",
    age: 23,
    country: "USA",
    favoriteFood: "Burgers",
  },
  {
    firstName: "Zoe",
    lastName: "Collins",
    age: 34,
    country: "USA",
    favoriteFood: "Cobb Salad",
  },
  {
    firstName: "Jack",
    lastName: "Stewart",
    age: 39,
    country: "Australia",
    favoriteFood: "Meat Pie",
  },
  {
    firstName: "Natalie",
    lastName: "Sanchez",
    age: 28,
    country: "Argentina",
    favoriteFood: "Choripán",
  },
  {
    firstName: "Owen",
    lastName: "Morris",
    age: 30,
    country: "USA",
    favoriteFood: "Cheesecake",
  },
  {
    firstName: "Aubrey",
    lastName: "Rogers",
    age: 25,
    country: "France",
    favoriteFood: "Quiche",
  },
  {
    firstName: "Julian",
    lastName: "Reed",
    age: 32,
    country: "UK",
    favoriteFood: "Bangers and Mash",
  },
  {
    firstName: "Addison",
    lastName: "Cook",
    age: 27,
    country: "Canada",
    favoriteFood: "Maple Syrup",
  },
];

function Cell({ cellData, header }: { cellData: string; header?: boolean }) {
  return (
    <div
      className="cell"
      style={{
        width: "calc(100vw / 5)",
        ...(header && {
          display: "flex",
          justifyContent: "center",
        }),
      }}
    >
      {cellData}
    </div>
  );
}

function Row({
  rowData,
  highlight,
  header,
}: {
  rowData: Person;
  id: string;
  highlight: boolean;
  header?: boolean;
}) {
  const keys = Object.keys(rowData);
  return (
    <div
      className="row"
      style={{
        ...(highlight && { backgroundColor: "#F6F6F6" }),
        ...(header && { backgroundColor: "#DDDDDD" }),
      }}
    >
      {keys.map((key, i) => (
        <Cell
          header={header}
          key={`row-${rowData[key]}`}
          cellData={rowData[key]}
        />
      ))}
    </div>
  );
}

function Table({ data }: { data: Person[] }) {
  const dataWithHeader = [...data];
  const headerData = {
    firstName: "First Name",
    lastName: "Last Name",
    age: "Age",
    country: "Country",
    favoriteFood: "Favorite Food",
  };
  return (
    <div className="table">
      <Row header key="header-row" rowData={headerData} />
      {dataWithHeader.map((item, i) => {
        const key = `$item.firstName-$item.lastName`;
        return (
          <Row
            key={`table-${key}-${i}`}
            highlight={Boolean(i % 2)}
            id={key}
            rowData={item}
          />
        );
      })}
    </div>
  );
}

function SearchBar({ inputHandler, value, clearHandler }) {
  return (
    <div className="search-container">
      <input
        placeholder="Search"
        className="input"
        value={value}
        onChange={(e) => inputHandler(e.target.value)}
      />
      <button onClick={() => clearHandler()}>Clear</button>
    </div>
  );
}

export default function App() {
  const [inputValue, setInputValue] = useState("");
  const [localData, setLocalData] = useState([]);
  const [filteredData, setFilteredData] = useState([]);
  const { data, isLoading, error } = useQuery({
    queryFn: getData,
    queryKey: ["data"],
  });

  useEffect(() => {
    if (!localData?.length && data) {
      setLocalData(data);
      setFilteredData(data);
    }
  }, [data]);

  useEffect(() => {
    if (inputValue.length === 0) {
      setFilteredData(localData);
    }
    if (inputValue.length < 2) return;
    filterDataOnSearch(inputValue);
  }, [inputValue]);

  function filterDataOnSearch(searchTerm) {
    const filtered = localData.filter((row) => {
      let pass = false;
      const values = Object.values(row);
      values.forEach((value: string) => {
        if (typeof value === "string") {
          const normalized = value.toLowerCase();
          if (normalized.includes(searchTerm)) {
            pass = true;
            return;
          }
        }
        if (typeof value === "number") {
          const numberToString = value.toString();
          if (numberToString.includes(searchTerm)) {
            pass = true;
            return;
          }
        }
      });
      return pass;
      // if (values.includes(searchTerm)) return true;
    });
    setFilteredData(filtered);
  }

  function clearHandler() {
    setInputValue("");
    setFilteredData(localData);
  }

  if (error) {
    return <div>Hey! There's been a error!</div>;
  }

  if (isLoading) {
    return <div>Loading...</div>;
  }

  return (
    <main className="container">
      <SearchBar
        value={inputValue}
        inputHandler={setInputValue}
        clearHandler={clearHandler}
      />
      {data ? <Table data={filteredData} /> : null}
    </main>
  );
}
```

## Fragment: styles.css
```css
body {
  font-family: sans-serif;
}

.container {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 100%;
}

.table {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
  justify-content: space-between;
  border: 1px solid black;
  border-radius: 5px;
}

.row {
  display: flex;
  flex-direction: row;
  width: 100%;
  justify-content: center;

}

.cell {
  /* display: flex; */
  /* max-height: 50px; */
  border: 1px solid black;
  padding: 5px;
}

.search-container {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  margin-bottom: .25rem;
  gap: 5px;
}

.input {
  width: 100%;
}
```
