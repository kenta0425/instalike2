module NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @comment = nil
    @visitor_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'is following you'
    when 'like'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'liked' + tag.a('your post', href: post_path(notification.post_id))
    when 'comment' then
      #コメントの内容と投稿のタイトルを取得　      
      @comment = Comment.find_by(id: @visitor_comment)
      @comment_content =@comment.content
      @post_title =@comment.micropost.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'commented' + tag.a("#{@post_title}", href: post_path(notification.post_id))
    end
  end
end