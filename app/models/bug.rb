class Bug < ActiveRecord::Base
  has_many :states, dependent: :destroy
  accepts_nested_attributes_for :states, allow_destroy: true

  validates_presence_of :application_token
  validates_uniqueness_of :number, scope: :application_token,
                                   case_sensitive: false

  enum status: [:new_bug, 'in-progress', :closed]
  enum priority: { minor: 0, major: 1, critical: 2 }

  # for documentation: https://github.com/felipediesel/auto_increment
  auto_increment :number, scope: [:application_token],
                          initial: '1',
                          force: true,
                          lock: false

  after_commit :reset_count

  def self.cached_count_for(token)
    Rails.cache.fetch(['bug_count', token]) { Bug.where(application_token: token).count }
  end

  private

  def reset_count
    CountBugsJob.perform_async(application_token)
  end
end
