# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  lat                :decimal(15, 10)
#  lng                :decimal(15, 10)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  attr_accessible :lat, :lng, :image
  
  has_attached_file :image,
                    :styles => { :thumbnail => "100x100#" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS
  
  COORDINATE_DELTA = 0.5
  
  scope :nearby, lambda { |lat, lng|
    where("lat BETWEEN ? AND ?", lat - COORDINATE_DELTA, lat + COORDINATE_DELTA).
    where("lng BETWEEN ? AND ?", lng - COORDINATE_DELTA, lng + COORDINATE_DELTA).
    limit(64)
  }
  
  def as_json(options = nil)
      {
        :lat => self.lat,
        :lng => self.lng,

        :image_urls => {
          :original => self.image.url,
          :thumbnail => self.image.url(:thumbnail)
        },

        :created_at => self.created_at.iso8601
      }
    end
  
end
