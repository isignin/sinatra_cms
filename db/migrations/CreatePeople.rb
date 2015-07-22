Sequel.migration do
  up do
    create_table(:people) do
      primary_key :id
      Integer :case_id
      String :first_name
      String :last_name
      String :birthdate
      String :parent_name  
    end
  end

  down do
    drop_table(:people)
  end
end