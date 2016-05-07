class CountBugsJob
  include Sidekiq::Worker

  def perform(token)
    Bug.expire_cached_count(token)
  end
end
