module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Kurov"      
    end
  end
end
