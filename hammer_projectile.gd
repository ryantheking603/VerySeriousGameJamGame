extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func be_thrown(velocity: Vector2):
	self.reparent(self.get_parent().get_parent())
	self.linear_velocity = velocity
