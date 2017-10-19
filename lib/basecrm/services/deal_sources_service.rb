# WARNING: This code is auto-generated from the BaseCRM API Discovery JSON Schema

module BaseCRM
  class DealSourcesService
    OPTS_KEYS_TO_PERSIST = Set[:name, :resource_type]

    def initialize(client)
      @client = client
    end

    # Retrieve all sources
    #
    # get '/deal_sources'
    #
    # If you want to use filtering or sorting (see #where).
    # @return [Enumerable] Paginated resource you can use to iterate over all the resources.
    def all
      PaginatedResource.new(self)
    end

    # Retrieve all sources
    #
    # get '/deal_sources'
    #
    # Returns all deal sources available to the user according to the parameters provided
    #
    # @param options [Hash] Search options
    # @option options [String] :ids Comma-separated list of deal source IDs to be returned in a request.
    # @option options [String] :name Name of the source to search for. This parameter is used in a strict sense.
    # @option options [Integer] :page (1) Page number to start from. Page numbering starts at 1, and omitting the `page` parameter will return the first page.
    # @option options [Integer] :per_page (25) Number of records to return per page. The default limit is *25* and the maximum number that can be returned is *100*.
    # @option options [String] :sort_by (id:asc) A field to sort by. The **default** ordering is **ascending**. If you want to change the sort order to descending, append `:desc` to the field e.g. `sort_by=name:desc`.
    # @return [Array<DealSource>] The list of DealSources for the first page, unless otherwise specified.
    def where(options = {})
      _, _, root = @client.get("/deal_sources", options)

      root[:items].map{ |item| DealSource.new(item[:data]) }
    end


    # Create a new source
    #
    # post '/deal_sources'
    #
    # Creates a new source
    # <figure class="notice">
    # Source's name **must** be unique
    # </figure>
    #
    # @param deal_source [DealSource, Hash] Either object of the DealSource type or Hash. This object's attributes describe the object to be created.
    # @return [DealSource] The resulting object represting created resource.
    def create(deal_source)
      validate_type!(deal_source)

      attributes = sanitize(deal_source)
      _, _, root = @client.post("/deal_sources", attributes)

      DealSource.new(root[:data])
    end


    # Retrieve a single source
    #
    # get '/deal_sources/{id}'
    #
    # Returns a single source available to the user by the provided id
    # If a source with the supplied unique identifier does not exist it returns an error
    #
    # @param id [Integer] Unique identifier of a DealSource
    # @return [DealSource] Searched resource object.
    def find(id)
      _, _, root = @client.get("/deal_sources/#{id}")

      DealSource.new(root[:data])
    end


    # Update a source
    #
    # put '/deal_sources/{id}'
    #
    # Updates source information
    # If the specified source does not exist, the request will return an error
    # <figure class="notice">
    # If you want to update a source, you **must** make sure source's name is unique
    # </figure>
    #
    # @param deal_source [DealSource, Hash] Either object of the DealSource type or Hash. This object's attributes describe the object to be updated.
    # @return [DealSource] The resulting object represting updated resource.
    def update(deal_source)
      validate_type!(deal_source)
      params = extract_params!(deal_source, :id)
      id = params[:id]

      attributes = sanitize(deal_source)
      _, _, root = @client.put("/deal_sources/#{id}", attributes)

      DealSource.new(root[:data])
    end


    # Delete a source
    #
    # delete '/deal_sources/{id}'
    #
    # Delete an existing source
    # If the specified source does not exist, the request will return an error
    # This operation cannot be undone
    #
    # @param id [Integer] Unique identifier of a DealSource
    # @return [Boolean] Status of the operation.
    def destroy(id)
      status, _, _ = @client.delete("/deal_sources/#{id}")
      status == 204
    end


  private
    def validate_type!(deal_source)
      raise TypeError unless deal_source.is_a?(DealSource) || deal_source.is_a?(Hash)
    end

    def extract_params!(deal_source, *args)
      params = deal_source.to_h.select{ |k, _| args.include?(k) }
      raise ArgumentError, "one of required attributes is missing. Expected: #{args.join(',')}" if params.count != args.length
      params
    end

    def sanitize(deal_source)
      deal_source.to_h.select { |k, _| OPTS_KEYS_TO_PERSIST.include?(k) }
    end
  end
end
