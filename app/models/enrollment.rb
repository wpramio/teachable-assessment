class Enrollment
  include ActiveModel::Model
  attr_accessor :enrolled_at, :expires_at, :completed_at, :percent_complete,
                :user_id, :user_name, :user_email

  def expired?
    return false unless expires_at
    Time.parse(expires_at) < Time.now
  end

  def enrolled_at
    Time.parse(@enrolled_at).strftime("%B %d, %Y")
  end
end
