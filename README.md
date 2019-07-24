# Godot-Rigidbody-Interpolation
Just a simple GDScript for the interpolation of a mesh attached to a RigidBody (or any other node that inherits Spatial!). Useful if your physics framerate is different from your monitor's refresh rate.

# Uses
If you at any point use physics or are using \_physics\_process(delta) at all, it's very useful to have some form of interpolation for the meshes effected. If you don't, gameplay will appear stuttery for anyone running your game at a different framerate than your physics framerate. This is a very basic example that can be expanded upon or just used as reference.

# Why I put it on GitHub
Because I'm bored and thought having this as a reference might help someone someday.
