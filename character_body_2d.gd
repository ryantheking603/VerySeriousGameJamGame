extends CharacterBody2D

var my_weapon: Node2D

var original_offset: Vector2
var original_rotation: float
var movement_dir:Vector2 = Vector2.ZERO
var rotation_dir: float = 0
var rotation_speed: float = 0

@export var max_speed = 200
@export var acceleration = 200
@export var friction: float = 200.0
@export var max_rotation_speed = 200
@export var rotation_friction = 5
@export var rotation_accel = 10

func _ready() -> void:
	my_weapon = $hammerProjectile
	original_offset = my_weapon.position
	original_rotation = my_weapon.rotation

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		if $hammerProjectile:
			var offset_vector = $hammerProjectile.global_position\
								- self.global_position
			var tangent_direction = -offset_vector.orthogonal().normalized()
			var rotational_offset_velocity = tangent_direction\
							 		* offset_vector.length()\
									* rotation_speed
			$hammerProjectile.be_thrown(self.velocity + rotational_offset_velocity)
	elif event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			self.jump_to_my_weapon()
		if event.pressed and event.keycode == KEY_C:
			self.bring_back_my_weapon()


func get_input():
	movement_dir = Input.get_vector("left2", "right2", "up2", "down2")
	rotation_dir = Input.get_axis("rotateccw", "rotatecw")
	

func _physics_process(delta):
	get_input()
	
	if movement_dir != Vector2.ZERO:
		velocity = velocity.move_toward(movement_dir * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()
	
	if rotation_dir != 0:
		var target_spin = rotation_dir * max_rotation_speed
		rotation_speed = move_toward(rotation_speed, target_spin, rotation_accel * delta)
	else:
		rotation_speed = move_toward(rotation_speed, 0.0, rotation_friction * delta)
	rotation +=  rotation_speed * delta
	
func jump_to_my_weapon():
	if my_weapon and my_weapon.get_parent() != self:
		global_position = my_weapon.global_position
		velocity = Vector2.ZERO
		bring_back_my_weapon()
	
func bring_back_my_weapon():
	my_weapon.reparent(self)
	$hammerProjectile.position = original_offset
	$hammerProjectile.linear_velocity = Vector2.ZERO
	$hammerProjectile.rotation = original_rotation
	$hammerProjectile.is_held = true
