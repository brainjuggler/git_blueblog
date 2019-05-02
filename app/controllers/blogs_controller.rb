class BlogsController < ApplicationController
    before_action :move_to_index, except: :index
    
    def index
        flash[:notice] = "ようこそ。本日は#{Date.today}です。"
        @article =Article.order("updated_at DESC").page(params[:page]).per(5)
    end
    
    def new
        @article = Article.new
    end
    
    def create
        # binding.pry
        @article = Article.create(title: blog_params[:title], image: blog_params[:image], content: blog_params[:content], user_id: current_user[:id])
     if @article.save
      # メッセージの保存に成功した場合
      redirect_to action: :index, notice: 'メッセージの送信に成功しました'
     else
      # メッセージの保存に失敗した場合
      redirect_to action: :new, notice: 'メッセージの送信に失敗しました'
     end
    end
    
    def destroy
        article = Article.find(params[:id])
        article.destroy if article.user_id == current_user.id
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def update
        article = Article.find(params[:id])
        article.update(blog_params) if article.user_id == current_user.id
    end
    
    private
    def blog_params
        params.require(:article).permit(:title, :image, :content)
    end
        
    def move_to_index
        redirect_to action: :index unless user_signed_in?
    end    
    
end