class ChuckNorrisService

	RANDOM_ENDPOINT = "https://api.chucknorris.io/jokes/random"
	QUERY_ENDPOINT = "https://api.chucknorris.io/jokes/search?query="
	CATEGORY_ENDPOINT = "https://api.chucknorris.io/jokes/random?category="
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

		query_object
	end

	def get_random query_object
		single_entry = do_get_json(RANDOM_ENDPOINT, query_object)
		generate_result(single_entry, query_object)
	end

	def get_query query_object
		entries = do_get_json(QUERY_ENDPOINT + query_object.words, query_object)
		if entries.any?
			generate_results(entries["result"], query_object)
		end
	end

	def get_category query_object
		single_entry = do_get_json(CATEGORY_ENDPOINT + query_object.category, query_object)
		if single_entry.any?
			generate_result(single_entry, query_object)
		end
	end

	def set_error query_object
		query_object.response_status = 404
		query_object.response_error = I18n.t("services.unknown_query_kind")
	end

	### AUXILIARES

	def do_get url
		uri = URI.parse(url)
		Net::HTTP.get_response(uri)
	end

	def do_get_json url, query_object
		response = do_get url
		if manage_errors(response, query_object)
			JSON.parse(response.body)
		else
			[]
		end
	end

	def manage_errors(response, query_object)
		query_object.response_status = response.code.to_i
		if response.code.to_i == 200
			true
		else
			false
		end
	end

	def generate_results(json_data, query_object)
		json_data.each do |data|
			generate_result(data, query_object)
		end
	end

	def generate_result(data, query_object)
		if data.has_key? "id"
			data["remote_id"] = data.delete("id")
		end

		res = query_object.results.build(data)
		unless res.save
			query_object.response_error += res.error.full_messages
		end		
	end

	### FIN: AUXILIARES
end