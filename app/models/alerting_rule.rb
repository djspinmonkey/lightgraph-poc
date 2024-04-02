class AlertingRule
  attr_accessor :id, :project, :message_destination_client_id, :update_interval

  def initialize(id, project, dest_id, update_interval)
    @id = id
    @project = project
    @message_destination_client_id = dest_id
    @update_interval = update_interval
  end

  def destination
    @destination ||= AlertDestination.find(project, message_destination_client_id)
  end
end
