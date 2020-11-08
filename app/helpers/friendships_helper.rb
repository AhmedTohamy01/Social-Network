module FriendshipsHelper
  # Redirects to stored location.
  def redirect_back
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url
  end

  def format_stat(count, word)
    pluralize(count, word).split(' ')
  end

  def get_stats(friendship)
    case friendship
    when :friend
      current_user.friends.count
    when :friend_requests
      current_user.friend_requests.count
    when :pending_friends
      current_user.pending_friends.count
    end
  end
end
