class Like < ApplicationRecord

  belongs_to :customer
  belongs_to :review

  has_many :notices, dependent: :destroy

  def create_notification_like!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notice.where(["visitor_id = ? and visited_id = ? and like_id = ? and action = ? ", current_customer.id, customer_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      @notice = current_customer.active_notices.new(
        like_id: id,
        visited_id: customer_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notice.visitor_id == notice.visited_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end

end
