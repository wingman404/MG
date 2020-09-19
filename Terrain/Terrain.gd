extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Terrain_color= preload("res://Terrain/MAT_Terrain.tres")




func get_triangle_normal(a,b,c):
		var side1= b-a
		var side2= c-a
		var normal=side1.cross(side2)
		
		normal=normal/sqrt(normal.z*normal.z+normal.x*normal.x+normal.y*normal.y)
		
		
		return normal
	 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Creating Vertices Array
	var vertices = PoolVector3Array()
	
	var normal= PoolVector3Array()
	
	var uv1=PoolVector2Array()
	
	var INDEX=PoolIntArray()
	
	# Initializing OpenSimplexNoise
	var noise =  OpenSimplexNoise.new()
	
	
	noise.seed= 4815
	noise.octaves= 8
	noise.period= 25.0
	noise.persistence= 0.99
	var scale=10
	
	
	
	var noiseSize=0.01
	
	var vx=100
	var vy=100
	var s=1.0
	
	var num=0
	
	
	for i in range(vx):
		
		for y in range(vy):
			
			var point_h = [noise.get_noise_2d(y*noiseSize,i*noiseSize), noise.get_noise_2d((1+y)*noiseSize,i*noiseSize), noise.get_noise_2d(y*noiseSize,(i+1.0)*noiseSize), noise.get_noise_2d((y+1.0)*noiseSize, (i+1.0)*noiseSize)] 
			#var point_h=noise.get_noise_2d(y*noiseSize,i*noiseSize)
			
			var point1=s*Vector3(y,scale*point_h[0],i)
			var point2=s*Vector3(y+1.0,scale*point_h[1],i)
			var point3=s*Vector3(y,scale*point_h[2],i+1.0)
			#var point4=s*Vector3(i+1.0,scale*point_h[3],y+1.0)
			
			vertices.push_back(point1)				  
			
			#Calculating UV
			uv1.push_back((1/vx)*Vector2(i,y))
			
			#Calculating Normal
			var N=get_triangle_normal(point1,point2,point3)
			
			
			normal.push_back(N)
		pass
	pass
	
	for i in range(vertices.size()):
		
		INDEX.push_back(i)		# #--#
		INDEX.push_back(i+1)	# | /
		INDEX.push_back(i+vy)	# #
		
		INDEX.push_back(i+1)	#    #
		INDEX.push_back(i+vy+1)	#  / |
		INDEX.push_back(i+vy)	# #--# 
		
		
		
		
		
		
		
		num+=1
		
		
	pass
	

	# Creating a new Mesh
	var arr=ArrayMesh.new()
	
	# creating an array of arrays
	var arrays=[]
	
	# Expanding array
	arrays.resize(ArrayMesh.ARRAY_MAX)\
	
	# Setting arrays
	arrays[ArrayMesh.ARRAY_VERTEX] =vertices
	arrays[ArrayMesh.ARRAY_NORMAL] = normal
	arrays[ArrayMesh.ARRAY_TEX_UV2]=uv1
	arrays[ArrayMesh.ARRAY_INDEX]=INDEX
	
	# Calling a function to create the collision 
	get_node("StaticBody/CollisionShape").create_collision(vertices, true)
	
	
	
	arr.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays) 
	self.mesh= arr
	
	

	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
