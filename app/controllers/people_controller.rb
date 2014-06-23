class PeopleController < ApplicationController
  #POST /room/1/people
  def create
    @user = User.find(params[:user_id])
    @user.room_id = params[:id]
    @user.last_checkin = Time.now.to_i
    @user.save
    @expired_users = check_online(@user.room)
  end
  
  #DELETE /room/1/people
  def destroy
    @user = User.find(params[:user_id])
    @user.room_id = nil
    @user.save
    @expired_users = check_online(@user.room)
  end
  
  #POST /room/1/people/online
  def lodge_heartbeat
    @user = User.find(params[:user_id])
    @user.last_checkin = Time.now.to_i
    @user.save
    @expired_users = check_online(@user.room)
  end
  
  private
    def check_online(room)
      expired_users = []
      room.users.each do |user|
        if Time.now.to_i - user.last_checkin > 15
          expired_users.push(user)
        end
      end
      expired_users
    end
end