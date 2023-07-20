# Survey App

Features:
Start survey

Admin Features:
Must be logged in for any admin features
View results of existing surveys

Unrestricted pages:
Home - description of survey
Survery - fillable form with yes/no questions, submitting redirects to main page.
Login page - fillable form to submit admin user information

Restricted pages:
Results - Provides summary of all survey results.
List of Completed surveys - individual survey listed by id and input name.
individual survey details - details of survey with each individual questions answer.

PAGES:

Layout page:
navbar:
  When not logged in: top nav bar start survey, log in
  When logged in: start survey, signout, view results

home:
generic paragraph

sign_in:
sign in form with username and password submit button

Done:
Database:
Users:
  id
  name
  password (hashed with bccrypt)

Survey responses:
  id
  timestamp
  name
  question 1 answer
  question 2 answer
  question 3 answer
