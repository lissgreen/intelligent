class Article < ActiveRecord::Base
  # name    文章名称
  # summary 文章摘要
  # content 文章内容
  # sort    文章分类
  # allow_comment 文章是否可评论标志
  # browses 文章浏览量
  # user    创建文章的用户
  # column  文章归属的栏目 
  # comment 文章评论
  validates_presence_of :name, :summary, :content, :user_id
  validates_length_of :name, :within => 0..128
  validates_length_of :sort, :within => 0..32

  belongs_to :user
  belongs_to :guide

  COMMENT_ON  = true
  COMMENT_OFF = false

  PASS_ON  = true
  PASS_OFF = false

  include Comment::HostMethods

  def title
    name
  end

  def author
    user = User.find_by_id(user_id)
    user.name
  end


  def guide_view
    col = Guide.find_by_id(guide_id)
    col == nil ? "" : col.name
  end

  def review_stat
    Comment.count(:conditions=>["host_id = ? AND host_type = ?",id,Comment::HOST_TYPE_ARTICLE])
  end


  def self.list
    Artile.find_all_by_is_show(true)
  end

  def self.find_by_name_articles(article_name,size)
    articles = Article.find(:all,
                :conditions => ["name like '%?%'",article_name],
                :order => "updated_at DESC",
                :limit => size)
  end 

  def toggle_is_pass
    if is_pass == PASS_ON
      return update_attributes(:is_pass => PASS_OFF)
    end
    update_attributes(:is_pass => PASS_ON)
  end

  def toggle_allow_comment
    if allow_comment == COMMENT_ON
      return update_attributes(:allow_comment => COMMENT_OFF)
    end
    update_attributes(:allow_comment => COMMENT_ON)
  end

  def is_pass?
    is_pass = Article::PASS_ON
  end

  def allow_comment?
    allow_comment == COMMENT_ON
  end

end
