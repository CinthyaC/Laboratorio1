class Team
  attr_accessor :name_team , :players, :played_matches , :win_matches, :tied_matches, :lose_matches, :points

  def initialize(name)
    @name_team=name
    @players=[]
    @points = [3, 1 ,0]
    @played_matches=0
    @win_matches=0
    @tied_matches=0
    @lose_matches=0
  end

  def add_player(player)
    @players << player
  end

  def add_point(puntos)
  	form = Form.new('')
  	@points = form.select_from_list("Ingrese puntos", puntos)
  end

  def add_played_matches(played_matches_aux)
  	played_matches_aux=0
    if end_championship==false
	  	@played_matches=played_matches+played_matches_aux
	  else
	  	'El campeonato a finalizado no se puede agregar mas valores'
	  end
  end

  def add_win_matches(win_matches_aux)
  	win_matches_aux=0
    if end_championship==false
  	@win_matches=win_matches+win_matches_aux
  	else
	  	'El campeonato a finalizado no se puede agregar mas valores'
	  end
  end

  def add_tied_matches(tied_matches_aux)
  	tied_matches_aux=0
    if end_championship==false
  	@tied_matches=tied_matches+tied_matches_aux
  	else
	  	'El campeonato a finalizado no se puede agregar mas valores'
	  end
  end

  def add_lose_matches(lose_matches_aux)
  	lose_matches_aux=0
    if end_championship==false
	  	@lose_matches=lose_matches+lose_matches_aux
	  else
	  	'El campeonato a finalizado no se puede agregar mas valores'
	  end
  end



end