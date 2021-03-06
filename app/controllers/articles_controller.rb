# encoding: utf-8

class ArticlesController < ApplicationController

  skip_before_filter :login_require,:only=>[:index,:show]

  before_filter :per_load
  def per_load
    @article=Article.find_by_id(params[:id]) if params[:id]
  end

  def index 
    @articles = Article.paginate(:per_page=>20,:page=>params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    @article.user_id = current_user.id    
    if @article.save
      flash[:notice] = I18n.t("controller.article.save_success")
      return redirect_to articles_path
    end
    render :action=>:new
  end

  def edit
  end

  def update
    if @article.update_attributes(params[:article])
      flash[:notice] = I18n.t("controller.article.edit_success")
      return redirect_to articles_path        
    end
    render :action=>:edit,:id=>params[:id]
  end

  def show
    @comments = @article.comments.paginate(:per_page=>10,:page=>params[:page])
  end

  def destroy
    if @article.destroy
      flash[:notice] = I18n.t("controller.destroy_success")
      return redirect_to articles_path
    end
  end

  def remove_batch

  end

end
