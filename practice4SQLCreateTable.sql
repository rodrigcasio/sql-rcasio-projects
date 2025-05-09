CREATE TABLE friends (
  id  INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  birthday DATE
);

INSERT INTO friends
VALUES (1, 'Orore Monroe', '1940-05-30');

INSERT INTO friends
VALUES (2, 'Rodrigo Casio', '1999-09-07');

INSERT INTO friends
VALUES (3, 'Chris Martin', '1977-03-02');

INSERT INTO friends
VALUES (4, 'Leonhard Euler', '1707-04-17');

INSERT INTO friends
VALUES (5, 'Richard Feynman', '1918-05-11');

ALTER TABLE friends
ADD COLUMN email TEXT DEFAULT NULL;

UPDATE friends 
SET email = 'orore.Monroe@gmail.com'
WHERE id = 1;

UPDATE friends
SET email = 'rod.casio@outlook.com'
WHERE id = 2;

UPDATE friends
SET email = 'chrisMartin@gmail.com'
WHERE id = 3;

UPDATE friends
SET email = 'leoHard@gmail.com'
WHERE id = 4;

UPDATE friends
SET email = 'richardFEINman'
WHERE id = 5;

--deleting Orore Monroe row
DELETE FROM friends
WHERE id = 1;

SElECT *
FROM friends;

