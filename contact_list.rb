require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

end
if ARGV.length == 0
  puts "Here is a list of available commands"
  puts "\tnew      - Create a new contact"
  puts "\tlist     - List all contacts"
  puts "\tshow     - Show a contact"
  puts "\tsearch   - Search contacts"

  exit
end
