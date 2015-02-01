class FriendsController < ApplicationController

	before_filter :require_user

  def add
  	@friend = User.find(params[:id])
  	@sender = current_user

    @inv_sent = @sender.sent_invitations.create(:friend_id => @friend.id)
		@inv_received = @friend.received_invitations.create(:friend_id => @sender.id)

    @inv_sent.save
    @inv_received.save

    redirect_to(user_path(params[:id]), :notice => "Wyslano zaproszenie do uzytkownika "+@friend.login+"!")
  end

	def accept
		@add_to_friends = current_user.friends.create(:friend_id => params[:id])
		@add_to_friends2 = User.find(params[:id]).friends.create(:friend_id => current_user.id)

		@inv_to_remove = current_user.received_invitations.first(:conditions => ["friend_id= ?", params[:id]]).destroy

		@add_to_friends2.save

		redirect_to(user_path(current_user.id), :notice => "Dodano znajomego!")
	end

	def deny
		@inv_to_remove = current_user.received_invitations.first(:conditions => ["friend_id= ?", params[:id]]).destroy

		redirect_to(user_path(current_user.id), :notice => "Odrzucono zaproszenie!")
	end

	def delete
		@friend = User.find(params[:id])

		@friend_of_logged_user = current_user.friends.first(:conditions => ["friend_id= ?", @friend.id])
		@logged_user_from_friends = @friend.friends.first(:conditions => ["friend_id= ?", current_user.id])

		@invitation_of_logged_user = current_user.sent_invitations.first(:conditions => ["friend_id= ?", @friend.id])
		@invitation_of_friend = @friend.sent_invitations.first(:conditions => ["friend_id= ?", current_user.id])

		if @friend_of_logged_user
			@friend_of_logged_user.destroy
		end

		if @logged_user_from_friends
			@logged_user_from_friends.destroy
		end

		if @invitation_of_logged_user
			@invitation_of_logged_user.destroy
		end

		if @invitation_of_friend
			@invitation_of_friend.destroy
		end

		redirect_to(user_path(current_user.id), :notice => "Usunieto znajomego!")
	end
end
