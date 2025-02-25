extends Sprite2D

var blink_timer: Timer
var is_visible_state = true
var can_blink = true  # 🔹 Esta variável permite ou impede o piscar

func _ready():
	blink_timer = Timer.new()
	blink_timer.one_shot = true
	blink_timer.timeout.connect(_on_blink_timeout)
	add_child(blink_timer)

	visible = true
	blink_timer.start(1.8)

func _on_blink_timeout():
	if can_blink:  # 🔹 Só alterna visibilidade se puder piscar
		is_visible_state = not is_visible_state
		visible = is_visible_state
		
		var next_time = 1.8 if is_visible_state else 0.3
		blink_timer.start(next_time)

# 🔹 Função para impedir que o sprite pisque e mantê-lo invisível
func disable_blink():
	can_blink = false
	visible = false  # Mantém invisível

# 🔹 Função para permitir que o sprite volte a piscar
func enable_blink():
	can_blink = true
	blink_timer.start(2.0)  # Reinicia o Timer

