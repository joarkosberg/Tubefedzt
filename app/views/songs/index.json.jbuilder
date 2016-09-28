json.array!(@songs) do |song|
  json.extract! song, :id, :title, :link, :length
  json.url song_url(song, format: :json)
end
