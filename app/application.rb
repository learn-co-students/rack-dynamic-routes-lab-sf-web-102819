require "pry"
class Application
  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      #use regex to split on "/items/ then get last ele"
      item_name = req.path.split("/items/").last
      #find the first instance where item.name == item_name. "Figs"=="Figs"
      if item = @@items.find { |i| i.name == item_name }
      #respond with the item's price
      resp.write item.price
      # binding.pry
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
