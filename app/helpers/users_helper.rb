module UsersHelper
  def is_fixed_footer
    "fixed" if controller.controller_name == "registrations"
  end
end
