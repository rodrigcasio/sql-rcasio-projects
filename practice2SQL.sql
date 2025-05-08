CREATE TABLE celebs (
  id INTEGER,
  name TEXT,
  age INTEGER
);

INSERT INTO celebs
VALUES (1, 'Stephen Curry', 29);

INSERT INTO celebs
VALUES (2, 'LeBron James', 40);

INSERT INTO celebs
VALUES (3, 'Kanye West', 50);

ALTER celebs
ADD COLUMN twitter_page TEXT;

UPDATE celebs
SET twitter_page = '@stephCurry'
WHERE id = 1;

UPDATE celebs
SET twitter_page = '@LeMickeyLol'
WHERE id = 2;

UPDATE celebs
SET twitter_page = '@Ye'
WHERE id = 3;

SELECT * FROM celebs;
