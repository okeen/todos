class Todo < ActiveRecord::Base
  belongs_to :todo_list
  
  validates :title, :presence => true
  validates :expected_duration, :presence => true
  
  before_destroy :check_todo_is_finished
  
  #will_paginate config
  cattr_reader :per_page
  @@per_page = 10

  scope :unfinished, where(:is_finished => false)

  class << self
    def search(title)
      where("todos.title like ?" , "%#{title}%")
    end
  end

  private

  def check_todo_is_finished
    errors[:is_finished] << "Can't delete not finished todo"
    return false unless is_finished?
  end

  def as_json(options={})
    super(
      :except => [:id, :todo_list_id]
    )
  end

  def as_xml(options={})
    super(
      :except => [:id]
    )
  end
end
