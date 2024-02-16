class Organization
  attr_accessor :id, :projects

  def initialize(id)
    @id = id
    @projects = Project.all_for_organization(self)
  end

  def project(id:)
    projects.find { |project| project.id == id }
  end
end
