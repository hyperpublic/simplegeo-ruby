module SimpleGeo

  class Endpoint

    class << self
      def places(location, options={})
        params_str = ""
        options.each do |k,v|
          params_str << "#{k}=#{v}&"
        end

        query_str = case
          when location[:lat] && location[:lon] 
            then "places/#{location[:lat]},#{location[:lon]}.json?#{params_str}"
          when location[:address]
            then 
              begin
                params_str = "address=#{location[:address]}&" + params_str
                "places/address.json?#{params_str}"
              end
          when location[:ip]
            then "places/#{location[:ip]}.json?#{params_str}"
          else
            "places/ip.json?#{params_str}"
        end

        endpoint_url URI::escape(query_str.chop!)
      end

      def record(layer, id)
        endpoint_url "records/#{layer}/#{id}.json"
      end

      def records(layer, ids)
         ids = ids.join(',')  if ids.is_a? Array
         endpoint_url "records/#{layer}/#{ids}.json"
      end

      def add_records(layer)
        endpoint_url "records/#{layer}.json"
      end

      def history(layer, id)
        endpoint_url "records/#{layer}/#{id}/history.json"
      end

      def nearby_geohash(layer, geohash)
        endpoint_url "records/#{layer}/nearby/#{geohash}.json"
      end

      def nearby_coordinates(layer, lat, lon)
        endpoint_url "records/#{layer}/nearby/#{lat},#{lon}.json"
      end

      def nearby_ip_address(layer, ip)
        endpoint_url "records/#{layer}/nearby/#{ip}.json"
      end

      def nearby_address(lat, lon)
        endpoint_url "nearby/address/#{lat},#{lon}.json"
      end

      def geocode(address)
        endpoint_url "geocode/address.json?q=#{Endpoint.escape_uri(address)}"
      end

      def density(lat, lon, day, hour=nil)
        if hour.nil?
          path = "density/#{day}/#{lat},#{lon}.json"
        else
          path = "density/#{day}/#{hour}/#{lat},#{lon}.json"
        end
        endpoint_url path
      end

      def layer(layer)
        endpoint_url "layer/#{layer}.json"
      end

      def contains(lat, lon)
        endpoint_url "contains/#{lat},#{lon}.json"
      end

      def contains_ip_address(ip)
        endpoint_url "contains/#{ip}.json"
      end

      def overlaps(south, west, north, east)
        endpoint_url "overlaps/#{south},#{west},#{north},#{east}.json"
      end

      def boundary(id)
        endpoint_url "boundary/#{id}.json"
      end

      def locate(ip)
        endpoint_url "locate/#{ip}.json"
      end

      def endpoint_url(path)
        [REALM, API_VERSION, path].join('/')
      end

      def escape_uri(param)
        URI.escape(param, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      end
    end

  end

end
