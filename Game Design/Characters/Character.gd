@icon("res://assets/kenney_scribbledungeons/Player.png")

extends CharacterBody2D
class_name Character

const FRICTION: float = 0.15

@export var accerelation: int = 40
@export var max_speed: int = 200

@export var max_hp: int = 2
@export var hp: int = 2: set = set_hp
signal hp_changed(new_hp)

@onready var state_machine: Node = get_node("FiniteStateMachine")
@onready var animated_sprite: Sprite2D = get_node("Char")

var mov_direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * accerelation
	velocity = velocity.limit_length(max_speed)

func take_damage(dam: int, dir: Vector2, force: int) -> void:
	#if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		#_spawn_hit_effect()
		#self.hp -= dam
		hp -= dam
		velocity += dir * force
		#if name == "Player":
			##SavedData.hp = hp
			#if hp == 0:
				##SceneTransistor.start_transition_to("res://Game.tscn")
				##SavedData.reset_data()
				#print("dead")
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
		else:
			state_machine.set_state(state_machine.states.dead)
			velocity += dir * force * 2


func set_hp(new_hp: int) -> void:
	hp = clamp(new_hp, 0, max_hp)
	emit_signal("hp_changed", hp)


func _spawn_hit_effect() -> void:
	#var hit_effect: Sprite2D = HIT_EFFECT_SCENE.instantiate()
	#add_child(hit_effect)
	print("A")
