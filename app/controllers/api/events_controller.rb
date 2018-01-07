# frozen_string_literal: true

module Api
  class EventsController < ApiBaseController # :nodoc:
    def nearby
      events = Event.nearby(search_param[:lat], search_param[:long])
                    .future
                    .limit(20)
      render json: {
        ok: 1,
        events: ActiveModelSerializers::SerializableResource.new(events, each_serializer: EventSerializer).as_json
      }
    rescue
      render json: {
        ok: 0,
        error: {
          code: 404,
          message: 'not found.'
        }
      }
    end

    private

    def search_param
      params.require(:q).permit(:lat, :long)
    end
  end
end
