require_relative '../bin/environment.rb'

class Wallpaper

  def delete_old_image
    FileUtils.rm_rf(Dir.glob('tmp/image.jpg')) if File.exist? 'tmp/image.jpg'
  end

  def save_image(src)
    # https = src.gsub("http", "https")
    image = MiniMagick::Image.open(src)
    image.write('tmp/image.jpg')
  end

  def change_wallpaper
    path = File.absolute_path('tmp/image.jpg')
    cmd = "sqlite3 ~/Library/Application\\ Support/Dock/desktoppicture.db \"update data set value = '#{path}'\" && killall Dock"
    `#{cmd}`
  end
end
