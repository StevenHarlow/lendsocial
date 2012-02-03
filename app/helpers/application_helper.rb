module ApplicationHelper
  def list_classes(object, collection)
    classes = []
    classes << cycle('odd', 'even')
    classes << 'first' if object == collection.first
    classes << 'last' if object == collection.last
    classes.join(' ')
  end
  
  def truncate(text, options = {})
    options[:separator] ||= ' '
    options[:length] ||= 100
    super(text, options)
  end
  
  def number_to_currency(number, options = {})
    options[:strip_insignificant_zeros] ||= true
    super(number, options)
  end
end
