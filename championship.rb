class Championship
	attr_accessor :name_championship, :quantity_players, :teams , :start, :players, :matches, :end_championship

	def initialize(name, quantity)
		@name_championship = name
		@quantity_players=quantity
		@teams = []
		@players = []
		@start=false
		@matches =[]
		@end_championship=false
	end

	def add_player(player)
		@players << player
	end

	def add_team(team)
		@teams << team
	end

	def add_match(matches)
		@matches<<matches

	end

end