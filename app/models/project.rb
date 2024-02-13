class Project
  attr_accessor :id, :name

  def self.all_for_organization(org)
    LSPublicAPI.get("#{org.id}/projects").collect do |project|
      Project.new(project["id"], project["name"])
    end
  end

  def initialize(id, name)
    @id = id
    @name = name
  end
end
