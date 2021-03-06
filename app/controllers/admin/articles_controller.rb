# encoding: utf-8

class Admin::ArticlesController < AdminController

  before_filter :per_load
  def per_load
    @article = Article.find_by_id(params[:id]) if params[:id]
  end

  def index
    @articles = Article.paginate(:page=>params[:page],:per_page=>20,
                  :conditions=> ['name like ?',"%#{params[:search]}%"],
                  :order => "updated_at DESC")
  end

  def edit
  end 

  def update
    if @article.update_attributes(params[:article])
      flash[:notice] = I18n.t("controller.article.edit_success")
      return redirect_to admin_articles_path
    end
    render :action=>:edit,:id=>params[:id]
  end

  def destroy
    if @article.destroy
      flash[:notice] = I18n.t("controller.destroy_success")
      return redirect_to admin_articles_path
    end
  end

  def toggle_allow_comment
    if !@article.toggle_allow_comment
      flash[:error] = I18n.t("controller.update_fail")
    end
    return redirect_to admin_articles_path
  end

  def toggle_is_pass
    if !@article.toggle_is_pass
      flash[:error] = I18n.t("controller.update_fail")
    end
    return redirect_to admin_articles_path
  end

end
