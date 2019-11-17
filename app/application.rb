class Application
    def call(env)
        @@items = []
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            search_term = req.params["items"]
            if @@items.include?(search_term)
                puts @@items
                resp.write "Item found"
                resp.status = 200
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else 
            req.write "Route not found"
            req.status = 404