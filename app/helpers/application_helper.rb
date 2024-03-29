module ApplicationHelper
   def nav_link(link_text, page)
      class_name = current_page?(page) ? 'active' : ''

      if (controller_name == 'boards' || controller_name == 'posts') && link_text == 'Forum'
      	class_name = 'active'
      elsif (controller_name == 'jobs') && link_text == 'Jobs'
      	class_name = 'active'
      elsif (controller_name == 'contacts') && link_text == 'Database'
      	class_name = 'active'
      end

      content_tag(:li, :class => class_name) do
         link_to link_text, page
      end
   end

    def bootstrap_class_for flash_type
      { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
    end

    def flash_messages(opts = {})
      flash.each do |msg_type, message|
         concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
            concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
            concat message
            end)
      end
      nil
   end
end
