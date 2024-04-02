class Alert
  attr_accessor :id, :name, :project, :org, :base_attributes

  def self.all_for_project(project)
    Rails.cache.fetch("Alerts for project: #{project.id}", expires_in: 5.minutes) do
      alerts = LSPublicAPI.get("#{project.org.id}/projects/#{project.id}/metric_alerts") || {}
      alerts.collect do |alert|
        Alert.new(alert["id"], project, alert["attributes"])
      end
    end
  end

  def self.find(project, id)
    Alert.all_for_project(project).find { |alert| alert.id == id }
  end

  def initialize(id, project, base_attributes)
    @id = id
    @name = base_attributes["name"] || "[no name found]"
    @project = project
    @base_attributes = base_attributes
  end

  def snoozed?
    !snooze_ends_at.nil?
  end

  def snooze_ends_at
    Rails.cache.fetch("Alert snooze status for alert: #{id}", expires_in: 5.minutes) do
      raw = LSPublicAPI.get("#{project.org.id}/projects/#{project.id}/metric_alerts/#{id}/snoozes")
      if raw.empty?
        return nil
      else
        return raw.first["data"]["attributes"]["ends-micros"]
      end
    end
  end

  def all_queries
    queries = base_attributes["metric-queries"] || []
    if base_attributes.has_key?("composite-alert")
      base_attributes.dig("composite-alert", "alerts").each do |alert|
        queries = queries.union(alert["queries"])
      end
    end

    queries.collect { |q| q["query-string"] }
  end

  def alerting_rules
    rules = base_attributes["alerting-rules"] || {}
    rules.collect do |raw|
      AlertingRule.new(raw["id"], project, raw["message-destination-client-id"], raw["update-interval-ms"])
    end
  end

  # Attributes directly on base alert
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
