require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
				 :omniauthable, omniauth_providers: [:facebook]


	validates :name, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true

  has_many :sent_friend_requests, class_name: :FriendRequest, foreign_key: :from_id, dependent: :destroy
  has_many :received_friend_requests, class_name: :FriendRequest, foreign_key: :to_id, dependent: :destroy

  has_many :friend_as, class_name: :Friend, foreign_key: :friend_a_id, dependent: :destroy
  has_many :friend_bs, class_name: :Friend, foreign_key: :friend_b_id, dependent: :destroy

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_one_attached :avatar

	def self.search(name)
    User.where("name LIKE ?", "%#{name}%")
  end

	def self.relation_between(_id, _user_id)
		id = _id.to_i
		user_id = _user_id.to_i
    current_user = User.find(id)
    if user_id == id
      return :you
    elsif User.friends_ids(id).include?(user_id)
      return :friend
    elsif current_user.sent_friend_requests.pluck(:to_id).include?(user_id)
      return :friend_request_sent
    elsif current_user.received_friend_requests.pluck(:from_id).include?(user_id)
      return :friend_request_received
    end
    return :no_relation
  end

  def self.friends_ids(id)
    Friend.where(friend_b_id: id).pluck(:friend_a_id) + Friend.where(friend_a_id: id).pluck(:friend_b_id)
  end

	def self.from_omniauth(auth)
    new_user = true
    new_user = false if User.where(provider: auth.provider, uid: auth.uid).first

    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
    return [user, new_user]
  end
end
