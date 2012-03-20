# encoding: UTF-8

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
  
  def form_block_alerts resource
    if resource.errors.any?
      content_tag :div, class: 'alert alert-block' do
        content_tag(:a, '×', class: 'close', 'data-dismiss' => 'alert') +
        content_tag(:h4, I18n.t('errors.messages.not_saved', count: resource.errors.count, resource: resource.class.name.downcase), class: 'alert-heading') +
        content_tag(:ul, resource.errors.full_messages.map {|msg| content_tag(:li, msg)}.join("\n").html_safe)
      end
    end
  end
  
  def form_alerts
    content_tag :div, class: 'alert' do
      content_tag(:a, '×', class: 'close') + content_tag(:div, nil, class: 'message')
    end
  end
end
