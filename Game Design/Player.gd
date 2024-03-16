@icon("res://assets/kenney_scribbledungeons/Player.png")

extends Character

@onready var weapon: Node2D = get_node("Weapon")
@onready var weapon_animation_player: AnimationPlayer = weapon.get_node("WeaponAnimationPlayer")

@onready var sprite = $Sprite2D

func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	self.look_at(mouse_position)
	if Input.is_action_pressed("ui_attack") and not weapon_animation_player.is_playing():
		weapon_animation_player.play("attack")

func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down(s)"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left(a)"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right(d)"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up(w)"):
		mov_direction += Vector2.UP
