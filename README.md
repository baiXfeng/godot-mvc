# godot-mvc
Lightweight mvc framework wirtten with gdscript.

# Features

- Lightweight and non-intrusive.
- Independent of Node components.
- Support serialization and deserialization.
- Easy to use.

# How To Use

- Copy the 'mvc' directory to any location within your Godot project.
- Begin your MVC coding journey with the following code:

```

# create mvc app
var app = mvc_app.new()

# add proxy (model proxy)
app.add_proxy("p1", mvc_proxy.new(1))
app.add_proxy("p2", mvc_proxy.new(2))
app.add_proxy("p3", mvc_proxy.new(3))

# add handler (controller)
app.add_handler("h1", mvc_handler.new())
app.add_handler("h2", mvc_handler.new())
app.add_handler("h2", mvc_handler.new())

# add command
app.add_command("my_command", mvc_command)

# send notification
app.notify("my_notification", with_param)
app.notify("my_command", with_param)

# get proxy
var p1: mvc_proxy = app.get_proxy("p1")
print( p1.data() )

```
