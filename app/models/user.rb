class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :assignments
  has_many :subscriptions
  has_many :roles, through: :assignments
  before_create :make_me_admin_if_im_first

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.accounts.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end
  def make_me_admin_if_im_first
    if(User.count==0)
      self.roles << Role.find_by_name(:admin)
    end
  end
end
