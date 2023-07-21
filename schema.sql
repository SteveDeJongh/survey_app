CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name varchar(50),
  password text
);

CREATE TABLE responses (
  id SERIAL PRIMARY KEY,
  created_on timestamptz DEFAULT now(),
  name varchar(50),
  q1 text,
  q2 text,
  q3 text
);

INSERT INTO users (name, password)
VALUES ('Admin', '$2a$12$0XgEG6VcjXnEJXwZCVU92udirn1Ysfj1OnSiR.sMkn1LoM0dufZZ.');


--! Sample Data

INSERT INTO responses (created_on, name, q1, q2, q3)
VALUES ('2023-07-20 16:27:51.530979-07', 'Steve', 'Yes', 'Female', 'No'),
       ('2023-07-18 19:27:51.530979-07', 'Simon', 'No', 'Female', 'No'),
       ('2023-07-19 12:27:51.530979-07', 'David', 'No', 'Male', 'Yes'),
       ('2023-07-15 11:27:51.530979-07', 'Yanni', 'Yes', 'Female', 'No'),
       ('2023-06-20 12:27:51.530979-07', 'Norm', 'No', 'Female', 'Yes'),
       ('2023-06-21 16:27:51.530979-07', 'Ralf', 'No', 'Male', 'No'),
       ('2023-06-10 18:27:51.530979-07', 'Gerald', 'Yes', 'Male', 'Yes'),
       ('2023-07-20 16:27:51.530979-07', 'John', 'Yes', 'Female', 'No');

  5 | 2023-07-20 16:27:51.530979-07 | Gerald          | Yes | Male | no
--! Notes

SELECT count(id) as IDS,
       count(case WHEN q1 ILIKE 'Yes' THEN 1 end) AS Q1A,
       count(case WHEN q1 ILIKE 'No' THEN 1 end) AS Q1B,
       count(case WHEN q2 ILIKE 'Male' THEN 1 end) AS Q2A,
       count(case WHEN q2 ILIKE 'Female' THEN 1 end) AS Q2B,
       count(case WHEN q3 ILIKE 'Yes' THEN 1 end) AS Q3A,
       count(case WHEN q3 ILIKE 'No' THEN 1 end) AS Q3B
       FROM responses;