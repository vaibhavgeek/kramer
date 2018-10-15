module ApplicationHelper
    def active_helper(url)
        if current_page?(url)
          return "active" 
        else
          return nil
        end
      end
end