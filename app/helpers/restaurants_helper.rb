module RestaurantsHelper
  def street_city(rest)
    formatted = rest.address + " " + rest.city
  end

  def gsearch(rest)
    gsrch = rest.name + " " + rest.address + " " + rest.city
    gsrch.gsub(" ","+").gsub('\'','').gsub('&','').gsub('++','+')
  end

  def coords_hash(rest)
    coords = {}
    coords[:latitude] = rest.latitude
    coords[:longitude] = rest.longitude
    coords[:address] = street_city(rest)
    coords[:gsearch] = gsearch(rest)
    coords
  end

  def loc_hash(rest)
    loc = {}
    loc[:id] = rest.id
    loc[:address] = street_city(rest)
    loc      
  end

  def potential(string)
    string.downcase.gsub(' ','')
  end
end