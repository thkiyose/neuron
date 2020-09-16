module UsersHelper
  def is_fixed_footer
    "fixed" if controller.controller_name == "registrations" || controller.controller_name == "sessions"
  end

  def not_to_scroll
    "not_scroll" if controller.controller_name == "registrations" || controller.controller_name == "sessions"
  end
end
