class SessionsController < ApplicationController


  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
    	
    	# Sign the user in and redirect to the user's show page.
    	sign_in user
      redirect_back_or user
  	else
  	   flash.now[:error] = 'Invalid email/password combination'
  	   render 'new'
   		#Create an error message and re-render the signin form.
  	end
  end
  	#render 'new'  #defの中に今回のようにrenderとかが入っているときと、上のように空っぽの時の違いは？
  

  def destroy
    sign_out
    redirect_to root_url
  end
  
end
