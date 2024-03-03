extends Characters

@onready var battle_buttons = $"../CanvasLayer/BattleButtons"
@onready var battle_zone = $".."

signal nextTurn

func _ready():
	battle_buttons.hide()
	typeCharacter = "Player"
	hp = 100
	damage = 7
	nextTurn.connect(battle_zone.process_turn)
	

func _process(delta):
	$hp.text = "Player\nHP: " + str(hp) + "\nDAMAGE: " + str(damage) + "\nArmor: " + str(defense)


func attack(target):
	battle_zone.damage()
	battle_buttons.hide()
	$AnimationPlayer.play("Attack")
	await $AnimationPlayer.animation_finished
	var losses = (damage * battle_zone.ballsDamage) - target.defense
	damage_label(losses)
	target.hp -= losses
	if target.hp <= 0:
		target.queue_free()
	battle_zone.WhoToHit = false
	battle_zone.targetEnemie = null
	$Timer.wait_time = 0.6
	$Timer.start()

func heal():
	battle_buttons.hide()
	hp += 15
	if hp > 100:
		hp = 100
	nextTurn.emit()


func _on_timer_timeout():
	nextTurn.emit()

func damage_label(damage: int):
	$damageLabel.text = "Dmg: " + str(damage)
	$damageLabel.show()
	$Timer.wait_time = 2.5
	await $Timer.timeout
	$damageLabel.hide()
	
