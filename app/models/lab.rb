class Lab < Sequel::Model
  plugin :validation_helpers
  many_to_many :contacts_by, :right_key => :contact_by_id, :left_key => :contact_with_id, :join_table=>:contacts, :class=>self
  many_to_many :contacts_with, :left_key => :contact_by_id, :right_key => :contact_with_id, :join_table=>:contacts, :class=>self
  many_to_one :person
  
  def validate
    super
    #validates_presence [:date_received, :date_completed, :result, :tested_by]
  end
end  