require_relative 'utils/io'
require_relative 'utils/form'
require_relative 'championship'
require_relative 'player'
require_relative 'team'
require_relative 'match'
require_relative 'point'

class Program

	include IOTools

	def initialize

		form = Form.new('Ingrese informacion del Campeonato.' , name_championship: "Ingrese nombre:")
		form.ask_for( :name_championship)

		

		@quantity = form.select_from_list("Ingrese la cantidad de jugadores.", [5, 7 ,11] )

		@championship = Championship.new(form.get_data[0],@quantity)

	end


	def championship_can_be_played
		if @championship.teams.size == 0
			return 'No hay equipos para disputar el campeonato'
		elsif @championship.teams.size % 2 == 1
			return 'La cantidad de equipos disponibles debe ser par' 
		elsif @championship.teams.any? { |team| team.players.size != @quantity }
			return 'Hay equipos que tienen menos o mas de la cantidad de jugadores requeridos'
		end
	end


	def championship_start
		if @championship.start == false
			@championship.start = true
		end


		fixture_array = @championship.teams.combination(2).to_a

		fixture_array.each do |teams_match|
			@championship.add_match( Match.new(teams_match[0], teams_match[1]) )
		end
		

	end

	def championship_name
		@championship.name_championship
	end

	def add_team
		formt = Form.new("Datos del nuevo equipo", name_team: "Nombre del equipo: " )
		formt.ask_for(:name_team)

		@championship.add_team( Team.new(formt.get_data[0]) )

	end

	def add_player
		formp = Form.new("Datos del nuevo jugador", ci_player: "Cedula de identidad: ", name_player: "Nombre completo: " )
		formp.ask_for(:ci_player, :name_player)

		ci = formp.get_data[0]

		if @championship.players.any? { |player| player.ci_player==ci }
			show_error("Ya hay un jugador con esa cedula de identidad")
		elsif ci.length != 8
			show_error("La cedula de identidad debe ser de 8 digitos")
		else
			@championship.add_player( Player.new(ci, formp.get_data[1]) )
			puts 'Listo'
		end


	end

	def add_player_to_team
		names_players = []
		@championship.players.each do |player|
			names_players << player.name_player
		end

		names_teams = []
		@championship.teams.each do |team|
			names_teams << team.name_team
		end

		form = Form.new("Agregar jugadores a equipos")
		name_select_player = form.select_from_list('Seleccione un jugador', names_players)
		name_select_team = form.select_from_list('Seleccione un equipo', names_teams)
		
		select_team = nil
		@championship.teams.each do |team|
			if team.name_team == name_select_team
				select_team = team
			end
		end

		@championship.players.each do |player|
			if player.name_player == name_select_player
				select_team.players << player
			end
		end

	end

	def display_players
		puts "Lista de jugadores"
		puts "CI     | Nombre"
		@championship.players.each do |player|
			puts "#{player.ci_player} | #{player.name_player}"
		end
	end

	def display_teams
		puts "Lista de equipos"
		@championship.teams.each do |team|
			puts team.name_team
		end
	end

	def next_match
		order_matches = @championship.matches.sort{ |a, b| a.finish=true <=> b.finish=false}
		
		order_matches.find do |match|
			match.finish==false 

			Point.add_point(match.team_a, match.team_b)


	        match.finish=false
	    end
	end

	def display_fixture

		@championship.matches.each do |match|
			puts "#{match.team_a.name_team} vs. #{match.team_b.name_team}"

		end
	
	end

	def display_team_players

		names_teams = []
		@championship.teams.each do |team|
			names_teams << team.name_team
		end

		form = Form.new("Mostrar jugadores de un equipo")
		name_select_team = form.select_from_list('Seleccione un equipo', names_teams)

		
		select_team = nil
		@championship.teams.each do |team|
			if team.name_team == name_select_team
				team.players.each do |player|
					puts player.name_player
				end
			end
		end

	end

	def print_table
		matches_size=@championship.matches.size
		@championship.matches.each do |match|
			if match.finish
				matches_finished=[]
				matches_finished<<match
				matches_finished_size= matches_finished.size
			end
			if matches_size==matches_finished_size
				@end_championship = true
				'Tabla del campeonato (Final).'
			else
				'Tabla del campeonato (Parcial).'
			end
		end

		teams_table = @championship.teams.sort{ |a, b| a.points <=> b.points}

		position = 1

		teams_table.each do |team|
			puts "#{position}. #{team.name_team} | PJ: #{team.played_matches} | PG: #{team.win_matches} | PE: #{team.tied_matches} | PP: #{team.lose_matches} | Puntos: #{team.played_matches+team.win_matches+team.tied_matches+team.lose_matches}"
			position += 1
		end


	end

end