CREATE TABLE IF NOT EXISTS "personTable" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    child_age INT
);

INSERT INTO "personTable" (name, child_age) VALUES ('John', 10);
INSERT INTO "personTable" (name, child_age) VALUES ('John', 10);
