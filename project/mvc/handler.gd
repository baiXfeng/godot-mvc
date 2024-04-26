extends RefCounted
class_name mvc_handler
	
func name() -> String:
	return _name
	
func app() -> mvc_app:
	return _app.get_ref()
	
func on_enter(a: mvc_app):
	if a.debug_print:
		print("handler <%s:%s> on_enter." % [app().name(), _name])
	_on_enter(a)
	
func on_exit(a: mvc_app):
	if a.debug_print:
		print("handler <%s:%s> on_exit." % [app().name(), _name])
	_on_exit(a)
	
func save(dict: Dictionary):
	_on_save(dict)
	
func load(dict: Dictionary):
	_on_load(dict)
	
func notify(event_name: String, value = null):
	app().notify(event_name, value)
	
func send(e: mvc_event):
	app().send(e)
	
# ==============================================================================
# private
var _app: WeakRef
var _name: String
	
# override
func _on_enter(a: mvc_app):
	pass
	
# override
func _on_exit(a: mvc_app):
	pass
	
# override
func _on_save(dict: Dictionary):
	pass
	
# override
func _on_load(dict: Dictionary):
	pass
	
func _set_name(n: String):
	_name = n
	
func _set_app(a: mvc_app):
	_app = weakref(a)
	
func _to_string() -> String:
	return "handler:%s" % _name
	
