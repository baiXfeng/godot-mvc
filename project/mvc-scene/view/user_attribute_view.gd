extends HBoxContainer

@onready var gold = $gold
@onready var hp = $HP

func set_proxy(p: user_attribute_proxy):
	p.connect("on_gold_changed", _on_gold_changed)
	p.connect("on_hp_changed", _on_hp_changed)
	p.update_ui()
	
func _on_gold_changed(value: int):
	gold.text = "GOLD: %d" % value
	
func _on_hp_changed(value: int):
	hp.text = "HP: %d" % value
	
