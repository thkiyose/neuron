module ApplicationHelper
  def side_menu_display?
    controllers = ["sessions","registrations"]
    actions = ["top"]
    if user_signed_in? && controllers.exclude?(controller.controller_name) && actions.exclude?(controller.action_name) 
      true
    else
      false
    end
  end
end
