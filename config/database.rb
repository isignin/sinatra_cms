require 'sinatra/sequel'
require 'sqlite3'
 
DB=Sequel.sqlite("tmp/cms.db")

unless DB.table_exists?(:users)
  DB.create_table :users do
    primary_key :id
    String :username
    String :email
    String :first_name
    String :last_name
    String :password_digest
    String :token
    Integer :verified, :default => false
   end
end

unless DB.table_exists?(:people)
  DB.create_table :people do
    primary_key :id
    Integer :case_id
    String :first_name
    String :last_name
    String :middle_name
    String :nickname
    String :gender
    String :birthdate
    String :parent_name
    String :date_detected
    String :form_completed_by
    String :info_transmitted_by 
    String :notified_by
    String :notification_group
    String :relationship_to_patient
    String :head_of_household
    String :village_district
    String :country
    String :nationality
    String :ethnic_group
   end
end

unless DB.table_exists?(:contacts)
  DB.create_table :contacts do
    Integer :contact_by_id
    Integer :contact_with_id
  end
  DB.add_index :contacts, [:contact_by_id, :contact_with_id] 
end

unless DB.table_exists?(:labs)
  DB.create_table :labs do
    primary_key :id
    Integer :person_id
    String :date_received
    String :date_completed
    String :result
    String :tested_by
    Boolean :completed, :default => false
   end
end


