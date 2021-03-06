module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Social Scaffold'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user && user == current_user
  end

  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    return unless current_user.friend?(post.user) || post.user == current_user

    user_like = post.likes.find { |like| like.user == current_user }
    if user_like
      link_to('Dislike!', post_like_path(id: user_like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def show_comment_button(post)
    current_user.friend?(post.user) || post.user == current_user
  end
end
