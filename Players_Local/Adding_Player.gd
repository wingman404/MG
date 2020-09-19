extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var controllers=[]
var player= preload("res://Players_Local/Player_local.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var list=[Vector2(0,0),Vector2(1,0),Vector2(0,1),Vector2(1,1)]

var size=OS.window_size
var i=0


func _unhandled_input(event):
	
	if event is InputEventKey or event is InputEventJoypadButton:
		if (event.get_device() in controllers) == false:
			var p=player.instance()
			p.margin_top=list[i][1]*size[1]/1.175
			p.margin_left=list[i][0]*size[0]/1.075
			p.margin_bottom=list[i][1]*size[1]
			p.margin_right=list[i][0]*size[0]
			
			controllers.append(event.get_device())
			self.add_child(p,true)
			print(controllers)
			i+=1
		pass
