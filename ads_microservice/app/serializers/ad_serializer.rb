class AdSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title,
    :description,
    :city,
    :lat,
    :lon
end
