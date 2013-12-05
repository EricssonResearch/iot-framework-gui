class RelationshipsController < ApplicationController
	#before_action :signed_in_user

	def create
		@stream_id = params[:relationship][:followed_id]
		current_user.follow!(@stream_id)

		respond_to do |format|
			format.html { redirect_to root_path }
			#format.js
		end
	end

	def destroy
		#@stream_id = Relationship.find(params[:id]).followed_id
		@stream_id = params[:id]
		current_user.unfollow!(@stream_id)

		respond_to do |format|
			format.html { redirect_to root_path }
			format.js
		end
	end
end
