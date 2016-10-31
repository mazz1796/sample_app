class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') } #postの表示を降順へ変更する
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	def self.from_users_followed_by(user)
    #followed_user_ids = user.followed_user_ids
    #where("user_id IN (:followed_user_ids) OR user_id = :user_id",
    #      followed_user_ids: followed_user_ids, user_id: user)
    #where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
