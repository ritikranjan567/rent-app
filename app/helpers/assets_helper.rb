module AssetsHelper
  #for image crousel activity
  def active_class(ind)
    if (ind == 0)
      "active"
    else
      ""
    end
  end
end
