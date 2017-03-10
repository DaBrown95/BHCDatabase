class ConditionsGrid
  include Datagrid

  scope do
    Condition
  end

  column(:id, :mandatory => true) do |model|
    format(model.id) { |value| link_to value, MedicalCondition.find(model.medical_condition_id) }
  end
  column(:medical_condition_id, :mandatory => true) do |model|
    format(model.medical_condition_id) do
      link_to MedicalCondition.find(model.medical_condition_id).name, MedicalCondition.find(model.medical_condition_id)
    end
  end
  column(:created_at, :mandatory => true, :header => 'Assigned Condition') do |model|
    format(model.created_at) { |value| value.strftime('%d/%m/%Y - %H:%M') }
  end
  column(:updated_at, :mandatory => true, :header => 'Unassigned Condition') do |model|
    format(model.updated_at) do |value|
      if model.updated_at == model.created_at
        'Still have this condition'
      else
        value.strftime('%d/%m/%Y - %H:%M')
      end
    end
  end
end
