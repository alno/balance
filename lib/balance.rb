class Balance

  module Providers; end

  class ProviderNotFound < StandardError; end

  class << self

    # Register new provider
    def add_provider! name, provider
      @providers ||= {}
      @providers[name.to_s] = provider
    end

    # Get provider by name
    def provider name
      require File.join(File.dirname(__FILE__), 'balance', 'providers', name.to_s)

      @providers[name.to_s].new
    rescue LoadError
      nil
    end

  end

end
