class EnrolmentsGrid

  include Datagrid

  scope do
    Enrolment
  end

  #
  # Filters
  #

  
  filter(:id, :string, :multiple => ',')
  filter(:user, :integer, :multiple => ',')
  filter(:initiative, :integer, :multiple => ',')

  #
  # Columns
  #

  column(:id, :mandatory => true) do |model|
    format(model.id) do |value|
      value
    end
  end
  column(:user_id, :header => 'User', :mandatory => true) do |model|
    format(model.user_id) do |value|
      user = User.find(value)
      link_to user.name, user
    end
  end
  column(:initiative_id, :header => 'Initiative', :mandatory => true) do |model|
    format(model.initiative_id) do |value|
      init = Initiative.find(value)
      link_to init.name, init
    end
  end
  column(:created_at, :header => 'Enrolled', :mandatory => true) do |model|
    format(model.created_at) do |value|
      value.strftime("%d/%m/%Y - %H:%M")
    end
  end
  column(:created_at, :header => 'Un-Enrolled', :mandatory => true) do |model|
    format(model.updated_at) do |value|
      if value == model.created_at
        'Still enrolled'
      else
        value.strftime("%d/%m/%Y - %H:%M")
      end
    end
  end

end
