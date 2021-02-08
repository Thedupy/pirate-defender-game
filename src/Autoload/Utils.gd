extends Node

var display_width = ProjectSettings.get('display/window/size/width')
var display_height = ProjectSettings.get('display/window/size/height')
var center_point = Vector2(display_width/2, display_height/2)

func inst_on_main_scene(object):
	var main_scene = get_tree().current_scene;
	main_scene.call_deferred("add_child", object);
	
func reload_scene(time: int):
	yield(get_tree().create_timer(time), "timeout")
	get_tree().reload_current_scene();
	
func remap_range(value, InputA, InputB, OutputA, OutputB):
	var result = (value - InputA) / (InputB - InputA) * (OutputB - OutputA) + OutputA
	return result
