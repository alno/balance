require 'mechanize'

class Balance::Providers::MtsMoscow

  def check( number, password )
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Linux; U; Android 2.2; en-us; Desire_A8181 Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1'

    login_page = agent.get 'https://ihelper.mts.ru/SELFCAREPDA/Security.mvc/LogOn'
    login_form = login_page.forms.first
    login_form.field(:name => 'username').value = number
    login_form.field(:name => 'password').value = password

    login_form.submit.parser.css('.main p strong strong').text.to_f
  end

end

Balance.add_provider! 'mts_moscow', Balance::Providers::MtsMoscow
