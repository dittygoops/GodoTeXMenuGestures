extends Node2D

var size : int;
var cardIndex : int;
var sideIndex : int;
var flashcards : Array;

const threshold := 250;
var pressedPos : Vector2;
var releasePos : Vector2;

func initFlashcards():
	var temp : Array = Global.database.select_rows("EU_Database", "Sides > 0", ["Title", "Sides", "Side_1", "Side_2", "Side_3", "Side_4", "Side_5", "Side_6", "Side_7"]);
	
	for ls in temp:
		var entry : Array = [];
		entry = [ls.get("Title"), ls.get("Sides")];
		
		for i in range(1, entry[1] + 1):
			entry.push_back(ls.get("Side_" + str(i)));
		
		flashcards.push_back(entry);

func setLabels(cardI : int, sideI : int):
	get_node("Page/MarginContainer/VBoxContainer/IndexLabel").text = str(sideI + 1) + " / " + str(flashcards[cardI][1]);
	var title : String = flashcards[cardI][0];
	var entry : String = flashcards[cardI][sideI + 2];
	get_node("Page/MarginContainer/VBoxContainer/Title").LatexExpression = title;
	get_node("Page/MarginContainer/VBoxContainer/Title").Render();
	get_node("Page/MarginContainer/VBoxContainer/Flashcard").LatexExpression = entry;
	get_node("Page/MarginContainer/VBoxContainer/Flashcard").Render();

# Called when the node enters the scene tree for the first time.
func _ready():
	initFlashcards();
	
	cardIndex = 0;
	sideIndex = 0;
	
	setLabels(cardIndex, sideIndex);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event : InputEvent):
	if event.is_action_pressed("click"):
		pressedPos = event.position;
	if event.is_action_released("click"):
		releasePos = event.position;
		calculateGesture();
		
func calculateGesture():
	var d := releasePos - pressedPos;
	
	if d.length_squared() > 500:
		if abs(d.x) > abs(d.y):
			if d.x < 0:
				#left
				cardIndex = mod((cardIndex + 1), flashcards.size());
				sideIndex = 0;
				
			else:
				#right
				cardIndex = mod((cardIndex - 1), flashcards.size());
				sideIndex = 0;
		else:
			size = flashcards[cardIndex][1];
			if d.y < 0:
				#up
				sideIndex = mod((sideIndex + 1), size);
			
			else:
				#down
				sideIndex = mod((sideIndex - 1), size);
		
		setLabels(cardIndex, sideIndex);

func mod(x : int, y : int) -> int:
	return (x % y + y) % y;

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/CalculusIII/Calculus_III.tscn");
