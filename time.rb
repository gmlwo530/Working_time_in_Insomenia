require 'nokogiri'
require 'open-uri'
require 'mechanize'

times = 0

agent = Mechanize.new

4.times do |index|
  page = agent.get("https://insomenia.com/works?page=#{index+1}")

  if index == 0
    form = page.forms[1]
    form.field_with(id: 'user_email').value = "" #이메일을 적어주세요
    form.field_with(id: 'user_password').value = "" #비밀번호를 적어주세요

    page_login = form.submit
  end
  tkb_page = agent.get ARGV[0]

  result_page = Nokogiri::HTML(tkb_page.body)

  result_page.css("tr td:nth-child(3)").each do |l|
    time = l.text.delete "시간"
    puts "#{time}시간"
    times += time.to_f
  end
end
puts "총 #{times}시간"
