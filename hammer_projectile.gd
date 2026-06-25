extends RigidBody2D

var is_held: bool = true
const friction: float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if not is_held:
		linear_velocity = linear_velocity.move_toward(Vector2.ZERO, friction * delta)

func be_thrown(velocity: Vector2):
	self.reparent(self.get_parent().get_parent())
	self.linear_velocity = velocity
	is_held = false
