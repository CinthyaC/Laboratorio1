require_relative 'team'
class Point
	attr_accessor :points

	def initialize
		@points = [3, 1 ,0]
	end

	def add_points(team_a, team_b)
		@points = form.select_from_list("Ingrese puntos de: #{match.team_a}", team_a_points)
		@points = form.select_from_list("Ingrese puntos de: #{match.team_b}", team_b_points)

		match.team_a.add_point(team_a_points)
		match.team_b.add_point(team_b_points)
	end
end