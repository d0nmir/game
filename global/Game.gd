extends Node

func _ready() -> void:
	addEXP(100)
	print(dataBasePlayer)

var dataBaseBoss = {
	0 : {
		"Name" : "Dummy",
		"Frame" : 0,
		"Current_Health" : 100,
		"Max_Health": 100,
		"level" : 1,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strength" : 10,
		"Defense" : 5,
		"Attacks" : {
			0 : {
				"Name" : "Tackle",
				"Target" : "Monster",
				"Damage" : 20,
				"cost" : 2
			},
			1 : {
				"Name" : "Burst",
				"Target" : "Monster",
				"Damage" : 20,
				"cost" : 3
			} 
		}
	} ,
	1 : {
		"Name" : "Crab Boss",
		"Frame" : 0,
		"Current_Health" : 200,
		"Max_Health": 200,
		"level" : 1,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strength" : 10,
		"Defense" : 5,
		"Attacks" : {
			0 : {
				"Name" : "Tackle",
				"Target" : "Monster",
				"Damage" : 15,
				"cost" : 2
			},
			1 : {
				"Name" : "Burst",
				"Target" : "Monster",
				"Damage" : 20,
				"cost" : 3
			} 
		}
	}
}

var dataBasePlayer = {
	0 : {
		"Name" : "Pirate",
		"Frame" : 0,
		"Current_Health" : 100,
		"Max_Health": 100,
		"Level" : 1,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strength" : 10,
		"Defence" : 5,
		"Attacks" : {
			0 : {
				"Name" : "Tackle",
				"Target" : "Monster",
				"Damage" : 10,
				"cost" : 2
			},
			1 : {
				"Name" : "Burst",
				"Target" : "Monster",
				"Damage" : 20,
				"cost" : 3
			} 
		}
	}
}

func addEXP(amount):
	for i in dataBasePlayer:
		dataBasePlayer[i]["Exp"] += amount
		if dataBasePlayer[i]["Exp"] >= dataBasePlayer[i]["MaxExp"]:
			dataBasePlayer[i]["Level"] += 1
			dataBasePlayer[i]["Exp"] = 0
			dataBasePlayer[i]["MaxExp"] = dataBasePlayer[i]["MaxExp"] * 1.5
	
	
