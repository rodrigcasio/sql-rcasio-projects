-- this is an example of creating a table with each column with one constraint

CREATE TABLE awards (
  id INTEGER PRIMARY KEY,
  recipient TEXT NOT NULL,
  award_name TEXT DEFAULT 'Oscar'
);

INSERT INTO awards
VALUES (1, 'Eddie Einsenberg', 'Best Actor');

INSERT INTO awards
VALUES (2, 'Andrew Garfield', 'Best Support-Actor');

INSERT INTO awards
VALUES (3, 'Justin Timberlake', 'Oscar');

ALTER awards
ADD COLUMN character_name TEXT;

UPDATE awards
SET character_name = 'Mark Zucherberg'
WHERE id = 1;

UPDATE awards
SET character_name = 'Eduardo Saverin'
WHERE id = 2;

UPDATE awards
SET character_name = 'Sean Parker'
WHERE id = 3;

SELECT * FROM awards;

