class MusicLibraryController
  attr_accessor :music_importer

  def initialize(path="./db/mp3s")
    @music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    input = ""
    loop do
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip

      if input == "exit"
        break
      end
    end
  end

  def list_songs
    songs_name = []
    i=0
    @music_importer.files.each {|file| songs_name << file.split(' - ')[1]}
    songs_name.sort.each { |name|
      i += 1
      puts "#{i}. #{Song.find_by_name(name).artist.name} - #{name} - #{Song.find_by_name(name).genre.name}"
    }
  end

  def list_artists
    @music_importer.files.each do |song|
      puts "1. #{song.split(' - ')[0]}"
    end
  end
end
