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
    queries = base_attributes["metric-queries"] || []
    if base_attributes.has_key?("composite-alert")
      base_attributes.dig("composite-alert", "alerts").each do |alert|
        queries = queries.union(alert["queries"])
      end
    end

    queries.collect { |q| q["query-string"] }
  end

  # Attributes directly on base alert
  def alerting_rules = base_attributes["alerting-rules"]
  def description = base_attributes["description"]
  def labels = base_attributes["labels"]

  # Attributes on base alert expression
  def enable_no_data_alert = base_attributes.dig("expression", "enable-no-data-alert")
  def no_data_duration = base_attributes.dig("expression", "no-data-duration-ms")
  def operand = base_attributes.dig("expression", "operand")
  def warning_threshold = base_attributes.dig("expression", "thresholds", "warning")
  def warning_threshold_duration = base_attributes.dig("expression", "thresholds", "warning-duration-ms")
  def critical_threshold = base_attributes.dig("expression", "thresholds", "critical")
  def critical_threshold_duration = base_attributes.dig("expression", "thresholds", "critical-duration-ms")
  def is_multi_alert = base_attributes.dig("expression", "is-multi-alert")

end
