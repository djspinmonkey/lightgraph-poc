class Organization
  attr_accessor :id, :projects

  def initialize(id)
    @id = id
    @projects = Rails.cache.fetch("Projects for org: #{id}", expires_in: 5.minutes) do
      Project.all_for_organization(self)
    end
  end
end
