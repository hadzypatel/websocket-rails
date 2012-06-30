module WebsocketRails
  class Channel

    attr_reader :name, :subscribers

    def initialize(channel_name)
      @subscribers = []
      @name = channel_name
    end

    def subscribe(connection)
      @subscribers << connection
    end

    def trigger(event_name,data,options={})
      options.merge! :channel => name
      event = Event.new event_name, data, options
      send_data event
    end

    def trigger_event(event)
      send_data event
    end

    private

    def send_data(event)
      puts "sending channel event: #{event.serialize}"
      subscribers.each do |subscriber|
        subscriber.trigger event
      end
    end

  end
end
