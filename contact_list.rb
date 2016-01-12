require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def self.list
    file = File.open("contact_list.txt", "r")
    i = 1
    until file.eof?
      line = file.readline
      split_line = line.split(',')
      puts "#{split_line[0]}: #{split_line[1]} (#{split_line[2].strip})"
      if i % 5 == 0
        puts "Press any key to show the next 5 lines"
        $stdin.gets
        system "clear"
      end
      i += 1
    end
    file.close
  end

  def self.new(name, email)
    contact = Contact.new(name: name, email: email)
    file = File.open("contact_list.txt", "a+")
    lines = file.readlines
    duplicate = lines.any? { |l| l.include? email }
    if duplicate
      puts "That email already exists in the list."
    else
      split_last_line = last_line.split(',')
      next_id = split_last_line[0].to_i
      contact.id = next_id + 1
      file.puts("#{contact.id},#{contact.name},#{contact.email}")
      puts "Contact #{contact.id}: #{contact.name}, #{contact.email} was" +
        " created successfully!"
    end
    file.close
  end

  def self.show(id)
    result = ""
    file = File.open("contact_list.txt", "r")
    until file.eof?
      line = file.readline
      split_line = line.split(',')
      if split_line[0] == id
        result = "#{split_line[0]}: #{split_line[1]} (#{split_line[2].strip})\n"
        if split_line[-1].include? '|'
          phone_numbers = split_line[-1].split('|')
          phone_numbers.each { |num| result << "\t" + num + "\n"}
        end
      end
    end
    file.close
    result = "Sorry, that ID could not be found" if result.length == 0
    puts result
  end

  def self.search(query)
    result = ""
    file = File.open("contact_list.txt", "r")
    until file.eof?
      line = file.readline
      if line.include? query
        split_line = line.split(',')
        result = "#{split_line[0]}: #{split_line[1]} (#{split_line[2].strip})"
      end
    end
    file.close
    result = "Sorry, that ID could not be found" if result.length == 0
    puts result

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
when "new"
  print "Enter the contact's full name: "
  name = $stdin.gets.chomp
  print "Enter the contact's email: "
  email = $stdin.gets.chomp
  ContactList.new(name, email)

when "show"
  if ARGV[1].nil?
    puts "You need to enter an ID as the second argument."
    exit
  end
  ContactList.show(ARGV[1])

when "search"
  if ARGV[1].nil?
    puts "You need to enter a query."
    exit
  end
  ContactList.search(ARGV[1])
end
