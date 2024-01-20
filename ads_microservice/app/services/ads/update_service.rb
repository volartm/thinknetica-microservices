module Ads
  class UpdateService
    prepend BasicService

    param :id
    param :data
    option :ad, default: proc { Ad.first(id: @id) }

    def initialize(*args)
      super(*args)
      @errors = []
    end

    def call
      return fail!() if @ad.blank?
      @ad.update_fields(@data, %i[lat lon])
    end
  end
end