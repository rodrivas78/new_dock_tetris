extends TileMap

#tetrominoes
var i_0 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]
var i_90 := [Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]
var i_180 := [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]
var i_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)]
var i := [i_0, i_90, i_180, i_270]

var t_0 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var t_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var t := [t_0, t_90, t_180, t_270]

var o_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_90 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 0)]
var o_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 0), Vector2i(1, 0)]
var o_270 := [Vector2i(1, 1), Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1)]
var o := [o_0, o_90, o_180, o_270]

var z_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_90 := [Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var z_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var z_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var z := [z_0, z_90, z_180, z_270]

var s_0 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var s_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var s_180 := [Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2), Vector2i(1, 2)]
var s_270 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s := [s_0, s_90, s_180, s_270]

var l_0 := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var l_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var l_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2)]
var l_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var l := [l_0, l_90, l_180, l_270]

var j_0 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var j_90 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]
var j_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var j_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)]
var j := [j_0, j_90, j_180, j_270]

#var shapes := [i, t, o, z, s, l, j]
var shapes := [j, t, z, s, l, i, o]
var shapes_full := shapes.duplicate()

# Lados possíveis para o surgimento das peças
enum Side { TOP, RIGHT, BOTTOM, LEFT }

# Adicione uma variável para armazenar o lado sorteado
var spawn_side: int

# Modifique a posição inicial e direção com base no lado sorteado
var start_positions := {
	#Side.TOP: Vector2i(COLS / 2, 0),
	#Side.RIGHT: Vector2i(COLS - 1, ROWS / 2),
	#Side.BOTTOM: Vector2i(COLS / 2, ROWS - 1),
	#Side.LEFT: Vector2i(0, ROWS / 2)
	Side.TOP: Vector2i(15, 1),
	Side.RIGHT: Vector2i(29, 14),
	Side.BOTTOM: Vector2i(15, 28),
	Side.LEFT: Vector2i(0, 14)
}

var movement_directions := {
	Side.TOP: Vector2i(0, 1),     # De cima para baixo
	Side.RIGHT: Vector2i(-1, 0),  # Da direita para a esquerda
	Side.BOTTOM: Vector2i(0, -1), # De baixo para cima
	Side.LEFT: Vector2i(1, 0)     # Da esquerda para a direita
}

#grid variables
const COLS : int = 34
const ROWS : int = 30

#movement variables
const mov_directions := [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.UP]
var steps : Array
const steps_req : int = 50
const start_pos := Vector2i(5, 1)
var cur_pos : Vector2i
var speed : float
const ACCEL : float = 0.11

#game piece variables
var piece_type
var next_piece_type
var rotation_index : int = 0
var active_piece : Array

#game variables
var stage: int = 1
var piece_count : int = 0
var red_tiles : int = 0
var blue_tiles : int = 0
var score : int
var hi_score: int
const REWARD : int = 100
var game_running : bool
var pick_or_create_piece_enabled : bool = true
var is_continue_enabled : bool = false
var isMusicPaused : bool = false
var isMusicSilenced : bool = false
var playbackPosition = 0.0
var is_paused : bool = true
var auto_step = 0 
var end_of_the_game : bool = false
var cancel_requested : bool = false
var first_piece_spawned : bool = false 

#tilemap variables
var tile_id : int = 0
var piece_atlas : Vector2i
var next_piece_atlas : Vector2i

#layer variables
var board_layer : int = 0
var active_layer : int = 1

#store special positions
var special_positions := []

#@onready var tween = $Tween

@onready var start_button = $HUD.get_node("StartButton")
@onready var panel_red_node = $HUD.get_node("RedTilesPanel")
@onready var panel_blue_node = $HUD.get_node("BlueTilesPanel")
@onready var closed_board = get_node("Sprite2D2")
@onready var title = get_node("SpriteTitle")
@onready var sprite_press_new = get_node("SpritePressNewGame")
@onready var sprite_logo = get_node("SpriteLogo")
@onready var orb_logo = get_node("SpriteLogo2")
@onready var sprite_bg_win = get_node("SpriteWinScreen")
@onready var sprite_you_won = get_node("SpriteYouWon")
@onready var sprite_credits_one = get_node("SpriteCredits")
@onready var sprite_credits_two = get_node("SpriteCredits2")
@onready var sprite_esc_to_return = get_node("SpriteEscToReturn")
#var panel_red_node = $HUD.get_node("RedTilesPanel")
@onready var moveSound : AudioStreamPlayer = $AudioStreamPlayer
@onready var rotateSound : AudioStreamPlayer = $AudioStreamPlayer2
@onready var dockSound : AudioStreamPlayer = $AudioStreamPlayer3
@onready var dockSound2 : AudioStreamPlayer = $AudioStreamPlayer4
@onready var gameOverSound : AudioStreamPlayer = $GameOverSound
@onready var levelCompletedSound : AudioStreamPlayer = $LevelCompletedSound
@onready var scoreSound : AudioStreamPlayer = $ScoreSound
@onready var gameTitleMusic : AudioStreamPlayer = $GameTitleMusic
@onready var gameWinMusic : AudioStreamPlayer = $GameWinMusic
@onready var gameWinSound : AudioStreamPlayer = $GameWinSound

@onready var gameMusic : AudioStreamPlayer = $GameMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	closed_board.visible = true
	$HUD.get_node("StartButton").pressed.connect(new_game)
	
func new_game():
	# Reset de variáveis dependendo se é um "continue" ou um novo jogo
	end_of_the_game = false
	gameTitleMusic.stop()
	sprite_press_new.disable_blink()
	panel_red_node.change_color(Color(0,1,0)) 
	panel_blue_node.change_color(Color(1,0,0)) 
	$HUD.get_node("StartButton").release_focus()
	$HUD.get_node("ContinueButton").release_focus()
	
	closed_board.visible = false
	title.visible = false
	sprite_press_new.visible = false
	sprite_logo.visible = false
	# Se for um novo jogo (não continuação), resetamos tudo
	if not is_continue_enabled:
		stage = 1
		speed = 1.0  # Reset da velocidade apenas no novo jogo
		playbackPosition = 0.0
		gameMusic.seek(playbackPosition)
		if not isMusicSilenced:
			gameMusic.volume_db = 0.0
			gameMusic.stop()
			gameMusic.play()
		else: 
			gameMusic.volume_db = 0.0
			gameMusic.stop
	
	# Reset de variáveis para ambos os casos
	score = 0
	red_tiles = 0
	blue_tiles = 0
	piece_count = 0
	special_positions = []
	pick_or_create_piece_enabled = true
	game_running = true
	steps = [0, 0, 0, 0] # 0:left, 1:right, 2:down
	$HUD.get_node("GameOverLabel").hide()

	# Limpeza da tela e reinício do jogo
	clear_piece()
	clear_board()
	clear_panel()
	create_fixed_center_piece()
	piece_type = pick_piece()
	piece_atlas = Vector2i(shapes_full.find(piece_type), 0)
	next_piece_type = pick_piece()
	next_piece_atlas = Vector2i(shapes_full.find(next_piece_type), 0)
	spawn_side = randi() % 4
	create_piece()
	updateHudLabels()
	
	# Desativa o modo de continuação após a execução
	is_continue_enabled = false
	$HUD.get_node("ContinueButton").hide()
	$HUD.get_node("StartButton").flat = false

# Adiciona uma peça fixa no centro do tabuleiro no início do jogo
func create_fixed_center_piece():
	##var center_pos = Vector2i(COLS / 2, ROWS / 2)
	var center_pos = Vector2i(15, 14)
	var selected_piece = []  # Inicializa como lista vazia
	# Se for a primeira chamada, usa a peça "O"
	if not first_piece_spawned:
		selected_piece = o[0]  # Usa a peça "O" sem rotação
		first_piece_spawned = true  # Marca que a primeira peça já foi gerada
	else:
		# Usa o método `pick_piece()` para garantir que sempre haja peças disponíveis
		var random_shape = pick_piece()
		# Verifica se a peça sorteada tem rotações disponíveis
		if random_shape.size() > 0:
			selected_piece = random_shape[randi() % random_shape.size()]
		else:
			print("Erro: A peça sorteada não tem rotações!")
	# Se selected_piece estiver vazia, usa a peça "O" como fallback
	if selected_piece.size() == 0:
		selected_piece = o[0]
	# Posiciona a peça escolhida no tabuleiro
	for i in selected_piece:
		set_cell(board_layer, center_pos + i, tile_id, Vector2i(7, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		
		# Determinar a direção automática atual
		var auto_move_direction = movement_directions[spawn_side]
		
		# Movimentos manuais permitidos com base na direção automática
		if auto_move_direction == Vector2i(0, 1):  # Vindo de cima para baixo
			if Input.is_action_pressed("ui_left"):
				steps[0] += 10
			elif Input.is_action_pressed("ui_right"):
				steps[1] += 10
			elif Input.is_action_pressed("ui_down"):
				steps[2] += 10
		elif auto_move_direction == Vector2i(0, -1):  # Vindo de baixo para cima
			if Input.is_action_pressed("ui_left"):
				steps[0] += 10
			elif Input.is_action_pressed("ui_right"):
				steps[1] += 10
			elif Input.is_action_pressed("ui_up"):
				steps[3] += 10
		elif auto_move_direction == Vector2i(1, 0):  # Vindo da esquerda para a direita
			if Input.is_action_pressed("ui_right"):
				steps[1] += 10
			elif Input.is_action_pressed("ui_down"):
				steps[2] += 10
			elif Input.is_action_pressed("ui_up"):
				steps[3] += 10
		elif auto_move_direction == Vector2i(-1, 0):  # Vindo da direita para a esquerda
			if Input.is_action_pressed("ui_left"):
				steps[0] += 10
			elif Input.is_action_pressed("ui_down"):
				steps[2] += 10
			elif Input.is_action_pressed("ui_up"):
				steps[3] += 10
		
		# Rotação sempre permitida
		if Input.is_action_just_pressed("rotate_piece"):
			rotateSound.play()
			rotate_piece()       
		
		if Input.is_action_just_pressed("toggle_music"):  
			if isMusicSilenced:
				unsilence_music()  # Desilencia se a música estiver silenciada
			else:
				silence_music()
		
			# Aplicar movimentos manuais
		for i in range(steps.size()):
			if steps[i] > steps_req:
				move_piece(mov_directions[i])  # Aplica apenas os movimentos válidos
				steps[i] = 0
				#moveSound.play()
		 
		# Movimento automático na direção oposta ao lado de surgimento
		auto_step += speed
		if auto_step > steps_req:
			move_piece(auto_move_direction)  # Movimento automático
			auto_step = 0  # Resetar apenas o movimento automático
			
	if end_of_the_game:
		if Input.is_action_just_pressed("return_to_main_menu"):
			cancel_sequence()
			go_to_splash_screen()
					
func pick_piece():
	var piece
	if not shapes.is_empty():
		shapes.shuffle()
		piece = shapes.pop_front()
	else:
		shapes = shapes_full.duplicate()
		shapes.shuffle()
		piece = shapes.pop_front()
	return piece

func create_piece():
	#reset variables
	steps = [0, 0, 0, 0] #0:left, 1:right, 2:down
	cur_pos = start_positions[spawn_side]
	active_piece = piece_type[rotation_index]
	draw_piece(active_piece, cur_pos, piece_atlas)
	#show next piece
	draw_piece(next_piece_type[0], Vector2i(37, 6), next_piece_atlas)

func clear_piece():
	for i in active_piece:
		erase_cell(active_layer, cur_pos + i)

func draw_piece(piece, pos, atlas):
	for i in piece:
	#criar aqui condicionais para troca de cor dos tiles de acordo com a peça
		if piece == o_0:
			if i == Vector2i(0,0) or i == Vector2i(1,1): 
				atlas = Vector2i(3,0)  # Cor 1
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:  
				atlas = Vector2i(0,0)  # Cor 2
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == o_90:
			if i == Vector2i(1,0) or i == Vector2i(0,1):  
				atlas = Vector2i(3,0)  # Cor 1 (girado)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:  
				atlas = Vector2i(0,0)  # Cor 2
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == o_180:
			if i == Vector2i(1,1) or i == Vector2i(0,0):  
				atlas = Vector2i(3,0)  # Cor 1 (girado novamente)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:  
				atlas = Vector2i(0,0)  # Cor 2
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == o_270:
			if i == Vector2i(0,1) or i == Vector2i(1,0):  
				atlas = Vector2i(3,0)  # Cor 1 (última rotação)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:  
				atlas = Vector2i(0,0)  # Cor 2
				set_cell(active_layer, pos + i, tile_id, atlas)
				
		elif piece == j_0:
			if i == Vector2i(0,0) or i == Vector2i(2,1): 
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else: 
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == j_90:
			if i == Vector2i(2,0) or i == Vector2i(1,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == j_180:
			if i == Vector2i(0,1) or i == Vector2i(2,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == j_270:
			if i == Vector2i(0,2) or i == Vector2i(1,0):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == t_0:
			if i == Vector2i(1,0) or i == Vector2i(0,1) or i == Vector2i(2,1): 
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else: 
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == t_90:
			if i == Vector2i(1,0) or i == Vector2i(2,1) or i == Vector2i(1,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == t_180:
			if i == Vector2i(0,1) or i == Vector2i(2,1) or i == Vector2i(1,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == t_270:
			if i == Vector2i(1,0) or i == Vector2i(0,1) or i == Vector2i(1,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == z_0:
			if i == Vector2i(0,0) or i == Vector2i(2,1): 
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else: 
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == z_90:
			if i == Vector2i(2,0) or i == Vector2i(1,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == z_180:
			if i == Vector2i(0,1) or i == Vector2i(2,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == z_270:
			if i == Vector2i(1,0) or i == Vector2i(0,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == s_0:
			if i == Vector2i(2,0) or i == Vector2i(0,1): 
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else: 
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == s_90:
			if i == Vector2i(1,0) or i == Vector2i(2,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == s_180:
			if i == Vector2i(2,1) or i == Vector2i(0,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == s_270:
			if i == Vector2i(0,0) or i == Vector2i(1,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == l_0:
			if i == Vector2i(2,0) or i == Vector2i(0,1): 
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else: 
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == l_90:
			if i == Vector2i(1,0) or i == Vector2i(2,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == l_180:
			if i == Vector2i(2,1) or i == Vector2i(0,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == l_270:
			if i == Vector2i(0,0) or i == Vector2i(1,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == i_0:
			if i == Vector2i(0,1) or i == Vector2i(3,1): 
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else: 
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == i_90:
			if i == Vector2i(2,0) or i == Vector2i(2,3):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == i_180:
			if i == Vector2i(0,2) or i == Vector2i(3,2):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
		elif piece == i_270:
			if i == Vector2i(1,0) or i == Vector2i(1,3):
				atlas = Vector2i(3,0)
				set_cell(active_layer, pos + i, tile_id, atlas)
			else:
				atlas = Vector2i(0,0)
				set_cell(active_layer, pos + i, tile_id, atlas)

		else: 
			set_cell(active_layer, pos + i, tile_id, atlas)

func rotate_piece():
	if can_rotate():
		clear_piece()
		rotation_index = (rotation_index + 1) % 4
		active_piece = piece_type[rotation_index]
		draw_piece(active_piece, cur_pos, piece_atlas)

func move_piece(dir):
	if can_move(dir):
		clear_piece()
		cur_pos += dir
		draw_piece(active_piece, cur_pos, piece_atlas)

		#detects if piece has passed the central block
		if movement_directions[spawn_side] == Vector2i(0, 1) and cur_pos.y >= 25:
			game_over()
		elif movement_directions[spawn_side] == Vector2i(-1, 0) and cur_pos.x <= 2:
			game_over()
		elif movement_directions[spawn_side] == Vector2i(0, -1) and cur_pos.y <= 2:
			game_over()
		elif movement_directions[spawn_side] == Vector2i(1, 0) and cur_pos.x >= 25:
			game_over()
		
	else:
		#if dir == Vector2i.DOWN:
		if dir == movement_directions[spawn_side] and pick_or_create_piece_enabled:
			dockSound.play()
			land_piece()
			$HUD.get_node("PiecesLabel").text = "Pieces: " + str(piece_count)
			#check_rows()
			piece_type = next_piece_type
			piece_atlas = next_piece_atlas
			next_piece_type = pick_piece()
			next_piece_atlas = Vector2i(shapes_full.find(next_piece_type), 0)
			clear_panel()
			spawn_side = randi() % 4
			create_piece()
			#check_game_over()


func can_move(dir):
# Calcula a nova posição desejada
	var new_pos = cur_pos + dir
# Aplica os limites dependendo da direção de movimento
	if movement_directions[spawn_side] in [Vector2i(0, 1), Vector2i(0, -1)]:  # Movimento vertical
		if new_pos.x < 1 or new_pos.x > 28:
			return false
	elif movement_directions[spawn_side] in [Vector2i(1, 0), Vector2i(-1, 0)]:  # Movimento horizontal
		if new_pos.y < 1 or new_pos.y > 26: 
			return false

# Verifica se há espaço livre para mover
	for i in active_piece:
		if not is_free(i + new_pos):
			return false
		
	return true


func can_rotate():
	var cr = true
	var temp_rotation_index = (rotation_index + 1) % 4
	for i in piece_type[temp_rotation_index]:
		if not is_free(i + cur_pos):
			cr = false
	return cr

func is_free(pos):
	return get_cell_source_id(board_layer, pos) == -1

func land_piece():
	# Remove cada segmento da camada ativa e move para a camada do tabuleiro
	for i in active_piece:
		erase_cell(active_layer, cur_pos + i)
		if active_piece == o_0:
			if i == Vector2i(0,0) or i == Vector2i(1,1):
				piece_atlas = Vector2i(3,0)  # Cor 1
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)  # Cor 2
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)

		elif active_piece == o_90:
			if i == Vector2i(1,0) or i == Vector2i(0,1):
				piece_atlas = Vector2i(3,0)  # Cor 1 (girado)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)  # Cor 2
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == o_180:
			if i == Vector2i(1,1) or i == Vector2i(0,0):
				piece_atlas = Vector2i(3,0)  # Cor 1 (girado novamente)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)  # Cor 2
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == o_270:
			if i == Vector2i(0,1) or i == Vector2i(1,0):
				piece_atlas = Vector2i(3,0)  # Cor 1 (última rotação)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)  # Cor 2
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == j_0:
			if i == Vector2i(0,0) or i == Vector2i(2,1): 
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else: 
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == j_90:
			if i == Vector2i(2,0) or i == Vector2i(1,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == j_180:
			if i == Vector2i(0,1) or i == Vector2i(2,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == j_270:
			if i == Vector2i(0,2) or i == Vector2i(1,0):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == t_0:
			if i == Vector2i(1,0) or i == Vector2i(0,1) or i == Vector2i(2,1): 
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else: 
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == t_90:
			if i == Vector2i(1,0) or i == Vector2i(2,1) or i == Vector2i(1,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == t_180:
			if i == Vector2i(0,1) or i == Vector2i(2,1) or i == Vector2i(1,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == t_270:
			if i == Vector2i(1,0) or i == Vector2i(0,1) or i == Vector2i(1,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == z_0:
			if i == Vector2i(0,0) or i == Vector2i(2,1): 
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else: 
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == z_90:
			if i == Vector2i(2,0) or i == Vector2i(1,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == z_180:
			if i == Vector2i(0,1) or i == Vector2i(2,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == z_270:
			if i == Vector2i(1,0) or i == Vector2i(0,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == s_0:
			if i == Vector2i(2,0) or i == Vector2i(0,1): 
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else: 
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == s_90:
			if i == Vector2i(1,0) or i == Vector2i(2,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == s_180:
			if i == Vector2i(2,1) or i == Vector2i(0,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == s_270:
			if i == Vector2i(0,0) or i == Vector2i(1,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == l_0:
			if i == Vector2i(2,0) or i == Vector2i(0,1): 
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else: 
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == l_90:
			if i == Vector2i(1,0) or i == Vector2i(2,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == l_180:
			if i == Vector2i(2,1) or i == Vector2i(0,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == l_270:
			if i == Vector2i(0,0) or i == Vector2i(1,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == i_0:
			if i == Vector2i(0,1) or i == Vector2i(3,1): 
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else: 
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == i_90:
			if i == Vector2i(2,0) or i == Vector2i(2,3):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == i_180:
			if i == Vector2i(0,2) or i == Vector2i(3,2):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
		elif active_piece == i_270:
			if i == Vector2i(1,0) or i == Vector2i(1,3):
				piece_atlas = Vector2i(3,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
				special_positions.append(cur_pos + i)
			else:
				piece_atlas = Vector2i(0,0)
				set_cell(board_layer, cur_pos + i, tile_id, piece_atlas)
	# Atualiza os tiles adjacentes após a peça pousar
	update_adjacent_tiles()
	
		
func update_adjacent_tiles():
	red_tiles = 0
	blue_tiles = 0
	var directions = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]

	for pos in special_positions:
		var occupied_count = 0
		
		# Conta quantas posições adjacentes estão ocupadas
		for dir in directions:
			if not is_free(pos + dir):
				occupied_count += 1
		# Define a cor apenas para 1 a 4 espaços ocupados
		var new_atlas = piece_atlas  # Mantém a cor original por padrão
		if occupied_count == 1:  
			new_atlas = Vector2i(3, 0) #vermelho
			red_tiles += 1
		elif occupied_count == 2:  
			new_atlas = Vector2i(2, 0) #amarelo
		elif occupied_count == 3:  
			new_atlas = Vector2i(4, 0) #verde
		elif occupied_count == 4:  
			new_atlas = Vector2i(6, 0) #azul
			blue_tiles += 1
	
		set_cell(board_layer, pos, tile_id, new_atlas)
			
	updateHudLabels()
			
	piece_count += 1
	
	check_stage_conditions()
	

# Definição das condições para cada fase
var stage_conditions = {
	1: { "total_pieces": 10, "min_blue": 4, "max_red": 3 },
	2: { "total_pieces": 10, "min_blue": 6, "max_red": 3 },
	3: { "total_pieces": 12, "min_blue": 8, "max_red": 2 },
	4: { "total_pieces": 12, "min_blue": 9, "max_red": 2 },
	5: { "total_pieces": 14, "min_blue": 10, "max_red": 2 },
	6: { "total_pieces": 14, "min_blue": 11, "max_red": 2 },
	7: { "total_pieces": 16, "min_blue": 12, "max_red": 1 },
	8: { "total_pieces": 16, "min_blue": 13, "max_red": 1 },
	9: { "total_pieces": 18, "min_blue": 14, "max_red": 1 },
	10: { "total_pieces": 18, "min_blue": 15, "max_red": 1 },
	11: { "total_pieces": 20, "min_blue": 16, "max_red": 0 },
	12: { "total_pieces": 20, "min_blue": 17, "max_red": 0 },
	13: { "total_pieces": 22, "min_blue": 18, "max_red": 0 },
	14: { "total_pieces": 22, "min_blue": 19, "max_red": 0 },
	15: { "total_pieces": 24, "min_blue": 20, "max_red": 0 },
}

func check_stage_conditions():
	if stage_conditions.has(stage):
		var conditions = stage_conditions[stage]
		var total_pieces = conditions["total_pieces"]
		var min_blue = conditions["min_blue"]
		var max_red = conditions["max_red"]
		
		# Atualiza cores dos painéis com base nas quantidades de peças
		update_panel_colors(min_blue, max_red)
		
		if piece_count == total_pieces:
			if blue_tiles >= min_blue and red_tiles <= max_red:
				#chamar  método de contagem de pontos
				advance_stage()
			else:
				game_over()
			
				
func advance_stage():
	pick_or_create_piece_enabled = false
	await show_level_completed()
	await calculate_score()
	stage += 1
	clear_board()
	piece_count = 0
	blue_tiles = 0
	red_tiles = 0
	special_positions = []
	#create_fixed_center_piece()
	#await get_tree().create_timer(2).timeout
	speed += ACCEL
	game_running = true
	pick_or_create_piece_enabled = true
	updateHudLabels()
	check_stage_conditions()
	
	if stage >= 16:
		$HUD.get_node("StageLabel").text = "Stage: " + str("15")
		set_music_fade_out()
		game_running = false
		clear_panel()
		end_of_the_game = true 
		await get_tree().create_timer(2).timeout
		show_victory()
		gameWinSound.play()
		await get_tree().create_timer(4).timeout
		gameWinMusic.volume_db = 0.0
		gameWinMusic.play()
		start_button.visible = false
		closed_board.visible = true
		#sprite_bg_win.visible = true
		show_win_background()
		start_sequence()
		
	else:
		create_fixed_center_piece()
		s
					
func update_panel_colors(min_blue, max_red):
	# Atualiza a cor do painel vermelho
	if red_tiles > max_red:
		panel_red_node.change_color(Color(1, 0, 0))  # Vermelho (falha)
	else:
		panel_red_node.change_color(Color(0, 1, 0))  # Verde (dentro do limite)
	
	# Atualiza a cor do painel azul
	if blue_tiles < min_blue:
		panel_blue_node.change_color(Color(1, 0, 0))  # Vermelho (falha)
	else:
		panel_blue_node.change_color(Color(0, 1, 0))  # Verde (dentro do limite)
		
# Exibe "Level Completed" por 2 segundos
func show_level_completed():
	var level_label = $HUD.get_node("LevelCompletedLabel")
	level_label.text = "LEVEL COMPLETED!"
	levelCompletedSound.play()
	game_running = false
	level_label.show()
	await get_tree().create_timer(2).timeout
	
func calculate_score():
	var blue_multiplication_factor = $HUD.get_node("BlueMultiplicationFactor")
	var red_bonus_factor = $HUD.get_node("RedMultiplicationFactor")
	var red_tiles_panel = $HUD.get_node("RedTilesPanel")
	var blue_tiles_panel = $HUD.get_node("BlueTilesPanel")
	$HUD.get_node("LevelCompletedLabel").hide()
	
	blue_multiplication_factor.show()
	red_bonus_factor.show()
	red_tiles_panel.hide()
	blue_tiles_panel.hide()
	
	var score_increment = (blue_tiles * 50) # Cada peça azul vale 50 pontos
	
	# Lógica de pontuação para peças vermelhas
	match red_tiles:
		0:
			score_increment += 300
			red_bonus_factor.text = "+300"
		1:
			score_increment += 200
			red_bonus_factor.text = "+200"
		2:
			score_increment += 100
			red_bonus_factor.text = "+100"
		_:
			score_increment += 0  # Ou apenas não faça nada
			red_bonus_factor.text = ""
	
	# Atualiza o score
	for i in range(score_increment/10):
		score += 10
		moveSound.play()
		$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
		await get_tree().create_timer(0.003).timeout
		
	if score >= hi_score:
		hi_score = score
	
	blue_multiplication_factor.hide()
	red_bonus_factor.hide()
	red_tiles_panel.show()
	blue_tiles_panel.show()
	# Chama advance_stage() após calcular os pontos
	
func clear_panel():
	for i in range(36, 42):
		for j in range(4, 8):
			erase_cell(active_layer, Vector2i(i, j))
			

func game_over():
	closed_board.visible = true

	if not isMusicSilenced:
		toggle_music()

	gameOverSound.play()
	$HUD.get_node("GameOverLabel").show()
	$HUD.get_node("ContinueButton").show()
	
	$HUD.get_node("StartButton").flat = true
	
	$HUD.get_node("ContinueButton").pressed.connect(continue_game)
	game_running = false
	
func continue_game():
	is_continue_enabled = true  # Ativa a flag de continuação
	
	if not isMusicSilenced:  # Checa se a música estava silenciada
		unsilence_music()
	
	new_game()  # Chama new_game() com a flag ativada
	
		
func toggle_music():
	if isMusicSilenced:
		if not isMusicPaused:
			playbackPosition = gameMusic.get_playback_position()  # Armazena a posição antes de parar
			gameMusic.stop()  # Para a música
			isMusicPaused = true
		return  # Se estiver silenciado, não faz mais nada

	if isMusicPaused:
		gameMusic.play()  # Retoma a música
		gameMusic.seek(playbackPosition)  # Retorna à posição de reprodução
		isMusicPaused = false
	else:
		playbackPosition = gameMusic.get_playback_position()  # Armazena a posição atual
		gameMusic.stop()  # Para a música
		isMusicPaused = true
		
func silence_music():
	isMusicSilenced = true
	toggle_music()  

func unsilence_music():
	isMusicSilenced = false
	toggle_music() 
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("pause"):
		if not end_of_the_game:
			toggle_music()
			toggle_pause()
		
	
func toggle_pause():
	is_paused = not is_paused
	game_running = is_paused
			
func check_rows():
	var row : int = ROWS
	while row > 0:
		var count = 0
		for i in range(COLS):
			if not is_free(Vector2i(i + 1, row)):
				count += 1
		#if row is full then erase it
		if count == COLS:
			shift_rows(row)
			score += REWARD
			$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
			speed += ACCEL
		else:
			row -= 1

func shift_rows(row):
	var atlas
	for i in range(row, 1, -1):
		for j in range(COLS):
			atlas = get_cell_atlas_coords(board_layer, Vector2i(j + 1, i - 1))
			if atlas == Vector2i(-1, -1):
				erase_cell(board_layer, Vector2i(j + 1, i))
			else:
				set_cell(board_layer, Vector2i(j + 1, i), tile_id, atlas)

func clear_board():
	for i in range(ROWS):
		for j in range(COLS):
			erase_cell(board_layer, Vector2i(j + 1, i + 1))
			erase_cell(active_layer, Vector2i(j + 1, i + 1))

func check_game_over():
	for i in active_piece:
		if not is_free(i + cur_pos):
			land_piece()
			$HUD.get_node("GameOverLabel").show()
			game_running = false

func updateHudLabels():
	$HUD.get_node("StageLabel").text = "Stage: " + str(stage)
	$HUD.get_node("PiecesLabel").text = "Pieces: " + str(piece_count)
	$HUD.get_node("RedTilesLabel").text = "= " + str(red_tiles)
	$HUD.get_node("BlueTilesLabel").text = "= " + str(blue_tiles)
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
	$HUD.get_node("HiScoreLabel").text = "HI-SCORE: " + str(hi_score)


func set_music_fade_out():
	var tween = create_tween()
	tween.tween_property(gameMusic, "volume_db", -40.0, 2.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_callback(stop_music)
	
func stop_music():
	if gameMusic.volume_db <= -35.0:  # Verifica se o volume já está muito baixo
		gameMusic.stop()

func show_victory():
	sprite_you_won.visible = true  # Torna o sprite visível
	
	var start_position = sprite_you_won.position
	var target_position = Vector2(start_position.x, get_viewport_rect().size.y * 0.2)  # 80% da tela
	
	var tween = create_tween()  # Cria um tween no Godot 4
	tween.tween_property(sprite_you_won, "position", target_position, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
func show_win_background():
	sprite_bg_win.visible = true
	sprite_bg_win.modulate.a = 0.0  # Começa completamente invisível
	var tween = create_tween()
	tween.tween_property(sprite_bg_win, "modulate:a", 1.0, 2.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

func show_credits_one():
	sprite_credits_one.visible = true  
	var target_position = Vector2(sprite_credits_one.position.x, get_viewport_rect().size.y * 0.42)  
	var tween = create_tween()  
	tween.tween_property(sprite_credits_one, "position", target_position, 14.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	
func show_credits_two():
	sprite_credits_two.visible = true  
	var target_position = Vector2(sprite_credits_two.position.x, get_viewport_rect().size.y * 0.68)  
	var tween = create_tween()  
	tween.tween_property(sprite_credits_two, "position", target_position, 14.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

func fade_in_orb_logo():
	orb_logo.visible = true
	orb_logo.modulate.a = 0.0  # Começa completamente invisível
	var tween = create_tween()
	tween.tween_property(orb_logo, "modulate:a", 1.0, 4.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

func show_esc_to_return():
	sprite_esc_to_return.visible = true
	sprite_esc_to_return.modulate.a = 0.0  # Começa completamente invisível
	var tween = create_tween()
	tween.tween_property(sprite_esc_to_return, "modulate:a", 1.0, 4.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	
func go_to_splash_screen():
	await set_win_music_fade_out()
	sprite_esc_to_return.visible = false
	orb_logo.visible = false
	sprite_credits_one.visible = false
	sprite_credits_two.visible = false
	sprite_you_won.visible = false
	start_button.visible = true
	sprite_bg_win.visible = false
	reset_credits_sprites_position()
	#end_of_the_game = false
	
	gameTitleMusic.play()
	title.visible = true
	sprite_press_new.visible = true
	sprite_press_new.enable_blink()
	sprite_logo.visible = true

func set_win_music_fade_out():
	var tween = create_tween()
	tween.tween_property(gameWinMusic, "volume_db", -40.0, 2.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_callback(stop_win_music)
	await get_tree().create_timer(2).timeout
	
func stop_win_music():
	if gameMusic.volume_db <= -35.0:  # Verifica se o volume já está muito baixo
		gameMusic.stop()

func reset_credits_sprites_position():
	sprite_you_won.position = Vector2(505, 1016)
	sprite_credits_one.position = Vector2(512, 1056)
	sprite_credits_two.position = Vector2(512, 1107)
	
func start_sequence():
	cancel_requested = false

	await delay(6)
	if cancel_requested: return
	show_credits_one()

	await delay(14)
	if cancel_requested: return
	show_credits_two()

	await delay(14)
	if cancel_requested: return
	fade_in_orb_logo()

	await delay(4)
	if cancel_requested: return
	show_esc_to_return()

func cancel_sequence():
	cancel_requested = true

func delay(seconds: float):
	await get_tree().create_timer(seconds).timeout
