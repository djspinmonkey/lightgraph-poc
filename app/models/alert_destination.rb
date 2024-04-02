class AlertDestination
  attr_accessor :id, :project, :name, :type, :channel, :scope, :url, :template, :username

  def self.find(project, id)
    Rails.cache.fetch("Alert destination: #{id}", expires_in: 5.minutes) do
      raw = LSPublicAPI.get("#{project.org.id}/projects/#{project.id}/destinations/#{id}")
      AlertDestination.new(id, project, raw["attributes"])
    end
  end

  def initialize(id, project, attributes = {})
    @id = id
    @project = project
    @type = attributes["destination_type"]
    @channel = attributes["channel"]
    @scope = attributes["scope"]
    @url = attributes["url"]
    @template = attributes["template"]
    @username = attributes.dig("auth", "username")
  end
end
