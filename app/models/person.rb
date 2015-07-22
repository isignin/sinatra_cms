class Person < Sequel::Model
  plugin :validation_helpers
  many_to_many :contacts_by, :right_key => :contact_by_id, :left_key => :contact_with_id, :join_table=>:contacts, :class=>self
  many_to_many :contacts_with, :left_key => :contact_by_id, :right_key => :contact_with_id, :join_table=>:contacts, :class=>self
  
  # one_to_many :contacts, :foreign_key => :contact_by_id
  # one_to_many :contacts_with, :through => :contacts
  # one_to_many :contacts, :foreign_key => :contact_with_id
  # one_to_many :contacts_by, :through => :contacts
  
  def validate
    super
    validates_presence [:first_name, :last_name, :gender, :birthdate, :parent]
  end
  
  def fullname
    first_name+" "+last_name
  end  
    
end