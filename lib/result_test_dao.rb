require 'pg'
require_relative './db_connection'

class ResultTestDAO
  def initialize
    @connection = DBConnection.connection
  end

  def execute(sql)
    @connection.exec(sql)
  end

  def all
    execute('SELECT * FROM result_tests').to_a.to_json
  end

  def self.all = new.all
  def self.execute(sql) = new.execute(sql)
end
