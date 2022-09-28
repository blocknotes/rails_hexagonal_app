# frozen_string_literal: true

class BaseService
  def notify(listeners, message, *args)
    listeners.each do |listener|
      listener.send(message, *args) if listener.respond_to? message
    end
  end

  class << self
    def call(*args)
      new.call(*args)
    end
  end
end
