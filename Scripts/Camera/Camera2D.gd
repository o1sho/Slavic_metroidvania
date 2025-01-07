extends Camera2D

@export var player: CharacterBody2D
var current_area: Area2D = null

@export var true_width: float = 640  # Желаемая ширина области видимости в пикселях
@export var true_height: float = 360 # Желаемая высота области видимости в пикселях

@export var look_ahead_distance: float = 100.0  # Расстояние обзора в направлении движения
@export var smooth_factor: float = 0.1  # Коэффициент сглаживания (0.0 - резкое, 1.0 - вообще не двигается)

var target_offset: Vector2 = Vector2.ZERO

func _ready():
	сonnectAllAreas()
	update_camera_zoom()

func _process(delta):
	if player != null:
		position = player.position
		update_camera_offset(delta)

func _physics_process(delta):
	pass

func сonnectAllAreas():
	var areas = get_tree().get_nodes_in_group("Areas")
	for area in areas:
		if area is Area2D:  # Проверяем, что узел является Area2D
			area.connect("body_entered", Callable(self, "on_body_entered").bind(area))
			print(area.name, " connected")
			area.connect("body_exited", Callable(self, "on_body_exited").bind(area))

# Обработчик для body_entered
func on_body_entered(body: Node, area: Area2D):
	if body.name == "Player":  # Проверяем, что в зону вошел именно игрок
		if area != current_area:
			print("Player entered area: ", area.name)
			current_area = area
			print("Current area: ",  current_area.name)
			update_camera_limit()

# Обработчик для body_exited
func on_body_exited(body: Node, area: Area2D):
	if body.name == "Player":
		print("Player exited area: ", area.name)

func update_camera_limit():
	if current_area == null:
		return

	var collision_shape = current_area.get_node("CollisionShape2D")
	var shape = collision_shape.shape
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

		# Обнуляем смещение для синхронизации
		target_offset = Vector2.ZERO
		offset = Vector2.ZERO

func update_camera_zoom() -> void:
	var viewport_size = get_viewport().size
	print(viewport_size)
	# Рассчитываем масштабирование по ширине и высоте
	var horizontal_zoom = viewport_size.x / true_width
	var vertical_zoom = viewport_size.y / true_height

	# Используем наименьший коэффициент масштабирования, чтобы охватить всю область
	var zoom_factor = min(horizontal_zoom, vertical_zoom)
	
	# Устанавливаем масштаб камеры
	zoom = Vector2(1.0, 1.0) * zoom_factor

func update_camera_offset(delta: float) -> void:
	if player != null:
		var velocity = player.velocity
		# Проверяем направление движения
		var offset_x = 0.0
		var offset_y = 0.0

		if abs(velocity.x) > 0.1:  # Двигается по горизонтали
			offset_x = sign(velocity.x) * look_ahead_distance

		if velocity.y > 0.1:  # Проверяем, что скорость направлена вниз
			offset_y = velocity.y * 0.1 + look_ahead_distance * 0.3  # Пропорциональное смещение

		# Целевое смещение камеры
		target_offset = Vector2(offset_x, offset_y)
		
		# Плавно приближаем текущее смещение к целевому
		offset = offset.lerp(target_offset, smooth_factor)
