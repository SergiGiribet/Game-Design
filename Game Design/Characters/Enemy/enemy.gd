@icon("res://assets/kenney_scribbledungeons/enemy.png")

extends Character
class_name Enemy

@onready var player: CharacterBody2D = get_tree().current_scene.get_node("Player")
@onready var path_timer: Timer = get_node("PathTimer")
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")


func _ready() -> void:
	var __ = connect("tree_exited", Callable(get_parent(), "_on_enemy_killed"))
	while(player):
		if is_instance_valid(player):
			_get_path_to_player()
		else:
			path_timer.stop()
			mov_direction = Vector2.ZERO
		await get_tree().create_timer(0.1).timeout

func chase() -> void:
	if not navigation_agent.is_target_reached():
		var vector_to_next_point: Vector2 = navigation_agent.get_next_path_position() - global_position
		mov_direction = vector_to_next_point



#func _on_PathTimer_timeout() -> void:
	#print("pepe")
	#if is_instance_valid(player):
		#_get_path_to_player()
	#else:
		#path_timer.stop()
		#mov_direction = Vector2.ZERO


func _get_path_to_player() -> void:
	navigation_agent.target_position = player.position
	print(player.position)





