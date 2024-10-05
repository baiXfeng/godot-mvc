extends RefCounted
class_name mvc_app

var debug_print: bool

var _name: String
var _proxy_pool: Dictionary
var _handler_pool: Dictionary
var _command_pool: Dictionary
var _event_pool: mvc_event_center = mvc_event_center.new()
	
func _init(name: String = "mvc_app"):
	_name = name
	
func name() -> String:
	return _name
	
func clear():
	remove_all_commands()
	remove_all_handlers()
	remove_all_proxies()
	
func add_proxy(name: String, proxy):
	remove_proxy(name)
	_proxy_pool[name] = proxy
	proxy._set_name(name)
	proxy._set_app(self)
	proxy.on_enter(self)
	
func remove_proxy(name: String) -> bool:
	if _proxy_pool.has(name):
		var proxy = _proxy_pool[name]
		proxy.on_exit(self)
	return _proxy_pool.erase(name)
	
func remove_all_proxies():
	var keys = _proxy_pool.keys()
	for k in keys:
		remove_proxy(k)
	
func has_proxy(name: String) -> bool:
	return _proxy_pool.has(name)
	
func get_proxy(name: String) -> mvc_proxy:
	if _proxy_pool.has(name):
		return _proxy_pool[name]
	return null
	
func add_handler(name: String, handler):
	remove_handler(name)
	_handler_pool[name] = handler
	handler._set_name(name)
	handler._set_app(self)
	handler.on_enter(self)
	
func remove_handler(name: String) -> bool:
	if _handler_pool.has(name):
		var handler = _handler_pool[name]
		handler.on_exit(self)
	return _handler_pool.erase(name)
	
func remove_all_handlers():
	var keys = _handler_pool.keys()
	for k in keys:
		remove_handler(k)
	
func has_handler(name: String):
	return _handler_pool.has(name)
	
func get_handler(name: String):
	if _handler_pool.has(name):
		return _handler_pool[name]
	return null
	
class _command_shell extends RefCounted:
	var _debug_print: bool
	var _class: Resource
	var _app_name: String
	var _app: WeakRef
	func _init(r: Resource, debug_print: bool = false):
		_class = r
		_debug_print = debug_print
	func _register(a: mvc_app, name: String):
		_app_name = a.name()
		_app = weakref(a)
		a.add_callable(name, _on_event)
	func _unregister(a: mvc_app, name: String):
		a.remove_callable(name, _on_event)
		_app = null
	func _on_event(e: mvc_event):
		if _debug_print:
			print("command <%s:%s> execute." % [_app_name, e.name])
		var cmd = _class.new()
		cmd._set_app(_app.get_ref())
		cmd.execute(e)
	
func add_command(name: String, cmdres: Resource) -> bool:
	if cmdres == null:
		print("add command <%s:%s> fail: Resource is null." % [_name, name])
		return false
	remove_command(name)
	var shell = _command_shell.new(cmdres, debug_print)
	_command_pool[name] = shell
	shell._register(self, name)
	if debug_print:
		print("command <%s:%s> add to mvc_app." % [_name, name])
	return true
	
func remove_command(name: String) -> bool:
	if _command_pool.has(name):
		var shell = _command_pool[name]
		shell._unregister(self, name)
		if debug_print:
			print("command <%s:%s> remove from mvc_app." % [_name, name])
	return _command_pool.erase(name)
	
func remove_all_commands() -> bool:
	var keys = _command_pool.keys()
	for name in keys:
		remove_command(name)
	return true
	
func has_command(name: String):
	return _command_pool.has(name)
	
func add_callable(name: String, c: Callable):
	_event_pool.add_callable(name, c)
	
func remove_callable(name: String, c: Callable):
	_event_pool.remove_callable(name, c)
	
func notify(event_name: String, value = null):
	_event_pool.notify(event_name, value)
	
func send(e: mvc_event):
	_event_pool.send(e)
	
