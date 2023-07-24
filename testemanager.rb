require 'pg'
class Testemanager
  def create_db
    con = PG.connect(
    dbname: 'postgres',
    user: 'admin',
    password: '87273836',
    host: 'db',
    port: '5432'    
    )

    con.exec("CREATE DATABASE app OWNER admin;")
    con.close
  end

  def create_table
    con = PG.connect(
      dbname: 'app',
      user: 'admin',
      password: '87273836',
      host: 'db',
      port: '5432'    
    )
    create_query = <<~SQL
        CREATE TABLE IF NOT EXISTS exams (
          id SERIAL PRIMARY KEY,
          cpf VARCHAR(11),
          name VARCHAR(100) NOT NULL,
          email VARCHAR(100) NOT NULL,
          birthdate DATE NOT NULL,
          address VARCHAR(255) NOT NULL,
          city VARCHAR(100) NOT NULL,
          state VARCHAR(100) NOT NULL,
          doctor_registration VARCHAR(50) NOT NULL,
          doctor_state_registration VARCHAR(100) NOT NULL,
          doctor_name VARCHAR(100) NOT NULL,
          doctor_email VARCHAR(100) NOT NULL,
          exam_token VARCHAR(100) NOT NULL,
          exam_date DATE NOT NULL,
          exam_type VARCHAR(100) NOT NULL,
          exam_ranges VARCHAR(255) NOT NULL,
          exam_results VARCHAR(100) NOT NULL
        );
      SQL
    con.exec(create_query)
    con.close
  end

  def database_cleaner
    con = PG.connect(
      dbname: 'app',
      user: 'admin',
      password: '87273836',
      host: 'db',
      port: '5432'    
    )

    con.exec("DELETE FROM exams;")
    con.close
  end
end

