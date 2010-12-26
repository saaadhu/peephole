class Post < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :title, :content

  before_create :update_datetime
  before_update :update_datetime

  def update_datetime
    self.posted_at = user.last_seen = Time.now
  end

  def get_formatted_post_time
    self.posted_at.localtime.strftime("%a, %d/%m/%Y %I:%M%p")
  end

  def can_edit? (user)
    self.user == user
  end
end
