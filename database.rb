require 'pg'

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: "survey")
  end
  
  def disconnect
    @db.close
  end

  def query(statement, *params)
    @db.exec_params(statement, params)
  end

  def retrieve_user_details(username)
    sql = "SELECT * FROM users where username = $1"
    result = query(sql, username)
    result.map do |tuple|
            { id: tuple["id"],
              username: tuple["username"],
              password: tuple["password"] }
            end.first
  end

  def add_survey_result(name, q1, q2, q3)
    sql = <<~SQL
      INSERT INTO responses (name, q1, q2, q3)
      VALUES ($1, $2, $3, $4);
    SQL
    
    query(sql, name, q1, q2, q3)
  end

  def retrieve_survey_responses
    sql = "SELECT * FROM responses;"

    result = query(sql)
    tuple_to_hash_array(result)
  end

  def retrieve_survey_response(id)
    sql = "SELECT * FROM responses WHERE id = $1;"

    result = query(sql, id)
    tuple_to_hash_array(result)
  end

  def retrieve_response_counts
    sql = <<~SQL
    SELECT count(id) as IDS,
       count(case WHEN q1 ILIKE 'Yes' THEN 1 end) AS Q1A,
       count(case WHEN q1 ILIKE 'No' THEN 1 end) AS Q1B,
       count(case WHEN q2 ILIKE 'Male' THEN 1 end) AS Q2A,
       count(case WHEN q2 ILIKE 'Female' THEN 1 end) AS Q2B,
       count(case WHEN q3 ILIKE 'Yes' THEN 1 end) AS Q3A,
       count(case WHEN q3 ILIKE 'No' THEN 1 end) AS Q3B
       FROM responses;
    SQL

    query(sql).values.flatten
  end
  
  private

  def tuple_to_hash_array(tuples)
    tuples.map do |tuple|
                { id: tuple["id"],
                  created_on: tuple["created_on"],
                  name: tuple["name"],
                  q1: tuple["q1"],
                  q2: tuple["q2"],
                  q3: tuple["q3"] }
              end
  end
end