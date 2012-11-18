require 'net/http'
require 'nokogiri'

class Balance::Providers::Maxnet

  def check( login, password )
    encoded_login = URI.encode login
    encoded_password = URI.encode password

    req = Net::HTTP::Post.new '/cgi-bin/index.cgi'
    req['Accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    req['User-Agent'] = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:16.0) Gecko/20100101 Firefox/16.0'
    req['Accept-Language'] = 'en-US,en;q=0.5'
    req['Accept-Encoding'] = 'gzip, deflate'
    req['Connection'] = 'keep-alive'
    req['Referer'] = 'https://stat.maxnet.ru//cgi-bin/login.cgi'
    req['Cookie'] = "data=sid&&login&#{encoded_login}; pass=#{encoded_login}&#{encoded_password}"
    req.body = "username=#{encoded_login}&password=#{encoded_password}&action=login"

    res = Net::HTTP.start('stat.maxnet.ru', 443, use_ssl: true) { |http| http.request(req) }

    Nokogiri::HTML(res.body).css('font b').text.to_f
  end

end
