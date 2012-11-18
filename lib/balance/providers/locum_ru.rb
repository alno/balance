require 'mechanize'

class Balance::Providers::LocumRu

  def check( login, password )
    agent = Mechanize.new

    login_page = agent.get 'http://locum.ru/'
    login_form = login_page.forms.first
    login_form.field(:name => 'login_data[login]').value = login
    login_form.field(:name => 'login_data[password]').value = password

    login_form.submit.parser.css('#cpl-data .section .value .number').first.text.to_f
  end

end
