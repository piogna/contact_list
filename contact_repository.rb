require 'pg'
require_relative 'contact'
class ContactRepository
  def initialize

  end
  def self.connection
    @@connection ||= PG.connect(
      host: 'localhost',
      dbname: 'contact_list',
      user: 'development',
      password: 'development'
    )
  end
  def self.all()
    contacts = []
    connection.exec("SELECT * FROM CONTACTS ORDER BY id;") do |records|
      records.each do |contact|
        contacts << Contact.new(id: contact['id'], name: contact['name'], email: contact['email'])
      end
    end
    contacts
  end

  def self.find(id)
    results = connection.exec("SELECT * FROM CONTACTS WHERE id=#{id};")
    if record = results.first
      contact = Contact.new(id: record['id'], name: record['name'], email: record['email'])
      phone_numbers = connection.exex("SELECT * FROM phone_numbers;")
    end
    nil
  end

  def self.query(search_string)
    contacts = []
    results = connection.exec("SELECT * FROM contacts c WHERE c::text LIKE '%#{search_string}%' ORDER BY id") do |records|
      records.each do |contact|
        contacts << Contact.new(id: contact['id'], name: contact['name'], email: contact['email'])
      end
    end
    contacts
  end

  def self.destroy(id)
    contact = find id
    unless contact.nil?
      connection.exec("DELETE FROM phone_numbers WHERE contact_id = #{id}")
      connection.exec("DELETE FROM contacts WHERE id = #{id}")
      return "Contact: #{id} successfully deleted!"
    end
    "Contact: #{id} could not be found"
  end

  def self.update(contact)
    save contact
  end

  def self.create(contact)
    save contact
  end

  def self.save(contact)
    if contact.id.nil?
      connection.exec("INSERT INTO contacts (name, email) VALUES ('#{contact.name}', '#{contact.email}')")
    else
      connection.exec("UPDATE contacts SET name='#{contact.name}', email='#{contact.email}' WHERE id=#{contact.id}")
    end
  end
end
