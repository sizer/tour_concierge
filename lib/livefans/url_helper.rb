# frozen_string_literal: true

module Livefans
  module UrlHelper # :nodoc:
    def livefans_root_url
      'http://www.livefans.jp'
    end

    def venues_list_path(pref_code, page)
      format(venues_list_path_format, pref_code, page)
    end

    def venues_list_path_format
      livefans_root_url + '/venue/search/area/JPN-%02d/page:%01d'
    end

    def fetch_page(url)
      if @last_fetched.present? && (Time.current.to_i - @last_fetched) < 2
        sleep 1 while (Time.current.to_i - @last_fetched) < 2
      end
      @last_fetched = Time.current.to_i
      result = HTTPClient.get(url)
      result.body
    end
  end
end