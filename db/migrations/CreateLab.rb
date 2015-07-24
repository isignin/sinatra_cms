Sequel.migration do
  up do
    create_table(:labs) do
      primary_key :id
      Integer :person_id
      String :date_received
      String :date_completed
      String :result
      String :tested_by
      Boolean :completed, :default=> false
    end
  end

  down do
    drop_table(:labs)
  end
end