class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todos

  def as_json(options={})
    super(
        :include => [:todos],
        :except => [:id]
    )
  end

  def as_xml(options={})
    super(
        :include => [:todos],
        :except => [:id, :user_id]
    )
  end

end
