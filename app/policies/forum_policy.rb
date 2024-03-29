class ForumPolicy < ApplicationPolicy
	attr_reader :user, :forum

	class Scope < Scope
		def resolve
			if user.admin?
				scope.all
			else
				scope.where(privilege: 0)
			end
		end
	end

	def initialize(user, forum)
		@user = user
		@forum = forum
	end

	def new?
		user.admin?
	end

	def create?
		user.admin?
	end

	def edit?
		user.admin?
	end

	def update?
		user.admin?
	end
end
