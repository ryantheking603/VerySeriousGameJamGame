extends CharacterBody2D

var speed = 10
var target = null;

func _ready() -> void:
	target = NodeRefs.player_ref

func _physics_process(delta):
	position += (target.position - position)/speed
