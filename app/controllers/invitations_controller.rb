class InvitationsController < ApplicationController

	before_filter :require_user

  def create
    @inv_sent = current_user.sent_invitations.build(params[:user])
		@inv_received = User.find(params[:user]).received_invitations.create(:friend_id => current_user)
		
    @inv_sent.save
    @inv_received.save
    
    redirect_to(user_path(:user), :notice => "Wysłano zaproszenie!")  
  end
	
	def accept
		@friends = current_user.friends		 #tabela z przyjaciolmi
		@add_to_friends = @friends.create(:friend_id => params[:friend_id]) #dodanie nowego rekordu z id nowego przyjaciela
		@add_to_friends.save
		
		@inv_received = current_user.received_invitations.find(params[:friend_id]).destroy #usuniecie rekordu z zaproszeniem
		
		redirect_to(user_path(:user), :notice => "Dodano znajomego!")
	end

	def deny
		@inv_received = current_user.received_invitations.find(params[:friend_id]).destroy #usuniecie rekordu z zaproszeniem
		
		redirect_to(user_path(:user), :notice => "Odrzucono zaproszenie!")
	end
end
