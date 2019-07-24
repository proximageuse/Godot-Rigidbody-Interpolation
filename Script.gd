extends Spatial

# The name of the node to be interpolated (must be a child of this node)
var interpolatedNodeName: String = "MeshInstance"

# The actual node reference (you can define this yourself if you want!)
var interpolatedNode: Node

# The previous transform of the interpolatedNode
var lastTransform: Transform

# The current physics tickRate, in milliseconds
var tickRate: float

# The total ticks (in ms) since the last physics tick
var lastMS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lastTransform != null && lastMS != null:
		var msDifference = OS.get_ticks_msec() - lastMS
		
		# The factor for interpolating, range is 0.0 - 1.0
		var interpolationFactor = msDifference / tickRate
		
		interpolatedNode.global_transform = lastTransform.interpolate_with(transform, interpolationFactor)


func _physics_process(delta):
	if interpolatedNode == null:
		# Finding the node by name if it doesn't exist yet
		interpolatedNode = get_node(interpolatedNodeName)
		
		# This is just checking if we successfully found the node and if not, printing something.
		# This sometimes will be printed a few times when you start your game.
		# You should probably remove this once you're sure the script is working.
		if interpolatedNode == null:
			print("Can't find node to interp!")
	else:
		# Setting all pf the variables we need to interpolate:
		
		# Finding & setting the physics tickRate at the time of this physics tick
		tickRate = delta * 1000 
		
		# Finding & setting the time at which this tick was
		lastMS = OS.get_ticks_msec()
		
		# Finding & setting the transform at the time of this tick
		lastTransform = transform