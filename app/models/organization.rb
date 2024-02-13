class Organization
  attr_accessor :id, :name, :projects

  def initialize(id, name)
    @id = id
    @name = name
    @projects = [
      Project.new(1, "Sample Project 1"),
      Project.new(2, "Sample Project 2"),
      Project.new(3, "Sample Project 3"),
    ]
  end
end
