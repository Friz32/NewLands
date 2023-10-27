class_name PGenCave
extends RefCounted

const TILES = {
	"ground": Vector2i(1, 0),
	"wall": Vector2i(0, 0),
}

var size := Vector2i(80, 50)
var iterations := 20_000
var neighbors := 4
var ground_chance := 48.0
var min_cave_size := 80

var caves = []

func generate() -> PackedScene:
	var root = Node2D.new()
	
	var tile_map = TileMap.new()
	tile_map.tile_set = preload("uid://bglwjv6yeyp67")
	tile_map.scale = Vector2(4, 4)
	root.add_child(tile_map)
	tile_map.owner = root
	
	fill_wall(tile_map)
	random_ground(tile_map)
	dig_caves(tile_map)
	get_caves(tile_map)
	connect_caves(tile_map)
	
	var scene = PackedScene.new()
	scene.pack(root)
	return scene

func fill_wall(tile_map: TileMap):
	for x in size.x:
		for y in size.y:
			tile_map.set_cell(0, Vector2i(x, y), 0, TILES["wall"])

func random_ground(tile_map: TileMap):
	for x in size.x:
		for y in size.y:
			if randf() < ground_chance / 100:
				tile_map.set_cell(0, Vector2i(x, y), 0, TILES["ground"])

func dig_caves(tile_map: TileMap):
	for i in iterations:
		var x = round(randf_range(1, size.x - 1))
		var y = round(randf_range(1, size.y - 1))
		
		if check_nearby(tile_map, x, y) > neighbors:
			tile_map.set_cell(0, Vector2i(x, y), 0, TILES["wall"])
		elif check_nearby(tile_map, x, y) < neighbors:
			tile_map.set_cell(0, Vector2i(x, y), 0, TILES["ground"])

func check_nearby(tile_map: TileMap, x, y):
	var count = 0
	
	if tile_map.get_cell_atlas_coords(0, Vector2i(x, y - 1)) == TILES["wall"]: count += 1
	if tile_map.get_cell_atlas_coords(0, Vector2i(x, y + 1)) == TILES["wall"]: count += 1
	if tile_map.get_cell_atlas_coords(0, Vector2i(x - 1, y)) == TILES["wall"]: count += 1
	if tile_map.get_cell_atlas_coords(0, Vector2i(x + 1, y)) == TILES["wall"]: count += 1
	if tile_map.get_cell_atlas_coords(0, Vector2i(x + 1, y + 1)) == TILES["wall"]: count += 1
	if tile_map.get_cell_atlas_coords(0, Vector2i(x + 1, y - 1)) == TILES["wall"]: count += 1
	if tile_map.get_cell_atlas_coords(0, Vector2i(x - 1, y + 1)) == TILES["wall"]: count += 1
	if tile_map.get_cell_atlas_coords(0, Vector2i(x - 1, y - 1)) == TILES["wall"]: count += 1
	
#	for xx in range(-1, 1):
#		for yy in range(-1, 1):
#			if xx == x && yy == y:
#				continue
#
#			if tile_map.get_cell_atlas_coords(0, Vector2i(x + xx, y + yy)) == TILES["wall"]:
#				count += 1
	
	return count

func get_caves(tile_map: TileMap):
	caves.clear()
	
	for x in size.x:
		for y in size.y:
			if tile_map.get_cell_atlas_coords(0, Vector2i(x, y)) == TILES["ground"]:
				flood_fill(tile_map, x, y)
	
	for cave in caves:
		for tile in cave:
			tile_map.set_cell(0, tile, 0, TILES["ground"])

func flood_fill(tile_map: TileMap, x, y):
	var cave = []
	var to_fill = [Vector2i(x, y)]
	
	while to_fill:
		var tile = to_fill.pop_back()
		
		if !cave.has(tile):
			cave.append(tile)
			tile_map.set_cell(0, tile, 0, TILES["wall"])
			
			var side = []
			var angle = 0
			for i in 4:
				side.append(tile + Vector2i(cos(angle), sin(angle)))
				angle += PI / 2
			
			for dir in side:
				if tile_map.get_cell_atlas_coords(0, dir) == TILES["ground"] && !to_fill.has(dir) && !cave.has(dir):
					to_fill.append(dir)
	
	if cave.size() > min_cave_size:
		caves.append(cave)

func connect_caves(tile_map: TileMap):
	var prev_cave
	var tunnel_caves = caves.duplicate()
	
	for cave in tunnel_caves:
		if prev_cave:
			var new_point = cave[randi() % cave.size()]
			var prev_point = prev_cave[randi() % prev_cave.size()]
			
			if new_point != prev_point:
				create_tunnel(tile_map, new_point, prev_point, cave)
		
		prev_cave = cave

func create_tunnel(tile_map: TileMap, a, b, cave):
	const MAX_STEPS = 500
	
	var steps = 0
	var drunk_pos = Vector2i(b.x, b.y)
	
	while steps < MAX_STEPS && !cave.has(drunk_pos):
		var n = 1.0
		var s = 1.0
		var e = 1.0
		var w = 1.0
		var weight = 1
		
		if drunk_pos.x < a.x:
			e += weight
		elif drunk_pos.x > a.x:
			w += weight
		
		if drunk_pos.y < a.y:
			s += weight
		elif drunk_pos.y > a.y:
			n += weight
		
		var total = n + s + e + w
		n /= total
		s /= total
		e /= total
		w /= total
		
		var dx
		var dy
		var choice = randf()
		
		if 0 <= choice && choice < n:
			dx = 0
			dy = -1
		elif n <= choice && choice < n + s:
			dx = 0
			dy = 1
		elif n + s <= choice && choice < n + s + e:
			dx = 1
			dy = 0
		else:
			dx = -1
			dy = 0
		
		if (2 < drunk_pos.x + dx && drunk_pos.x + dx < size.x - 2) && (2 < drunk_pos.y + dy && drunk_pos.y + dy < size.y - 2):
			drunk_pos += Vector2i(dx, dy)
			
			if tile_map.get_cell_atlas_coords(0, drunk_pos) == TILES["wall"]:
				tile_map.set_cell(0, drunk_pos, 0, TILES["ground"])
				
				tile_map.set_cell(0, Vector2i(drunk_pos.x + 1, drunk_pos.y), 0, TILES["ground"])
				tile_map.set_cell(0, Vector2i(drunk_pos.x + 1, drunk_pos.y + 1), 0, TILES["ground"])
		
		steps += 1
