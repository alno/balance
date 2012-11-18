require 'mechanize'

class Balance::Providers::DomolinkKaluga

  def check( login, password )
    agent = Mechanize.new
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE

    login_page = agent.get 'https://room.centertelecom.ru/klg/www.PageViewer?page_name=S*START_PAGE'
    login_form = login_page.forms.first
    login_form.field(:name => 'p_logname').value = login.upcase
    login_form.field(:name => 'p_pwd').value = password

    result_page = login_form.submit
    result_page.parser.css('.dat').text.match(/\d+\.\d+/)[0].to_f
  end

end
