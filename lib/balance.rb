class Balance

  module Providers; end

  class ProviderNotFound < StandardError; end

  class << self

    # Get provider by name
    def provider name
      const_name = camelize name.to_s

      unless Providers.const_defined? const_name
        require File.join(File.dirname(__FILE__), 'balance', 'providers', name.to_s)
      end

      Providers.const_get(const_name).new
    rescue LoadError
      nil
    end

    private

    # Based on https://github.com/intridea/omniauth/blob/v1.0.2/lib/omniauth.rb#L129-139
    def camelize(str)
      str.to_s.gsub(/\/(.?)/){ "::" + $1.upcase }.gsub(/(^|_)(.)/){ $2.upcase }
    end

    def underscore(str)
      str.to_s.gsub(/::(.?)/){ "/" + $1.downcase }.gsub(/(^|_)(.)/){ $2.upcase }.gsub(/^(.)/){ $1.downcase }
    end

  end

end
