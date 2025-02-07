extends Node

var hand = []
var size = 5

func _ready():
	randomCards()
	print(hand)

func randomCards():
	#i = 0
	for i in size:
		hand.append(CardDatabase.cards[1])
