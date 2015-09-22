class Match
	attr_accessor :team_a, :team_b, :finish

	def initialize(team_a, team_b)
		@team_a=team_a
		@team_b=team_b
		@finish=false
	end

	def end_match
		@finish=true
	end
end