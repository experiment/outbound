class FollowUpsPreview < ActionMailer::Preview
  def interested_first_follow_up
    FollowUps.interested_first_follow_up(Contact.last.id)
  end

  def mass_follow_up
    FollowUps.mass_follow_up(Contact.last.id)
  end
end
