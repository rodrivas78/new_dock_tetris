extends Sprite2D

# Intervalo de tempo para o piscar (em segundos)
var blink_interval = 1.0  # Ajuste conforme necessário

# Timer para controlar o piscar
var blink_timer: Timer

func _ready():
	# Cria o Timer
	blink_timer = Timer.new()
	add_child(blink_timer)  # Adiciona o Timer como filho do nó atual
	
	# Configura o Timer
	blink_timer.wait_time = blink_interval
	blink_timer.autostart = true  # Começa automaticamente
	blink_timer.connect("timeout", _on_blink_timeout)  # Conecta o evento de timeout do Timer
	
	# Faz o sprite começar visível
	visible = true

# Função chamada toda vez que o Timer dispara
func _on_blink_timeout():
	# Alterna a visibilidade do sprite
	visible = not visible
