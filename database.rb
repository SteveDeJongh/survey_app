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
end