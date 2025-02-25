#extends Sprite2D
#
#var blink_interval = 1.0  # Intervalo de tempo para piscar (em segundos)
#var blink_timer: Timer  # Timer para controlar o piscar
#
#func _ready():
	## Criar e configurar o Timer
	#blink_timer = Timer.new()
	#blink_timer.wait_time = blink_interval
	#blink_timer.autostart = true  # Timer inicia automaticamente
	#blink_timer.one_shot = false  # Continua rodando
	#blink_timer.timeout.connect(_on_blink_timeout)  # Conectar o sinal corretamente
	#
	## Adicionar Timer como filho do nó atual
	#call_deferred("add_child", blink_timer)
	#
	## Iniciar o Timer
	#blink_timer.start()
	#
	## O sprite começa visível
	#visible = true
	#print_debug("Timer configurado!")  # Verifica se o código chegou até aqui
#
## Função chamada quando o Timer dispara
#func _on_blink_timeout():
	#print_debug("Timer disparou!")  # Verifica se a função está sendo chamada
	#visible = not visible  # Alternar visibilidade


#----------------- vs. 2
#
#extends Sprite2D
#
#var blink_timer: Timer
#var is_visible_state = true  # Começa visível
#
#func _ready():
	## Criar o Timer
	#blink_timer = Timer.new()
	#blink_timer.one_shot = true  # Agora ele dispara uma vez e precisa ser reiniciado
	#blink_timer.timeout.connect(_on_blink_timeout)
	#
	## Adicionar o Timer como filho do nó
	#add_child(blink_timer)
	#
	## Iniciar visível e configurar primeiro tempo
	#visible = true
	#blink_timer.start(1.8)  # Primeiro tempo de espera
#
## Função chamada quando o Timer dispara
#func _on_blink_timeout():
	#is_visible_state = not is_visible_state  # Alternar estado
	#visible = is_visible_state  # Aplicar estado no Sprite
	#
	## Ajustar o tempo do próximo ciclo
	#var next_time = 1.8 if is_visible_state else 0.3  # 2s ligado, 0.5s desligado
	#blink_timer.start(next_time)  # Reiniciar o Timer com o novo tempo

# --------------- vs. 3

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

