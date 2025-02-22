module UsersHelper

  def self.send_signup_followup
    cond = "welcome_sent_at IS NULL"
    User.find_in_batches(:conditions => cond) do |users|
      users.each {|u| QC.enqueue("UsersHelper.send_wlcome_email", u.id) }
    end
  end

  def self.send_wlcome_email(user_id)
    user = User.find(user_id)
    puts "sending welcome email to #{user.id}"
    user.update_attribute :welcome_sent_at, Time.now
  end

  def self.send_email(user_id)
    user = User.find(user_id)
    puts "sending email to #{user.id}"
  end

  def self.make_avatar(user_id)
    user = User.find(user_id)
    puts "making avatar for #{user.id}"
  end

end
