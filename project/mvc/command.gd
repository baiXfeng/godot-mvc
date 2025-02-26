extends RefCounted
class_name MVCCommand

var _cmd_list: Array
var _app: WeakRef

func add_command(cmd):
	_cmd_list.append(cmd)

func execute(e: MVCEvent):
	for cmd in _cmd_list:
		cmd._set_app(app())
		cmd.execute(e)
	_on_execute(e)
	
func app() -> MVCApp:
	return _app.get_ref()
	
func get_proxy(name: String) -> MVCProxy:
	return app().get_proxy(name)
	
# ==============================================================================
# override
func _on_execute(e: MVCEvent):
	pass
	
func _set_app(a: MVCApp):
	_app = weakref(a)
	
