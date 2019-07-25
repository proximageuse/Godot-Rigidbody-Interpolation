extends Spatial

# The name of the node to be interpolated. (must be a child of this node)
var interpolatedNodeName: String = "MeshInstance"

# The actual node reference. (you can define this yourself if you want!)
var interpolatedNode: Node

# The previous transform of the interpolatedNode.
var lastTransform: Transform

# The current physics tickRate, defined in milliseconds between each tick.
var tickRate: float

# The time (in MS) at which the last tick happened.
var lastMS

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	if lastTransform != null && lastMS != null:
		# The amount of time elapsed since the last physics tick, in milliseconds.
		var msDifference = OS.get_ticks_msec() - lastMS
		
		# The factor for interpolating, range is 0.0 - 1.0
		var interpolationFactor = msDifference / tickRate
		
		interpolatedNode.global_transform = lastTransform.interpolate_with(transform, interpolationFactor)

# Called every physics tick. 'delta' is the elapsed time since the previous frame
func _physics_process(delta):
	if interpolatedNode == null:
		# Finding the node by name if it doesn't exist yet.
		interpolatedNode = get_node(interpolatedNodeName)
		
		# This is just checking if we successfully found the node and if not, printing something.
		# This sometimes will be printed a few times when you start your game.
		# You should probably remove this once you're sure the script is working.
		if interpolatedNode == null:
			print("Can't find node to interp!")
	else:
		# Setting all of the variables we need to interpolate:
		
		# Getting the tickRate, based on how much time has passed since the previous tick.
		tickRate = delta * 1000 
		
		# Getting the time at which this tick happened.
		lastMS = OS.get_ticks_msec()
		
		# Getting the current transform, as of this tick.
		lastTransform = transform
