require_relative 'contact'
class ContactDataAccess
  def initialize

  end

  def get()
    file = File.open("contact_list.txt", "r")
    contacts = []
    until file.eof?
      line = file.readline
      split_line = line.split(',')
      contacts << Contact.new(id: split_line[0], name: split_line[1],
                              email: split_line[2])
    end
    file.close
    return contacts
  end

  def find(id)
    result = ""
    file = File.open("contact_list.txt", "r")
    until file.eof?
      line = file.readline
      split_line = line.split(',')
      if split_line[0] == id
        if split_line[-1].include? '|'
          phone_numbers = split_line[-1].split('|')
          file.close
          return Contact.new(id: split_line[0], name: split_line[1],
                             email: split_line[2], phone_numbers: phone_numbers)
        end
        file.close
        return Contact.new(id: split_line[0], name: split_line[1],
                           email: split_line[2])
      end
    end
  end

  def query(search_string)
    file = File.open("contact_list.txt", "r")
    until file.eof?
      line = file.readline
      if line.include? query
        split_line = line.split(',')
        if split_line[-1].include? '|'
          phone_numbers = split_line[-1].split('|')
          file.close
          return Contact.new(id: split_line[0], name: split_line[1],
                             email: split_line[2], phone_numbers: phone_numbers)
        end
        file.close
        return Contact.new(id: split_line[0], name: split_line[1],
                           email: split_line[2])
      end
    end
    file.close
  end

  def create(contact)
    contact = Contact.new(name: name, email: email)
    file = File.open("contact_list.txt", "a+")
    lines = file.readlines
    duplicate = lines.any? { |l| l.include? email }
    if duplicate
      file.close
      return "That email already exists in the list."
    else
      split_last_line = last_line.split(',')
      next_id = split_last_line[0].to_i
      contact.id = next_id + 1
      file.puts("#{contact.id},#{contact.name},#{contact.email}")
      file.close
      return "Contact #{contact.id}: #{contact.name}, #{contact.email} was" +
        " created successfully!"
    end
  end
end
