class Project
  attr_accessor :id, :name, :org, :alerts

  def self.all_for_organization(org)
    Rails.cache.fetch("Projects for org: #{org.id}", expires_in: 5.minutes) do
      LSPublicAPI.get("#{org.id}/projects").collect do |project|
        Project.new(project["id"], project["attributes"]["name"], org)
      end
    end
  end

  def initialize(id, name = "No name found", org)
    @id = id
    @name = name
    @org = org
  end

  def alerts
    Alert.all_for_project(self)
  end

  def alert(id:)
    alerts.find { |alert| alert.id == id }
  end
end
