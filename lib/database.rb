require 'pg'

class Database
  def self.connection
    @@connection ||= PG.connect(
      host: 'postgres',
      dbname: 'maracuja',
      user: 'maracuja',
      password: 'maracuja'
    )
  end

  def self.execute(sql)
    connection.exec(sql)
  end

  def self.tests
    execute('SELECT * FROM result_tests').to_a.to_json
  end
end
