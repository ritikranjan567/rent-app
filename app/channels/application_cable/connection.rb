module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
    end

    def find_user
      user_id = cookies.signed["user.id"]
      current_user = User.find_by(id: user_id)
      
      current_user || reject_unauthorized_connection
    end
    
  end
end
