extends RefCounted
class_name mvc_command

var _cmd_list: Array
var _app: WeakRef

func add_command(cmd):
	_cmd_list.append(cmd)

func execute(e: mvc_event):
	for cmd in _cmd_list:
		cmd._set_app(app())
		cmd.execute(e)
	_on_execute(e)
	
func app() -> mvc_app:
	return _app.get_ref()
	
func get_proxy(name: String) -> mvc_proxy:
	return app().get_proxy(name)
	
# ==============================================================================
# override
func _on_execute(e: mvc_event):
	pass
	
func _set_app(a: mvc_app):
	_app = weakref(a)
	
