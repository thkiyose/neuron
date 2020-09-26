module VotesHelper
  def already_voted?(contribution)
    if user_signed_in?
      vote = Vote.find_by(user_id: current_user.id)
      vote.option.que.contribution_id == contribution.id
    end
  end
end
