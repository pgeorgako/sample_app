module SessionsHelper
    # logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    # Returns the current logged-in user (if any)
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    # Returns true if the given user is the current user.
    def current_user?(user)
        user == current_user
    end

    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil? # == !!current_user
    end

    # Logs out the current user.
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
