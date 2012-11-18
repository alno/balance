require 'mechanize'

class Balance::Providers::MegafonMoscow

  def check( number, password )
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Linux; U; Android 2.2; en-us; Desire_A8181 Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1'

    lp = agent.post 'https://moscowsg.megafon.ru/ps/scc/php/check.php?CHANNEL=WWW', 'LOGIN' => number, 'PASSWORD' => password
    sid = Nokogiri::XML(lp.body).css('SESSION_ID').text

    p = agent.post 'https://moscowsg.megafon.ru/SCWWW/ACCOUNT_INFO', 'CHANNEL' => 'WWW', 'P_USER_LANG_ID' => 1, 'find' => '', 'SESSION_ID' => sid
    p.parser.css('.balance_good').text.match(/-?\d+\.\d+/)[0].to_f
  end

end

Balance.add_provider! 'megafon_moscow', Balance::Providers::MegafonMoscow
