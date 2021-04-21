class MapMarkersDecorator < Draper::CollectionDecorator

  def to_map_marker_json
    to_json(only: [:id, :latitude, :longitude, :public], methods: [:map_marker_display])
  end
end
