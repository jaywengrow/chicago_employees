require "chicago_employees/version"
require "unirest"
module ChicagoEmployees
  class Employee
    attr_reader :job_title, :department, :name, :salary

    def initialize(hash)
      @job_title = hash["job_titles"]
      @department = hash["department"]
      @name = hash["name"]
      @salary = hash["employee_annual_salary"]
    end
    
    def self.all
      employees_array = Unirest.get("https://data.cityofchicago.org/resource/xzkq-xp2w.json").body
      create_employees(employees_array)
    end

    def self.search(search_term)
      employees_array = Unirest.get("https://data.cityofchicago.org/resource/xzkq-xp2w.json?$q=#{search_term}").body
      create_employees(employees_array)
    end

    private ################

    def create_employees(array_of_hashes)
      employees = []
      employees_array.each do |employee_hash|
        employees << Employee.new(employee_hash)
      end
      return employees
    end
  end
end
