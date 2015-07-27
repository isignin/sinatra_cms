Sequel.migration do
  up do
    create_table(:people) do
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

  down do
    drop_table(:people)
  end
end