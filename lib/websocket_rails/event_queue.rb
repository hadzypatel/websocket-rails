class EventQueue

  attr_reader :queue

  def initialize
    @queue = []
  end

  def enqueue(event)
    @queue << event
  end
  alias :<< :enqueue

  def last
    @queue.last
  end

  def flush(&block)
    unless block.nil?
      @queue.each do |item|
        block.call item
      end
    end
    @queue = []
  end

end
