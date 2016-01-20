require_relative 'environment'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def self.list
    Contact.all.each do |contact|
      puts "#{contact.id}: #{contact.name} (#{contact.email})"
    end
  end

  def self.new(name, email)
    Contact.create(name: name, email: email)
  end

  def self.show(id)
    contact = Contact.find id
    puts "#{contact.id}: #{contact.name} (#{contact.email})"
  end

  def self.search(search_string)
    contacts = Contact.where("name LIKE ? OR email LIKE ?", "%#{search_string}%", "%#{search_string}%")
    contacts.each do |contact|
      puts "#{contact.id}: #{contact.name} (#{contact.email})"
    end
  end

  def self.update(id)
    contact = Contact.find(ARGV[1])
    unless contact.nil?
      print "What will the new name be? "
      name = $stdin.gets.chomp
      print "What will the new email be? "
      email = $stdin.gets.chomp
      contact.name = name
      contact.email = email
      Contact.save
    end
  end

  def self.delete(id)
    contact = Contact.find id
    contact.destroy
  end
end
if ARGV.length == 0
  puts "Here is a list of available commands"
  puts "\s\snew      - Create a new contact"
  puts "\s\slist     - List all contacts"
  puts "\s\sshow     - Show a contact"
  puts "\s\ssearch   - Search contacts"
  puts "\s\supdate   - Update contact"
  puts "\s\sdelete   - Delete contact"

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

when "update"
  if ARGV[1].nil?
    puts "You need to enter an ID as the second argument."
    exit
  end
  ContactList.update(ARGV[1])

when "delete"
  if ARGV[1].nil?
    puts "You need to enter an ID as the second argument."
    exit
  end
  ContactList.delete(ARGV[1])
end
