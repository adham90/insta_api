class CreateBugJob
  include Sidekiq::Worker

  def perform(args)
    Bug.create!(args)
  end
end
