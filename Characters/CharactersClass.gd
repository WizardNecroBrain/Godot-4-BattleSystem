extends Node

class_name Characters

var typeCharacter: String
var hp: int
var damage: int
var defense = randi_range(1, 5)

func attack(target):
	var losses = damage - target.defense
	target.hp -= losses
	if target.hp <= 0:
		target.queue_free()



