CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name varchar(50),
  password text
);

CREATE TABLE responses (
  id SERIAL PRIMARY KEY,
  created_on timestamptz,
  name varchar(50),
  q1 text,
  q2 text,
  q3 text
);