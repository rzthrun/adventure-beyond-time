package screens.hud
{
	public class HintSolutionGenerator
	{
		private var game:Game;
		public function HintSolutionGenerator(_game:Game)
		{
			game = _game;
		}
		public function GetSolution():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass != undefined){
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FrontDoor' || 
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'BirdHouse'){
					return "Open the bird house and retrieve the key from inside. Close the bird house," +
						" then use the key to open the front door of the house.";
				}else{
					return RaftSolution();
				}
			}else{
				return "No Solution at this time.";
			}
			
		}
		
		private function RaftSolution():String{
			if(game.SavedGame.SavedGameObj.data.Raft != undefined){
				if(game.SavedGame.SavedGameObj.data.Raft['Door'] != undefined){
					return FreighterPullerSolutions();
				}else{
					return "Pick up the handle from inside the box." +
						" Place the handle on the semi-circular device beside the door," +
						" then tap to open the door.";
				}
			}else{
				return "Pick up the handle from inside the box." +
					" Place the handle on the semi-circular device beside the door," +
					" then tap to open the door.";
			}
			
		}
		
		private function FreighterPullerSolutions():String{
			if(game.SavedGame.SavedGameObj.data.FreighterWheel != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterWheel['Puller'] == 'Attached'){
					return FreighterWheelSolution();
				}else{
					return "Pick up the lever from the table inside the freight ship." +
						" Head upstaris and place the lever on the ship's throttle."
				}
			}else{
				return "Pick up the lever from the table inside the freight ship." +
					" Head upstairs and place the lever on the ship's throttle."
			}
		}
		
		private function FreighterWheelSolution():String{
			if(game.SavedGame.SavedGameObj.data.FreighterWheel != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterWheel['Solved'] == 'Yes'){
					return CoastCaveBoxSolution();
				}else{
					return "Place the lever found on table on the freighter's throttle." +
						" Point it to the right, then move the wheel left two times." +
						" Then, move the lever one position (up) and move the wheel right three times." +
						" Move the lever one position (left), and move the wheel left one time." +
						" Move the lever one position (up), and  move the wheel right two times. " +
						" Then move the lever one more position so it points to the right again.";
				}
			}else{
				return "Place the lever found on table on the freighter's throttle." +
					" Point it to the right, then move the wheel left two times." +
					" Then, move the lever one position (up) and move the wheel right three times." +
					" Move the lever one position (left), and move the wheel left one time." +
					" Move the lever one position (up), and  move the wheel right two times. " +
					" Then move the lever one more position (right).";
			}
		}
		
		private function CoastCaveBoxSolution():String{
			if(game.SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCaveBox['Stone'] != undefined){
					return MoaiSolution();
				}else{
					return "Pick up the ornamental medallion from the crew's lockers aboard the freight ship." +
						" Place the medallion on the box in the cave beside the sea," +
						" then pick up the red stone from inside.";
				}
			}else{
				return "Pick up the ornamental medallion from the crew's lockers aboard the freight ship." +
					" Place the medallion on the box in the cave beside the sea," +
					" then pick up the red stone from inside.";
			}
		}
		
		private function MoaiSolution():String{
			if(game.SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastMoaiEyes['Solved'] == 'Yes'){
					return JungleStumpSolution();
				}else{
					return "Pick up the red stone from beside the buoy in the forest near the coast."+
						" Then place each of the red stones in the eyes of Moai scuplture.";
					
				}
			}else{
				return "Pick up the red stone from beside the buoy in the forest near the coast."+
					" Then place each of the red stones in the eyes of Moai scuplture.";
			}
		}
		
		private function JungleStumpSolution():String{
			if(game.SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleStumpPuzzle['PirateDisc'] == 'PickedUp'){
					return CoastCaveDoorOneSolution();
				}else{
					return "Place the wooden discus found in the Moai's mouth on the center of" +
						" the rings on the tree stump. Rotate the rings so the radial lines match up," +
						" then pick up the metal disc inside.";
					
				}
			}else{
				return "Place the wooden discus found in the Moai's mouth on the center of" +
					" the rings on the tree stump. Rotate the rings so the radial lines match up," +
					" then pick up the metal disc inside.";
			}
		}
		
		private function CoastCaveDoorOneSolution():String{
			if(game.SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCaveCombo['Third'] == 'Attached'){
					return CoastCaveDoorTwoSolution();
				}else{
					return "Place the cylinder from the freighter's safe into the slot on the door in the cave by" +
						" the coast. Then place the disc from the tree stump in the empty slot of the cylinder."+
						" The cylinder and the disc may also be combined in your inventory, and together " +
						" placed in the door's slot.";
					
				}
			}else{
				return "Place the cylinder from the freighter's safe into the slot on the door in the cave by" +
					" the coast. Then place disc from the tree stump in the empty slot of the cylinder."+
					" The cylinder and the disc may also be combined in your inventory, and together " +
					" placed in the door's slot.";
			}
		}
		
		private function CoastCaveDoorTwoSolution():String{
			if(game.SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCaveCombo['Solved'] == 'Yes'){
					return CoastCaveFireSolutionOne();
				}else{
					return "The three names scrawled on the side of the freighter correspond to three" +
						" roman numerals in the Book of Great Queens (I, VI, & VIII). In the Book of Buccanner Sea Flags,"+
						" the three numerals correspond to Black Bart, Edward England & Ned Low. " +
						"Enter their flags in the same order into the combination lock in cave by the coast.";
				}
			}else{
				return "The three names scrawled on the side of the freighter correspond to three" +
					" roman numerals in the Book of Great Queens (I, VI, & VIII). In the Book of Buccanner Sea Flags,"+
					" the three numerals correspond to Black Bart, Edward England & Ned Low. " +
					"Enter their flags in the same order into the combination lock in cave by the coast.";
			}
		}
		private function CoastCaveFireSolutionOne():String{
			if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'LogsAndSticks'){
					return CoastCaveFireSolutionTwo();
				}else if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					return TorchSolution();
				}else{
					return "Pick up the wooden logs beside the Moai and pick up the stick on the ledge" +
						" overlooking the freighter. Add each to the fire pit in the cave by the coast.";
				}
			}else{
				return "Pick up the wooden logs beside the Moai and pick up the stick on the ledge" +
					" overlooking the freighter. Add each to the fire pit in the cave by the coast.";
			}
		}
		
		private function CoastCaveFireSolutionTwo():String{
			if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.InvenPuzzle['flintAndMarcasite'] == 'yes'){
					return FireSolution();
				}else{
					return "Pick up the flint and geode from inside the cave." +
						" Then combine the stones by first selecting one, then immediately selecting the other in your inventory.";
				}
			}else{
				return "Pick up the flint and geode from inside the cave." +
					" Then combine the stones by first selecting one, then immediately selecting the other in your inventory.";
			}
			
			
		}
		private function FireSolution():String{
			if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					return TorchSolution();
				}else{
					return "Use the sparking stones to light the fire in the cave by the coast.";		
				}
			}else{
				return "Use the sparking stones to light the fire in the cave by the coast.";
			}
		}
		private function TorchSolution():String{
			if(game.SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['TarTorch'] == "Yes"){
					return CaveCorridorSolution();
				}else{
					return "Pick up the petrified stick from the tar pit" +
						" and the length of canvas hanging from the tree nearby." +
						" Combine them by first selecting one, and then the other in your inventory." +
						" Then, torch into the pit to add tar to it.";
				}
			}else{
				return "Pick up the petrified stick from the tar pit" +
					" and the length of canvas hanging from the tree nearby." +
					" Combine them by first selecting one, and then the other in your inventory." +
					" Then, torch into the pit to add tar to it.";
			}
			
		}
		
		private function CaveCorridorSolution():String{
			if(game.SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				if(game.SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
					return TarPitPlankSolution();
				}else{
					return "Light the tar covered torch by dipping it in the fire." +
						" Then, use the flaming torch to illuminte the dark corridor in the cave.";
				}
			}else{
				return "Light the tar covered torch by dipping it in the fire." +
					" Then, use the flaming torch to illuminte the dark corridor in the cave.";
			}
		}
		
		private function TarPitPlankSolution():String{
			if(game.SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['PlankClose'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['PlankFar'] == 'Attached'){
						return SubLadderSolution();
					}else{
						return "Pick up the wooden planks near the anchor and barrels, in the cave where the pirate ship is." +
							" Then, place each plank on the rocks sticking out of the center of the tar pit to form a bridge across.";
					}
				}else{
					return "Pick up the wooden planks near the anchor and barrels, in the cave where the pirate ship is." +
						" Then, place each plank on the rocks sticking out of the center of the tar pit to form a bridge across.";
				}
			}else{
				return "Pick up the wooden planks near the anchor and barrels, in the cave where the pirate ship is." +
					" Then, place each plank on the rocks sticking out of the center of the tar pit to form a bridge across.";
			}
			
			
		}
		
		private function SubLadderSolution():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Card'] == 'Attached'){
					return SubCodeSolution();
				}else{
					return "Pick up card on the ground at the cliff overlooking the waterfall." +
						" Also, pick up the ladder inside of the boat below. Place the ladder on the wing of" +
						" the submarine and climb up. Then, use the card to activate the submarine's security console.";
				}
			}else{
				return "Pick up card on the ground at the cliff overlooking the waterfall." +
					" Also, pick up the ladder inside of the boat below. Place the ladder on the wing of" +
					" the submarine and climb up. Then, use the card to activate the submarine's security console.";
			}
			
			
		}
		
		private function SubCodeSolution():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Solved'] == 'yes'){
					return SubmarineHatchSolution();
				}else{
					return "The novel in the row boat, 20,000 Leagues Under the Seas, features the 'Nautilus'," +
						" a great ship of the ocean depths." +
						" Enter 'NAUTILUS' on into the security console of the submarine " +
						"and then press 'ENTER' to unlock it.";
					
				}
			}else{
				return "The novel in the row boat, 20,000 Leagues Under the Seas, features the 'Nautilus'," +
					" a great ship of the ocean depths." +
					" Enter 'NAUTILUS' on into the security console of the submarine " +
					"and then press 'ENTER' to unlock it.";
			}
		}
		
		
		private function SubmarineHatchSolution():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineInterior["Rope"] == "Attached"){
					return SubPowerSolution();
				}else{
					return "Open the hatch on the floor of the submarine's bridge." +
						"Then, tie the rope from the wrecked greek trireme near the waterfall" +
						" to the pipes at the left of the hatch."
				}
			}else{
				return "Open the hatch on the floor of the submarine's bridge." +
					"Then, tie the rope from the wrecked greek trireme near the waterfall" +
					" to the pipes at the left of the hatch."
			}
		}
		
		private function SubPowerSolution():String{
			if(game.SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					return CannonLoadSolution();
				}else{
					return "Pick up the red lever from the deck of the old merchant ship deep in the jungle." +
						" Attach the lever where there's an empty space on the submarine's power main. " +
						"Then, position the levers so they match the markings on the wall up the hill from the junk ship." +
						"From left to right, the top row is: DOWN, MIDDLE, UP. The lower row is: UP, UP, DOWN.";
				}
			}else{
				return "Pick up the red lever from the deck of the old merchant ship deep in the jungle." +
					" Attach the lever where there's an empty space on the submarine's power main. " +
					"Then, position the levers so they match the markings on the wall up the hill from the junk ship." +
					"From left to right, the top row is: DOWN, MIDDLE, UP. The lower row is: UP, UP, DOWN.";
			}
		}
		
		private function CannonLoadSolution():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Added'){
					return SmallTorchSolution();
				}else{
					if(game.SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Spent'){
						return FreighterHatchSolution();
					}else{
						return "Release the black powder from the overturned barrel onto the deck of" +
							" the pirate ship in the cave, then pick some up. Head up to the upper deck" +
							" of the ship and load the black powder into the breach of the cannon.";
					}
				}
			}else{
				return "Release the black powder from the overturned barrel onto the deck of" +
					" the pirate ship in the cave, then pick some up. Head up to the upper deck" +
					" of the ship and load black powder into the breach of the cannon.";
			}				
		}
		
		private function SmallTorchSolution():String{
			if(game.SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				if(game.SavedGame.SavedGameObj.data.CaveCorridor['CannonTorch'] == 'Yes'){
					return LightCannonHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
						if(game.SavedGame.SavedGameObj.data.CoastCave['CannonTorch'] == 'Yes'){
							return LightCannonHints();
						}else{
							return "Take the small torch from the deck of the pirate ship," +
								" and ignite it using either the already burning torch in the cave," +
								" or the fire near the entrance of the cave by the sea.";
						}
					}else{
						return "Take the small torch from the deck of the pirate ship," +
							" and ignite it using either the already burning torch in the cave," +
							" or the fire near the entrance of the cave by the sea.";
					}
				}
			}else{
				return "Take the small torch from the deck of the pirate ship," +
					" and ignite it using either the already burning torch in the cave," +
					" or the fire near the entrance of the cave by the sea.";
			}
		}
		
		private function LightCannonHints():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateCannon['K2SO'] == 'PickedUp'){
					return FreighterHatchSolution();
				}else{
					return "Use the torch found on the pirate ship, now lit, to light the cannon's fuse" +
						". Make sure to close the breach before-hand. Then, pick up the white powder that's " +
						"left over inside the cannon.";
				}
			}else{
				return "Use the torch found on the pirate ship, now lit, to light the cannon's fuse" +
					". Make sure to close the breach before hand. Then, pick up the white powder that's " +
					"left over inside the cannon.";
			}
		}
		
		private function FreighterHatchSolution():String{
			if(game.SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineFreighterHatch['Hatch'] == 'Unlocked'){
					return BlowtorchSolution();
				}else{
					return "Combine the vinegar found by the side of the pirate ship " +
						"with the white powder produced by the reaction inside the breach of the cannon." +
						" Pour this powerful solvent onto the hatch on the deck of the freighter to dissolve" +
						" the rust. The powder and vinegar maybe added to the hatch seperately, but the powder must" +
						" be added before for the vinegar can be effective.";
				}
			}else{
				return "Combine the vinegar found by the side of the pirate ship " +
					"with the white powder produced by the reaction inside the breach of the cannon." +
					" Pour this powerful solvent onto the hatch on the deck of the freighter to dissolve" +
					" the rust. The powder and vinegar maybe added to the hatch seperately, but the powder must" +
					" be added before for the vinegar can be effective.";
			}
			
			
		}
		
		private function BlowtorchSolution():String{
			if(game.SavedGame.SavedGameObj.data.FreighterOil != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterOil['BlowTorchLit'] == 'Yes'){
					return FreighterWallSolution();
				}else{
					return "Pick up the empty blowtorch from inside the submarine's torpedo bays. Then head to the freighter and down the hatch, in the lower level. Place the ladder in order to " +
						"get up to the oil barrels. Take the lid off one of the barrels that isn't empty, and use it" +
						" to fill up the blowtorch."
				}
			}else{
				return "Pick up the empty blowtorch from inside the submarine's torpedo bays. Then head to the freighter and down the hatch, in the lower level. Place the ladder in order to " +
					"get up to the oil barrels. Take the lid off one of the barrels that isn't empty, and use it" +
					" to fill up the blowtorch."
			}
		}
		
		private function FreighterWallSolution():String{
			if(game.SavedGame.SavedGameObj.data.FreighterWall != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterWall['Door'] == 'open'){
					return SubConsoleSol();
				}else{
					return "Use the blowtorch to cut the corroded wall of the freighter's" +
						" lower deck, then push on the metal to open a hole.";
				}
			}else{
				return "Use the blowtorch to cut the corroded wall of the freighter's" +
					" lower deck, then push on the metal to open a hole.";
			}
		}
		
		private function SubConsoleSol():String{
			if(game.SavedGame.SavedGameObj.data.HeroBoatSteering != undefined){							
				if(game.SavedGame.SavedGameObj.data.HeroBoatSteering["Screwdriver"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
						if(game.SavedGame.SavedGameObj.data.SubmarineConsole['PanelUnlocked'] == 'yes'){
							return SubmarineWiresSolution();
						}else{
							return "Pick up the screwdriver next to the steering wheel in the yacht by the Moai." +
								" Use the screwdriver to open the panel on the submarine's bridge navigation console.";
						}
					}else{
						return "Pick up the screwdriver next to the steering wheel in the yacht by the Moai." +
							" Use the screwdriver to open the panel on the submarine's bridge navigation console.";
					}
				}else{
					return "Pick up the screwdriver next to the steering wheel in the yacht by the Moai." +
						" Use the screwdriver to open the panel on the submarine's bridge navigation console.";
				}
			}else{
				return "Pick up the screwdriver next to the steering wheel in the yacht by the Moai." +
					" Use the screwdriver to open the panel on the submarine's bridge navigation console.";
			}
			
			
		}
		
		
		private function SubmarineWiresSolution():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_blue'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_green'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_red'] == 'Attached'){
							if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_yellow'] == 'Attached'){
								return ConsoleWireSolve();
							}else{
								return "Pick up the soldering iron from the desk in the field laboratory on the mountain side." +
									" Use it to repair the wires inside the navigation console on the submarine's bridge. ";
							}			
						}else{
							return "Pick up the soldering iron from the desk in the field laboratory on the mountain side." +
								" Use it to repair the wires inside the navigation console on the submarine's bridge. ";
						}			
					}else{
						return "Pick up the soldering iron from the desk in the field laboratory on the mountain side." +
							" Use it to repair the wires inside the navigation console on the submarine's bridge. ";
					}
				}else{
					return "Pick up the soldering iron from the desk in the field laboratory on the mountain side." +
						" Use it to repair the wires inside the navigation console on the submarine's bridge. ";
				}
			}else{
				return "Pick up the soldering iron from the desk in the field laboratory on the mountain side." +
					" Use it to repair the wires inside the navigation console on the submarine's bridge. ";
			}	
			
		}
		
		
		private function ConsoleWireSolve():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['Solved'] == 'Yes'){
					return SubmarineDoorSolution();
				}else{
					return "Arrange the wires in the submarine's navigation console so the colors at the top connect" +
						" to the same color wires at the bottom. From right to left, they'll be arranged: RED, YELLOW, GREEN BLUE";	
				}
			}else{
				return "Arrange the wires in the submarine's navigation console so the colors at the top connect" +
					" to the same color wires at the bottom. From right to left, they'll be arranged: RED, YELLOW, GREEN BLUE";	
				
			}
		}
		
		private function SubmarineDoorSolution():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineInterior['Door'] != undefined){
					return WrenchSolution();	
				}else{
					return "Use the lever on the submarines navigation console to fully restore power. " +
						"Then, open the door."
				}
			}else{
				return "Use the lever on the submarines navigation console to fully restore power. " +
					"Then, open the door."
			}
		}
		
		private function WrenchSolution():String{
			if(game.SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastBuoy["SolarPanels"] == "PickedUp"){
					return WireCutterSolution();
				}else{
					return "Using the wrench from the floor of the torpedo bay, " +
						"remove the solar panel from the buoy in the forest near the life raft.";
				}
			}else{
				return "Using the wrench from the floor of the torpedo bay, " +
					"remove the solar panel from the buoy in the forest near the life raft.";
				
			}
		}
		
		private function WireCutterSolution():String{
			if(game.SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastBuoy["Wires"] == "PickedUp"){
					return JunkPotatoSol();
				}else{
					return "Remove the wire cutters from behind the vent in the submarine" +
						" captain's quarters. Then head to the weather buoy and use them to remove" +
						"  the wires.";
				}
			}else{
				return "Remove the wire cutters from behind the vent in the submarine" +
					" captain's quarters. Then head to the weather buoy and use them to remove" +
					"  the wires.";
			}
		}
		
		private function JunkPotatoSol():String{
			if(game.SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Potatoes'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Wires'] == 'Attached'){
						return VikingTrunkSol();
					}else{
						return "Open the unlocked cabinet in the interior of the junk merchent" +
							" ship and pick up the three potatoes. Combine the potatoes with the wires" +
							" removed from the weather buoy to form a crude electrochemical battery. Then, attach" +
							" the battery to the TV on the Viking longboat as a powersource.";
					}
				}else{
					return "Open the unlocked cabinet in the interior of the junk merchent" +
						" ship and pick up the three potatoes. Combine the potatoes with the wires" +
						" removed from the weather buoy to form a crude electrochemical battery. Then, attach" +
						" the battery to the TV on the Viking longboat as a powersource.";
				}
			}else{
				return "Open the unlocked cabinet in the interior of the junk merchent" +
					" ship and pick up the three potatoes. Combine the potatoes with the wires" +
					" removed from the weather buoy to form a crude electrochemical battery. Then, attach" +
					" the battery to the TV on the Viking longboat as a powersource.";
			}
		}
		
		private function VikingTrunkSol():String{
			if(game.SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleVikingTrunk['Handle'] == 'PickedUp'){
					return JungleEnclaveWallSol();
				}else{
					return "Find the key from inside the diving helmet, on the coast behind the submarine. " +
						"Then use the key to unlock the trunk on the Viking longboat's deck and pick up " +
						"the brass pointer inside.";
				}
			}else{
				return "Find the key from inside the diving helmet, on the coast behind the submarine. " +
					"Then use the key to unlock the trunk on the Viking longboat's deck and pick up " +
					"the brass pointer inside.";
				
			}
		}
		
		private function JungleEnclaveWallSol():String{
			if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall['Arm'] == 'PickedUp'){
					return VikingBallSol();
				}else{
					return "Go up the hill near the junk merchent ship and pick up the brass pointer" +
						" on the rock shelf.";
				}
			}else{
				return "Go up the hill near the junk merchent ship and pick up the brass pointer" +
					" on the rock shelf.";
			}
		}
		
		private function VikingBallSol():String{
			if(game.SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Ball'] == 'PickedUp'){
					return TriemeDeviceSolOne();
				}else{
					return "In the TV, on the deck of the Viking longboat, there is a small marble ball that can be picked up";
				}
			}else{
				return "In the TV, on the deck of the Viking longboat, there is a small marble ball that can be picked up";
			}
			
		}
		
		private function TriemeDeviceSolOne():String{
			if(game.SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDevice['Ball'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.TriremeDevice['Mars'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.TriremeDevice['Sun'] == 'Attached'){
							return TriremeDeviceSolTwo();
						}else{
							return "Place the two brass pointers and the black and white marble ball " +
								"from the TV onto the device located insided the old Greek trireme by " +
								"the waterfall.";
						}
					}else{
						return "Place the two brass pointers and the black and white marble ball " +
							"from the TV onto the device located insided the old Greek trireme by " +
							"the waterfall.";	
					}
				}else{
					return "Place the two brass pointers and the black and white marble ball " +
						"from the TV onto the device located insided the old Greek trireme by " +
						"the waterfall.";
				}
			}else{
				return "Place the two brass pointers and the black and white marble ball " +
					"from the TV onto the device located insided the old Greek trireme by " +
					"the waterfall.";
			}
		}
		
		private function TriremeDeviceSolTwo():String{
			if(game.SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDevice['Solved'] == 'Yes'){
					return SubCaptainsCoinSol();
				}else{
					return"In order from longest to shortest, arrange pointers on the device in" +
						" the greek ship as follows: ΙΧΘΥΕΣ, ΤΑΥΡΟΣ, ΑΙΓΟΚΕΡΩΣ, ΚΑΠΚΙΝΟΣ, ΣΚΟΡΠΙΟΣ, ΠΑΡΘΕΝΟΣ. " +
						"Which corresponds to Pisces, Taurus, Capricorn, Cancer, Scorpio, , and Virgo respectively.";
					
				}
			}else{
				return "In order from longest to shortest, arrange pointers on the device in" +
					" the greek ship as follows: ΙΧΘΥΕΣ, ΤΑΥΡΟΣ, ΑΙΓΟΚΕΡΩΣ, ΚΑΠΚΙΝΟΣ, ΣΚΟΡΠΙΟΣ, ΠΑΡΘΕΝΟΣ. " +
					"Which corresponds to Pisces, Taurus, Capricorn, Cancer, Scorpio, , and Virgo respectively.";
				
			}
		}
		
		private function SubCaptainsCoinSol():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Coin'] == 'PickedUp'){
					return CavePirateCoinSol();
				}else{
					return "Pick up the coin from under the pillow in the submarine captain's quarters."
				}
			}else{
				return "Pick up the coin from under the pillow in the submarine captain's quarters."
			}
		}
		
		private function CavePirateCoinSol():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateDitch["Coin"] == "PickedUp"){
					return CoinJunkHint();
				}else{
					return "Use the shovel from the boat near the moai to dig a hole beside" +
						" the pirate ship where light 'X' is drawn in the sand. Pick up the disc" +
						" revealed.";
				}
			}else{
				return "Use the shovel from the boat near the moai to dig a hole beside" +
					" the pirate ship where light 'X' is drawn in the sand. Pick up the disc" +
					" revealed.";
			}
		}
		
		private function CoinJunkHint():String{
			if(game.SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkTopDeck["Coin"] == "PickedUp"){
					return TriremeCoinSol();
				}else{
					return "On the upper deck of the merchant ship deep in the jungle," +
						" there is a disc with an image of a tiger hanging from the mast.";
				}
			}else{
				return "On the upper deck of the merchant ship deep in the jungle," +
					" there is a disc with an image of a tiger hanging from the mast.";
			}
		}
		
		private function TriremeCoinSol():String{
			if(game.SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDevice['Coin'] == 'PickedUp'){
					return ChinesePuzzleTigerSol();
				}else{
					return "In the device, inside the greek trireme near the" +
						" waterfall, is a disc with the picture of a turtle " +
						"that can be picked up.";
				}
			}else{
				return "In the device, inside the greek trireme near the" +
					" waterfall, is a disc with the picture of a turtle " +
					"that can be picked up.";
			}
		}
		
		private function ChinesePuzzleTigerSol():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'tiger'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'tiger'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'tiger'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'tiger'){
								trace("BARK 1");
								return "Place the disc with the image of tiger in one" +
									" of the slots on the cabinet in lower level of the old merchant junk" +
									" ship.";
							}else{
								trace("BARK 2");
								
								return PlaceDragonCoinSol();
							}
						}else{
							trace("BARK 2");
							return PlaceDragonCoinSol();
						}
					}else{
						trace("BARK 3");
						return PlaceDragonCoinSol();
					}
				}else{
					trace("BARK 4");
					return PlaceDragonCoinSol();
				}
			}else{
				trace("BARK 5");
				return PlaceDragonCoinSol();
			}
			
			
		}
		
		private function PlaceDragonCoinSol():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'dragon'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'dragon'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'dragon'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'dragon'){
								trace("BARK 6");
								
								return "Place the disc with image of dragon in one" +
									" of the slots on the cabinet in the lower level of the old merchant junk" +
									" ship.";
							}else{
								trace("BARK 7");
								return PlacePhoenixCoinSol();
							}
						}else{
							trace("BARK 8");
							return PlacePhoenixCoinSol();
						}
					}else{
						trace("BARK 9");
						return PlacePhoenixCoinSol();
					}
				}else{
					trace("BARK 10");
					return PlacePhoenixCoinSol();
				}
			}else{
				trace("BARK 11");
				return PlacePhoenixCoinSol();
			}
		}
		
		private function PlacePhoenixCoinSol():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'phoenix'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'phoenix'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'phoenix'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'phoenix'){
								
								return "Place the disc with the image of phoenix in one" +
									" of the slots on the cabinet in the lower level of the old merchant junk" +
									" ship.";
							}else{
								return PlaceTurtleCoinSol();
							}
						}else{
							return PlaceTurtleCoinSol();
						}
					}else{
						return PlaceTurtleCoinSol();
					}
				}else{
					return PlaceTurtleCoinSol();
				}
			}else{
				return PlaceTurtleCoinSol();
			}
		}
		
		private function PlaceTurtleCoinSol():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'turtle'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'turtle'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'turtle'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'turtle'){
								return "Place the disc with the image of turtle in one" +
									" of the slots on the cabinet in the lower level of the old merchant junk" +
									" ship.";
							}else{
								return PirateDoorSol();
								
							}
						}else{
							return PirateDoorSol();
						}
					}else{
						return PirateDoorSol();					
					}
				}else{
					return PirateDoorSol();				
				}
			}else{
				return PirateDoorSol();	
			}
		}
		
		private function PirateDoorSol():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){				
				if(game.SavedGame.SavedGameObj.data.CavePirateTopDeck['DoorUnlocked'] == 'Yes'){
					return ChinesePuzzleSolveSol();
				}else{
					return "Pick up the key beside the drone that's crashed behind the freight ship." +
						" It will unlock the door on the upper deck of the pirate ship in the cave."
				}
			}else{
				return "Pick up the key beside the drone that's crashed behind the freight ship." +
					" It will unlock the door on the upper deck of the pirate ship in the cave."
			}
		}
		
		private function ChinesePuzzleSolveSol():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Solved'] == 'Yes'){
					return DigDragonBallSol();
				}else{
					return "The stone beside the merchant ship has ancient Oracle Bone symbols for" +
						" 'Phoenix, Dragon, Turtle, Tiger' engraved on it, going clockwise. These can be deciphered" +
						" using the book from the submarine captain's quarters. Spread across the island are images of " +
						"each of these creatures in a different color. Order the discs on the cabinet inside the merchant" +
						" ship so they're ordered clockwise as follows: Red Phoenix, Green Dragon, Purple Turtle, White Tiger.";
				}
			}else{
				return "The stone beside the merchant ship has ancient Oracle Bone symbols for" +
					" 'Phoenix, Dragon, Turtle, Tiger' engraved on it, going clockwise. These can be deciphered" +
					" using the book from the submarine captain's quarters. Spread across the island are images of " +
					"each of these creatures in a different color. Order the discs on the cabinet inside the merchant" +
					" ship so they're ordered clockwise as follows: Red Phoenix, Green Dragon, Purple Turtle, White Tiger.";
			}
		}
		
		private function DigDragonBallSol():String{
			if(game.SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
					return JungleEnclaveBallSol();
				}else{
					return "Find the pick axe inside of the pirate captain's quarters, then head to the " +
						"excavation site on the mountain side and use the pick axe to remove the spherical stone" +
						" from the wall of sediment. Then pick up the round stone that is released.";
				}
			}else{
				return "Find the pick axe inside of the pirate captain's quarters, then head to the " +
					"excavation site on the mountain side and use the pick axe to remove the spherical stone" +
					" from the wall of sediment. Then pick up the round stone that is released.";
			}
		}
		
		private function JungleEnclaveBallSol():String{
			if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall['Dragonball'] == 'PickedUp'){
					return JunkDragonBallSol();
				}else{
					return "Head up the hill beside the merchant ship in the deep jungle, and pick up" +
						" the spherical stone on the rock shelf at the top.";
				}
			}else{
				return "Head up the hill beside the merchant ship in the deep jungle, and pick up" +
					" the spherical stone on the rock shelf at the top.";
			}
		}
		
		private function JunkDragonBallSol():String{
			if(game.SavedGame.SavedGameObj.data.JunkInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkInterior['DragonBall'] == 'PickedUp'){
					return LedgeDragonBallSol();
				}else{
					return "Pick up the stone sphere with the three dots from the cabinet" +
						" in the lower level of the junk merchant ship in the deep jungle.";
				}
			}else{
				return "Pick up the stone sphere with the three dots from the cabinet" +
					" in the lower level of the junk merchant ship in the deep jungle.";
			}
		}
		
		private function LedgeDragonBallSol():String{
			if(game.SavedGame.SavedGameObj.data.MountainLedge != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainLedge['DragonBall'] == 'PickedUp'){
					return BananaSol();
				}else{
					return "Find and pick up the spherical stone on the pedestal on " +
						" the ledge overlooking the jungle beside the cave on the mountain side.";
				}
			}else{
				return "Find and pick up the spherical stone on the pedestal on " +
					" the ledge overlooking the jungle beside the cave on the mountain side.";
			}
		}
		
		private function BananaSol():String{
			if(game.SavedGame.SavedGameObj.data.JungleBananas != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleBananas['Bananas'] == 'PickedUp'){
					return BirdCageSol();
				}else{
					return "Inside of the pirate captain's quarters, pick up the harpoon from the floor," +
						" then head to the banana tree in the jungle near the Viking ship and use it to reach the bananas.";
				}
			}else{
				return "Inside of the pirate captain's quarters, pick up the harpoon from the floor," +
					" then head to the banana tree in the jungle near the Viking ship and use it to reach the bananas.";
			}
		}
		
		private function BirdCageSol():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateBirdCage['Coin'] == 'PickedUp'){
					return CouchCoinSol();
				}else{
					return "Use the needle from the compass on the table in the freight ship" +
						" to open the lock of the bird cage on the upper level of the pirate ship." +
						" The bird cage can be revealed by turning the steering wheel on the right." +
						" After opening pick up the coin inside.";
				}
			}else{
				return "Use the needle from the compass on the table in the freight ship" +
					" to open the lock of the bird cage on the upper level of the pirate ship." +
					" The bird cage can be revealed by turning the steering wheel on the right." +
					" After opening pick up the coin inside.";
			}
		}
		
		private function CouchCoinSol():String{
			if(game.SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				if(game.SavedGame.SavedGameObj.data.PirateCaptainsCouch['Coin'] == 'PickedUp'){
					return PirateChestSol();
				}else{
					return "Remove the cushions from the couch in the pirate captain's quarters." +
						" on the right-hand side, under the cushions, there is an antique coin. Pick it up.";
				}
			}else{
				return "Remove the cushions from the couch in the pirate captain's quarters." +
					" on the right-hand side, under the cushions, there is an antique coin. Pick it up.";
				
			}
			
			
		}
		
		private function PirateChestSol():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateChest != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateChest['Hammer'] == 'PickedUp'){
					return AppleSol();
				}else{
					return "Place each of the ancient coins (one found in the birdcage, and the" +
						" other in the couch cushions) into the eyes of the skull on the chest in the cave" +
						" with the pirate ship. Then, open the chest and pick up the hammer inside.";
				}
			}else{
				return "Place each of the ancient coins (one found in the birdcage, and the" +
					" other in the couch cushions) into the eyes of the skull on the chest in the cave" +
					" with the pirate ship. Then, open the chest and pick up the hammer inside.";
			}
		}
		
		private function AppleSol():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateBarrels['Apple'] == 'PickedUp'){
					return FishSol();
				}else{
					return "Use the hammer to remove the nails from the barrels in the cave with the pirate ship." +
						" then pick up the green apple inside.";
				}
			}else{
				return "Use the hammer to remove the nails from the barrels in the cave with the pirate ship." +
					" then pick up the green apple inside.";
			}
			
			
		}
		
		private function FishSol():String{
			if(game.SavedGame.SavedGameObj.data.TriremeDeck != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDeck['Fish'] == 'PickedUp'){
					return CliffTreeHint();
				}else{
					return "On the deck of the old greek trireme near the waterfall," +
						" is a fish a skeleton. Pick it up; it'll be useful.";
				}
			}else{
				return "On the deck of the old greek trireme near the waterfall," +
					" is a fish a skeleton. Pick it up; it'll be useful.";
			}
		}
		
		private function CliffTreeHint():String{
			if(game.SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
				if(game.SavedGame.SavedGameObj.data.FarCoastCliff['TrunkState'] == '4'){
					return SealSol();
				}else{
					return "Using the jaw bone found in the bone pile in the cave near" +
						" the coast, saw the trunk of the tree on the overlook above the" +
						" waterfall to push it over and reach the opening where the waterfall emerges.";
					
				}
			}else{
				return "Using the jaw bone found in the bone pile in the cave near" +
					" the coast, saw the trunk of the tree on the overlook above the" +
					" waterfall to push it over and reach the opening where the waterfall emerges.";
				
			}
			
			
		}
		
		private function SealSol():String{
			if(game.SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.CliffCavePuzzle['Solved'] == 'Yes'){
					return FeedTheBeastSol();
				}else{
					return "Pry open the rock in the deep jungle up the hill from the merchant" +
						" ship using the screwdriver. Pick up the brass cylinder inside and place it on" +
						" the door where the waterfall pours out of the cliff side. Then arrange the images so" +
						" they match the painting on wall of the cave near the coast. From bottom to top," +
						" the images should be ordered as follows: Fire, Water, Mountain, Wind, Stars.";
				}
			}else{
				return "Pry open the rock in the deep jungle up the hill from the merchant" +
					" ship using the screwdriver. Pick up the brass cylinder inside and place it on" +
					" the door where the waterfall pours out of the cliff side. Then arrange the images so" +
					" they match the painting on wall of the cave near the coast. From bottom to top," +
					" the images should be ordered as follows: Fire, Water, Mountain, Wind, Stars.";
			}
			
		}
		
		private function FeedTheBeastSol():String{
			if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
				if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster['DragonBall'] == 'PickedUp'){
					return TempleLeftPlaceSol();
				}else{
					return "In the cave over the waterfall, a monster lurks. Leave bananas, the fish skeleton, " +
						"and the green apple on the rock floor in front of it's lair. " +
						"It will hand you a spherical stone with seven dots, before wandering off for a nap.";
				}
			}else{
				return "In the cave over the waterfall, a monster lurks. Leave bananas, the fish skeleton, " +
					"and the green apple on the rock floor in front of it's lair. " +
					"It will hand you a spherical stone with seven dots, before wandering off for a nap.";
			}
		}
		
		private function TempleLeftPlaceSol():String{
			
			if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
				if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft['BallOne'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft['BallTwo'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft['BallThree'] == 'Attached'){
							return TempleRightPlaceSol();
						}else{
							return "Take the spherical stones with one, two, and three dots on their surface," +
								" and place them into the three corresponding holes " +
								" on the left side of the geometric cave on the mountain side.";
						}
					}else{
						return "Take the spherical stones with one, two, and three dots on their surface," +
							" and place them into the three corresponding holes " +
							" on the left side of the geometric cave on the mountain side.";
					}
				}else{
					return "Take the spherical stones with one, two, and three dots on their surface," +
						" and place them into the three corresponding holes " +
						" on the left side of the geometric cave on the mountain side.";
				}
			}else{
				return "Take the spherical stones with one, two, and three dots on their surface," +
					" and place them into the three corresponding holes " +
					" on the left side of the geometric cave on the mountain side.";
			}
			
		}
		
		private function TempleRightPlaceSol():String{
			if(game.SavedGame.SavedGameObj.data.TempleTunnelRight != undefined){
				if(game.SavedGame.SavedGameObj.data.TempleTunnelRight['BallFive'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.TempleTunnelRight['BallSeven'] == 'Attached'){
						return TarRoofSol();
					}else{
						return "Take the two spherical stones with five and seven dots on their surface," +
							" and place them into the two corresponding holes " +
							"on the right side of the geometric cave on the mountain side.";
					}
				}else{
					return "Take the two spherical stones with five and seven dots on their surface," +
						" and place them into the two corresponding holes " +
						"on the right side of the geometric cave on the mountain side.";
				}
			}else{
				return "Take the two spherical stones with five and seven dots on their surface," +
					" and place them into the two corresponding holes " +
					"on the right side of the geometric cave on the mountain side.";
			}
		}
		
		private function TarRoofSol():String{
			if(game.SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineRoof['Tar'] == 'Attached'){
					return SolarRoofSol();
				}else{
					return "Take the wooden bucket, found beside the broken cannon on the deck of pirate ship, and" +
						" fill it with tar from the pit in the middle jungle. Then place the ladder by the side of the house in" +
						" the ravine, and climb up to the roof. There, spread the tar on to the roof of the house.";
				}
			}else{
				return "Take the wooden bucket, found beside the broken cannon on the deck of pirate ship, and" +
					" fill it with tar from the pit in the middle jungle. Then place the ladder by the side of the house in" +
					" the ravine, and climb up to the roof. There, spread the tar on to the roof of the house.";
			}
			
		}
		
		private function SolarRoofSol():String{
			if(game.SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineRoof['SolarPanels'] == 'Attached'){
					return PascalSol();
				}else{
					return "Using the wrench, remove the solar panels from the buoy on the coast, " +
						"and place them into the tar on the roof of the house.";
				}
			}else{
				return "Using the wrench, remove the solar panels from the buoy on the coast, " +
					"and place them into the tar on the roof of the house.";
			}
		}
		
		private function PascalSol():String{
			if(game.SavedGame.SavedGameObj.data.TemplePascal != undefined){
				if(game.SavedGame.SavedGameObj.data.TemplePascal['Solved'] == 'Yes'){
					return MirrorSol();
				}else{
					return "The dots on the left of the triangle wall in the geometric cave represent prime numbers," +
						" and can be combined on the right to create other numbers. The orange dot represents the " +
						"'multiply' symbol. Solve by matching" +
						" values on it's spaces with those of Pascal's Triangle shown on the doctor's computer" +
						" in the lab. For instance, to get '35' combine '7' & '5' on the right, and then place" +
						" the value on the wall. Or, to get '20,' combine '5' & '2' & '2'.";
				}
			}else{
				return "The dots on the left of the triangle wall in the geometric cave represent prime numbers," +
					" and can be combined on the right to create other numbers. The orange dot represents the " +
					"'multiply' symbol. Solve by matching" +
					" values on it's spaces with those of Pascal's Triangle shown on the doctor's computer" +
					" in the lab. For instance, to get '35' combine '7' & '5' on the right, and then place" +
					" the value on the wall. Or, to get '20,' combine '5' & '2' & '2'.";
			}
			
		}
		
		private function MirrorSol():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['Mirror'] == 'Attached'){
					return HominidSkullSol();
				}else{
					return "Take the broken mirror from the cave over the waterfall, where" +
						" the monster was, to the pedestal at the center of the geometric" +
						" chamber inside the mountain. There, place the mirror into the beam of light.";
				}
			}else{
				return "Take the broken mirror from the cave over the waterfall, where" +
					" the monster was, to the pedestal at the center of the geometric" +
					" chamber inside the mountain. There, place the mirror into the beam of light.";
			}
			
			
		}
		
		private function HominidSkullSol():String{
			if(game.SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'PickedUp'){
					return PirateSkullSol();
				}else{
					return "Using the sculptor's tools found on the table in the pirate captain's quarters," +
						" remove the rock surrounding the skull in the wall of sediment at the archaeological" +
						" excavation on the mountain side. Then, pick up the skull. ";
				}
			}else{
				return "Using the sculptor's tools found on the table in the pirate captain's quarters," +
					" remove the rock surrounding the skull in the wall of sediment at the archaeological" +
					" excavation on the mountain side. Then, pick up the skull. ";
			}
			
			
		}
		
		private function PirateSkullSol():String{
			if(game.SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
				if(game.SavedGame.SavedGameObj.data.PirateCaptainsTable['Skull'] == 'PickedUp'){
					return AlienSkullSol();
				}else{
					return "Inside the pirate captain's quarters, there's a skull " +
						"on the table, pick it up.";
				}
			}else{
				return "Inside the pirate captain's quarters, there's a skull " +
					"on the table, pick it up.";
			}
			
		}
		
		private function AlienSkullSol():String{
			if(game.SavedGame.SavedGameObj.data.RavineDig != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'PickedUp'){
					return RedCrystalHint();
				}else{
					return "Take the trowel from the excavation site on the mountain side " +
						" down to the dig at the base of the slope. There, use the trowel to remove " +
						"the soil from the elongated skull. Which can then be picked up without " +
						" damage";
				}
			}else{
				return "Take the trowel from the excavation site on the mountain side " +
					" down to the dig at the base of the slope. There, use the trowel to remove " +
					"the soil from the elongated skull. Which can then be picked up without " +
					" damage";
			}
			
			
		}
		
		private function RedCrystalHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['Red'] == 'Attached'){
					return RedSkullSol();
				}else{
					return "Use the pick axe to remove the red crystal from the walls of the cave " +
						"above the waterfall. Then take the red crystal up to the pedestal in" +
						" the center of the geometric chamber and place it in one of the four holes on " +
						"the surface of the stone.";
				}
			}else{
				return "Use the pick axe to remove the red crystal from the walls of the cave " +
					"above the waterfall. Then take the red crystal up to the pedestal in" +
					" the center of the geometric chamber and place it in one of the four holes on " +
					"the surface of the stone.";
			}
			
			
		}
		
		private function RedSkullSol():String{
			if(game.SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberRedSkulls['Solved'] == 'Yes'){
					return SlideSol();
				}else{
					return "Position the mirror on the pedestal at the center of the geometric chamber so" +
						" that a light shines into the red crystal. Then head down into the now red lit sub-section" +
						" of the chamber. To the left is a triangle with three circles on it. These represent the brain" +
						" sizes of the three skulls, and their respective positions in the alcoves on the nearby wall. " +
						"Human at the top, the elongated skull to the left, and the hominid skull to the right.";
				}
			}else{
				return "Position the mirror on the pedestal at the center of the geometric chamber so" +
					" that a light shines into the red crystal. Then head down into the now red lit sub-section" +
					" of the chamber. To the left is a triangle with three circles on it. These represent the brain" +
					" sizes of the three skulls, and their respective positions in the alcoves on the nearby wall. " +
					"Human at the top, the elongated skull to the left, and the hominid skull to the right.";
			}
			
			
		}
		
		private function SlideSol():String{
			if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.InvenPuzzle['SlideMade'] == 'yes'){
					return MircoscopeSol();
				}else{
					return "Press the green glowing triangle on the wall of the geometric chamber with the three skulls," +
						" make sure the red crystal is illuminted so that the subchamber is lit also. Then, after the" +
						" slime oozes out, pick some up and combine it with glass shards found on the upper level" +
						" of the freight ship in the canyon.";
				}
			}else{
				return "Press the green glowing triangle on the wall of the geometric chamber with the three skulls," +
					" make sure the red crystal is illuminted so that the subchamber is lit also. Then, after the" +
					" slime oozes out, pick some up and combine it with glass shards found on the upper level" +
					" of the freight ship in the canyon.";
			}
			
			
		}
		
		private function MircoscopeSol():String{
			if(game.SavedGame.SavedGameObj.data.LabMicroscope != undefined){
				if(game.SavedGame.SavedGameObj.data.LabMicroscope['Analyzed'] == 'Yes'){
					return AttachSatelliteSol();
				}else{
					return "Inside the laboratory at the foot of the mountain's slope, turn the machine on" +
						" in the corner of the room. Then place the slide of slime on the bed of the microscope. Look" +
						" through the microscope's viewfinder and press the 'analyze' button at the top.";
				}
			}else{
				return "Inside the laboratory at the foot of the mountain's slope, turn the machine on" +
					" in the corner of the room. Then place the slide of slime on the bed of the microscope. Look" +
					" through the microscope's viewfinder and press the 'analyze' button at the top.";
			}
			
			
		}
		
		private function AttachSatelliteSol():String{
			if(game.SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineRoof['SatDish'] == 'Attached'){
					return UploadAlgoSol();
				}else{
					return "Take the small satellite dish from out of the nose of the drone." +
						" Then, climb back up onto the roof of the laboratory " +
						"and connect the dish to the wires sticking out of the vertical" +
						" tube.";
				}
			}else{
				return "Take the small satellite dish from out of the nose of the drone." +
					" Then, climb back up onto the roof of the laboratory " +
					"and connect the dish to the wires sticking out of the vertical" +
					" tube.";
			}
			
			
			
		}
		
		private function UploadAlgoSol():String{
			if(game.SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if(game.SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "Attached"){
					if(game.SavedGame.SavedGameObj.data.LabComputer != undefined){
						if(game.SavedGame.SavedGameObj.data.LabComputer['Files'] == 'Written'){
							return CleanHoseSol();
						}else{
							return "Take the floppy disk, found beside the computer in the submarine captain's quarters," +
								" and insert it into the desktop computer tower in the laboratory. Then go into the computer" +
								" and open the 'ISS CON' program. Click on 'Write To Disk,' then eject and pick up the disk by" +
								" tapping twice on the computer tower. Take the disk - now with the algorithmic data - over to the machine" +
								" in the corner and insert it.";
						}
					}else{
						return "Take the floppy disk, found beside the computer in the submarine captain's quarters," +
							" and insert it into the desktop computer tower in the laboratory. Then go into the computer" +
							" and open the 'ISS CON' program. Click on 'Write To Disk,' then eject and pick up the disk by" +
							" tapping twice on the computer tower. Take the disk - now with the algorithmic data - over to the machine" +
							" in the corner and insert it.";
					}
				}else{
					return "Take the floppy disk, found beside the computer in the submarine captain's quarters," +
						" and insert it into the desktop computer tower in the laboratory. Then go into the computer" +
						" and open the 'ISS CON' program. Click on 'Write To Disk,' then eject and pick up the disk by" +
						" tapping twice on the computer tower. Take the disk - now with the algorithmic data - over to the machine" +
						" in the corner and insert it.";
				}
			}else{
				return "Take the floppy disk, found beside the computer in the submarine captain's quarters," +
					" and insert it into the desktop computer tower in the laboratory. Then go into the computer" +
					" and open the 'ISS CON' program. Click on 'Write To Disk,' then eject and pick up the disk by" +
					" tapping twice on the computer tower. Take the disk - now with the algorithmic data - over to the machine" +
					" in the corner and insert it.";
			}
			
			
		}
		
		private function CleanHoseSol():String{
			if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.InvenPuzzle['HoseCleaned'] == 'yes'){
					return AttachHoseSol();
				}else{
					return "In the ravine at the base of the mountain slope is part of a propeller driven" +
						"aircraft's fuselage. Remove the left cover and take the dirty green rubber hose from inside." +
						" Use the rubbing alcohol, found in the medicine cabinet in the lab, " +
						"to clean and sterilize the hose.";
				}
			}else{
				return "In the ravine at the base of the mountain slope is part of a propeller driven" +
					"aircraft's fuselage. Remove the left cover and take the dirty green rubber hose from inside." +
					" Use the rubbing alcohol, found in the medicine cabinet in the lab, " +
					"to clean and sterilize the hose.";
			}
			
		}
		
		private function AttachHoseSol():String{
			if(game.SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if(game.SavedGame.SavedGameObj.data.LabEquipment['Hose'] == 'Attached'){
					return MarbleSol();
				}else{
					return "Connect the machine in the laboratory to" +
						" the 3D Printer by attaching the green rubber hose to the 'OUTPUT'" +
						" valve on the machine.";
				}
			}else{
				return "Connect the machine in the laboratory to" +
					" the 3D Printer by attaching the green rubber hose to the 'OUTPUT'" +
					" valve on the machine.";
			}
			
		}
		
		private function MarbleSol():String{
			if(game.SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if(game.SavedGame.SavedGameObj.data.LabPrinter['Stone'] == 'Attached'){
					return AddMushroomSol();
				}else{
					return "Use the hammer to open the wooden box at the excavation site" +
						" on the mountain side. Pick up the five-sided piece of petrified wood " +
						"from inside it and take it to the laboratory. There, place the piece" +
						" of hardened stone wood on to the right surface of the 3d printer.";
				}
			}else{
				return "Use the hammer to open the wooden box at the excavation site" +
					" on the mountain side. Pick up the five-sided piece of petrified wood " +
					"from inside it and take it to the laboratory. There, place the piece" +
					" of hardened stone wood on to the right surface of the 3d printer.";
			}
			
		}
		
		private function AddMushroomSol():String{
			if(game.SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				if(game.SavedGame.SavedGameObj.data.LabDeskDetail["Mortar"] == "PickedUp"){
					return PourGooSol();
				}else{
					return "Make sure to pluck the purple flower from the edge of the jungle," +
						" forage the mushroom from beside the stump in the forest, " +
						" and pick up the pestle from beside the broken canoe." +
						" Then, fill up the gourd with fresh water from either the cave above the waterfall" +
						" or the cave near the coast and campfire. After, combine the water, mushroom, and" +
						" flower in the bowl on the table in the laboratory. Then mash them with the pestle" +
						" and pick up the resulting mixture.";
				}
			}else{
				return "Make sure to pluck the purple flower from the edge of the jungle," +
					" forage the mushroom from beside the stump in the forest, " +
					" and pick up the pestle from beside the broken canoe." +
					" Then, fill up the gourd with fresh water in either the cave above the waterfall" +
					" or the cave near the coast and campfire. After, combine the water, mushroom, and" +
					" flower in the bowl on the table in the laboratory. Then mash them with the pestle" +
					" and pick up the resulting mixture.";
			}
			
		}
		
		private function PourGooSol():String{
			if(game.SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if(game.SavedGame.SavedGameObj.data.LabPrinter['Goo'] == 'Attached'){
					return PrinterSol();
				}else{
					return "Pour the pink mush made from the flower, mushroom and water into the pyrex" +
						" bowl resting on the surface of the 3d printer in the laboratory.";
				}
			}else{
				return "Pour the pink mush made from the flower, mushroom and water into the pyrex" +
					" bowl resting on the surface of the 3d printer in the laboratory.";
			}
			
		}
		
		private function PrinterSol():String{
			if(game.SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if(game.SavedGame.SavedGameObj.data.LabPrinter['Crystal'] == 'PickedUp'){
					return SpaceDoorSol(); 
				}else{
					return "Press 'PRINT' on the user interface of the machine in the " +
						"corner of the laboratory and wait for the printer to finish it's work." +
						" Then pick up the green crystal produced.";
				}
			}else{
				return "Press 'PRINT' on the user interface of the machine in the" +
					"corner of the laboratory and wait for the printer to finish it's work." +
					" Then pick up the green crystal produced.";
			}
			
		}
		
		private function SpaceDoorSol():String{
			
			if(game.SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Solved'] == 'Yes'){
					return SpaceShipConsoleSol();
				}else{
					return "Use the trowel to pick up the hand bones from the excavation at the foot" +
						" of the mountains slope. Place the hand onto the panel on the door of the spacecraft." +
						" Take the futuristic device, also found at the dig site, and point it at the nearby rock " +
						"face. The letters of the alien alphabet needed to enter the door are each enclosed on the" +
						"TV by one of the symbols from the rock. Enter the corresponding symbols into" +
						" the spaceship's door."
				}
			}else{
				return "Use the trowel to pick up the hand bones from the excavation at the foot" +
					" of the mountains slope. Place the hand onto the panel on the door of the spacecraft." +
					" Take the futuristic device, also found at the dig site, and point it at the nearby rock " +
					"face. The letters of the alien alphabet needed to enter the door are each enclosed on the" +
					"TV by one of the symbols from the rock. Enter the corresponding symbols into" +
					" the spaceship's door.";
			}
			
		}
		
		private function SpaceShipConsoleSol():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipConsole['Tricorder'] == 'Attached'){
					return SpaceShipPuzzleSol();
				}else{
					return "Place the futuristic sensor device into the hole located at the " +
						" center of the console aboard the space craft to activate the ship.";
				}
			}else{
				return "Place the futuristic sensor device into the hole located at the " +
					" center of the console aboard the space craft to activate the ship.";
			}
		}
		
		private function SpaceShipPuzzleSol():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){				
				if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle['Solved'] == 'Yes'){
					return SpaceShipOvenOnSol();
				}else{
					return "Rotate the dials on the spacecraft control system interface " +
						"so that each open circle on each dial overlaps with another circle." +
						" Start with the upper middle dial, then lower middle dial, then " +
						"either of the lower sides, and finally either of the upper sides.";
				}
			}else{
				return "Rotate the dials on the spacecraft control system interface " +
					"so that each open circle on each dial overlaps with another circle." +
					" Start with the upper middle dial, then lower middle dial, then " +
					"lower left, then lower right, and finally either of the upper sides.";
			}
			
			
		}
		
		private function SpaceShipOvenOnSol():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] == 'Yes'){
					return SpaceShipOvenUseSol();
				}else{
					return "Inside the spaceship control system, go to the screen that shows the image" +
						" of the ship. Press each of the red circles so that they turn yellow, then go back" +
						" to the page that shows the open switch. Tap on the switch to close it.";
				}
			}else{
				return "Inside the spaceship control system, go to the screen that shows the image" +
					" of the ship. Press each of the red circles so that they turn yellow, then go back" +
					" to the page that shows the open switch. Tap on the switch to close it.";
			}
		}
		
		private function SpaceShipOvenUseSol():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipOven['Plasma'] == 'PickedUp'){
					return GreenCrystalSol();
				}else{
					return "Place the 1000 gram bar of iridium from the chest in the pirate cave into the machine inside" +
						"  the spacecraft, then close the door of the machine. " +
						" Press the two holographic interfaces on the left so each turn green." +
						" A spiral form should appear on the right. Press it to start the machine." +
						" Then, once complete, pick up the transformed item.";
				}
			}else{
				return "Place the 1000 gram bar of iridium from the chest in the pirate cave into the machine inside" +
					"  the spacecraft, then close the door of the machine. " +
					" Press the two holographic interfaces on the left so each turn green." +
					" A spiral form should appear on the right. Press it to start the machine." +
					" Then, once complete, pick up the transformed item.";
			}
			
		}
		
		private function GreenCrystalSol():String{
			if(game.SavedGame.SavedGameObj.data.ChamberGreen != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberGreen['Crystal'] == 'PickedUp'){	
					return NautilusAttach();
				}else{
					return "Place the green crystal into a hole on the pedestal at the center " +
						"of the geometric cavern. Adjust the mirror so it illuminates the green crystal." +
						" Then head up to the now lit green chamber and place the animated metal upon the" +
						" flat surface with an etched form of fractal tree.";
				}
			}else{
				return "Place the green crystal into a hole on the pedestal at the center " +
					"of the geometric cavern. Adjust the mirror so it illuminates the green crystal." +
					" Then head up to the now lit green chamber and place the animated metal upon the" +
					" flat surface with an etched form of fractal tree.";
			}
			
			
		}
		
		private function NautilusAttach():String{
			if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus['Shell'] == 'Attached'){
					return ChamberBlueHint();
				}else{
					return "Place the nautilus shell (found with the skeleton near the mouth of the cave on the coast)" +
						" into the grooved stone in the upper most chamber of the geometric cavern.";
				}
			}else{
				return "Place the nautilus shell (found with the skeleton near the mouth of the cave on the coast)" +
					" into the grooved stone in the upper most chamber of the geometric cavern.";
			}
			
			return "";
		}
		
		private function ChamberBlueHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus['Solved'] == 'Yes'){
					return WhiteCrystalSol();
				}else{
					return "Place the blue crystal into one of the holes in the surface of the stone pedestal " +
						"at the center of the geometric chamber. Move the mirror, so the that light shines" +
						" into the blue crystal. Then head up to the blue lit sub chamber. The colors of" +
						" the spiral should be ordered to match the colors of the molecules of the analyzed " +
						" green slime under the mircoscope. From the center outwards: Violet, Magenta, Red," +
						" Yellow, Green, Cyan.";
				}
			}else{
				return "Place the blue crystal into one of the holes in the surface of the stone pedestal " +
					"at the center of the geometric chamber. Move the mirror, so the that light shines" +
					" into the blue crystal. Then head up to the blue lit sub chamber. The colors of" +
					" the spiral should be ordered to match the colors of the molecules of the analyzed " +
					" green slime under the mircoscope. From the center outwards: Violet, Magenta, Red," +
					" Yellow, Green, Cyan.";
			}
			
			
		}
		
		private function WhiteCrystalSol():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
						return FinalSolution();
					}else{
						return "Pick up the white crystal from the uppermost chamber of the geometric cavern," +
							" then place the crystal in the last remaining hole in the pedestal." +
							" Position the mirror so that all the crystals are illuminated.";
					}
				}else{
					return "Pick up the white crystal from the uppermost chamber of the geometric cavern," +
						" then place the crystal in the last remaining hole in the pedestal." +
						" Position the mirror so that all the crystals are illuminated.";
				}
			}else{
				return "Pick up the white crystal from the uppermost chamber of the geometric cavern," +
					" then place the crystal in the last remaining hole in the pedestal." +
					" Position the mirror so that all the crystals are illuminated.";
			}
			
			
		}
		
		private function FinalSolution():String{
			
			return "There are no more solutions. There is no more time. Only the portal waits....";
		}
		
	}
}