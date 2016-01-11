require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def self.list
    file = File.open("contact_list.txt", "r")
    until file.eof?
      line = file.readline
      split_line = line.split(',')
      puts "#{split_line[0]}: #{split_line[1]} (#{split_line[2].strip})"
    end
  end
end
if ARGV.length == 0
  puts "Here is a list of available commands"
  puts "\tnew      - Create a new contact"
  puts "\tlist     - List all contacts"
  puts "\tshow     - Show a contact"
  puts "\tsearch   - Search contacts"

  exit
end

case ARGV[0]
when "list"
  ContactList.list
end
