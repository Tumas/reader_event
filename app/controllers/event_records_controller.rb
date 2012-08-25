class EventRecordsController < ApplicationController
  def index
    @event_records = EventRecord.order('created_at desc')
  end
end
