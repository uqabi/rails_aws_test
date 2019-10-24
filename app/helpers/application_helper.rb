module ApplicationHelper
def custom_bootstrap_flash
  flash_messages = []
  flash.each do |type, message|
    type = 'success' if type == 'notice'
    type = 'error'   if type == 'alert'
    text = "<script>toastr.#{type}('#{message}');</script>"
    flash_messages << text.html_safe if message
  end
  flash_messages.join("\n").html_safe
end

 def class_active(menu_path, menu_url=nil)
    return 'active' if request.path == menu_path
    return 'active' if request.url == menu_url if menu_url
  end
end
