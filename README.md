# World Cup Database Project

This project involves creating a PostgreSQL database to
store World Cup match data and writing SQL queries to
retrieve specific information from it.

This project is part of the
[FreeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database).

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

## Expected Output

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

## Files in the Project

- **games.csv**: CSV file containing match data.
- **insert_data.sh**: Bash script to populate the database
  with the data from `games.csv`.
- **queries.sh**: Bash script containing queries to retrieve
  data from the database.
- **worldcup.sql**: SQL file that contains the full dump of
  the `worldcup` database.