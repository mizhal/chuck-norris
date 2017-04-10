class ChuckNorrisService

	RANDOM_ENDPOINT = "https://api.chucknorris.io/jokes/random"
	QUERY_ENDPOINT = "https://api.chucknorris.io/jokes/search?query="
	CATEGORIES_ENDPOINT = "https://api.chucknorris.io/jokes/categories"

	def query query_object
		case query_object.kind
			when "random"
				get_random query_object
			when "query"
				get_query query_object
			when "category_kind"
				get_category query_object
			else
				set_error query_object
		end
	end
	
	def get_random query_object
	end

	def get_query query_object
	end

	def get_category query_object
	end

	def set_error query_object
	end

	def do_get url
		uri = URI.parse(url)
		Net::HTTP.new(uri.host, uri.port).start do |client|
			Net::HTTP.Get.new(uri.request_uri) do |req|
				return client.request(req)
			end
		end
	end

	def manage_errors(response, query_object)
		query_object.response_status = response.status
		if response.status != 200
			false
		else
			true
		end
	end
end