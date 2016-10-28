class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') } #postの表示を降順へ変更する
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true
end
