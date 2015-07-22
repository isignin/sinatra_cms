Sequel.migration do
  up do
    create_table(:contacts) do
      Integer :contacted_by_id
      Integer :contact_with_id
    end
    add_index :contacts, [:contacted_by_id, :contact_with_id] 
  end

  down do
    drop_table(:contacts)
  end
end