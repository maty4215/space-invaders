extends Node2D

class_name EnemySpawner

const ROWS = 5
const COLUMNS = 11
const HORIZONTAL_SPACING = 32
const VERTICAL_SPACING = 32
const INVADER_HEIGHT = 24
const START_Y_POSITION = -50
const INVADERS_POSITION_X_INCREMENT = 10
const INVADERS_POSITION_Y_INCREMENT = 20

var movement_direction = 1

var enemy_scene = preload("res://scenes/enemy.tscn")

#NODE REFERENCES
@onready var movement_timer = $MovementTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SETUP TIMERS
	movement_timer.timeout.connect(move_enemies)
	
	var enemy_1_res = preload("res://Resources/enemy1.tres")
	var enemy_2_res = preload("res://Resources/enemy2.tres")
	var enemy_3_res = preload("res://Resources/enemy3.tres")
	
	var enemy_config
	
	for row in ROWS:
		if row == 0:
			enemy_config = enemy_1_res
		elif row == 1 || row == 2:
			enemy_config == enemy_2_res
		elif row == 3 || row == 4:
			enemy_config = enemy_3_res
		
		var row_width = (COLUMNS * enemy_config.width * 3) + ((COLUMNS - 1) * HORIZONTAL_SPACING)
		var start_x = (position.x - row_width) / 2
		
		for col in COLUMNS:
			var x = start_x + (col * enemy_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_position = Vector2(x, y)
			
			spawn_enemy(enemy_config, spawn_position)
			
func spawn_enemy(enemy_config, spawn_position: Vector2):
	var enemy = enemy_scene.instantiate() as Enemy
	enemy.config = enemy_config
	enemy.global_position = spawn_position
	add_child(enemy)
	
func move_enemies():
	position.x += INVADERS_POSITION_X_INCREMENT * movement_direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_right_wall_area_entered(area: Area2D) -> void:
	if (movement_direction == 1):
		movement_direction *= -1


func _on_left_wall_area_entered(area: Area2D) -> void:
	if (movement_direction == -1):
		movement_direction *= -1
