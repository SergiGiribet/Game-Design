extends Area2D
class_name Hitbox

@export var damage: int = 1
@export var knockback_force: int = 1
@onready var mouse_position: Vector2 = get_global_mouse_position()
var knockback_direction: Vector2 = mouse_position

var body_inside: bool = false

@onready var collision_shape: CollisionShape2D = get_child(0)
@onready var timer: Timer = Timer.new()

func _init() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))


func _ready() -> void:
	assert(collision_shape != null)
	add_child(timer)


func _on_body_entered(body: Node2D) -> void:
	body_inside = true
	timer.start()
	while body_inside:
		_collide(body)
		await timer.timeout

func _on_body_exited(_body: Node2D) -> void:
	body_inside = false
	timer.stop()

func _collide(body: Node2D) -> void:
	var debounce  = false
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		#if (debounce == false):
			body.take_damage(damage, knockback_direction, knockback_force)
			#debounce = true
			#await get_tree().create_timer(0.1).timeout
			#debounce = false
