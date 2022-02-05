require "pry"
require_relative "../config/environment.rb"

SQL = {
  create_table: "CREATE TABLE IF NOT EXISTS songs (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) NOT NULL, album VARCHAR(255));",
  drop_table: "DROP TABLE songs;",
  save: "INSERT INTO songs (name, album) VALUES (?, ?);",
  _get_id: "SELECT id FROM songs ORDER BY id DESC LIMIT 1;",
}

class Song
  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @name = name
    @album = album
    @id
  end

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
    song
  end

  def self.create_table
    DB[:conn].execute(SQL[:create_table])
  end

  def self.drop_table
    DB[:conn].execute(SQL[:drop_table])
  end

  def save
    DB[:conn].execute(SQL[:save], @name, @album)
    @id = DB[:conn].execute(SQL[:_get_id])[0][0]
    binding.pry
    self
  end
end

# binding.pry
