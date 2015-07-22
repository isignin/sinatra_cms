require 'sinatra/sequel'
require 'sqlite3'
 
DB=Sequel.sqlite("tmp/cms.db")

unless DB.table_exists?(:users)
  DB.create_table :users do
    primary_key :id
    varchar :username
    varchar :email
    varchar :first_name
    varchar :last_name
    varchar :password
    varchar :token
    boolean :verified, :default => false
   end
end

unless DB.table_exists?(:people)
  DB.create_table :people do
    primary_key :id
    integer :case_id
    varchar :first_name
    varchar :last_name
    date :birthdate
    varchar :parent_name
   end
end

unless DB.table_exists?(:contacts)
  DB.create_table :contacts do
    primary_key :id
    integer :contact_by_id
    integer :contact_with_id
  end
  DB.add_index :contacts, [:contact_by_id, :contact_with_id] 
end


