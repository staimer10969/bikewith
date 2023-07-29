class Comment < ApplicationRecord

  belongs_to :customer
  belongs_to :review

  has_many :notices, dependent: :destroy

  def create_notice_comment!(current_customer, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:customer_id).where(like_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notice_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notice_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end

  def save_notice_comment!(current_customer, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    @notice = current_customer.active_notices.new(
      like_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notice.visitor_id == notice.visited_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end

end
