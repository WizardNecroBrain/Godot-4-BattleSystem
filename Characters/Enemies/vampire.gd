extends Characters

@onready var battle_zone = $"../.."
@onready var sprite_2d = $Sprite2D

var onButton: bool
signal onTargetenemie
signal nextTurn

func _ready():
	typeCharacter = "Enemy"
	hp = 100
	damage = 7
	onTargetenemie.connect(battle_zone.player_attack)
	nextTurn.connect(battle_zone.process_turn)


func _process(delta):
	if hp <= 0:
		battle_zone.remove_combatant($".")
	$hp.text = "Vampire\nHP: " + str(hp) + "\nDAMAGE: " + str(damage) + "\nArmor: " + str(defense)
	if onButton == true and battle_zone.WhoToHit == true:
		sprite_2d.scale = Vector2(0.6, 0.6)
		if Input.is_action_just_pressed("MouseLeft"):
			battle_zone.targetEnemie = $"."
			onTargetenemie.emit()
	else:
		sprite_2d.scale = Vector2(0.5, 0.5)




func attack(target):
	battle_zone.damage()
	$AnimationPlayer.play("Attack")
	await $AnimationPlayer.animation_finished
	var losses = (damage * battle_zone.ballsDamage) - target.defense
	damage_label(losses)
	target.hp -= losses
	if target.hp <= 0:
		target.queue_free()
		battle_zone.restart_menu()
	nextTurn.emit()



func _on_area_2d_mouse_entered():
	onButton = true


func _on_area_2d_mouse_exited():
	onButton = false

func damage_label(damage: int):
	$damageLabel.text = "Dmg: " + str(damage)
	$damageLabel.show()
	$Timer.wait_time = 1.5
	$Timer.start()
	await $Timer.timeout
	$damageLabel.hide()
