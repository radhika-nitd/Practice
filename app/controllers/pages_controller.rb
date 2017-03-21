class PagesController < ApplicationController
before_action :set_auth

    def profile
      @user=User.new
    end

    def leaderboard
     # @posts= User.all.order("created_at DESC").paginate(page: params[:page], per_page: 4)
    end

	def index

   if session[:score].nil?
      session[:score]=0
      session[:victor]=0
    elsif session[:score]>=30
      redirect_to victory_path
    end
    
    if session[:victor]==0
      my_id = session[:score]/10+1
      @question = Question.find(my_id)
    end

    if params[:answer].present?
      if params[:answer].casecmp(@question.answer)==0
        session[:score]+=10
        if session[:score]>=30
          session[:victor] = 1
          redirect_to victory_path
        else
          my_id=(session[:score]/10)+1
          @question=Question.find(my_id)
          redirect_to explore_path
        end
      else
        flash[:notice]="WA"
          render html: "<script>alert('Wrong Answer!!!')</script>".html_safe
          
      end
    end

	end

	def home

  end

   def victory
   end

   def explore 
    if session[:score].nil?
      session[:score]=0
      session[:victor]=0
    end
    if session[:victor]==0
      my_id = session[:score]/10+1
      if session[:score]>=30
          session[:victor] = 1
          redirect_to victory_path
      else
      @question = Question.find(my_id)
    end
    end
  end




    def set_auth
      @auth=session[:omniauth] if session[:omniauth]
    end

end