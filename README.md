# World Cup Database Project

This project involves creating a PostgreSQL database to
store World Cup match data and writing SQL queries to
retrieve specific information from it.

This project is part of the
[FreeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn/relational-database).
[Build a world cup database project](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database).

Here’s an improved table of contents for your World Cup
Database project, following the format you provided:

## Table of Contents

1. [Create Database and Connect](#1-create-database-and-connect):
   Set up and connect to the PostgreSQL database.
2. [Create Required Tables](#2-create-required-tables):
   Define tables for `teams` and `games`.
3. [Assign Primary and Foreign Keys](#3-assign-primary-and-foreign-keys):
   Ensure data integrity with primary and foreign key
   constraints.
4. [Make Shell Scripts Executable](#4-make-shell-scripts-executable):
   Set permissions for shell scripts.
5. [Run Shell Scripts (Insert Data First)](#5-run-shell-scripts-insert-data-first):
   Execute scripts to insert data and run queries.
6. [Check if Data is in the Database](#6-check-if-data-is-in-the-database):
   Verify successful data insertion through SQL queries.
7. [Export Database to SQL File](#7-export-database-to-sql-file):
   Backup the database using `pg_dump`.
8. [Expected Output](#8-expected-output): Review the
   anticipated results from SQL queries.
9. [Files in the Project](#9-files-in-the-project): Overview
   of project files and their purposes.
10. [Project Flowchart](#10-project-flowchart): Visual
    representation of the project workflow.
11. [Entity-Relationship Diagram (ERD)](#11-entity-relationship-diagram-erd):
    Illustrate relationships between tables.

Feel free to adjust any of the descriptions to better fit
your project!

## Project Steps

### 1. Create Database and Connect to It

To create the database and connect to it:

```bash
psql --username=freecodecamp --dbname=postgres
CREATE DATABASE worldcup;
\c worldcup
```

### 2. Create Required Tables

Create the tables `teams` and `games` using the following
commands:

```sql
CREATE TABLE teams (
    team_id SERIAL NOT NULL,
    name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE games (
    game_id SERIAL NOT NULL,
    year INTEGER NOT NULL,
    round VARCHAR(20) NOT NULL,
    winner_id INTEGER NOT NULL,
    opponent_id INTEGER NOT NULL,
    winner_goals INTEGER NOT NULL,
    opponent_goals INTEGER NOT NULL
);
```

### 3. Assign Primary and Foreign Keys

- A primary key is a unique identifier for a record in a
  table.
  - It ensures that no two rows have the same value for the
    primary key column(s).
- A foreign key is a field (or collection of fields) in one
  table that uniquely identifies a row of another table or
  the same table.
  - It establishes a relationship between the two tables.

Set up primary and foreign key constraints:

```sql
ALTER TABLE teams ADD PRIMARY KEY (team_id);
ALTER TABLE games ADD PRIMARY KEY (game_id);
ALTER TABLE games ADD FOREIGN KEY (winner_id) REFERENCES teams (team_id);
ALTER TABLE games ADD FOREIGN KEY (opponent_id) REFERENCES teams (team_id);
```

### 4. Make Shell Scripts Executable

Give execute permissions to the shell scripts:

```bash
chmod +x insert_data.sh
chmod +x queries.sh
```

### 5. Run Shell Scripts (Insert Data First)

First, insert the data using `insert_data.sh`, then run the
queries with `queries.sh`:

```bash
./insert_data.sh
./queries.sh
```

### 6. Check if Data is in the Database

After inserting the data, you can check if it was
successfully inserted by using SQL queries.

#### Connect to the database:

```bash
psql --username=freecodecamp --dbname=worldcup
```

#### Check the `teams` table:

```sql
SELECT * FROM teams;
```

This will show all teams in the database.

#### Check the `games` table:

```sql
SELECT * FROM games;
```

This will show all the games in the database.

#### Get the count of rows in each table:

For `teams`:

```sql
SELECT COUNT(*) FROM teams;
```

For `games`:

```sql
SELECT COUNT(*) FROM games;
```

This will display how many rows (teams or games) are in the
tables to confirm the data has been inserted.

### 7. Export Database to a SQL File

To compact the database into a `.sql` file, use the
following command:

```bash
pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql
```

## 8. Expected Output

Here are some expected results from your queries:

- **Total goals from winning teams**: 68
- **Total goals from both teams**: 90
- **Average goals from winning teams**: 2.13 (rounded to two
  decimal places)
- **Average goals from both teams**: 2.81
- **Most goals in a single game by one team**: 7
- **Games where the winning team scored more than 2 goals**:
  6
- **2018 World Cup Winner**: France
- **Teams in the 2014 'Eighth-Final' round**:
  - Algeria
  - Argentina
  - Belgium
  - Brazil
  - Chile
  - Colombia
  - Costa Rica
  - France
  - Germany
  - Greece
  - Mexico
  - Netherlands
  - Nigeria
  - Switzerland
  - United States
  - Uruguay
- **Unique winning teams**:
  - Argentina
  - Belgium
  - Brazil
  - Colombia
  - Costa Rica
  - Croatia
  - England
  - France
  - Germany
  - Netherlands
  - Russia
  - Sweden
  - Uruguay
- **World Cup champions**:
  - 2014 | Germany
  - 2018 | France
- **Teams starting with 'Co'**:
  - Colombia
  - Costa Rica

## 9. Files in the Project

- **games.csv**: CSV file containing match data.
- **insert_data.sh**: Bash script to populate the database
  with the data from `games.csv`.
- **queries.sh**: Bash script containing queries to retrieve
  data from the database.
- **worldcup.sql**: SQL file that contains the full dump of
  the `worldcup` database.

### 10. Project Flowchart

The flowchart outlines the primary steps in building and
managing the World Cup database project, from database
creation to data handling and verification.

```plaintext
+---------------------------+
|       Start Process       |
+---------------------------+
             |
             v
+---------------------------+
| Connect to PostgreSQL     |
| Command: psql --username=... |
+---------------------------+
             |
             v
+---------------------------+
| Create 'worldcup' Database|
| Command: CREATE DATABASE worldcup; |
+---------------------------+
             |
             v
+---------------------------+
| Define Tables             |
| Command: CREATE TABLE teams (...); |
|         CREATE TABLE games (...); |
+---------------------------+
             |
             v
+---------------------------+
| Assign Primary & Foreign  |
| Keys for Relationships    |
| Command: ALTER TABLE ...  |
+---------------------------+
             |
             v
+---------------------------+
| Make Shell Scripts        |
| Executable (Permissions)  |
| Command: chmod +x insert_data.sh; |
+---------------------------+
             |
             v
+---------------------------+
| Execute Shell Scripts     |
| Command: ./insert_data.sh; |
|         ./queries.sh       |
+---------------------------+
             |
             v
+---------------------------+
| Verify Data Insertion     |
| Command: SELECT * FROM teams; |
|         SELECT * FROM games; |
+---------------------------+
             |
             v
+---------------------------+
| Export Database to SQL    |
| Command: pg_dump -cC ...  |
+---------------------------+
             |
             v
+---------------------------+
|        End Process        |
+---------------------------+
```

### 11. Entity-Relationship Diagram (ERD)

The ERD illustrates the relationships and attributes of the
primary tables in the World Cup database, `teams` and
`games`.

1. **Teams Table**

   - **team_id** (Primary Key): Unique identifier for each
     team.
   - **name**: Team name, unique and non-null.

2. **Games Table**
   - **game_id** (Primary Key): Unique identifier for each
     game.
   - **year**: Year of the game.
   - **round**: Round in which the game was played.
   - **winner_id** (Foreign Key): References `team_id` in
     `teams`, indicating the winning team.
   - **opponent_id** (Foreign Key): References `team_id` in
     `teams`, indicating the opposing team.
   - **winner_goals**: Goals scored by the winning team.
   - **opponent_goals**: Goals scored by the opponent team.

ERD:

```plaintext
+---------+        +-----------+
| TEAMS   |        |  GAMES    |
+---------+        +-----------+
| team_id |<-------| winner_id
| name    |    |   | opponent_id
+---------+    |   | year
               |   | round
               |   | winner_goals
               |   | opponent_goals
               +---+
```

This ERD highlights the one-to-many relationship between
`teams` and `games`: each game is associated with two teams
(a winner and an opponent), and each team can participate in
multiple games. Foreign keys in `games` link to the `teams`
table, ensuring relational integrity.
