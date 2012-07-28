class UserUploadEvent < Event
  def event_occurred?(entry)
    false
  end
end
