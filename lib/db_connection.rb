require 'pg'

class DBConnection
  def self.connection
    PG.connect(
      host: 'postgres',
      dbname: 'maracuja',
      user: 'maracuja',
      password: 'maracuja'
    )
  end
end
