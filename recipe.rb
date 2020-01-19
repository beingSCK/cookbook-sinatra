class Recipe
  attr_reader :title, :description, :author

  def initialize(attributes = {})
    @title = attributes[:title]
    @description = attributes[:description]
    @author = attributes[:author]
    @done = attributes[:done]
    @id = attributes[:id]
  end

  def done?
    @done
  end

  def update_status!
    @done = !@done
  end
end
