class Person < Sequel::Model
  plugin :validation_helpers
  many_to_many :contacts_by, :right_key => :contact_by_id, :left_key => :contact_with_id, :join_table=>:contacts, :class=>self
  many_to_many :contacts_with, :left_key => :contact_by_id, :right_key => :contact_with_id, :join_table=>:contacts, :class=>self
  one_to_one :lab
  
  def validate
    super
    validates_presence [:first_name, :last_name, :gender, :birthdate, :parent_name]
  end
  
  def contacts
    contacts_by + contacts_with
  end  
    
end