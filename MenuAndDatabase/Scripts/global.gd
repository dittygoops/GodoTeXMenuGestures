extends Node

var database : SQLite;

func _ready():
	database = SQLite.new();
	database.path = "res://data.db";
	database.open_db();
