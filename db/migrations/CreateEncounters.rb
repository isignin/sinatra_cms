Sequel.migration do
  up do
    create_table(:encounters) do
      Integer :contact_id
      String :contact_date
      
    end
    add_index :encounters, [:contact_id] 
  end

  down do
    drop_table(:encounters)
  end
end