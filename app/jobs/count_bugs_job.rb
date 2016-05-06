class CountBugsJob
  include Sidekiq::Worker

  def perform(token)
    Rails.cache.delete(['bug_count', token])
    Rails.cache.fetch(['bug_count', token]) { Bug.where(application_token: token).count }
  end
end
