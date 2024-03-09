extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_calculus_i_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/CalculusI/Calculus_I.tscn");


func _on_calculus_ii_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/CalculusII/Calculus_II.tscn")


func _on_calculus_iii_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/CalculusIII/Calculus_III.tscn");


func _on_differential_equations_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/DifferentialEquations/Differential_Equations.tscn");
