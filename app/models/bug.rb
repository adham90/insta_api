class Bug < ActiveRecord::Base
  CACHE_NAME = self.class.name

  has_many :states, dependent: :destroy
  accepts_nested_attributes_for :states, allow_destroy: true

  validates_presence_of :application_token
  validates_uniqueness_of :number, scope: :application_token,
                                   case_sensitive: false

  enum status: { new_bug: 0, 'in-progress' => 1, closed: 2 }
  enum priority: { minor: 0, major: 1, critical: 2 }

  auto_increment :number, scope: [:application_token],
                          initial: '1',
                          force: true,
                          lock: false

  after_create :reset_count

  def self.cached_count_for(token)
    Rails.cache.fetch([CACHE_NAME, token]) { Bug.where(application_token: token).count }
  end

  def self.expire_cached_count(token)
    count = Rails.cache.fetch([CACHE_NAME, token])
    Rails.cache.write([CACHE_NAME, token], count + 1)
  end

  private

  def reset_count
    CountBugsJob.perform_async(application_token)
  end
end
