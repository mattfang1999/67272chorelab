class Chore < ApplicationRecord

	belongs_to :child
	belongs_to :task

    validates_date :due_on

	scope :by_task, -> { joins(:task).order('name') }

    # scope :chronological, -> { joins(:task).order('due_on')}
    scope :chronological, -> { order('due_on').joins(:task).order('name')}

    scope :pending, -> {where(completed: false)}
	scope :done, -> {where(completed: true)}

    scope :upcoming, ->{ where('due_on >= ?', Date.today.to_date)}
	scope :past, ->{ where('due_on < ?', Date.today.to_date)}

    def status

		if self.completed == true
			return 'Completed'
		else
			return 'Pending'
		end

	end



	
end
