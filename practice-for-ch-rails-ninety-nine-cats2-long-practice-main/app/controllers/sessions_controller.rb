class SessionsController < ApplicationController
    def new
        render :new
    end
    
    def create
        user = User.find_by_credentials(params[:username], params[:password])
        if user 
            login(user)
            redirect_to cats_url
        else
            render :new, status: 403
        end
    end

    def destroy
	    logout 
	    redirect_to new_session_url
    end

end
