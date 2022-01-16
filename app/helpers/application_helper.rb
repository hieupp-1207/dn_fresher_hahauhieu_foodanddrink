module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title = ""
    base_title = t "title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def serial param_pages, index_loop
    return index_loop + Settings.number.digit_1 if param_pages.to_i.zero?

    index_loop + Settings.number.digit_1 +
      (param_pages.to_i - Settings.number.digit_1) * Settings.per_page_10
  end
end
