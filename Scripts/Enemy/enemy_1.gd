extends entity_movement

func _ready():
	random_direction() # on appelle la fonction random ici de la script entity.gd
# Timer : Nouveau node --> en fin de la décomptage, on va actionner on va appeler notre fonction random direction

func _on_timer_timeout():
	random_direction()
	$Timer.start()    # On va relancer le time start qui va créer une boucle qui va donc à chaque fois changer la direction de notre personnage


func _on_box_collision_area_entered(area):
	if area.is_in_group("Sword"):
		vie -= 1
		flash()
		print(vie)
		
func flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0)
