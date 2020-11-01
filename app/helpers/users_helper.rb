module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def show_confirm_friend?(user)
    !current_user?(user) && current_user.friend_requests.include?(user)
  end

  def show_friends?(user)
    !current_user?(user) && current_user.friend?(user)
  end

  def show_cancel_request?(user)
    !current_user?(user) && current_user.pending_friends.include?(user)
  end

  def show_confirm_delete_friend?(user)
    !current_user?(user) && current_user.friend_requests.include?(user)
  end

  def show_add_friend?(user)
    !current_user?(user) && current_user.friends.exclude?(user) &&
      current_user.pending_friends.exclude?(user) && current_user.friend_requests.exclude?(user)
  end
end
