require 'mechanize'

class Balance::Providers::Yota

  def check( login, password )
    agent = Mechanize.new

    login_page = agent.get 'https://my.yota.ru/selfcare/login'
    login_form = login_page.forms[1]
    login_form.field(:name => 'IDToken1').value = login
    login_form.field(:name => 'IDToken2').value = password
    login_form.field(:name => 'IDToken3').value = password

    login_form.submit.parser.css('.account-money dd')[0].text.match(/\d+\.\d+/)[0].to_f
  end

end

Balance.add_provider! 'yota', Balance::Providers::Yota
