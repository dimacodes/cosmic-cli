require_relative '../bin/environment.rb'
require_relative "./get_apod.rb"
require_relative "./apod.rb"
require_relative "./ascii_art.rb"
require_relative './wallpaper.rb'

class CLI

  def run
    clear_screen
    greeting
    create_apod
    display_apod_title
    display_ascii_image
    # apod_copyright_info (usually nil)
    menu
    puts "Goodbye!"
    puts
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def greeting
    puts "\nWelocme to NASA's Astronomy Picture of the Day. Each day a different image of our fascinating universe is featured, along with a brief explanation written by a professional astronomer.\n"
    puts "\nToday's picture is:\n"
  end

  def create_apod(date: nil)
    apod_data = GetApod.new_data(date: date)
    apod = Apod.new(apod_data)
  end

  def display_apod_title
    puts "\n#{Apod.most_recent.title}"
  end

  def display_ascii_image
    puts AsciiArt.generate(src: Apod.most_recent.url)
  end

  # def apod_copyright_info
  #   puts "#{Apod.most_recent.copyright}"
  # end

  def menu
    @input = nil
    while @input != "q"
      puts "\nYou can (r)ead the expalnation of the picture, (v)iew it in your browser, search by (d)ate for another day's picture, (s)et it as your (w)allpaper, or visit the NASA (www)ebsite.\n"
      puts "\nWhat would you like to do? (Please type 'r', 'v', 'd', 'sw', 'www' or 'q' to exit.)\n"
      puts
      @input = gets.strip.downcase
      if @input == "r"
          puts "\n#{Apod.most_recent.explanation}\n"
        elsif @input == "v"
          launch_in_browser
        elsif @input == "d"
          create_apod_by_date
        elsif @input == "sw"
          set_wallpaper
        elsif @input == "www"
          visit_website
        elsif @input == "q"
          puts
        else
          puts
          puts "Not sure what you want."
        end
      end
    end
  end

  def set_wallpaper
    wallpaper = Wallpaper.new
    wallpaper.delete_old_image
    wallpaper.save_image(Apod.most_recent.hdurl)
    wallpaper.change_wallpaper
  end

  def launch_in_browser
    Launchy.open("#{Apod.most_recent.url}")
  end

  def visit_website
    Launchy.open("http://apod.nasa.gov/apod/")
  end

  def create_apod_by_date
    puts "\nPlease enter a date in the format YYYY-MM-DD (The oldest date is 1995-09-22 and the newest is #{Apod.most_recent.date}):\n"
    puts
    @input = gets.strip.downcase
    date = @input
    validate(date)
    create_apod(date: date)
    clear_screen
    display_apod_title
    display_ascii_image
    # apod_copyright_info
    menu
  rescue
    date_error
    create_apod_by_date
  end

  def validate(date)
    invalid_date unless date =~ /\d{4}-\d{2}-\d{2}/
  end

  def invalid_date
    puts
    puts "The date you entered was not in the correct format."
  end

  def date_error
    puts
    puts "There was a problem retrieving the picture for that date, please try another date!"
  end
