class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
	before_save { self.email = email.downcase} #saveするまえにdowncaseに変更する
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	before_create :create_remember_token # this:called Method Reference, add a callback method to create a remember token immediately before creating a new user in the database


	validates :name, presence: true, length: {maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } ,uniqueness:{case_sensitive: false}  #regexでemailのvalidationを行う方法

    has_secure_password #allow u to use password and password digest
    validates :password,length: {minimum: 6 }


    def User.new_remember_token
    	SecureRandom.urlsafe_base64
    end

    def User.digest(token)
    	Digest::SHA1.hexdigest(token.to_s)
    end


    def feed
    #This is preliminary. See "Following users" for the full implementation.
    #Micropost.where("user_id = ?", id)
      Micropost.from_users_followed_by(self)
      #followed_user_ids = user.followed_user_ids
     # where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
    end

    def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
    end

    private

      def create_remember_token
      	self.remember_token = User.digest(User.new_remember_token)  #selfは、User classのinstance methodだから@userを指す
      end

end



