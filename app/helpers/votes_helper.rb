module VotesHelper
  def already_voted?(contribution)
    return false unless user_signed_in?
      votes = Vote.where(user_id: current_user.id)
      votes.where(option_id: contribution.que.options.ids).present?
  end
end
