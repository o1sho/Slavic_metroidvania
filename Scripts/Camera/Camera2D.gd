extends Camera2D

@export var player: CharacterBody2D
var current_area: Area2D = null

@export var true_width: float = 640  # Желаемая ширина области видимости в пикселях
@export var true_height: float = 360 # Желаемая высота области видимости в пикселях

func _ready():
	сonnectAllAreas()
	update_camera_zoom()

func _process(delta):
	if player != null:
		position = player.position
		#var movement_core = player.get_node("Cores/MovementCore") # путь к дочерней ноде внутри Player
		#if movement_core != null:
			#if movement_core.face_direction == 1:
				#scale.x = 1 
			#else: 1

func _physics_process(delta):
	pass

func сonnectAllAreas():
	var areas = get_tree().get_nodes_in_group("Areas")
	for area in areas:
		if area is Area2D:  # Проверяем, что узел является Area2D
			#Callable:
				#В Godot 4 для вызова методов при подключении сигналов используется Callable. Этот объект определяет, какой метод будет вызван, когда сработает сигнал.
				#Callable(self, "_on_body_entered") создает ссылку на метод _on_body_entered в текущем скрипте.
			#bind(area):
				#Метод bind позволяет привязать дополнительные аргументы, которые будут переданы в метод вместе с сигналом. Здесь мы передаем area — ссылку на ту Area2D, которая вызвала сигнал.
			area.connect("body_entered", Callable(self, "on_body_entered").bind(area))
			print(area.name, " connected")
			area.connect("body_exited", Callable(self, "on_body_exited").bind(area))

# Обработчик для body_entered
func on_body_entered(body: Node, area: Area2D):
	if body.name == "Player":  # Проверяем, что в зону вошел именно игрок
		print("Player entered area: ", area.name)
		current_area = area
		print("Current area: ",  current_area.name)
		update_camera_limit()
		#move_camera_to_new_area()

# Обработчик для body_exited
func on_body_exited(body: Node, area: Area2D):
	if body.name == "Player":
		print("Player exited area: ", area.name)

func update_camera_limit():
	var collision_shape = current_area.get_node("CollisionShape2D")
	var shape = collision_shape.shape
	 # Проверяем, что форма является RectangleShape2D
	if shape is RectangleShape2D:
		var rect_size = shape.extents
		var rect_position = current_area.position
		print(rect_position)
		# Вычисляем границы области
		var left_limit = rect_position.x - rect_size.x
		var right_limit = rect_position.x + rect_size.x
		var top_limit = rect_position.y - rect_size.y
		var bottom_limit = rect_position.y + rect_size.y

		# Устанавливаем лимиты камеры
		limit_left = left_limit
		limit_right = right_limit
		limit_top = top_limit
		limit_bottom = bottom_limit

		print("Camera limits updated: Left =", limit_left, " Top =", limit_top, " Right =", limit_right, " Bottom =", limit_bottom)

func update_camera_zoom() -> void:
	var viewport_size = get_viewport().size
	print (viewport_size)
	# Рассчитываем масштабирование по ширине и высоте
	var horizontal_zoom = viewport_size.x / true_width
	var vertical_zoom = viewport_size.y / true_height

	# Используем наименьший коэффициент масштабирования, чтобы охватить всю область
	var zoom_factor = min(horizontal_zoom, vertical_zoom)
	
	# Устанавливаем масштаб камеры
	zoom = Vector2(1.0, 1.0) * zoom_factor
