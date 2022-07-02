module ApplicationHelper
  def show_errors(error,field)
    error.messages[field].join(', ') if error.present? && !error.messages[field].nil?
 end
end
