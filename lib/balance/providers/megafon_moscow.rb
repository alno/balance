require 'mechanize'

class Balance::Providers::MegafonMoscow

  def check( number, password )
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Linux; U; Android 2.2; en-us; Desire_A8181 Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1'
    agent.get 'https://www.serviceguide.megafonmoscow.ru/'

    p = agent.post 'https://www.serviceguide.megafonmoscow.ru/ps/scc/mobile/', 'MOBILE_MODE' => 'AUTH', 'LOGIN' => number, 'PASSWORD' => password
    p.parser.css('#statusbalance').text.match(/\d+\.\d+/)[0].to_f
  end

end

Balance.add_provider! 'megafon_moscow', Balance::Providers::MegafonMoscow
