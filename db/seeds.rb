# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
locations = {
  :sf   => [37.75, 122.68],
  :atx  => [30.30, 97.70],
  :pit  => [40.50, 80.22],
  :mia  => [25.65, 80.43],
  :chi  => [41.90, 87.65],
  :abq  => [35.05, 106.60],
  :nola => [29.98, 90.25],
  :nyc  => [40.77, 73.98],
  :la   => [33.93, 118.40],
  :dc   => [38.85, 77.04],
  :bos  => [42.37, 71.03],
  :kc   => [39.12, 94.60]
}

image = File.open(File.join(Rails.root, "public", "sgi-retro-logo.png"))

locations.values.each do |coordinate|
  Photo.create(:lat => coordinate[0], :lng => coordinate[1], :image => image)
end