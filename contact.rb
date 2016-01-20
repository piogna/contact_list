require 'csv'

# Represents a person in an address book.
class Contact

  attr_accessor :id, :name, :email, :phone_numbers

  def initialize(options = {})
    @id = options[:id]
    @name = options[:name]
    @email = options[:email]
    @phone_numbers = options[:phone_numbers]
    @phone_numbers ||= []
  end
end
