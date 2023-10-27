#node tree
#https://m.imgur.com/gallery/g2a5wEj


@tool
extends CollisionPolygon2D
 
@export var detect_change : bool = true
@export var fitting : bool = true
 
 
 
var time = 0
var lastTiles
 
 
func _process(_delta):
 
	if (Engine.is_editor_hint() && time<Time.get_ticks_msec() && detect_change):
		# Code to execute in editor.
		time = Time.get_ticks_msec()+10
		
		var tileset = get_parent().get_parent().get_node("TileMap")
		var tiles = tileset.get_used_cells()
		
		if(lastTiles!=tiles):
			lastTiles=tiles
		
			var cell_size = tileset.cell_size.x
			var rect = tileset.get_used_rect()
			var myShape = Array()
			
			if(fitting):
				for tile in tiles:
					#print(tile)
					var pos
					var where
					########################################
					pos =tileset.map_to_world(tile)+Vector2(0,0)
					where = myShape.find(pos)
					if(where>=0):
						myShape.remove(where)
					else:
						myShape.append(pos)
					##################################
					pos =tileset.map_to_world(tile)+Vector2(0,0)+Vector2(cell_size,0)
					where = myShape.find(pos)
					if(where>=0):
						myShape.remove(where)
					else:
						myShape.append(pos)
					##################################
					pos =tileset.map_to_world(tile)+Vector2(0,0)+Vector2(cell_size,cell_size)
					where = myShape.find(pos)
					if(where>=0):
						myShape.remove(where)
					else:
						myShape.append(pos)
					##################################
					pos =tileset.map_to_world(tile)+Vector2(0,0)+Vector2(0,cell_size)
					where = myShape.find(pos)
					if(where>=0):
						myShape.remove(where)
					else:
						myShape.append(pos)
					
					
				for n in range(1, myShape.size()-1):
					var current=myShape[n]
					var last =myShape[n-1]
					
					var next=[]
					var sDist=99999
   
					for m in range(n+1, myShape.size()):
						var candidate = myShape[m]
						var dist=current.distance_to(candidate)
						#print(n,current)
						if(orthogonal(last,current,candidate)):
							var angle = current.direction_to(candidate).rotated(-PI/4)
							var f = !!tileset.get_cellv(tileset.world_to_map(current+angle))
							var g = !!tileset.get_cellv(tileset.world_to_map(current+angle.rotated(PI/2)))
							if(f!=g && dist<sDist):
								next=m
								sDist=dist
 
					if(next):
						#next = next[0]
						var nextS = myShape[next]
						myShape.remove(next)
						myShape.insert(n+1,nextS)
			
			if(!fitting): ## || !workingShape):
				myShape = Array()
				myShape.append(tileset.map_to_world(rect.position))
				myShape.append(tileset.map_to_world(Vector2(rect.position.x,rect.end.y)))
				myShape.append(tileset.map_to_world(rect.end))
				myShape.append(tileset.map_to_world(Vector2(rect.end.x,rect.position.y)))  
			
			set_polygon(myShape)
	
 
	if not Engine.is_editor_hint():
		pass
 
 
func orthogonal(c, a, b):
	return ((a.x == b.x) || (a.y == b.y)) && ((c.x != b.x) && (c.y != b.y))
