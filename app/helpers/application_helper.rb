module ApplicationHelper

  def greet_user
    greeting = 'Welcome'

    if current_user.nil?
      'Please login'
    else
      if current_user.provider == "facebook"
        greeting + ', ' + current_user.first_name
      else
        greeting + ', ' + current_user.first_name + ' ' + current_user.last_name
      end
    end
  end
end
