require_relative './result_test_dao'
require_relative './csv_to_json'

class Importer
  def self.call(filename)
    dao = ResultTestDAO.new

    dao.execute(setup_table_sql)

    csv_data(filename).each do |result_test|
      row = result_test
        .values
        .map { |value| value.gsub("'", "\"") }
        .map { |value| "'#{value}'" }
        .join(', ')

      columns = result_test
        .keys
        .join(', ')

      insert_data_sql = %{ INSERT INTO result_tests (#{columns}) VALUES (#{row}) }
      dao.execute(insert_data_sql)
    end
  end

  def self.setup_table_sql
    %{
      DROP TABLE IF EXISTS result_tests;

      CREATE TABLE result_tests (
        id SERIAL PRIMARY KEY,
        cpf VARCHAR(20),
        name VARCHAR(250),
        email VARCHAR(100),
        birthday DATE,
        street_address TEXT,
        city_address VARCHAR(100),
        state_address VARCHAR(50),
        doctor_crm VARCHAR(50),
        doctor_crm_state VARCHAR(5),
        doctor_name VARCHAR(250),
        doctor_email VARCHAR(100),
        result_token VARCHAR(50),
        result_date DATE,
        test_type VARCHAR(50),
        test_limits VARCHAR(20),
        result VARCHAR(20)
      )
    }
  end

  def self.csv_data(filename)
    CsvToJson.call(filename)
  end
end
