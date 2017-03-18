require_relative '../bin/environment.rb'

class GetApod

  BASE_URL = 'https://api.nasa.gov/planetary/apod?api_key='
  API_KEY = 'DEMO_KEY'

  def self.new_data(date: nil)
    @date = date
    data = JSON.parse((open "#{BASE_URL}#{API_KEY}#{'&date=' if date}#{@date}").read)

    {
      copyright: data["copyright"],
      date: data["date"],
      explanation: data["explanation"],
      hdurl: data["hdurl"],
      media_type: data["media_type"],
      title: data["title"],
      url: data["url"].gsub("http", "https")
    }

  end
end
