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
var o_90 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
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
var shapes := [j, t, z, s, l, i]
var shapes_full := shapes.duplicate()

# Lados possíveis para o surgimento das peças
enum Side { TOP, RIGHT, BOTTOM, LEFT }

# Adicione uma variável para armazenar o lado sorteado
var spawn_side: int

# Modifique a posição inicial e direção com base no lado sorteado
var start_positions := {
	Side.TOP: Vector2i(COLS / 2, 0),
	Side.RIGHT: Vector2i(COLS - 1, ROWS / 2),
	Side.BOTTOM: Vector2i(COLS / 2, ROWS - 1),
	Side.LEFT: Vector2i(0, ROWS / 2)
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
const ACCEL : float = 0.25

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
const REWARD : int = 100
var game_running : bool
var is_color_adjacent_tiles_enabled : bool = true

#tilemap variables
var tile_id : int = 0
var piece_atlas : Vector2i
var next_piece_atlas : Vector2i

#layer variables
var board_layer : int = 0
var active_layer : int = 1

#store special positions
var special_positions := []

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$HUD.get_node("StartButton").pressed.connect(new_game)

func new_game():
	#reset variables
	score = 0
	speed = 1.0
	game_running = true
	steps = [0, 0, 0, 0] #0:left, 1:right, 2:down
	$HUD.get_node("GameOverLabel").hide()
	#clear everything
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

# Adiciona uma peça fixa no centro do tabuleiro no início do jogo
func create_fixed_center_piece():
	#var center_pos = Vector2i(COLS / 2, ROWS / 2)
	var center_pos = Vector2i(15, 13)
	var center_piece = o[0] # Usando o formato "O" como exemplo
	for i in center_piece:
		set_cell(board_layer, center_pos + i, tile_id, Vector2i(0,0))

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
			rotate_piece()        
		
		# Aplicar movimentos manuais
		for i in range(steps.size()):
			if steps[i] > steps_req:
				move_piece(mov_directions[i])  # Aplica apenas os movimentos válidos
				steps[i] = 0

		# Movimento automático na direção oposta ao lado de surgimento
		steps[2] += speed  # Incrementamos o contador para o movimento automático
		if steps[2] > steps_req:
			move_piece(auto_move_direction)  # Movimento automático
			steps[2] = 0
		

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
	draw_piece(next_piece_type[0], Vector2i(38, 6), next_piece_atlas)

func clear_piece():
	for i in active_piece:
		erase_cell(active_layer, cur_pos + i)

func draw_piece(piece, pos, atlas):
	for i in piece:
	#criar aqui condicionais para troca de cor dos tiles de acordo com a peça
		if piece == j_0:
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
		if movement_directions[spawn_side] == Vector2i(0, 1) and cur_pos.y >= 27:
			$HUD.get_node("GameOverLabel").show()
			game_running = false
		elif movement_directions[spawn_side] == Vector2i(-1, 0) and cur_pos.x <= 2:
			$HUD.get_node("GameOverLabel").show()
			game_running = false
		elif movement_directions[spawn_side] == Vector2i(0, -1) and cur_pos.y <= 3:
			$HUD.get_node("GameOverLabel").show()
			game_running = false
		elif movement_directions[spawn_side] == Vector2i(1, 0) and cur_pos.x >= 27:
			$HUD.get_node("GameOverLabel").show()
			game_running = false
		
	else:
		#if dir == Vector2i.DOWN:
		if dir == movement_directions[spawn_side]:
			land_piece()
			piece_count += 1
			$HUD.get_node("PiecesLabel").text = "Pieces: " + str(piece_count)
			#check_rows()
			piece_type = next_piece_type
			piece_atlas = next_piece_atlas
			next_piece_type = pick_piece()
			next_piece_atlas = Vector2i(shapes_full.find(next_piece_type), 0)
			clear_panel()
			spawn_side = randi() % 4
			create_piece()
			check_game_over()

func can_move(dir):
	#check if there is space to move
	var cm = true
	for i in active_piece:
		if not is_free(i + cur_pos + dir):
			cm = false
	return cm

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
		if active_piece == j_0:
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
		# Define a cor apenas para 2, 3 ou 4 espaços ocupados
		var new_atlas = piece_atlas  # Mantém a cor original por padrão
		if occupied_count == 1:  #Vermelho
			new_atlas = Vector2i(3, 0)
			red_tiles += 1
			$HUD.get_node("RedTilesLabel").text = "Red Tiles: " + str(red_tiles)
		elif occupied_count == 2:  
			new_atlas = Vector2i(2, 0)
		elif occupied_count == 3:  
			new_atlas = Vector2i(4, 0)
		elif occupied_count == 4:  
			new_atlas = Vector2i(6, 0)
			blue_tiles += 1
			$HUD.get_node("BlueTilesLabel").text = "Blue Tiles: " + str(blue_tiles)
		if is_color_adjacent_tiles_enabled:
			set_cell(board_layer, pos, tile_id, new_atlas)
		#seta condicionais para avançar de estágio - 
		#Stage 1:
		if piece_count >= 9 and blue_tiles >= 6 and red_tiles <= 2:
			stage += 1
			$HUD.get_node("StageLabel").text = "Stage: " + str(stage)
			piece_count = 0
			blue_tiles = 0
			red_tiles = 0
			is_color_adjacent_tiles_enabled = false
			clear_board()
		elif piece_count >= 9 and blue_tiles <= 6 and red_tiles >= 3:
			$HUD.get_node("GameOverLabel").show()
			game_running = false
			
			
func clear_panel():
	for i in range(36, 42):
		for j in range(4, 8):
			erase_cell(active_layer, Vector2i(i, j))

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

func check_game_over():
	for i in active_piece:
		if not is_free(i + cur_pos):
			land_piece()
			$HUD.get_node("GameOverLabel").show()
			game_running = false

