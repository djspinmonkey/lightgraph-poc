class Alert
  attr_accessor :id, :name, :project, :base_attributes

  def self.all_for_project(project)
    Rails.cache.fetch("Alerts for project: #{project.id}", expires_in: 5.minutes) do
      LSPublicAPI.get("#{project.org.id}/projects/#{project.id}/metric_alerts").collect do |alert|
        Alert.new(alert["id"], alert["attributes"], project)
      end
    end
  end

  def initialize(id, base_attributes, project)
    @id = id
    @name = base_attributes["name"] || "[no name found]"
    @project = project
    @base_attributes = base_attributes
  end

  def queries
    queries = []
    queries = queries.union(base_attributes["metric-queries"]) if base_attributes.has_key?("metric-queries")
    if base_attributes.has_key?("composite-alert")
      base_attributes.dig("composite-alert", "alerts").each do |alert|
        queries = queries.union(alert["queries"])
      end
    end

    queries.collect { |q| q["query-string"] }
  end

end
