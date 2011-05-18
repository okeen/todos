class User < ActiveRecord::Base
  has_one :session
  has_many :todo_lists
  has_many :todos , :through => :todo_lists
  validates :password, :presence => true

  validates :email, :presence => true, :uniqueness => true,
    :format   => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def as_json(options={})
    super(
      :except => [:updated_at, :id, :password]
    )
  end

  def as_xml(options={})
    super(
      :except => [:updated_at, :id, :password]
    )
  end



end
