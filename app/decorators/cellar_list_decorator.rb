require_relative 'paginating_decorator'

class CellarListDecorator < PaginatingDecorator

  def decorator_class
    CellarDecorator
  end

end

