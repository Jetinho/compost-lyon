class MapMarkersDecorator < Draper::CollectionDecorator

  def self.public_composter_marker
    'public_composter_marker.png'
  end

  def self.private_composter_marker
    'private_composter_marker.png'
  end

  def to_map_marker_json
    to_json(only: [:id, :latitude, :longitude, :public], methods: [:map_marker_display])
  end

end
