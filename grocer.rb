# Method. consolidate_cart
def consolidate_cart(cart)

  new_cart = {}
  
  # Iterates over all elements of cart.
  cart.each do |hash|
    
    # Within each element (hash) is a hash with a key and a value.
    hash.each do |item, descr|
      
      # If the item exists, increment count by 1
      if new_cart[item]
        new_cart[item][:count] += 1
        
      # Else add item, descr, & count = 1 to the new_cart hash
      else
        new_cart[item] = descr
        new_cart[item][:count] = 1
      
      end
      
    end
    
  end
  
  new_cart
  
end


# Method. apply_coupons
def apply_coupons(cart, coupons)

  # If there are no coupons, break and return cart
  return cart if coupons == []

  # Create new_cart var, set it equal to cart, and make changes
  new_cart = cart

  # Iterates over each element in array coupons
  coupons.each do |coupon|  # Each coupon is a hash w/ key & value
    c_name = coupon[:item]
    c_num = coupon[:num]
    
    # If cart has item & coupon && item count >= num of coupons
    if cart.include?(c_name) && cart[c_name][:count] >= c_num
      
      # Subtract item count in cart by num of coupons 
      new_cart[c_name][:count] -= c_num
       
      # If item "W/ COUPON" exists, increment count by 1
      if new_cart["#{c_name} W/COUPON"]
        new_cart["#{c_name} W/COUPON"][:count] += 1
      
      # Else add item "W/ COUPON" to cart hash
      else
        new_cart["#{c_name} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => new_cart[c_name][:clearance],
          :count => 1
        }
      end
      
    end
    
  end
   
   new_cart
   
end


# Method. apply_clearance
def apply_clearance(cart)

  # Create new_cart hash, set equal to cart, in order to make changes to orig
  new_cart = cart

  # Iterate over each item. If clearance = true, take 2-% off.
  cart.each do |name, hash|
      if hash[:clearance] #if clearance is true, take 20% off
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
      end
  end
  
  new_cart #if not, just return the same cart

end


# Method. checkout
def checkout(cart, coupons)

  # Consolidate cart array into cart hash
  new_cart = consolidate_cart(cart)
  
  # Apply coupons to cart
  apply_coupons(new_cart, coupons)
  
  # Apply clearance to cart
  apply_clearance(new_cart)

  # Create total var for total price
  total = 0

  # Add up all item prices for total
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

  # If total price is greater than $100, take 10% off
  if total >= 100
    total *= 0.9
  end

  total
  
end


## Scrap Code

cart_array = [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]

cart_hash = consolidate_cart(cart_array)

coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]


puts test_cart = apply_coupons(cart_hash, coupons)
