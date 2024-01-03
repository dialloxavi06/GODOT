extends CharacterBody2D
class_name entity_movement
var current_states
enum enemy_states {MOVEUP, MOVEDOWN, MOVERIGHT, MOVELEFT, DEAD}

var dir # pour déclarer l variable de la direction
@onready var dead_anim = preload("res://Scenes/Effect/dead_fx.tscn")
@onready var coin_loot = preload("res://Scenes/Detectable/piece.tscn")
@export var speed = 50
@export var vie = 3


func _ready():
	current_states = enemy_states.MOVEDOWN


func _physics_process(delta):
	if vie <= 0:
		current_states = enemy_states.DEAD
	match current_states:
		enemy_states.MOVEDOWN:
			move_down(delta)
		enemy_states.MOVEUP:
			move_up(delta)
		enemy_states.MOVELEFT:
			move_left(delta)
		enemy_states.MOVERIGHT:
			move_right(delta)
		enemy_states.DEAD:
			dead()
	
	move_and_slide()
	
func random_direction():
	dir = randi() % 4 + 1 # fonction qui permette de générer une suite de nombrs entier entre 0 et 4 // le plus 1 permettre de soustraire le zéro.
	print(dir)
	random_mouvement()
	
func random_mouvement():
	match dir:  # match statement
		1:
			current_states = enemy_states.MOVELEFT
		2:
			current_states = enemy_states.MOVERIGHT
		3:
			current_states = enemy_states.MOVEUP
		4:
			current_states = enemy_states.MOVEDOWN

func move_down(delta):
	Vector2.DOWN # pour que notre ennemie bouge sans le contrôler
	velocity.y += speed * delta  # bouge sur l'axe vertical Y et multipler par delta pour contrôler la vitesse de notre ennemie
	velocity.y = clamp(-speed, 15 , speed)  # pour mettre une limite à la vitesse pour qu'il ne dépasse pas 
	velocity.x = 0 # sinon l'ennemi reste se déplace d'une sorte diagonale bizarre.
	$anim.play("move_down")
func move_up(delta):
	Vector2.UP 
	velocity.y -= speed * delta  
	velocity.y = clamp(speed, 15 , -25)  
	velocity.x = 0
	$anim.play("move_up")

func move_left(delta):
	Vector2.LEFT 
	velocity.x -= speed * delta  
	velocity.x = clamp(speed, 15 , -25)  
	velocity.y = 0
	$anim.play("move_left")

func move_right(delta):
	Vector2.RIGHT 
	velocity.x += speed * delta 
	velocity.x = clamp(-speed, 15 , speed)  
	velocity.y = 0
	$anim.play("move_right")
	
func dead():
	dead_animation()
	queue_free()

func dead_animation():
	var mort = dead_anim.instantiate()
	mort.global_position = global_position
	get_tree().get_root().add_child(mort)
	loot_coin()
	
func loot_coin():
	var coin = coin_loot.instantiate()
	coin.global_position = global_position
	get_tree().get_root().add_child(coin)
	
