class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.length > 0
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      add_req = req.params["item"]
      resp.write handle_add(add_req)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(item)
    if @@items.include?(item)
      @@cart << item
      return "added #{item}"
    else
      return "We don't have that item"
    end
  end

  # def show_cart
  #   # @@cart.each do |cart_item|
  #   #   resp.write "#{cart_item}\n"
  #   # end
  #   if @@cart.length > 0
  #     @@cart.each do |cart_item|
  #       resp.write "#{cart_item}\n"
  #     end
  #   else
  #     return "Your cart is empty"
  #   end
  # end


end
