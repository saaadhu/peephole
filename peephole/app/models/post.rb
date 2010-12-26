class Post < ActiveRecord::Base

  belongs_to :user

  has_many :responses, :class_name => "Post"
  belongs_to :parent, :class_name => "Post"

  validates_presence_of :title, :content, :user

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

  def blog_entry?
    self.post_type == :blog
  end

end
