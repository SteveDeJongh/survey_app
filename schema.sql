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

INSERT INTO users (name, password)
VALUES ('Admin', '$2a$12$0XgEG6VcjXnEJXwZCVU92udirn1Ysfj1OnSiR.sMkn1LoM0dufZZ.');