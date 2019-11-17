class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            search_word = req.path.split("/items/").last
            puts search_word
            item_names = @@items.map { |item| item.name}
            puts item_names
            if item_names.include?(search_word)
                puts search_word
                item = @@items.find{|item| item.name == search_word }
                resp.write "#{item.price}"
                resp.status = 200
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else 
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end