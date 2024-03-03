extends Node2D

var batCharacter = preload("res://Characters/Enemies/Bat.tscn")
var vampireCharacter = preload("res://Characters/Enemies/vampire.tscn")

var spawnCombatants = [batCharacter, vampireCharacter]

var combatants = []
var currentTurn = 0
var turn = 0

var targetEnemie = null
var WhoToHit: bool
var dungeonLevel = 1
var ballsDamage: int


func _ready():
	$CanvasLayer/Label.text = "Dungeon level: " + str(dungeonLevel)
	spawn_characters()
	characters_ready()
	next_level()
	process_turn()

func characters_ready():
	for i in $Enemies.get_children():
		combatants.append($Player)
		combatants.append(i)

func process_turn():
	if combatants.size() != 0:
		var combatant = combatants[currentTurn % combatants.size()]
		if combatant == $Player:
			$CanvasLayer/BattleButtons.show()
		else:
			combatant.attack($Player)
		currentTurn += 1
	else:
		next_level()
	
	
func remove_combatant(character):
	var index = combatants.find(character)
	if index != -1:
		combatants.remove_at(index - 1)
		combatants.remove_at(index - 1)

func player_attack():
	if $CanvasLayer/BattleButtons.visible == true:
		if WhoToHit == true and targetEnemie != null:
			$Player.attack(targetEnemie)

func _on_button_attack_button_down():
	WhoToHit = true


func _on_button_skip_button_down():
	$Player.heal()



func next_level():
	if combatants.size() == 0:
		dungeonLevel += 1
		$CanvasLayer/Label.text = "Dungeon level: " + str(dungeonLevel)
		spawn_characters()
		characters_ready()
		currentTurn = 0
		process_turn()

func spawn_characters():
	var createACharacter = 0
	var instance = spawnCombatants[randi() % spawnCombatants.size()].instantiate()
	instance.position = Vector2(200, 200)
	$Enemies.add_child(instance)
	
	createACharacter = randi_range(0, 1)
	if createACharacter == 1:
		instance = spawnCombatants[randi() % spawnCombatants.size()].instantiate()
		instance.position = Vector2(200, 350)
		$Enemies.add_child(instance)

	createACharacter = randi_range(0, 1)
	if createACharacter == 1:
		instance = spawnCombatants[randi() % spawnCombatants.size()].instantiate()
		instance.position = Vector2(200, 500)
		$Enemies.add_child(instance)
	
func damage(): #Эта функция для команды отвечающей за три в ряд, вообще если бы я действительно делал для команды то тут были бы воходные данные которые помещались бы ballsDamage
	var quantityBurstBalls = randi_range(3, 9)
	if quantityBurstBalls > 5:
		ballsDamage = 5
	else:
		ballsDamage = quantityBurstBalls

func restart_menu():
	get_tree().change_scene_to_file("res://restart_menu.tscn")

