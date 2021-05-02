class MapMarkersDecorator < Draper::CollectionDecorator

  def to_map_marker_json
    to_json(only: [:id, :latitude, :longitude], methods: [:map_marker_display, :icon_url])
  end
end
