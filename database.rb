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
end