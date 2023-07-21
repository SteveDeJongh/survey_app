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


--! Notes

SELECT count(id) as IDS,
       count(case WHEN q1 ILIKE 'Yes' THEN 1 end) AS Q1A,
       count(case WHEN q1 ILIKE 'No' THEN 1 end) AS Q1B,
       count(case WHEN q2 ILIKE 'Male' THEN 1 end) AS Q2A,
       count(case WHEN q2 ILIKE 'Female' THEN 1 end) AS Q2B,
       count(case WHEN q3 ILIKE 'Yes' THEN 1 end) AS Q3A,
       count(case WHEN q3 ILIKE 'No' THEN 1 end) AS Q3B
       FROM responses;