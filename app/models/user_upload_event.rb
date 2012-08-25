class UserUploadEvent < Event
  def event_occurred? entry 
    @users = fetch_users entry
    @users.any?
  end

  def event_options feed_entry
    { headline: "Message: User activity detected for #{@users.join(", ")}" }
  end

  private 

  def tracked_users
    LM::TRACKED_USERS
  end

  def fetch_users entry
    page = agent.get entry.url
    form = page.forms.first

    # handle incorrect login : create notification model (counter)
    if form and form.action == 'takelogin.php'
      login(form) 
    end

    user_activity = []
    tracked_users.each do |username|
      if agent.page.link_with text: username
        user_activity << username
      end
    end

    user_activity
  end

  def login form
    form.username = LM::USERNAME
    form.password = LM::PASSWORD
    form.submit
  end

  def agent
    @agent ||= Mechanize.new
  end
end
