package screens.hud
{
	public class HintGenerator
	{
		private var game:Game;
		private var rand:Boolean = false;
		
		public function HintGenerator(_game:Game)
		{
			game = _game;
		}
		public function GetHint():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass != undefined){
				//	if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FrontDoor'){
				//		return FrontDoorHits();
				//					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'BirdHouse'){
				//		return FrontDoorHits();
				
				//	}else{
				return RaftHints();
				
				//	}
				
				
				
			}else{
				return "You Just Got This hint!";
			}
			
			
			
		}
		
		/*
		private function FrontDoorHits():String{
		//if(game.SavedGame.SavedGameObj.data.FrontDoor != undefined){
		//	if(game.SavedGame.SavedGameObj.data.FrontDoor['Door'] == ){
		if(game.SavedGame.SavedGameObj.data.BirdHouse != undefined){
		trace("BirdHouse is Defined");
		if(game.SavedGame.SavedGameObj.data.BirdHouse['cover'] == 'open'){
		if(game.SavedGame.SavedGameObj.data.BirdHouse['key'] == 'PickedUp'){
		if(game.SavedGame.SavedGameObj.data.FrontDoor != undefined){
		if(game.SavedGame.SavedGameObj.data.FrontDoor['Door'] == 'open'){
		return "It wouldn't be right to leave the eggs exposed.";
		}else{
		return "Try using the key on objects around the front of the house.";
		}
		}else{
		return "Try using the key on the objects around the front of the house.";
		}
		}else{
		return "Why not try picking up the key inside the birdhouse.";
		}		
		}else{
		if(game.SavedGame.SavedGameObj.data.BirdHouse['key'] == 'PickedUp'){
		if(game.SavedGame.SavedGameObj.data.FrontDoor != undefined){
		if(game.SavedGame.SavedGameObj.data.FrontDoor['Door'] == 'open'){
		return "Go inside....";
		}else{
		return "Try using the key to open the door.";
		}
		}else{
		return "Try using the key to open the door.";
		}
		
		
		}else{
		return "Look in the birdhouse.";
		}
		}
		}else{
		return "Look around and search for items.";
		}
		//	}else{
		//		return "";
		//	}
		}
		
		*/
		
		
		private function RaftHints():String{
			if(game.SavedGame.SavedGameObj.data.Raft != undefined){
				if(game.SavedGame.SavedGameObj.data.Raft['Door'] != undefined){
					return FreighterWheelHints();
					//	return CoastCaveBoxHints();
					
				}else{
					if(game.SavedGame.SavedGameObj.data.Raft['Handle'] == 'Attached'){
						return "Try turning the handle to open the door of the raft";
					}else{
						return "Try placing the handle on the semi-circular device beside the door.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.RaftBox != undefined){
					if(game.SavedGame.SavedGameObj.data.RaftBox['Lid'] == undefined){
						return "Try opening the box with the tool symbol on it.";
						
					}else{
						if(game.SavedGame.SavedGameObj.data.RaftBox['Handle'] == 'PickedUp'){
							return "Try placing the handle on the semi-circular device beside the door.";
						}else{
							return "Pick up the handle inside the box.";
							
						}
					}
				}else{
					return "Try opening the box with the tool symbol on it";
				}
			}
		}
		
		
		private function FreighterWheelHints():String{
			if(game.SavedGame.SavedGameObj.data.FreighterWheel != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterWheel['Solved'] == 'Yes'){
					if(game.SavedGame.SavedGameObj.data.FreighterSafe != undefined){
						if(game.SavedGame.SavedGameObj.data.FreighterSafe['PirateTube'] == 'PickedUp'){
							return CoastCaveBoxHints();
						}else{
							return "Why not pick up the cylinder from the safe in the freighter?";
						}
					}else{
						return "No hint at this time";
					}					
				}else{
					if(game.SavedGame.SavedGameObj.data.FreighterWheel['Puller'] != 'Attached'){
						return FreighterPullerText();
					}else{
						if(game.SavedGame.SavedGameObj.data.JungleTarPitWall != undefined){
							if(game.SavedGame.SavedGameObj.data.JungleTarPitWall['SeenIt'] == 'Yes'){
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPitWall'){
									return "The markings here indicate the position of the freighter's throttle and steering wheel."+
										" The markings read from right to left.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWheel'){
									return "Try placing the throttle lever in one position, then moving the steering wheel." +
										" Then putting the throttle in another position.";
									
								}else{
									return "Trying working on the freighter's steering wheel.";
								}
								
							}else{
								return "Look for clues to help with the freighter's steering wheel and throttle.";
							}
						}else{
							return "Look for clues to help with the freighter's steering wheel and throttle.";
						}
					}	
				}
			}else{
				return FreighterPullerText();
			}
			
			
		}
		private function FreighterPullerText():String{
			if(game.SavedGame.SavedGameObj.data.FreighterTable != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterTable['Puller'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWheel'){
						return "Why not try placing the brass lever of the ship's throttle?";
						
					}else{
						return "Look for a place to use the brass lever found on the freighter navigator's table.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterInterior'){
						return "Have a look at the table";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterTable'){
						return "Why not try picking up the brass lever?";
						
					}else{
						return "Explore the island, there are items and puzzles to discover.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterInterior'){
					return "Have a look at the table";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterTable'){
					return "Why not try picking up the brass lever?";
					
				}else{
					return "Explore the island, there are items and puzzles to discover.";
				}
			}
		}
		
		private function CoastCaveBoxHints():String{
			if(game.SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCaveBox['Stone'] == 'PickedUp'){
					return MoaiHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CoastCaveBox['Celtic'] != undefined){
						if(game.SavedGame.SavedGameObj.data.CoastCaveBox['Lid'] == undefined){
							return "Why not look in the box in the cave by the coast.";
						}else{
							return "Try picking up the red stone from the box inside the cave by coast.";
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CoastCaveBox['Lid'] == undefined){
							return "Why not look in the box in the cave by the coast.";
						}else{
							return "Try picking up the red stone from the box inside the cave by coast.";
						}
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.FreighterLocker != undefined){
					if(game.SavedGame.SavedGameObj.data.FreighterLocker['DoorOne'] != undefined){
						if(game.SavedGame.SavedGameObj.data.FreighterLocker['CelticTriangle'] == 'PickedUp'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave'){
								return "Take a closer look at the small box.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveBox'){
								return "Try placing the medallion on the box.";
							}else{
								return "Look for somewhere to place the ornamental medallion found in the lockers.";
							}
							
						}else{
							return "Why not pick up the ornamental medallion from the freighter's crew lockers.";
						}
					}else{
						return "Take a look inside all the lockers aboard the freight ship.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLocker'){
						return "Have a look at the ship's lockers.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterInterior'){
						return "Have a look inside the lockers.";						
					}else{
						return "Keep searching... there are items to be found.";
					}
					
				}
			}
			
			
		}
		
		private function MoaiHints():String{
			if(game.SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastMoaiEyes['Solved'] == 'Yes'){
					return JungleStumpPuzzleHints();
				}else if(game.SavedGame.SavedGameObj.data.CoastMoaiEyes['left_eye'] != 'Attached'){
					return MoaiBouyText();
				}else if(game.SavedGame.SavedGameObj.data.CoastMoaiEyes['right_eye'] != 'Attached'){					
					return MoaiBouyText();
				}else{
					return MoaiBouyText();
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CoastBuoy != undefined){
					return MoaiBouyText();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle'){
						return "Take a look at the red stone";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastBuoy'){
						return "Try picking up the red stone.";
					}else{
						return "There are things to discover, keep searching to find new items.";
					}
				}
			}
			
		}
		
		private function MoaiBouyText():String{
			if(game.SavedGame.SavedGameObj.data.CoastBuoy != undefined){						
				if(game.SavedGame.SavedGameObj.data.CoastBuoy["Stone"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastMoai'){
						return "Why not try putting the red stone in the eyes of the Moai?";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastMoaiEyes'){ 	
						return "Why not try putting the red stone in the eyes of the Moai?";
					}else{
						return "Try looking for a place to put the red stone.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle'){
						return "Take a look at the red stone";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastBuoy'){
						return "Try picking up the red stone.";
					}else{
						return "There are things to discover, keep searching to find new items.";
					}
					
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle'){
					return "Take a look at the red stone";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastBuoy'){
					return "Try picking up the red stone.";
				}else{
					return "There are things to discover, keep searching to find new items.";
				}
			}
		}
		
		private function JungleStumpPuzzleHints():String{
			if(game.SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleStumpPuzzle['PirateDisc'] == 'PickedUp'){
					return CoastCaveDoorHintsOne();
				}else{
					if(game.SavedGame.SavedGameObj.data.JungleStumpPuzzle['Solved'] == 'Yes'){
						return "Why not pick up the disc from inside the tree stump.";
					}else{
						if(game.SavedGame.SavedGameObj.data.JungleStumpPuzzle['WoodCircle'] == 'Attached'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleStumpPuzzle'){
								return "Try rotating the the tree rings into different positions.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleStump'){
								return "Try working on the rings of the tree.";
							}else{
								return "Try working on the tree stump.";
							}
							
						}else{
							return JungleStumpText();
						}
					}
				}
			}else{
				return JungleStumpText();
			}
			
		}
		
		private function JungleStumpText():String{
			if(game.SavedGame.SavedGameObj.data.CoastMoai != undefined){
				
				if(game.SavedGame.SavedGameObj.data.CoastMoai['WoodCircle'] != 'PickedUp'){
					return "Why not pick up the wooden disk in the mouth of the Moai?";
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleStumpPuzzle'){
						return "Try placing the wooden disk in the center of the tree rings.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleStump'){
						return "Take a closer look at the tree rings.";
					}else{
						return "Look for a place to use the wooden disc from the Moai's mouth.";
					}
				}
			}else{
				return "No hint at this time.";
			}
		}
		
		private function CoastCaveDoorHintsOne():String{	
			if(game.SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCaveCombo['Third'] == 'Attached'){
					return CoastCaveDoorHintsTwo();
				}else{
					if(game.SavedGame.SavedGameObj.data.CoastCaveDoor != undefined){
						if(game.SavedGame.SavedGameObj.data.CoastCaveDoor['ComboLock'] == 'Attached'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave'){
								return "Take a closer look at the combination lock on the door.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveDoor'){
								return "Take a closer look at the combination lock on the door.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveCombo'){
								return "Try placing the disc found in the tree stump in the empty slot of the cylinder.";
							}else{
								return "Look around for a place to use the disc found in the tree stump.";
							}
						}else{
							trace("BARK 1");
							return CoastCaveDoorTextOne();
						}
					}else{
						trace("BARK 2");
						return CoastCaveDoorTextOne();
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CoastCaveDoor != undefined){
					if(game.SavedGame.SavedGameObj.data.CoastCaveDoor['ComboLock'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave'){
							return "Take a closer look at the combination lock on the door.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveDoor'){
							return "Take a closer look at the combination lock on the door.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveCombo'){
							return "Try placing the disc found in the tree stump into the empty slot of the cylinder.";
						}else{
							return "Look around for a place to use the disc found in the tree stump.";
						}
					}else{
						return CoastCaveDoorTextOne();
					}
				}else{
					return CoastCaveDoorTextOne();
				}
				
				
				
			}
			
		}
		private function CoastCaveDoorTextOne():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave'){
				return "Take a closer look at the door.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveDoor'){
				return "Something goes into the slot on the door.";
			}else{
				return "Look around for a place to put the cylinder from the safe in the freighter.";
			}
		}
		
		private function CoastCaveDoorHintsTwo():String{
			
			if(game.SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCaveCombo['Solved'] == 'Yes'){
					return CoastCaveFireHintsOne();
				}else{
					if(game.SavedGame.SavedGameObj.data.JungleHole != undefined){
						if(game.SavedGame.SavedGameObj.data.JungleHole['Book'] != undefined){
							if(game.SavedGame.SavedGameObj.data.FreighterLocker != undefined){
								if(game.SavedGame.SavedGameObj.data.FreighterLocker['Book'] != undefined){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLocker'){
										if(game.SavedGame.SavedGameObj.data.FreighterLocker['Book'] == 'open'){
											return "The Book of Great Queens also uses roman numerals like The Book of Buccanner Sea Flags.";
										}else{
											return "Take a closer look at the Book of Great Queens.";
										}
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHole'){
										if(game.SavedGame.SavedGameObj.data.JungleHole['Book'] == 'open'){
											return "The Book of Buccanner Sea Flags also uses roman numerals like The Book of Great Queens.";
										}else{
											return "Take a closer look at the Book of Buccanner Flags.";
										}
										
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyonMessage'){
										return "There are three names listed here, and three dials on the combination lock on the door in the cave.";
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveCombo'){
										if(game.SavedGame.SavedGameObj.data.RavineCanyonMessage != undefined){
											if(game.SavedGame.SavedGameObj.data.RavineCanyonMessage['SeenIt'] == 'Yes'){
												return "There are dials on the lock, and three names written on the side of the freighter.";
											}else{
												return "Keep searching - there's information out there that can help here.";
											}
										}else{
											return "Keep searching - there's information out there that can help here.";
										}
									}else{
										if(game.SavedGame.SavedGameObj.data.RavineCanyonMessage != undefined){
											if(game.SavedGame.SavedGameObj.data.RavineCanyonMessage['SeenIt'] == 'Yes'){
												return "Try comparing the Book of Great Queens and the Book of Buccaneer Flags";
											}else{
												return "There are clues waiting to be discovered.";
											}
										}else{
											if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyon'){
												return "There's a clue on the side of the ship.";
											}else{
												return "There are clues waiting to be discovered.";
												
											}
										}
									}
								}else{
									return "Look around for more clues to help solve the combination of the door in the coastal cave.";
								}
							}else{
								return "No hint at this time.";
							}
						}else{
							return "There are clues waiting to be discovered.";
						}
					}else{
						return "There are clues waiting to be discovered.";
					}
				}
			}else{
				return "No Hint at This Time";
			}
			
			
		}
		private function CoastCaveFireHintsOne():String{
			if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'LogsAndSticks'){
					return CoastCaveFireHintsTwo();
				}else if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					return TorchHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CoastMoai != undefined){
						if(game.SavedGame.SavedGameObj.data.CoastMoai['Logs'] == 'PickedUp'){
							if(game.SavedGame.SavedGameObj.data.RavineFreighter != undefined){
								if(game.SavedGame.SavedGameObj.data.RavineFreighter["Sticks"] == "PickedUp"){
									if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] != 'Logs'){
										if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave'){
											return "Why not place the logs in the fire pit?";
										}else{
											return "Look for a place to use the wooden logs.";
										}
									}else if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] != 'Sticks'){
										if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave'){
											return "Why not add the sticks to the fire pit?";
										}else{
											return "Look for a place to use the tree sticks.";
										}
									}else{
										return "No hint at this time.";
									}
									
								}else{
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter'){
										return "Why not pick up the sticks?";
									}else{
										return "Look around, there are useful items to be found.";
										
									}
								}
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter'){
									return "Why not pick up the sticks?";
								}else{
									return "Look around, there are useful items to be found.";
								}
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastMoai'){
								return "Why not pick up the logs?";
							}else{
								return "Keep searching, there are items to pick up.";
							}	
						}
					}else{
						return "No hint at this time.";
					}
				}
			}else{
				return "No hint at this time.";
			}
			
		}
		
		
		private function CoastCaveFireHintsTwo():String{
			if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.InvenPuzzle['flintAndMarcasite'] == 'yes'){
					return FireHints();
				}else{
					return FlintMarcText();
				}
			}else{
				return FlintMarcText();
			}
			
		}
		
		private function FlintMarcText():String{
			if(game.SavedGame.SavedGameObj.data.CaveBones != undefined){						
				if(game.SavedGame.SavedGameObj.data.CaveBones["Flint"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.CaveCorridor != undefined){
						if(game.SavedGame.SavedGameObj.data.CaveCorridor["Marcasite"] == "PickedUp"){
							return "Try combining the two stones found in the cave.";
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor'){
								return "Why not pick up the unusual stone?";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave'){
								return "There are items in this cave.";
							}else{
								return "There are things to discover on the island... keep looking.";
							}
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor'){
							return "Why not pick up the unusual stone?";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave'){
							return "There are still more items in this cave.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveBones'){
							return "There are still more items in this cave.";
						}else{
							return "There are things to discover on the island... keep looking.";
						}
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveBones'){
						return "Try picking up the black stone?";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave'){
						return "There are items to be found in this cave.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor'){
						return "There are items to be found in this cave.";
					}else{
						return "There are things to discover on the island... keep looking.";
					}
				}
			}else{
				
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveBones'){
					return "Try picking up the black stone?";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave'){
					return "There are items to be found in this cave.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor'){
					return "There are items to be found in this cave.";
				}else{
					return "There are things to discover on the island... keep looking.";
				}
				
			}
		}
		
		
		private function FireHints():String{
			if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
				
				if(game.SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					return TorchHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave'){
						return "Why not try lighting the logs and sticks using the sparks from the flint and geode?";
					}else{
						return "There's a place to use the sparks from the flint and geode.";
					}
				}
			}else{
				return "No hint at this time.";
			}
		}
		private function TorchHints():String{
			if(game.SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['TarTorch'] == "Yes"){
					return CaveCorridorHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['TorchStick'] == 'PickedUp'){
							if(game.SavedGame.SavedGameObj.data.JungleTarPit != undefined){
								if(game.SavedGame.SavedGameObj.data.JungleTarPit['Ribbon'] == 'PickedUp'){
									if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
										if(game.SavedGame.SavedGameObj.data.InvenPuzzle['torch'] == 'yes'){
											if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPitPit'){
												return "Try adding tar to the torch.";
											}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPit'){
												return "Take a closer look at the tar pit.";
											}else{
												return "The tar in the pit could be useful.";
											}
										}else{
											return "Try wrapping the ribbon of woven canvas around the petrified stick from the tar pit.";
										}
									}else{
										return "No hint at this time.";
									}
								}else{
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPit'){
										return "There's something hanging from the tree here."
									}else{
										return "There are items to find keep looking.";
									}
								}
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPit'){
									return "There's something hanging from the tree here.";
								}else{
									return "There are items to find, keep looking.";
								}
							}
						}else{
							return TorchText();
						}
					}else{
						return TorchText();
					}
				}
			}else{
				return TorchText();
			}
			
		}
		private function TorchText():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPitPit'){
				return "Why not try picking up the stick from out of the tar pit?";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPit'){
				return "Take a closer look at the tar pit."
			}else{
				return "There are items that can be picked up, keep looking.";
			}
		}
		private function CaveCorridorHints():String{
			if(game.SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				if(game.SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
					return TarPitPlanksHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
						if(game.SavedGame.SavedGameObj.data.CoastCave['TorchTar'] == 'Yes'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave'
							){
								return "Try illuminating the darkness with the torch.";
							}else{
								return "Look for a place to use the light from the torch.";
							}
						}else{
							return "Try igniting the tar covered torch on the burning fire in the cave by coast.";
						}
					}else{
						return "No hint at this time";
					}
				}
			}else{
				return "No hint at this time";
			}
			
			
		}
		
		
		private function TarPitPlanksHints():String{
			if(game.SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['PlankClose'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['PlankFar'] == 'Attached'){
						return SubLadderHint();
					}else{
						return TarPlankTextTwo();
					}
				}else{
					return TarPlankTextTwo();
				}
			}else{
				return "No Hint at this time";
			}		
			
		}				
		
		private function TarPlankTextTwo():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateDitch["Plank"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.CavePirateEnclave != undefined){
						if(game.SavedGame.SavedGameObj.data.CavePirateEnclave["Plank"] == "PickedUp"){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPit' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPitPit' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPitWall'
								
							){
								return "There's something that can be done here to get across the pit.";
							}else{
								return "Make your way to the tar pit, there's something that can be done there.";
							}
						}else{
							return TarPlankText();
						}
					}else{
						return TarPlankText();
					}
				}else{
					return TarPlankText();
				}
			}else{
				return TarPlankText();
			}
		}
		
		private function TarPlankText():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'
			){
				return "There are items that can be picked up in this area, have a look around.";
			}else{
				if(game.SavedGame.SavedGameObj.data.CavePirate != undefined){
					if(game.SavedGame.SavedGameObj.data.CavePirate['SeenIt'] == 'Yes'){
						return "Try exploring the cave around the pirate ship.";
					}else{
						return "Continue exploring, there's more to discover.";
					}
				}else{
					return "Continue exploring, there's more to discover.";
				}
				
			}
		}
		
		
		
		
		private function SubLadderHint():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Card'] != undefined){
					return SubCodeHint();
				}else{
					return SubLadderText_04();
				}
			}else{
				return SubLadderText_04();
			}
			
		}
		private function SubLadderText_04():String{
			if(game.SavedGame.SavedGameObj.data.TriremeInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeInterior["Ladder"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
						if(game.SavedGame.SavedGameObj.data.FarCoastCliff['Card'] == 'PickedUp'){
							if(game.SavedGame.SavedGameObj.data.JungleSubmarine != undefined){
								if(game.SavedGame.SavedGameObj.data.JungleSubmarine['Ladder'] == 'Attached'){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleSubmarineDoor' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineHatchPuzzle'
									){
										return "There's something that can be done here, try using the security card.";
									}else{
										return "Head to the submarine, there's something that can be done.";
									}
									
								}else{
									return SubLadderText_01();
								}
							}else{
								return SubLadderText_01();
							}
							
						}else{
							return SubLadderText_02();
						}
					}else{
						return SubLadderText_02();
					}
				}else{
					return SubLadderText_03();
				}
			}else{
				return SubLadderText_03();
			}
			
		}
		
		
		private function SubLadderText_03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDeck' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDevice'
			){
				return "There's something that can be picked up on this boat.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCliff'
			){
				return "Look in the old ship by the waterfall.";
			}else{
				return "Find the waterfall, there are items that can be picked up.";
			}
		}
		
		private function SubLadderText_02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCliff'
			){
				return "This is a good place to search for items. Try looking around the waterfall.";
				
			}else{
				return "Find the waterfall, there are things to find.";
			}
		}
		private function SubLadderText_01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleSubmarine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Jungle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoast'
			){
				return "Try using the ladder to get on to the wing of the submarine tower.";
			}else{
				return "There's a place the ladder can be used, you've already seen where to put it.";
			}
		}
		
		private function SubCodeHint():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Solved'] == 'yes'){
					return SubmarineHatchHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.FarCoastDingy != undefined){
						if(game.SavedGame.SavedGameObj.data.FarCoastDingy["Book"] != undefined){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoast' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastDingy' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastHelmet'
							){
								return "Study the book in the ruined row boat closely, there's a clue to the submarine code - it's also a good read.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineHatchPuzzle' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleSubmarineDoor' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleSubmarine'
								
							){
								return "The book in the row boat was about a submarine.";
							}else{
								return "Look nearby the submarine for clues to the door code.";
							}
						}else{
							return SubCodeText01();
						}
					}else{
						return SubCodeText01();
					}
				}
			}else{
				return SubCodeText01();
			}
			
		}
		
		private function SubCodeText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoast' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastDingy' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastHelmet'
			){
				return "This a good place to look for clues.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineHatchPuzzle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleSubmarineDoor' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleSubmarine'
				
			){
				
				return "Head to the nearby beach.";
			}else{
				return "Look nearby the submarine for clues to the door code.";
			}
			
			
		}
		
		private function SubmarineHatchHint():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineInterior["Rope"] == "Attached"){
					return SubmarinePowerHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.SubmarineInterior["Hatch"] != undefined){						
						if(game.SavedGame.SavedGameObj.data.TriremeInterior != undefined){
							if(game.SavedGame.SavedGameObj.data.TriremeInterior["Rope"] == "PickedUp"){
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' 				
								){
									return "Try attaching the rope to a pipe near the hatch.";
								}else{
									return "Make your way back into the submarine's interior, there's a way to get down the hatch.";
								}
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDeck' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeInterior' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDevice'
								){
									return "There's something that can be picked up on this boat.";
									
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCornerCliff'
								){
									return "Look in the old ship by the waterfall.";
								}else{
									return "Head back to the old greek trireme near the waterfall, there's something there."
								}
								
							}
						}else{
							return "No hint at this time."
						}
					}else{
						return SubmarineHatchText01();
					}
				}
			}else{
				return SubmarineHatchText01();
				
				
			}
			
			return "No Hint at this time."
		}
		private function SubmarineHatchText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' 				
			){
				return "Try opening the hatch on the floor."
			}else{
				return "Check out the interior of the submarine. There's a problem there to identify."
			}
		}
		
		private function SubmarinePowerHints():String{
			if(game.SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					return CannonLoadHints();
				}else{				
					if(game.SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
						if(game.SavedGame.SavedGameObj.data.JunkTopDeck["Lever"] == "PickedUp"){
							if(game.SavedGame.SavedGameObj.data.SubmarinePowerMain['Lever'] == 'Attached'){
								if(game.SavedGame.SavedGameObj.data.JungleEnclaveMessage != undefined){
									if(game.SavedGame.SavedGameObj.data.JungleEnclaveMessage['SeenIt'] == 'Yes'){
										if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
											game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclave' || 				
											game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveRock' ||  				
											game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveMessage' 
										){
											return 'The markings on the wall here resemble the power controls of the submarine'; 
										}else{
											return "Study the markings on the rock wall up the hill from old merchant ship closely."
										}
										
									}else{
										return SubPowerText02();
									}
								}else{
									return SubPowerText02();
								}
								
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' || 				
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||  				
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos' 
									
								){
									return "There's a place to use the lever nearby."
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain'){
									return "Try attaching the lever here."
								}else{
									return "Look for a place to use the red lever found on the deck of the old merchant junk ship."
								}
							}
						}else{
							trace("BARK 1");
							return SubPowerText01();
						}
					}else{
						trace("BARK 2");
						return SubPowerText01();
					}
					
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole'				
				){
					return "Head to the lower lever, there's a puzzle to identify."
				}else if (game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||  				
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
				){	
					return "Have a look at the power console."
				}else if (game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ){
					return "Search the jungle for items and clues to help with power console."
					
				}else {
					return "Head to the submarine, there's a puzzle to identify."
				}
				
			}
			
			
		}
		private function SubPowerText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclave' || 				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveRock' ||  				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall' 								
			){
				return "There's a clue to help with the submarine power supply here."
			}else{
				return "Search the jungle for clues about the submarine's power supply."
			}
		}
		
		private function SubPowerText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior' || 				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||  				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkOracle' ||  				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk'  				
			){
				return "There are things to be found in this area."
			}else{
				return "Search the jungle for items and clues to help the submarine's power supply."
			}
		}
		
		private function CannonLoadHints():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Added'){
					return SmallTorchHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CavePirateCannon['K2SO'] == 'PickedUp'){
						return FreighterHatchHints();
					}else if(game.SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Spent'){
						return "Pick up the powder inside the breach of the cannon.";
						
					}else{
						return CannonLoadText02();
					}
				}
			}else{
				return CannonLoadText02();
			}	
		}
		
		private function CannonLoadText02():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateJunk['Barrel'] == 'Open'){
					if(game.SavedGame.SavedGameObj.data.CavePirateJunk["BlackPowder"] == "PickedUp"){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon'){
							return "Try loading the black powder into the cannon."
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk' || 				
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||  				
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage' 				
							
						){
							return "There's a place to put the black powder nearby."
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck'){
							return "There's something that can be done here."
						}else{
							return "Look around the pirate ship, there's something that can be done with black powder."
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk'){
							return "Why not pick up some of the black powder?"
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon' || 				
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||  				
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage' 				
							
						){
							return "There's something on this ship that can be picked up.";
						}else{
							return "Head to the pirate ship inside the cave, there's an item there.";
						}
					}
				}else{
					return CannonLoadText01();
				}
			}else{
				return CannonLoadText01();
			}
		}
		
		private function CannonLoadText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk'){
				return "Take a look at overturned barrel"
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon' || 				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||  				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage' 				
				
			){
				return "There's something on this ship waiting to be found.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' || 				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||  				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' 				
			){
				return "Look around onboard the wrecked pirate ship.";
			}else{
				return "Head to the pirate ship inside the cave, there's something to do.";
			}
		}
		
		private function SmallTorchHints():String{
			if(game.SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				if(game.SavedGame.SavedGameObj.data.CaveCorridor['CannonTorch'] == 'Yes'){
					return LightCannonHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
						if(game.SavedGame.SavedGameObj.data.CoastCave['CannonTorch'] == 'Yes'){
							return LightCannonHints();
						}else{
							return SmallTorchText01();
						}
					}else{
						return "No Hint at This Time"
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CoastCave != undefined){
					if(game.SavedGame.SavedGameObj.data.CoastCave['CannonTorch'] == 'Yes'){
						return FreighterHatchHints();
					}else{
						return SmallTorchText01();
					}
				}else{
					return "No Hint at This Time"
				}
			}
			
		}
		private function SmallTorchText01():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateJunk["Torch"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave' 
					){
						return "Try lighting the torch on the flames... but be careful.";
					}else{
						return "Find a way to light the small torch from the deck of the pirate ship.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk'){
						return "There's an item that can be picked up here."
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon' || 				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||  				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage' 				
						
					){
						return "There's something on this ship waiting to be found.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' || 				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||  				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' 				
					){
						return "Look around onboard the wrecked pirate ship.";
					}else{
						return "Head to the pirate ship inside the cave, there's an item that can be picked up.";
					}
				}
			}else{
				return "No Hint at this time"
			}
			
			
		}
		
		private function LightCannonHints():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateCannon != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateCannon['K2SO'] == 'PickedUp'){
					return FreighterHatchHints();
				}else{
					if(game.SavedGame.SavedGameObj.data.CavePirateCannon['Powder'] == 'Spent'){
						
						return "Pick up the white powder inside the breach of the cannon."
						
					}else{
						return "Use the torch from the deck of the pirate ship to light the cannon's fuse."
					}
					
				}
			}else{
				return "No hint at this time";
			}
			
			
		}
		
		
		private function FreighterHatchHints():String{
			if(game.SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineFreighterHatch['Hatch'] == 'Unlocked'){
					return BlowTorchHints();
				}else{
					return FreighterHatchText02();
				}
			}else{
				return FreighterHatchText02();
			}
			
		}
		private function FreighterHatchText02():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateDitch["Jug"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
						if(game.SavedGame.SavedGameObj.data.InvenPuzzle['causticJug'] == 'yes'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighterHatch'){
								return "Try using the acidic mixture of powder and vinegar to clean the hatch.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighterDeck' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter'
							){
								return "Look around the deck, there's something that can be done.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterInterior' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterTable' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLocker' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterUpper' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterSafe' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWheel'
							){	
								return "Inspect the deck on the outside hatch of the freighter.";
							}else{
								return "Return to the freighter, there's something to accomplish there.";
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.RavineFreighterHatch != undefined){
								if(game.SavedGame.SavedGameObj.data.RavineFreighterHatch['Dust'] == 'Applied'){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighterHatch'){
										return "Try using the acidic mixture of powder and vinegar to clean the hatch.";
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighterDeck' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter'
									){
										return "Look around the  deck, there's something that can be done.";
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterInterior' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterTable' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLocker' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterUpper' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterSafe' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWheel'
									){	
										return "Inspect the deck on the outside hatch of the freighter.";
									}else{
										return "Return to the freighter, there's something to accomplish there.";
									}
								}else{
									return FreighterHatchText01();
								}
							}else{
								return FreighterHatchText01();
							}
						}
					}else{
						return FreighterHatchText01();
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' || 				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||  				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' 				
					){
						return "There's an item that can be picked up around here.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' || 				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk' ||  				
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage' 				
					){
						return 'Look around the waters of the ship.';
					}else{
						return "There's an item in the cave with the pirate ship that hasn't been picked up." 
					}
				}
			}else{
				return "No Hint at This Time";
			}
		}
		
		private function FreighterHatchText01():String{
			return "Try combining the powder created by the reaction inside the cannon with " +
				" the jug of vinegar found near the pirate ship.";
		}
		
		private function BlowTorchHints():String{
			if(game.SavedGame.SavedGameObj.data.FreighterOil != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterOil['BlowTorchLit'] == 'Yes'){
					return FreighterWallHints();
				}else{
					return BlowTorchText02();
				}
			}else{
				return BlowTorchText02();
			}
			
			
		}
		
		private function BlowTorchText02():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineTorpedos['DoorLeft'] != undefined){
					if(game.SavedGame.SavedGameObj.data.SubmarineTorpedos['Blowtorch'] == 'PickedUp'){
						if(game.SavedGame.SavedGameObj.data.FreighterLower != undefined){
							if(game.SavedGame.SavedGameObj.data.FreighterLower['Ladder'] == 'Attached'){
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterOil'){
									return "Remove the cap from barrel of gasoline and try filling up the blowtorch.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLower' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWall'
								){
									return "Climb the ladder to get a better look at the barrels.";
								}else{
									return "Head to the lower level of the freighter, there's something that can be accomplished.";
								}
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLower' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWall'
								){
									return "Try using the ladder to reach the oil barrels.";
								}else{
									return "Head to the lower level of the freighter, there's something that can be accomplished.";
								}
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLower' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWall'
							){
								return "Try using the ladder to reach the oil barrels suspended from the ceiling.";
							}else{
								return "Go down the hatch to lower level of the freighter - make sure to bring the ladder.";
							}
							
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos' || 				
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' 		
						){
							return "There's an item in here that can be picked up";
						}else{
							return "There's an item in the submarine that can be picked up";
						}
					}
				}else{
					return BlowTorchText01();
				}
			}else{
				return BlowTorchText01();
			}
		}
		
		private function BlowTorchText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos' || 				
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' 		
			){
				return "Look inside the torpedo bays.";
			}else{
				return "There's more to find in the submarine.";
			}
		}
		
		private function FreighterWallHints():String{
			if(game.SavedGame.SavedGameObj.data.FreighterWall != undefined){
				trace("1");
				if(game.SavedGame.SavedGameObj.data.FreighterWall['Door'] == 'open'){
					//	return SubmarineWiresHints();
					return SubConsoleHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.FreighterWall['BlowTorch'] == 'Used'){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWall' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLower' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterOil'
						){
							return "Push on the wall where you used the blowtorch";
						}else{
							return "Return to the lower level of the freight ship, there's something to do.";
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWall'){
							return "The blowtorch can cut through metal...";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLower' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterOil'
						){
							return "Take a look at wall where the light shines through - you now have a blowtorch.";
						}else{
							return "Return to the lower level of the freight ship, there's something to do.";
						}
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWall'){
					return "The blowtorch can cut through metal...";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLower' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterOil'
				){
					return "Take a look at wall where the light shines through - you now have a blowtorch.";
				}else{
					return "Return to the lower level of the freight ship, there's something to do.";
				}
			}
			
		}
		
		
		
		private function SubConsoleHint():String{
			if(game.SavedGame.SavedGameObj.data.HeroBoatSteering != undefined){							
				if(game.SavedGame.SavedGameObj.data.HeroBoatSteering["Screwdriver"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
						if(game.SavedGame.SavedGameObj.data.SubmarineConsole['PanelUnlocked'] == 'yes'){
							return SubmarineWiresHints();
						}else{
							
							if(	game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole'){
								return "Try to open the console with a tool.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
							){
								return "There's a place near here you can use the screwdriver.";
							}else{
								return "There's something that can be fixed inside the submarine.";
							}
						}
					}else{
						if(	game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole'){
							return "Try to open the console with a tool.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
						){
							return "There's a place near here you can use the screwdriver.";
						}else{
							return "There's something that can be done inside the submarine.";
						}
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoat' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoatSteering' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoatVista' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoatVistaStairs'
					){
						return "There's an item to pick up here.";
					}else{
						return "Head to the wrecked yacht near the Moai, there's still an item to pick up";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoat' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoatSteering' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoatVista' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'HeroBoatVistaStairs'
				){
					return "There's an item to pick up here.";
				}else{
					return "Head to the wrecked yacht near the Moai, there's still an item to pick up";
				}
			}
			
		}
		
		private function SubmarineWiresHints():String{
			
			/*
			if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
			if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['Solved'] == 'Yes'){
			*/	
			if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_blue'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_green'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_red'] == 'Attached'){
							if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_yellow'] == 'Attached'){
								return ConsoleWiresHintSolve();
							}else{
								return SubWiresText01()
							}
						}else{
							return SubWiresText01()
						}
					}else{
						return SubWiresText01()
						
						//	return SubmarineWiresText03();
					}
				}
				else{
					return SubWiresText01();
				}
			}else{
				return SubWiresText01();
			}
			
			
		}
		
		
		
		
		
		private function SubmarineWiresText04():String{
			if(	game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole'){
				return "Try to open the console with a tool.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
			){
				return "There's a place near here you can use the screwdriver.";
			}else{
				return "There's something that can be fixed inside the submarine.";
			}
		}
		
		private function SubWiresText01():String{
			if(game.SavedGame.SavedGameObj.data.Lab != undefined){
				if(game.SavedGame.SavedGameObj.data.Lab['SeenIt'] == 'Yes'){
					if(game.SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
						if(game.SavedGame.SavedGameObj.data.LabDeskDetail["Solder"] == "PickedUp"){
							
							
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineWirePuzzle'){
								return "Try using the soldering iron to repair broken wires.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
							){
								if(game.SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
									if(game.SavedGame.SavedGameObj.data.SubmarineConsole['PanelUnlocked'] == 'yes'){
										return "There's a place here to use the soldering iron.";
									}else{
										return SubmarineWiresText04();
									}
								}else{
									return SubmarineWiresText04();
								}
								
								
							}else{
								return "There's something that can be fixed inside the submarine.";
							}
							
						}else{
							return SubWiresText02();
						}
					}else{
						return SubWiresText02();
					}
				}else{
					return "Explore the new area - there's much to discover and useful items to find.";
				}
			}else{
				return "Explore the new area - there's much to discover and useful items to find.";
			}
			
			return "";
		}
		
		private function SubWiresText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter'
			){
				return "Continue to look around the field laboratory, there are items to find.";
			}else{
				return "Why not have a look around inside the field laboratory";
			}
		}
		
		/*
		private function SubmarineWiresText03():String{
		
		if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_blue'] == 'Attached'){
		if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_green'] == 'Attached'){
		if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_red'] == 'Attached'){
		if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_yellow'] == 'Attached'){
		if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineWirePuzzle'){
		return "Follow the paths of the each tangled wire and connect the corresponding colors.";
		}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
		game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
		game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
		game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
		game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
		){
		return "Take a look at the submarine's navigation console, there's something to do.";
		}else{
		return "There's something to do inside the submarine.";
		}
		
		}else{
		return SubWiresScrew01();
		}
		}else{
		return SubWiresScrew01();
		}
		}else{
		return SubWiresScrew01();
		}
		}else{
		return SubWiresScrew01();
		}
		the	}		
		*/
		
		private function ConsoleWiresHintSolve():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineWirePuzzle['Solved'] == 'Yes'){
					return SubmarineDoorHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineWirePuzzle'){
						return "Try different permutations of position in the four wires hanging from the top.";
					}else{
						return "Try to fix the wiring of the submarine's navigation puzzle. It can be solved.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineWirePuzzle'){
					return "Try different permutations of position in the four wires hanging from the top.";
				}else{
					return "Try to fix the wiring of the submarine's navigation puzzle. It can be solved.";
				}
			}
		}
		
		private function SubmarineDoorHint():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineInterior['Door'] != undefined){
					return WrenchHints();
				}else{
					return SubDoorText01();
				}
			}else{
				return SubDoorText01();
			}
		}
		private function SubDoorText01():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineConsole['ScreensOn'] == 'yes'){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior'){
						return "Try opening the door.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
					){
						return "Now that power's fully restored, try the door..";
					}else{
						return "There's another area to discover inside the submarine.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole'){
						return "Try flipping the switch.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'
					){
						return "There's something that can be done to get power fully restored here.";
					}else{
						return "Look around the submarine, there's something that can be done.";
					}
				}
			}else{
				return "No Hint at This Time.";
			}
		}
		
		
		
		private function WrenchHints():String{
			if(game.SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastBuoy["SolarPanels"] == "PickedUp"){
					return WireCuttersHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
						if(game.SavedGame.SavedGameObj.data.SubmarineTorpedos['Wrench'] == 'PickedUp'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastBuoy'){
								return "Try using the wrench to remove the solar panels from the buoy.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle'
							){
								return "Take a closer look at the buoy.";
							}else{
								return "There's something to do in the forest near the lifeboat.";							
							}
							
							
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos'){
								return "There is a wrench on the floor directly ahead.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineSonar' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptains' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsBed' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsTable' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsComputer'
								
							){
								return "There's a item nearby to pickup";
							}else{
								return "Search the submarine, there are items that still can be picked up"								
							}
						}
					}else{
						return "No Hint at this time";
					}
				}
				
			}else{
				return "No Hint at this time";
			}
		}
		
		private function WireCuttersHint():String{
			if(game.SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				if(game.SavedGame.SavedGameObj.data.CoastBuoy["Wires"] == "PickedUp"){
					return JunkPotatoHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
						if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsBed['WireCutters'] == 'PickedUp'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastBuoy'){
								return "Try cutting the wires off the buoy.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle'
							){
								return "Take a closer look at the buoy.";
							}else{
								return "There's something that can be done to the weather buoy.";							
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptains' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsBed' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsTable' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsComputer'
								
							){
								return "This is a good place to look for items";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineSonar'){
								
								return "There's an item in a room nearby.";
							}else{
								return "There are items to discover, continue the search.";							
							}
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptains' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsBed' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsTable' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsComputer'
							
						){
							return "This is a good place to look for items";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineSonar'){
							
							return "There's an item in a room nearby.";
						}else{
							return "There are items to discover, continue the search";							
						}
						
					}
				}
			}else{
				return "No Hint at This Time."
			}
		}
		
		private function JunkPotatoHint():String{
			if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.InvenPuzzle['PotatoesWired'] == 'yes'){
					if(game.SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
						if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Potatoes'] == 'Attached'){
							if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Wires'] == 'Attached'){
								return VikingTrunkHint();
							}else{
								return JunkPotatoText01();
							}
						}else{
							return JunkPotatoText01();
						}
					}else{
						return JunkPotatoText01();
					}
					
				}else if(game.SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
					if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Potatoes'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Wires'] == 'Attached'){
							return VikingTrunkHint();
						}else{
							
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTV'){
								return "Try hooking the potatoes up to the TV using the wires from the buoy.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingDeck' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunk' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingSheild'
							){
								return "Take a closer look at the TV, another item can be added.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingHead'
							){
								return "There's something that can be done on the Viking longboat, jump onboard.";
							}else{
								return "Search the jungle for a place to use the electrical wires.";
							}
						}
					}else{
						return JunkPotatoText02();
					}
					
					
				}else{
					return JunkPotatoText02();
				}
			}else{
				return JunkPotatoText02();
			}
			
			
		}					
		
		private function JunkPotatoText02():String{
			if(game.SavedGame.SavedGameObj.data.JunkInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkInterior["Potatoes"] == "PickedUp"){
					return "Potatoes can be used to form crude batteries with a few wires attached.";
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
						return "There's something to pick up in here.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck')
					{
						return "This is a good place to look for items.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk')
					{
						return "There's more to find on this ship.";
					}else{
						return "There's more to find in the jungle and it's stranded vessels.";
					}
				}
			}else{
				
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
					return "There's something to pick up in here.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
				){
					return "This is a good place to look for items.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk'	
				){
					return "There's more to find on this ship.";
				}else{
					return "There's more to find in the jungle and it's stranded vessels.";
				}
				
			}
		}
		
		
		private function JunkPotatoText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTV'){
				return "Try hooking the potato battery up to the TV.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingDeck' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunk' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingSheild'
			){
				return "Take a closer look at the TV, an item can be added.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingHead'
			){
				return "There's something that can be done on the Viking longboat, jump onboard.";
			}else{
				return "Search the jungle for a place to use the potato battery.";
			}
		}
		
		private function VikingTrunkHint():String{
			
			if(game.SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleVikingTrunk['Handle'] == 'PickedUp'){
					return JungleEnclaveWallHint();
				}else if(game.SavedGame.SavedGameObj.data.JungleVikingTrunk['Unlocked'] == 'Yes'){
					return "Why not pick up the brass pointer from inside the trunk on Viking longboat?";	
				}else{
					return JungleVikingText01();
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
					if(game.SavedGame.SavedGameObj.data.FarCoastHelmet['Key'] == 'PickedUp'){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunk'){
							return "Try unlocking the trunk with key found on the coast line.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingDeck' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunkTV' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingSheild'
						){
							return "There's something that can be done in here.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingHead'
						){
							return "There's something that can be done on the Viking longboat, jump onboard.";
						}else{
							return "It's possible to use a key in your inventory..";
						}	
						
					}else{
						return "Search the shore line for useful items.";
					}
				}else{
					return "Search the shore line for useful items.";
				}
			}
			
		}
		
		private function JungleVikingText01():String{
			if(game.SavedGame.SavedGameObj.data.JungleVikingTrunk['Handle'] == 'PickedUp'){
				return JungleEnclaveWallHint();
			}else if(game.SavedGame.SavedGameObj.data.JungleVikingTrunk['Unlocked'] == 'Yes'){
				return "Why not pick up the brass pointer from inside the trunk on Viking longboat?";	
			}else{
				if(game.SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
					if(game.SavedGame.SavedGameObj.data.FarCoastHelmet['Key'] == 'PickedUp'){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunk'){
							return "Try unlocking the trunk with key found on the coast line.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingDeck' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunkTV' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingSheild'
						){
							return "There's something that can be done in here.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingHead'
						){
							return "There's something that can be done on the Viking longboat, jump onboard.";
						}else{
							return "It's possible to use a key in your inventory..";
						}	
						
					}else{
						return "Search the shore line for useful items.";
					}
				}else{
					return "Search the shore line for useful items.";
					
				}
			}
		}
		
		private function JungleEnclaveWallHint():String{
			
			if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall['Arm'] == 'PickedUp'){
					return VikingBallHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall'){
						return "Why not pick up the brass pointer.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclave' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveRock' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveMessage'		
					){
						return "There's an item here.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleOracle'
					){
						return "This a good area to look for items.";
					}else{
						return "Search around the deep jungle near the junk merchant ship.";
					}	
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall'){
					return "Why not pick up the brass pointer.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclave' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveRock' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveMessage'		
				){
					return "There's an item here.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleOracle'
				){
					return "This a good area to look for items.";
				}else{
					return "Search around the deep jungle near the junk merchant ship.";
				}	
			}
		}
		
		private function VikingBallHint():String{
			if(game.SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleVikingTV['Ball'] == 'PickedUp'){
					return TriremeDeviceHintOne();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTV'){
						return "Why not pick up the black and white from the TV?";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunk' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingSheild'
					){
						return "There's an item that can be picked up here";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingHead'
					){
						return "There's an item on the Viking longboat, jump onboard.";
					}else{
						return "There are still items to pick up.";
					}
				}
			}else{
				return "No Hint at This Time"
			}
			
		}
		
		private function TriremeDeviceHintOne():String{
			
			if(game.SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDevice['Ball'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.TriremeDevice['Mars'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.TriremeDevice['Sun'] == 'Attached'){
							return TriremeDeviceHintTwo();
						}else{
							return "Attach the brass pointer to device located inside the Greek trireme.";
						}
					}else{
						return "Attach the brass pointer to device located inside the Greek trireme.";
					}
					
				}else{
					return "Attach the black and white ball to the device in the Greek Trireme.";
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeInterior' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDeck'){
					return "Take a closer look at the ancient device on this ship.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDevice'){
					return "Try attaching an item to the device.";
				}else{
					return "Head to the old Greek trireme by the waterfall, there's something that can be done there.";
				}
				
			}
			
		}
		
		private function TriremeDeviceHintTwo():String{
			if(game.SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDevice['Solved'] == 'Yes'){
					return SubCaptainsCoinHint();
				}else{
					return "Study and compare the old pages and on the deck of the Greek Trireme and the images show on the sonar screen in the" +
						" submarine."
				}
			}else{
				return "Study and compare the old pages on the deck of the Greek Trireme and the images show on the sonar screen in the" +
					" submarine."
			}
			
		}
		
		private function SubCaptainsCoinHint():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Coin'] == 'PickedUp'){
					return PirateCaveCoinHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptains' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsBed' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsTable' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsComputer'
					){
						return "There's an item in the is room that can be picked up.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain'
					){
						return "There's an item that can be picked up nearby.";
					}else{
						return "There are still items that can be picked up. Continue searching.";
					}
				}
			}else{
				return "No Hint at This Time";
			}
		}
		
		private function PirateCaveCoinHint():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateDitch["Coin"] == "PickedUp"){
					return CoinJunkHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.HeroBoatSteering != undefined){
						if(game.SavedGame.SavedGameObj.data.HeroBoat["Shovel"] == "PickedUp"){
							if(game.SavedGame.SavedGameObj.data.CavePirateDitch["Hole"] == "open"){
								return "Pick up the coin from the out of the hole in the sand near pirate ship in the cave";
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch'){
									return "Have a close look at the sand.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' 
								){
									return "There's a place around here to use the shovel.";
								}else{
									return "There's something that can be done in the cave with the pirate ship.";
								}
							}
						}else{
							return "There's something in the boat near the Moai that can be picked up.";
						}
					}else{
						return "No Hint at this Time.";
					}
				}
			}else{
				return "No hint at this time";
			}
			//	return "";
		}
		
		private function CoinJunkHint():String{
			if(game.SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
				
				if(game.SavedGame.SavedGameObj.data.JunkTopDeck["Coin"] == "PickedUp"){
					return TriemeCoinHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'){
						return "There's something here that can be picked up.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' 
					){
						return "This is a good area to look for items.";
					}else{
						return "There's an item somewhere in the jungle that can be picked up.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'){
					return "There's something here that can be picked up.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' 
				){
					return "This is a good area to look for items.";
				}else{
					return "There's an item somewhere in the jungle that can be picked up.";
				}
			}
			
			//return "";
		}
		
		private function TriemeCoinHint():String{
			if(game.SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDevice['Coin'] == 'PickedUp'){
					return ChinesePuzzleTigerHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDevice'){
						return "Pick up the disc with the image of the turtle form inside the device.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeInterior' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' 
					){
						return "This is a good area to look for items.";
					}else{
						return "There's an item somewhere near the waterfall that can be picked up.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDevice'){
					return "Pick up the disc with the image of the turtle form inside the device.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDeck' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeInterior' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' 
				){
					return "This is a good area to look for items.";
				}else{
					return "There's an item somewhere near the waterfall that can be picked up.";
				}
			}
			
			
		}
		
		private function ChinesePuzzleTigerHint():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'tiger'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'tiger'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'tiger'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'tiger'){
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
									return "Place the disc with image of the tiger on to the device.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
									
								){
									return "There's something nearby that can be done with the tiger disc.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
									return "Have a closer look at the chest.";
								}else{
									return "Look around the boats in the jungle, there's something to be done there.";
								}
							}else{
								return PlaceDragonCoinHint();
							}
						}else{
							return PlaceDragonCoinHint();
						}
					}else{
						return PlaceDragonCoinHint();
					}					
				}else{
					return PlaceDragonCoinHint();
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
					return "Place the disc with image of the tiger on to the device.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
					
				){
					return "There's something nearby that can be done with the tiger disc.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
					return "Have a closer look at the chest.";
				}else{
					return "Look around the boats in the jungle, there's something to be done there.";
				}
			}
			
		}
		
		private function PlaceDragonCoinHint():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'dragon'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'dragon'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'dragon'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'dragon'){
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
									return "Place the disc with image of the dragon on to the device.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
									
								){
									return "There's something nearby that can be done with the disc with image of a dragon on it.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
									return "Have a closer look at the chest.";
								}else{
									return "Look around the boats in the jungle, there's something to be done there.";
								}
							}else{
								return PlacePhoenixCoinHint();
							}
						}else{
							return PlacePhoenixCoinHint();
						}
					}else{
						return PlacePhoenixCoinHint();
					}					
				}else{
					return PlacePhoenixCoinHint();
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
					return "Place the disc with image of the dragon on the device.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
					
				){
					return "There's something nearby that can be done with the disc with image of a dragon on it.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
					return "Have a closer look at the chest.";
				}else{
					return "Look around the boats in the jungle, there's something to be done there.";
				}
			}
		}
		
		private function PlacePhoenixCoinHint():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'phoenix'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'phoenix'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'phoenix'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'phoenix'){
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
									return "Place the disc with image of the phoenix on to the device.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
									
								){
									return "There's something nearby that can be done with the disc with image of a phoenix on it.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
									return "Have a closer look at the chest.";
								}else{
									return "Look around the boats in the jungle, there's something to be done there.";
								}
							}else{
								return PlaceTurtleCoinHint();
							}
						}else{
							return PlaceTurtleCoinHint();
						}
					}else{
						return PlaceTurtleCoinHint();
					}					
				}else{
					return PlaceTurtleCoinHint();
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
					return "Place the disc with image of the phoenix on the device.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
					
				){
					return "There's something nearby that can be done with the disc with image of a phoenix on it.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
					return "Have a closer look at the chest.";
				}else{
					return "Look around the boats in the jungle, there's something to be done there.";
				}
			}
		}
		
		private function PlaceTurtleCoinHint():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'turtle'){
					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'turtle'){
						if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'turtle'){
							if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'turtle'){
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
									return "Place the disc with image of the turtle on to the device.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
									
								){
									return "There's something nearby that can be done with the disc with image of a turtle on it.";
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
									return "Have a closer look at the chest.";
								}else{
									return "Look around the boats in the jungle, there's something to be done there.";
								}
							}else{
								return OpenPirateDoorHint();
							}
						}else{
							return OpenPirateDoorHint();
						}
					}else{
						return OpenPirateDoorHint();
					}					
				}else{
					return OpenPirateDoorHint();
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'){
					return "Place the disc with image of the turtle on the device.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'
					
				){
					return "There's something nearby that can be done with the disc with image of a turtle on it.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior'){
					return "Have a closer look at the chest.";
				}else{
					return "Look around the boats in the jungle, there's something to be done there.";
				}
			}
		}
		
		private function OpenPirateDoorHint():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
				
				if(game.SavedGame.SavedGameObj.data.CavePirateTopDeck['DoorUnlocked'] == 'Yes'){
					return ChinesePuzzleSolveHint();
				}else{
					return OpenPirateDoorText02();
				}
			}else{
				return OpenPirateDoorText02();
			}
			
			
		}
		
		private function OpenPirateDoorText02():String{
			if(game.SavedGame.SavedGameObj.data.RavineDrone != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineDrone["Key"] == "PickedUp"){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck'){
						return "Try unlocking the door with a key.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' || 	
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon'
					){
						return "There's something that can be done on the upper level of the pirate ship."
					}else{
						return "Look around for a place to use the old slender key found beside the drone.";
					}
				}else{
					trace("BARK 1");
					return OpenPirateDoorText01();
				}
			}else{
				trace("BARK 2");
				return OpenPirateDoorText01();
			}
		}
		
		private function OpenPirateDoorText01():String {
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDrone'){
				return "Pick up the key to left of the drone.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyonRear' 								
			){
				return "There's an item nearby that can be picked up."
			}else{
				return "Look around the canyon behind the freight ship, something can be found there.";
			}
		}
		
		private function ChinesePuzzleSolveHint():String{
			if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Solved'] == 'Yes'){
					return DigDragonBallHint();
				}else{
					
					if(game.SavedGame.SavedGameObj.data.JungleOracle != undefined){
						if(game.SavedGame.SavedGameObj.data.JungleOracle['SeenIt'] == 'Yes'){
							if(game.SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
								if(game.SavedGame.SavedGameObj.data.SubmarineCaptains["Book"] != undefined){
									if(game.SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
										if(game.SavedGame.SavedGameObj.data.PirateCaptainsPainting['Letter'] != undefined){
											if(game.SavedGame.SavedGameObj.data.JungleVikingSheild != undefined){
												if(game.SavedGame.SavedGameObj.data.JungleVikingSheild['SeenIt'] == 'Yes'){
													if(game.SavedGame.SavedGameObj.data.RavineCanoe != undefined){
														if(game.SavedGame.SavedGameObj.data.RavineCanoe['SeenIt'] == 'Yes'){
															if(game.SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
																if(game.SavedGame.SavedGameObj.data.JunkTopDeck["Scroll"] != undefined){
																	if(game.SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
																		if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_00'] != 'phoenix'){
																			if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_01'] != 'dragon'){
																				if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_02'] != 'turtle'){
																					if(game.SavedGame.SavedGameObj.data.JunkPuzzle['Coin_Pos_03'] != 'tiger'){
																						return "Around the island are images of four animals: turtle, tiger, dragon & phoenix." +
																							" Each is specific color.";																				
																						
																					}else{
																						return "Compare the book on Chinese Hanzi etymology from the submarine captain's" +
																							" quarters with engravings on the stone next to the merchant ship.";	
																					}
																				}else{
																					return "Compare the book on Chinese Hanzi etymology from the submarine captain's" +
																						" quarters with engravings on the stone next to the merchant ship.";	
																				}
																			}else{
																				return "Compare the book on Chinese Hanzi etymology from the submarine captain's" +
																					" quarters with engravings on the stone next to the merchant ship.";	
																			}
																		}else{
																			return "Compare the book on Chinese Hanzi etymology from the submarine captain's" +
																				" quarters with engravings on the stone next to the merchant ship.";	
																		}
																	}else{
																		return "Compare the book on Chinese Hanzi etymology from the submarine captain's" +
																			" quarters with engravings on the stone next to the merchant ship.";	
																	}
																	
																}else{
																	return ChineseText04();
																}
															}else{
																return ChineseText04();
															}
														}else{
															return ChineseText01();
														}
													}else{
														return ChineseText01();
													}
												}else{
													return ChineseText02();
												}
											}else{
												return ChineseText02();
											}
										}else{
											return ChineseText03();
										}
									}else{
										return ChineseText03();
									}
								}else{
									return ChineseText05();
								}
							}else{
								return ChineseText05();
							}
						}else{
							return ChineseText06();
						}
					}else{
						return ChineseText06();
					}
				}
			}else{
				return "No hint at this time";
			}
			
			
		}
		private function ChineseText06():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck' ||	
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck'	
			){
				return "There's a clue nearby that can help with the puzzle on the lower level of this ship.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'
			){
				return "Look around the outside of the ship for clues to help open the cabinet.";
			}else{
				return "There's a clue around the junk merchant ship.";
			}
		}
		
		private function ChineseText05():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptains'){
				return "Take a look at the book resting on the bed.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsBed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsTable' ||	
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsComputer'	
			){
				return "There are clues in this room that can help with the cabinet inside the merchant ship inside the deep jungle.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineSonar'
			){
				return "There's a clue nearby that can help with the cabinet inside the merchant ship in the deep jungle";
			}else{
				return "Look around the upper decks of the submarine," +
					" there are clues that can help with the cabinet inside the merchant ship in the deep jungle.";
			}
		}
		
		private function ChineseText04():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkTopDeck'){
				return "Take a look at the scroll resting on the ship's old rudder mount.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkDeck' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk'	
			){
				return "There's a clue on this ship that can help with the cabinet in it's lower deck.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JunkPuzzle'
			){
				return "Look on the upper deck for clues to help solve the cabinet";
			}else{
				return "Look around the deck's of the old merchant ship in the deep jungle," +
					" there's a clue that can help with the cabinet inside the merchant ship.";
			}
		}
		
		
		private function ChineseText03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting'){
				return "There's a clue here that can help with the cabinent inside the merchant ship in the deep jungle.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsTable'
				
			){
				return "There's a clue nearby to that can help with the cabinent inside the merchant ship in the deep jungle.";
			}else{
				return "Look around the pirate ship's captain's quarters," +
					" there's a clue that can help with the cabinent inside the merchant ship in the deep jungle.";
			}
		}
		
		private function ChineseText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'VikingDeck' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'VikingTV' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'VikingTVStatic' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' 
				
			){
				return "There's a clue nearby to that can help with the cabinent inside the merchant ship in the deep jungle.";
			}else{
				return "Look around the Viking ship, there's a clue that can help with the cabinent inside the merchant ship in the deep jungle.";
			}
		}
		
		private function ChineseText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyon'
				
			){
				return "There's a clue nearby to that can help with the cabinent inside the merchant ship in the deep jungle.";
			}else{
				return "There's a clue near the canyon close to the coast that can help with the cabinent inside the merchant ship in the deep jungle.";
			}
		}
		
		
		private function DigDragonBallHint():String{
			if(game.SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
					return JungleEnclaveDragonBallHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'Opened'){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate'){
							return "Why not pick up the ball from out of the sediment?";
						}else{
							return "There's something that can be picked up from the excavation site on the mountain side.";
						}
						
					}else{
						return DigDragonBallText01();
					}
				}
				
			}else{
				return DigDragonBallText01();
			}
			
			
		}
		
		private function DigDragonBallText01():String{
			if(game.SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				if(game.SavedGame.SavedGameObj.data.PirateCaptainsCouch['PickAxe'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate'){
						return "Try using the pick axe on the stone ball.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDig' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigSupply'
					){
						return "There's a place to use the pick axe at this site.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'){
						return "Try looking at the other excavation site on the mountain side.";
					}else{
						return "Look around for a place to use the pick axe.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch'){
						return "Why not grab the pick axe from on the couch?";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateTable'
						
					){
						return "There's an item in this room that can be picked up.";
					}else{
						return "Have a look around the inside the pirate ship.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch'){
					return "Why not grab the pick axe from on the couch?";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateTable'
					
				){
					return "There's an item in this room that can be picked up.";
				}else{
					return "Have a look around the inside the pirate ship.";
				}
			}
		}
		
		private function JungleEnclaveDragonBallHint():String{
			if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleEnclaveWall['Dragonball'] == 'PickedUp'){
					return JunkDragonBallHit();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall'){
						return "Why not pickup the spherical stone.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclave' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveMessage' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' 
						
					){
						return "There's an item nearby that can be picked up.";
					}else{
						return "Look around the jungle, there are items still to find.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall'){
					return "Why not pickup the spherical stone.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclave' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveMessage' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleJunk' 
					
				){
					return "There's an item nearby that can be picked up.";
				}else{
					return "Look around the jungle, there are items still to find.";
				}
			}
			
			
		}
		
		private function JunkDragonBallHit():String{
			if(game.SavedGame.SavedGameObj.data.JunkInterior != undefined){
				if(game.SavedGame.SavedGameObj.data.JunkInterior['DragonBall'] == 'PickedUp'){
					return LedgeDragonBallHint();
				}else{
					
					return "Why not pick up the stone sphere from the cabinet inside the merchant ship.";
				}
			}else{
				return "Why not pick up the stone sphere from the cabinet inside the merchant ship.";
			}
		}
		
		private function LedgeDragonBallHint():String{
			if(game.SavedGame.SavedGameObj.data.MountainLedge != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainLedge['DragonBall'] == 'PickedUp'){
					return BananaHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainLedge'){
						return "Why not pickup the spherical stone.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainTemple' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight' || 
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft' 						
					){
						return "There's an item near the entrance of the cave that can be picked up";
					}else{
						return "Investigate the cave on the mountain side, there's something that can be picked up.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainLedge'){
					return "Why not pickup the spherical stone.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainTemple' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight' || 
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft' 						
				){
					return "There's an item near the entrance of the cave that can be picked up";
				}else{
					return "Investigate the cave on the mountain side, there's something that can be picked up.";
				}
			}
			
		}
		
		private function BananaHint():String{
			if(game.SavedGame.SavedGameObj.data.JungleBananas != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleBananas['Bananas'] == 'PickedUp'){
					return BirdCageHint();
				}else{
					return BananaText01();
				}
			}else{
				return BananaText01();
			}				
		}
		private function BananaText01():String{
			if(game.SavedGame.SavedGameObj.data.PirateCaptains != undefined){
				if(game.SavedGame.SavedGameObj.data.PirateCaptains['Poker'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleBananas'){
						return "Trying using the harpoon from the pirate ship to reach the bananas.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleDeep' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' 						
					){
						return "Take a closer look at the banana tree, it's possible to reach the fruit.";
					}else{
						return "There's something that can be done in the jungle, take a look around.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsTable' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting' 						
					){
						return "This is a good place to look for items.";
					}else{
						return "There are more items to find. Keep looking.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsTable' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting' 						
				){
					return "This is a good place to look for items.";
				}else{
					return "There are more items to find. Keep looking.";
				}
			}
		}
		private function BirdCageHint():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateBirdCage['Coin'] == 'PickedUp'){
					return CouchCoinHint();
				}else{
					return BirdCageText01();
				}
			}else{
				return BirdCageText01();
			}
			
			
		}
		
		private function BirdCageText01():String{
			if(game.SavedGame.SavedGameObj.data.FreighterTable != undefined){
				if(game.SavedGame.SavedGameObj.data.FreighterTable['Needle'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
						if(game.SavedGame.SavedGameObj.data.CavePirateBirdCage['Lid'] != undefined){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage'){
								return "Pick up the coin from the bird cage.";
							}
							else{
								return "There's an item in the bird cage on the pirate ship.";
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage'){
								return "Try picking the lock with the compass needle.";
							}
							else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk' 					
							){
								return "Take a closer look at the bird cage on the top deck.";
							}else{
								return "There's something that can be opened on the upper level of pirate ship.";
							}
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBirdCage'){
							return "Try picking the lock with the compass needle.";
						}
						else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk' 					
						){
							return "Take a closer look at the bird cage on the top deck.";
						}else{
							return "There's something that can be opened on the upper level of pirate ship.";
						}
					}
					
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterTable'){
						return "Remove the needle from the compass on the table";
					}
					else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterInterior' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLocker' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterUpper' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterSafe' ||						
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWheel' 						
					){
						return "This is a good place to look for items.";
					}else{
						return "There are items to be found, keep looking.";
					}
				}
			}else{
				return "No Hint at This Time";
			}
			
		}
		
		private function CouchCoinHint():String{
			if(game.SavedGame.SavedGameObj.data.PirateCaptainsCouch != undefined){
				if(game.SavedGame.SavedGameObj.data.PirateCaptainsCouch['Coin'] == 'PickedUp'){
					return PirateChestHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch'){
						return "Try looking between the couch cushions";
					}
					else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsTable' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting'					
					){
						return "This is a good place to look.";
					}else{
						return "There are items to be found, try searching the pirate ship in the cave.";
					}
				}
				
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch'){
					return "Try looking between the couch cushions";
				}
				else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsTable' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting'					
				){
					return "This is a good place to look.";
				}else{
					return "There are items to be found, try searching the pirate ship in the cave.";
				}
			}
			
		}
		
		private function PirateChestHint():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateChest != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateChest['Hammer'] == 'PickedUp'){
					return AppleHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CavePirateChest != undefined){
						if(game.SavedGame.SavedGameObj.data.CavePirateChest['Unlocked'] == 'Yes'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
								return "Why not pick up the hammer from the chest.";
							}else{
								return "There's an item in the skull chest that can be picked up.";
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CavePirateChest != undefined){
								if(game.SavedGame.SavedGameObj.data.CavePirateChest['CoinRight'] == 'Attached'){
									if(game.SavedGame.SavedGameObj.data.CavePirateChest['CoinLeft'] == 'Attached'){
										if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
											return "Pick up the hammer from inside the chest";
										}
										else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
											game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
											game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
										){
											return "There's something that can be picked up in the skull chest.";
										}else{
											return "There's an item in the cave with the pirate ship that can be picked up.";
										}
									}else{
										if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
											return "Place the other ancient coin into the eyes of the skull.";
										}
										else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
											game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
											game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
										){
											return "Have a closer look at the chest with the skull on it.";
										}else{
											return "Look around the cave with the pirate ship, there's something that can be done there.";
										}
									}
								}else if(game.SavedGame.SavedGameObj.data.CavePirateChest['CoinLeft'] == 'Attached'){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
										return "Place the other ancient coin into the eyes of the skull.";
									}
									else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
									){
										return "Have a closer look at the chest with the skull on it.";
									}else{
										return "Look around the cave with the pirate ship, there's something that can be done there.";
									}
								}else{
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
										return "Place one of the ancient coins into the eyes of the skull.";
									}
									else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
									){
										return "Have a closer look at the chest with the skull on it.";
									}else{
										return "Look around the cave with the pirate ship, there's something that can be done there.";
									}
								}
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
									return "Place one of the ancient coins into the eyes of the skull.";
								}
								else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
									game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
								){
									return "Have a closer look at the chest with the skull on it.";
								}else{
									return "Look around the cave with the pirate ship, there's something that can be done there.";
								}
							}
							
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
							return "Place one of the ancient coins into the eyes of the skull.";
						}
						else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
						){
							return "Have a closer look at the chest with the skull on it.";
						}else{
							return "Look around the cave with the pirate ship, there's something that can be done there.";
						}
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
					return "Place one of the ancient coins into the eyes of the skull.";
				}
				else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
				){
					return "Have a closer look at the chest with the skull on it.";
				}else{
					return "Look around the cave with the pirate ship, there's something that can be done there.";
				}
			}
			
			
		}
		
		private function AppleHint():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateBarrels['Apple'] == 'PickedUp'){
					return FishHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
						if(game.SavedGame.SavedGameObj.data.CavePirateBarrels['RightUnlocked'] == 'Yes'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels'){
								return "Pick up the apple from inside the barrel.";
							}
							else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
							){
								return "There's an item inside the barrels.";
							}else{
								return "There's an item in the cave with the pirate ship.";
							}
						}else{
							return AppleText01();
						}
					}else{
						return AppleText01();
					}
				}
			}else{
				return AppleText01();
			}
			
		}
		private function AppleText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels'){
				return "Try using the hammer to remove the nails from the barrels.";
			}
			else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate'					
			){
				return "Take a closer look at the barrels by the chest.";
			}else{
				return "There's something that can be opened in the cave surrounding the pirate ship.";
			}
		}
		
		private function FishHint():String{
			
			if(game.SavedGame.SavedGameObj.data.TriremeDeck != undefined){
				if(game.SavedGame.SavedGameObj.data.TriremeDeck['Fish'] == 'PickedUp'){
					return CliffTreeHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDeck'){
						return "Why not pick up the fish skeleton.";
					}
					else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeInterior' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDevice' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' 			
					){
						return "This is a good place to look for items.";
					}else{
						return "Search around the old greek trireme near the waterfall, there's something to be found.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDeck'){
					return "Why not pick up the fish skeleton.";
				}
				else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeInterior' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TriremeDevice' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' 			
				){
					return "This is a good place to look for items.";
				}else{
					return "Search around the old greek trireme near the waterfall, there's something to be found.";
				}
			}
			
		}
		
		
		private function CliffTreeHint():String{
			if(game.SavedGame.SavedGameObj.data.FarCoastCliff != undefined){
				if(game.SavedGame.SavedGameObj.data.FarCoastCliff['TrunkState'] == '4'){
					return SealHint();
				}else{
					return CliffTreeText01();
				}
			}else{
				return CliffTreeText01();
			}
			//return "";
		}
		private function CliffTreeText01():String{
			if(game.SavedGame.SavedGameObj.data.CaveBones != undefined){
				if(game.SavedGame.SavedGameObj.data.CaveBones['Jaw'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCliff'){
						return "The jaw is an effective saw. Try cutting the tree trunk a few times.";
					}
					else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FarCoastCorner' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleDeep'		
					){
						return "Head to ledge overlooking the waterfall, something can be done there.";
					}else{
						return "Look around for a place to use the jaw bone.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveBones'){
						return "Why not pick up the jaw bone?";
					}
					else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor'		
					){
						return "There's an item in this cave that can be picked up.";
					}else{
						return "There are more items to find. Keep searching.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveBones'){
					return "Why not pick up the jaw bone?";
				}
				else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor'		
				){
					return "There's an item in this cave that can be picked up.";
				}else{
					return "There are more items to find. Keep searching.";
				}
			}
		}
		
		private function SealHint():String{
			if(game.SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.CliffCavePuzzle['Solved'] == 'Yes'){
					return FeedTheBeastHint();
				}else{
					return SealText04();
				}
			}else{
				return SealText04();
			}
			
			
		}	
		private function SealText04():String{
			if(game.SavedGame.SavedGameObj.data.JungleEnclaveRock != undefined){
				if(game.SavedGame.SavedGameObj.data.JungleEnclaveRock['Seal'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
						if(game.SavedGame.SavedGameObj.data.CliffCavePuzzle['Seal'] == 'Attached'){
							if(game.SavedGame.SavedGameObj.data.CavePainting != undefined){
								if(game.SavedGame.SavedGameObj.data.CavePainting['SeenIt'] == 'Yes'){
									return "Compare the painting on the walls of the cave near the coast with" +
										" the images on the door above the waterfall.";
									
								}else{
									return SealText01();
								}
							}else{
								return SealText01();
							}
						}else{
							return SealText02();
						}
					}else{
						return SealText02();
					}
				}else{	
					if(game.SavedGame.SavedGameObj.data.JungleEnclaveRock['Unlocked'] == 'Yes'){
						return "Why not pick up the bronze seal from with in the rock in the jungle ?";
						
					}else{
						return SealText03();	
					}
					
				}
			}else{
				return SealText03();
			}
		}
		
		private function SealText03():String{
			
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveRock'){
				return "Try prying off the front of the rock with the screwdiver.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclave' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveWall' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEnclaveMessage'
			){
				return "Take a closer look the nearby rock, it can be opened.";
			}else{
				return "Head up the hill beside the old merchant ship, something can be done there.";
			}
			
		}
		
		private function SealText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffCavePuzzle'){
				return "Try placing the bronze cylinder on door's seal's alcove.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffCave'){
				return "Take a closer look at the door.";
			}else{
				return "Look around for a place to use the broze cylinder found in the rock deep in the jungle.";
			}
		}
		
		private function SealText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveBones' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Cave' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CaveCorridor'		
			){
				return "There's a clue in here can help with door by the waterfall.";
			}else{
				return "Search for clues to help with door above the waterfall.";
			}
		}
		
		
		private function FeedTheBeastHint():String{
			if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster != undefined){
				if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster['DragonBall'] == 'PickedUp'){
					return TempleTunnelLeftPlaceHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster['Bananas'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster['Fish'] == 'Attached'){
							if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster['Apple'] == 'Attached'){
								if(game.SavedGame.SavedGameObj.data.CliffMonsterMonster['DragonBall'] == 'Attached'){
									return "Why not pick up the spherical stone the friendly monster left for you?";
								}else{
									return "No Hint at this time.";
								}
							}else{
								if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterMonster'
								){
									return "Perhaps it would also like an apple?";
									
								}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterCave'){
									return "Maybe the monster is still hungry?";
								}else {
									return "The monster in the cave over the waterfall is still hungry.";
								}
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterMonster'
							){
								return "Maybe it would like to chew on a fish skeleton?";
								
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterCave'){
								return "Maybe the monster still is hungry?";
							}else {
								return "The monster in the cave over the waterfall is still hungry.";
							}
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterMonster'
						){
							return "The monster likes bananas, try leaving some bananas in front of it's dark lair.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterCave'){
							return "Maybe the monster is still hungry?";
						}else {
							return "The monster in the cave over the waterfall is hungry.";
						}
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterMonster'){
					return "Maybe it likes bananas?";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterCave'
				){
					return "Maybe the monster is hungry?";
				}else {
					return "Try interacting with the monster in the cave over the waterfall.";
				}
			}
			
			
		}
		
		
		
		
		
		private function TempleTunnelLeftPlaceHint():String{
			if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
				if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft['BallOne'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft['BallTwo'] == 'Attached'){
						if(game.SavedGame.SavedGameObj.data.TempleTunnelLeft['BallThree'] == 'Attached'){
							return TempleTunnelRightPlaceHint();
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft'
							){
								return "Try placing the spherical stone with three dots in one of the holes.";
								
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'  
							){
								return "Take a closer look at the three recesses on the left side of this cave near the entrence.";
							}else {
								return "There's something that can be done in the geometrically patterned cave on the mountain side.";
							}
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft'
						){
							return "Try placing the spherical stone with two dots in one of the holes.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'  
						){
							return "Take a closer look at the three recesses on the left side of this cave near the entrence.";
						}else {
							return "There's something that can be done in the geometrically patterned cave on the mountain side.";
						}
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft'
					){
						return "Try placing the spherical stone with one dot in one of the holes.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'  
					){
						return "Take a closer look at the three recesses on the left side of this cave near the entrence.";
					}else {
						return "There's something that can be done in the geometrically patterned cave on the mountain side.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft'
				){
					return "Try placing the spherical stone with one dot in one of the holes.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'  
				){
					return "Take a closer look at the three recesses on the left side of this cave near the entrence.";
				}else {
					return "There's something that can be done in the geometrically patterned cave on the mountain side.";
				}
			}
			
		}
		
		private function TempleTunnelRightPlaceHint():String{
			if(game.SavedGame.SavedGameObj.data.TempleTunnelRight != undefined){
				if(game.SavedGame.SavedGameObj.data.TempleTunnelRight['BallFive'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.TempleTunnelRight['BallSeven'] == 'Attached'){
						return TarRoofHint();
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight'
						){
							return "Try placing the spherical stone with the seven dots in one of the holes.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'  
						){
							return "Take a closer look at the two recesses on the right side of this cave near the entrence.";
						}else {
							return "There's something that can be done in the geometrically patterned cave on the mountain side.";
						}
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight'
					){
						return "Try placing the spherical stone with the five dots in one of the holes.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'  
					){
						return "Take a closer look at the two recesses on the right side of this cave near the entrence.";
					}else {
						return "There's something that can be done in the geometrically patterned cave on the mountain side.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelRight'
				){
					return "Try placing the spherical stone with the five dots in one of the holes.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnel' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TempleTunnelLeft' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'  
				){
					return "Take a closer look at the two recesses on the right side of this cave near the entrence.";
				}else {
					return "There's something that can be done in the geometrically patterned cave on the mountain side.";
				}
			}
			
		}
		
		private function TarRoofHint():String{
			if(game.SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineRoof['Tar'] == 'Attached'){
					return SolarRoofHint();
				}else{
					return RavineRoofText03();
				}
			}else{
				return RavineRoofText03();
			}
			
		}						
		private function RavineRoofText03():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateJunk['Rope'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						if(game.SavedGame.SavedGameObj.data.JungleTarPitPit['BucketTar'] == "PickedUp"){
							if(game.SavedGame.SavedGameObj.data.JungleHouses != undefined){
								if(game.SavedGame.SavedGameObj.data.JungleHouses["Ladder"] == "Attached"){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineRoof'
									){
										return "Why not try spreading the tar over the roof.";
										
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
									){
										return "Try climbing on to the roof of the small hut, there's something that can be done.";
									}else {
										return "Head to the house in the ravine, and climb up on to their roof.";
									}
								}else{
									return RoofTarText02();
								}
							}else{
								return RoofTarText02();
							}
						}else{
							return RoofTarText01();
						}
					}else{
						return RoofTarText01();
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateJunk'
					){
						return "Pick up the bucket beside the broken cannon.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateCannon' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDeck' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateTopDeck'		
					){
						return "There's something on this ship that can be picked up.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest' 		
					){
						return "Look aboard the ship, there's an item to pick up on it's decks.";
					}else{
						return "Keep searching, there are more items to pick up.";
					}
					
				}
			}else{
				return "No Hint at this time";
			}
		}
		
		private function RoofTarText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses'
			){
				return "The ladder could be helpful in getting up to the roof of the hut.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
			){
				return "Head to the front of the house, there's something that can be done there.";
			}else {
				return "Head to the front of the house in the ravine, there's something to do there.";
			}
		}
		
		
		private function RoofTarText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPitPit'
			){
				return "Try filling the wooden bucket up with tar from the pit.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPit' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleTarPitWall'
			){
				return "Take a closer look at the tar pit.";
			}else {
				return "Look around for something to fill the old wooden bucket with.";
			}
		}
		
		private function SolarRoofHint():String{
			if(game.SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineRoof['SolarPanels'] == 'Attached'){
					return PascalHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineRoof'
					){
						return "The tar should hold the solar panels in place up here.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
					){
						return "There's more to do on the roof.";
					}else{
						return "There's more to do on the roof of the house at the foot of the mountain.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineRoof'
				){
					return "The tar should hold the solar panels in place up here.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
				){
					return "There's more to do on the roof.";
				}else {
					return "There's more to do on the roof of the house at the foot of the mountain.";
				}
			}
			
		}
		
		private function PascalHint():String{
			if(game.SavedGame.SavedGameObj.data.TemplePascal != undefined){
				if(game.SavedGame.SavedGameObj.data.TemplePascal['Solved'] == 'Yes'){
					return MirrorHint();
				}else{
					return PascalText04();
				}
			}else{
				return PascalText04();
			}
			
			
		}
		
		private function PascalText04():String{
			if(game.SavedGame.SavedGameObj.data.LabDesk != undefined){
				if(game.SavedGame.SavedGameObj.data.LabDesk["Computer"] == "On"){
					if(game.SavedGame.SavedGameObj.data.LabComputer != undefined){
						if(game.SavedGame.SavedGameObj.data.LabComputer['PascalSeen'] == 'SeenIt'){
							if(game.SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
								if(game.SavedGame.SavedGameObj.data.MountainDigSupply["Book"] != undefined){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'TemplePascal'
									){
										return "The dots on the left represent prime numbers, and can be combined on the right to form" +
											" other numbers... the wall is similar to a diagram on doctor's computer.";
									}else {
										return "Compare the notes in doctor's journal from the excavation site" +
											" with the file on her computer about Pascal's triangle.";
									}
								}else{
									return PascalText01();
								}
							}else{
								return PascalText01();
							}
						}else{
							return PascalText02();
						}
					}else{
						return PascalText02();
					}
				}else{
					return PascalText03();
				}
			}else{
				return PascalText03();
			}
		}
		
		private function PascalText03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'
			){
				return "Try turning the computer on.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' 						
			){
				return "Take a closer look at the computer on the desk in this room.";
			}else {
				return "The laboratory has power now, head there and try turning some things on.";
			}
		}
		
		private function PascalText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
			){
				return "Inspect the files, one of them has information that'll help solve the triangle wall in the mountain.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter'
			){
				return "The computer has some files with information that'll help solve the triangle wall in the mountain.";
			}else {
				return "There are clues to be found that can help with the triangle wall in the mountain- look in the feild laboratory.";
			}
		}
		
		
		private function PascalText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigSupply'
			){
				return "The notebook has some information that could help with the triangle wall in the mountain.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDig' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate'
			){
				return "There are clues around here that can help with the triangle wall in the mountain.";
			}else {
				return "Look around the mountain side for more clues to help solve the triangle wall inside the geometric cave.";
			}
		}
		
		private function MirrorHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['Mirror'] == 'Attached'){
					return HominidSkullHint();
				}else{
					return MirrorText02();
				}
			}else{
				return MirrorText02();
			}
			
			
		}
		private function MirrorText02():String{
			if(game.SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
				if(game.SavedGame.SavedGameObj.data.CliffMonsterCave['Mirror'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
					){
						return "Try placing the broken mirror in the beam of light.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
					){
						return "Have a closer look at the raised pedestal in the center of chamber.";
					}else {
						return "Look around the geometric chamber, there's something that can be done there.";
					}
				}else{
					return MirrorText01();
				}
			}else{
				return MirrorText01();
			}
		}
		
		private function MirrorText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterCave'
			){
				return "Why not pick up the mirror?";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterMonster'
			){
				return "There's an item in this cave that can be picked up.";
			}else {
				return "Continue searching there are other items that can be picked up.";
			}
		}
		
		
		private function HominidSkullHint():String{
			if(game.SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'PickedUp'){
					return PirateSkullHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
						if(game.SavedGame.SavedGameObj.data.PirateCaptainsTable['SculptTools'] == 'PickedUp'){					
							if(game.SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
								if(game.SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'Opened'){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate'
									){
										return "Why not pick up the skull from the out of the sediment";
										
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigSupply' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDig'
									){
										return "There's an item in here that can be picked up.";
									}else {
										return "There's an item at the mountain side excavation that can be picked up.";
									}
									
								}else{
									return HominidSkullText01();
								}
							}else{
								return HominidSkullText01();
							}
						}else{
							return HominidSkullText02();
						}
					}else{
						return HominidSkullText02();
					}
				}
			}else{
				return "No hint at this time.";
			}
			
			
		}
		private function HominidSkullText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsTable'
			){
				return "Why not pick up the sculptor's tools from off the table";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting'
			){
				return "There's an item in here that can be picked up.";
			}else {
				return "There's an item inside the pirate captain's quarters waiting to be picked up.";
			}
		}
		
		private function HominidSkullText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate'
			){
				return "Try using the sculptor's tools to remove the skull from the layers of sediment";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigSupply' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDig'
			){
				return "Take a closer look at the wall of sediment holding the skull.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'
			){	
				return "Try the other excavation, further up the mountain side.";
			}else {
				return "Look around the archaeological  excavations, there's something to do.";
			}
		}
		
		private function PirateSkullHint():String{
			if(game.SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
				if(game.SavedGame.SavedGameObj.data.PirateCaptainsTable['Skull'] == 'PickedUp'){
					return AlienSkullHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsTable'
					){
						return "Why not pick up the skull from off the table";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptains' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsCouch' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'PirateCaptainsPainting'
					){
						return "There's an item in here that can be picked up.";
					}else {
						return "There's an item inside the pirate captain's quarters waiting to be picked up.";
					}
				}
			}
			else{
				return "No hint at this time.";
			}
			
		}
		
		
		private function AlienSkullHint():String{
			if(game.SavedGame.SavedGameObj.data.RavineDig != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'PickedUp'){
					return RedCrystalHint();
				}else{
					return AlienSkullText03();
				}
			}else{
				return AlienSkullText03();
			}
			
		}
		
		private function AlienSkullText03():String{
			if(game.SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainDigSupply['Trowel'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.RavineDig != undefined){
						if(game.SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'Opened'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'
							){
								return "Why not pick up the elongated skull?";
							}else{
								return "There's something that can be picked up from the dig at the foot of the mountain.";
							}
						}else{
							return AlienSkullText01();
						}
					}else{
						return AlienSkullText01();
					}
				}else{
					return AlienSkullText02();
				}
			}else{
				return AlienSkullText02();
			}
		}
		
		
		private function AlienSkullText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigSupply'
			){
				return "Why not pick up the trowel beside the boxes?";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDig'
			){
				return "There's an item here that can be picked up.";
				
			}else {
				return "There are items waiting to be found, continue the search.";
			}
		}
		
		private function AlienSkullText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'
			){
				return "Try using the trowel to remove the soil from the elongated skull";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavinePlane' 
			){
				return "Look around nearby for a place to use the trowel.";
			}else {
				return "Something can be done in the ravine at the foot of the mountain.";
			}
		}
		
		private function RedCrystalHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['Red'] == 'Attached'){
					return RedSkullHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
						if(game.SavedGame.SavedGameObj.data.CliffMonsterCave['Crystal'] == 'PickedUp'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
							){
								return "Try placing the red crystal into one of the holes on the surface of the stone.";
								
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
							){
								return "Have a closer look at the raised pedestal in the center of chamber, something can be done with the red crystal there.";
							}else {
								return "Look around the geometric chamber, there's something that can be done there.";
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterCave'
							){
								return "Try using the pick axe to remove the red crystal from the walls of the cave.";
								
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CliffMonsterMonster'
							){
								return "Have a look at the red crystal in here.";
							}else {
								return "Something can be done in the cave over the waterfall.";
							}
						}
					}else{
						return "No hint at this time.";
					}
				}
			}else{
				return "No hint at this time.";
			}
			
		}
		
		
		private function RedSkullHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberRedSkulls['Solved'] == 'Yes'){
					return SlideHint();
				}else{
					return RedSkullText03();
					
				}
			}else{
				return RedSkullText03();
			}
			
			
		}
		
		private function RedSkullText03():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
					return RedSkullText02();
					
				}else if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){								
					return RedSkullText02();
					
				}else if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){		
					return RedSkullText02();
					
				}else{
					return RedSkullText01();
				}
				
			}else{
				return "No hint at this time.";
			}
		}
		
		private function RedSkullText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls'
			){
				if(game.SavedGame.SavedGameObj.data.ChamberRedTriangle != undefined){
					if(game.SavedGame.SavedGameObj.data.ChamberRedTriangle['SeenIt'] == 'Yes'){
						return "Try placing the three different skulls in various arrangements in the alcoves.";
					}else{
						return "There are clues inside of this red chamber to help with the three triangular alcoves on the wall.";
					}
				}else{
					return "There are clues inside of this red chamber to help with the three triangular alcoves on the wall.";
					
				}
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
			){
				if(game.SavedGame.SavedGameObj.data.ChamberRedTriangle != undefined){
					if(game.SavedGame.SavedGameObj.data.ChamberRedTriangle['SeenIt'] == 'Yes'){
						return "Take a closer look at the three triangular alcoves on the wall";
					}else{
						return "There are clues inside of this red chamber to help with the three triangular alcoves on the wall.";
					}
				}else{
					return "There are clues inside of this red chamber to help with the three triangular alcoves on the wall.";
					
				}									
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism' 
				
			){							
				return "Head down into the red lit sub-chamber.";
			}else {
				return "There's something inside the geometric chamber in the center of the mountain.";
			}
		}
		
		private function RedSkullText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
			){
				return "Try moving the mirror into various positions so that a light beam strikes the red crystal.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
			){							
				return "Have a closer look at the raised pedestal in the center of the chamber, something amazing can be done there.";
			}else {
				return "There's something to do inside the geometric chamber in the center of the mountain.";
			}
			
		}
		
		private function SlideHint():String{
			if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.InvenPuzzle['SlideMade'] == 'yes'){
					return SolveMicroscope();
				}else{
					return SlimeText02();
				}
			}else{
				return SlimeText02();
			}
			
			
		}		
		
		private function SlimeText02():String{
			if(game.SavedGame.SavedGameObj.data.ChamberRedSkulls != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberRedSkulls['Slimed'] == 'Yes'){
					if(game.SavedGame.SavedGameObj.data.ChamberRedSkulls['Slime'] == 'PickedUp'){
						if(game.SavedGame.SavedGameObj.data.FreighterUpper != undefined){
							if(game.SavedGame.SavedGameObj.data.FreighterUpper["Glass"] == "PickedUp"){
								return "Try combining the slime with another item in the inventory to form a slide.";
							}else{
								return SlimeText01();
							}
						}else{
							return SlimeText01();
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls'){
							return "Grab some of the slime dripping from the wall.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
						){
							return "There's something in this place that could be useful";
							
						}else if(
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
						){							
							return "Head down into the sub-chamber with the three skulls, there's something there to pick up.";
						}else {
							return "There's something inside the geometric chamber in the center of the mountain.";
						}
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
						return SlimeText03();
					}else if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){								
						return SlimeText03();
					}else if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){							
						return SlimeText03();
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
						){
							return "Move the mirror on the pedestal so the light shines on the red crystal again.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
						){							
							return "Take another look at the raised pedestal in the center of the chamber, something amazing can be done there.";
						}else {
							return "There's something to do inside the geometic chamber in the center of the mountain.";
						}
					}
					
					
					
				}
			}else{
				return "No hint at this time.";
			}
		}
		
		private function SlimeText03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls'){
				return "Try pushing the glowing triangle.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
			){
				return "Take a closer look at the glowing green triangle.";
				
			}else if(
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
			){							
				return "Head down into the red lit sub-chamber, there's something there to do.";
			}else {
				return "There's something to do in the geometric chamber in the center of the mountain.";
			}
		}
		
		private function SlimeText01():String{
			
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterUpper'
			){
				return "There's something shining in the corner.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterWheel' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterSafe' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLocker' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterTable' 
				
			){							
				return "This is a good place to search for items.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterLower' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'FreighterOil' 
			){
				return "Try looking around the upper levels of the ship.";
				
			}else {
				return "Search around inside the freight ship, there's an item still to be found.";
			}
		}
		
		
		
		private function SolveMicroscope():String{
			if(game.SavedGame.SavedGameObj.data.LabMicroscope != undefined){
				if(game.SavedGame.SavedGameObj.data.LabMicroscope['Analyzed'] == 'Yes'){
					return AttachSatelliteHint();
				}else{
					return MircoscopeText02();
				}
			}else{
				return MircoscopeText02();
			}
			
		}
		private function MircoscopeText02():String{
			if(game.SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if(game.SavedGame.SavedGameObj.data.LabEquipment['MachineOn'] == 'Yes'){
					if(game.SavedGame.SavedGameObj.data.LabEquipment['Slide'] == 'Attached'){		
						
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope'
						){
							return "Try analyzing the slime now that all the equipment is set up.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' || 
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' || 
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer' 
							
						){							
							return "There's something that can be done with the microscope in this room.";
						}else {
							return "Time to conduct some research in the field laboratory.";
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment'
						){
							return "Try placing the slide under the microscope.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' || 
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
						){							
							return "Try taking another look at the microscope.";
						}else {
							return "Time to conduct some research in the field laboratory.";
						}
					}
				}else{
					return MicroscopeText01();
					
				}
			}else{
				return MicroscopeText01();
			}
		}
		
		
		private function MicroscopeText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment'
			){
				return "Doesn't the machine in the corner look interesting?";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' || 
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
			){							
				return "There are many pieces of equipment in this room that could be of use, try turning some on.";
			}else {
				return "Time to conduct some research in the field laboratory.";
			}
		}
		
		private function AttachSatelliteHint():String{
			if(game.SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineRoof['SatDish'] == 'Attached'){
					return UploadAlgoHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.RavineDrone != undefined){
						if(game.SavedGame.SavedGameObj.data.RavineDrone["Satellite"] == "PickedUp"){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineRoof'
							){
								return "Try connecting the satellite dish to the wires coming out of the tube.";
								
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
							){
								return "Try climbing up on to the roof of the laboratory, there's something that can be done.";
							}else {
								return "Head to the house in the ravine, there's something to be done on the roof.";
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDrone'
							){
								return "Try picking up the satellite dish from out of the nose of the aerial drone.";
								
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyonRear'
							){
								return "There's something here that can be picked up...";
							}else {
								return "There are more items to discover, keep up the search.";
							}
						}
						
					}else{
						return "No hint at this time";
					}
				}
			}else{
				return "No hint at this time";
			}
			
		}
		
		private function UploadAlgoHint():String{
			if(game.SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if(game.SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "Attached"){
					if(game.SavedGame.SavedGameObj.data.LabComputer != undefined){
						if(game.SavedGame.SavedGameObj.data.LabComputer['Files'] == 'Written'){
							return CleanHoseHint();
						}else{
							return AlgoText02();
						}
					}else{
						return AlgoText02();
					}
					
				}else{
					return AlgoText04();
				}
				
			}else{
				return AlgoText04();
			}
			
		}
		
		private function AlgoText04():String{
			if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsTable != undefined){
				if(game.SavedGame.SavedGameObj.data.SubmarineCaptainsTable['Floppy'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.LabComputer != undefined){
						if(game.SavedGame.SavedGameObj.data.LabComputer['Files'] == 'Written'){
							if(game.SavedGame.SavedGameObj.data.LabDesk != undefined){
								if(game.SavedGame.SavedGameObj.data.LabDesk["Disk"] == "PickedUp"){
									if(game.SavedGame.SavedGameObj.data.LabEquipment != undefined){
										if(game.SavedGame.SavedGameObj.data.LabEquipment["Disk"] == "Out"){
											if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment'
											){
												return "Try removing and reinserting the floppy disk into the machine in the corner.";
											}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine'){
												return "Have a look at this machine's hardware.";
											}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
											){
												return "Take another look at the machine in the corner, the floppy disk isn't properly inserted.";
											}else {
												return "Something can be done in the laboratory.";
											}
										}else{
											if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment'
											){
												return "Try inserting the floppy disk into the machine in the corner.";
											}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine'){
												return "Have a look at this machine's hardware.";
											}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
												game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
											){
												return "There's something that can be done with the machine in the corner.";
											}else {
												return "Something can be done in the laboratory.";
											}
										}
									}else{
										return "No hint at this time."
									}
								}else{
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
									){
										return "Try ejecting then picking up the floppy disk from the desktop computer tower.";
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'){
										return "Try ejecting then picking up the floppy disk from the desktop computer tower.";
										
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
									){
										return "There's something else that can be done with the floppy disk in this room.";
									}else {
										return "Something can be done in the laboratory.";
									}
								}
							}else{
								return AlgoText02();
							}
						}else{
							return AlgoText02();
						}
					}else{
						return AlgoText02();
					}
					
				}else{
					return AlgoText03();
				}
			}else{
				return AlgoText03();
			}
		}
		
		private function AlgoText03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsTable'
			){
				return "Try picking up the floppy disk next to the model tank.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptains' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsBed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineCaptainsComputer'
			){
				return "There's something in this room that can be picked up.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineConsole' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineSonar' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineLowerLevel' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarineTorpedos' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SubmarinePowerMain'
			){
				return "There be an item somewhere abord this undersea... underground.. vessel";
			}else {
				return "There are more items to be found. Continue the search.";
			}
		}
		
		private function AlgoText02():String{
			if(game.SavedGame.SavedGameObj.data.LabDesk != undefined){
				if(game.SavedGame.SavedGameObj.data.LabDesk["Disk"] == "Attached"){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
					){
						return "Use one of the computer programs to write the signal from the satellite on" +
							" to the floppy disk.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'){
						return "Try using some of the programs on the computer.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
					){
						return "There's something that can be done with a program on the desktop computer.";
					}else {
						return "Something can be done in the laboratory.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.LabDesk["Disk"] == "Out"){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'
						){
							return "Try removing and reinserting the floppy disk into the computer tower.";
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
						){
							return "Something can be done with the desktop computer tower in here, take a closer look.";
						}else {
							return "Something can be done in the laboratory.";
						}
					}else{
						return AlgoText01();
					}
				}
			}else{
				return "No hint at this time.";
			}
		}
		
		private function AlgoText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'
			){
				return "Try inserting the floppy disk into the computer tower.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
			){
				return "Something can be done with the desktop computer tower in here, take a closer look.";
			}else {
				return "Something can be done in the laboratory.";
			}
		}
		
		
		private function CleanHoseHint():String{
			if(game.SavedGame.SavedGameObj.data.InvenPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.InvenPuzzle['HoseCleaned'] == 'yes'){
					return AttachHoseHint();
				}else{
					return HoseCleanText01();
				}
			}else{
				return HoseCleanText01();
			}
			
			
		}
		
		private function HoseCleanText01():String{
			if(game.SavedGame.SavedGameObj.data.RavinePlane != undefined){
				if(game.SavedGame.SavedGameObj.data.RavinePlane['Hose'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.LabDesk != undefined){
						if(game.SavedGame.SavedGameObj.data.LabDesk["Alcohol"] == "PickedUp"){
							return "Try cleaning the dirty hose from the plane with the rubbing alcohol from " +
								"the medicine cabinet.";
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'
							){
								return "There's something in the medicine cabinet.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
							){
								return "There's an item that can be picked up here.";
							}else {
								return "There are more items to find. Keep looking.";
							}
						}
					}else{
						return "No hint at this time.";
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavinePlane'
					){
						return "Take a closer look at the plane's engine.";
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor'
					){
						return "There's an item to be found around here";
					}else {
						return "There are more items to find. Keep looking.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavinePlane'
				){
					return "Take a closer look at the plane's engine.";
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor'
				){
					return "There's an item to be found around here";
				}else {
					return "There are more items to find. Keep looking.";
				}
			}
		}
		
		private function AttachHoseHint():String{
			if(game.SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if(game.SavedGame.SavedGameObj.data.LabEquipment['Hose'] == 'Attached'){
					return MarbleHint();
				}else{
					return AttachHoseText01();
				}
			}else{
				return AttachHoseText01();
			}
			
		}
		private function AttachHoseText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment'
			){
				return "Try attaching the hose to the 'Output' of the machine in the corner.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine'){
				return "Have a look at this machine's hardware.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
			){
				return "There's something that can be done with the hose in this room.";
			}else {
				return "Look around for a place to use the hose.";
			}
		}
		
		
		private function MarbleHint():String{
			if(game.SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if(game.SavedGame.SavedGameObj.data.LabPrinter['Stone'] == 'Attached'){
					return AddMushroomHint();
				}else{
					return MarbleHintText01();
				}
			}else{
				return MarbleHintText01();
			}
			
		}		
		
		private function MarbleHintText01():String{
			if(game.SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
				if(game.SavedGame.SavedGameObj.data.MountainDigSupply['LidUnlocked'] == 'Yes'){
					if(game.SavedGame.SavedGameObj.data.MountainDigSupply['Marble'] == 'PickedUp'){
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter'
						){
							return "Try placing the five-sided piece of petrified wood onto one of the printer's surfaces.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
						){
							return "There's something that can be done with the 3d printer in here.";
						}else {
							return "There's something that can be done in the laboratory.";
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigSupply'
						){
							return "Why not pick up the object from inside the wooden box?";	
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDig'
						){
							return "There's an item here that can be picked up.";
						}else {
							return "There's an item on the dig site in the mountain that can be picked up.";
						}
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigSupply'
					){
						return "Try using the hammer to open the box.";	
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDigExcavate' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'MountainDig'
					){
						return "Take a closer look at the small wooden box.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'){
						return "Try searching the other excavation site, further up the mountain side.";	
					}else {
						return "Look around the dig sites, something can be done.";
					}
				}
			}else{
				return "No hint at this time.";
			}
		}
		
		
		private function AddMushroomHint():String{
			if(game.SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				if(game.SavedGame.SavedGameObj.data.LabDeskDetail["Mortar"] == "PickedUp"){
					return PourGooHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'mixed'){
						return "Why not pick up the bowl on that table in the laboratory?";
					}else{
						if(game.SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water_flower_mushroom'){
							if(game.SavedGame.SavedGameObj.data.RavineCanoe != undefined){
								if(game.SavedGame.SavedGameObj.data.RavineCanoe["Motor"] == "PickedUp"){
									if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
									){
										return "Try mixing the items in the bowl with the grinding pestle.";
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'){
										return "Take a closer look at the bowl on the table.";
									}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
										game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
									){
										return "There's something that can be done in this room.";
									}else {
										return "There's something to do in the laboratory.";
									}
								}else{
									return AddMushroomText01();
								}
							}else{
								return AddMushroomText01();
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.Jungle != undefined){
								if(game.SavedGame.SavedGameObj.data.Jungle["Flower"] == "PickedUp"){
									if(game.SavedGame.SavedGameObj.data.JungleStump != undefined){
										if(game.SavedGame.SavedGameObj.data.JungleStump["Mushroom"] == "PickedUp"){
											if(game.SavedGame.SavedGameObj.data.RavineCanoe != undefined){
												if(game.SavedGame.SavedGameObj.data.RavineCanoe["Gourd"] == "PickedUp"){
													
													if(game.SavedGame.SavedGameObj.data.CliffCave != undefined ||
														game.SavedGame.SavedGameObj.data.Cave != undefined ||
														game.SavedGame.SavedGameObj.data.CliffMonsterCave != undefined
													){
														if(game.SavedGame.SavedGameObj.data.CliffCave != undefined){	
															if(game.SavedGame.SavedGameObj.data.CliffCave['Gourd'] == 'Filled'){
																return AddMushroomText04();
															}else{
																return AddMushroomText06();
															}
														}else{
															return AddMushroomText06();
														}
														
													}else{
														return "No hint at this time.";
													}
												}else{
													return AddMushroomText05();
												}
											}else{
												return AddMushroomText05();
											}
											
										}else{
											return AddMushroomText03();
										}
									}else{
										return AddMushroomText03();
									}
								}else{
									return AddMushroomText02();
								}
							}else{
								return AddMushroomText02();
							}
						}
						
					}
				}
			}else{
				return "No hint at this time.";
			}
			
		}				
		private function AddMushroomText06():String{
			if(game.SavedGame.SavedGameObj.data.Cave != undefined){
				if(game.SavedGame.SavedGameObj.data.Cave['Gourd'] == 'Filled'){
					return AddMushroomText04();
				}else{
					if(game.SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
						if(game.SavedGame.SavedGameObj.data.CliffMonsterCave['Gourd'] == 'Filled'){
							return AddMushroomText04();
						}else{
							return "Search the island for a place to fill the hollow gourd with fresh water.";
						}
					}else{
						return "Search the island for a place to fill the hollow gourd with fresh water.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CliffMonsterCave != undefined){
					if(game.SavedGame.SavedGameObj.data.CliffMonsterCave['Gourd'] == 'Filled'){
						return AddMushroomText04();
					}else{
						return "Search the island for a place to fill the hollow gourd with fresh water.";
					}
				}else{
					return "Search the island for a place to fill the hollow gourd with fresh water.";
				}
			}
		}
		
		private function AddMushroomText05():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanoe'){
				return "Why not pick up the dried gourd beside the canoe.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyon' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyonWall' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle' 
			){
				return "There's an item to pick up around this area.";
			}else {
				return "There are other items waiting to be picked up on the island.";
			}
		}
		
		private function AddMushroomText04():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail'
			){
				return "Try adding different items to the bowl on the table.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk'){
				return "Take a closer look at the bowl on the table.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
			){
				return "There's something that can be done in this room.";
			}else {
				return "There's something to do in the laboratory.";
			}
		}
		
		private function AddMushroomText03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleStump'
			){
				return "Got Fungi?";	
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleStumpPuzzle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleEdge' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHole' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter'
			){
				return "There's a natural item to be found around here.";
			}else {
				return "Wander around the jungle and forest, there are natural items to discover.";
			}
		}
		
		private function AddMushroomText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Jungle'
			){
				return "Why not pluck a purple flower?";	
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleDeep' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleSubmarine'
			){
				return "There's a natural item to be found around here.";
			}else {
				return "Wander around the jungle and forest, there are natural items to discover.";
			}
		}
		
		private function AddMushroomText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanoe'){
				return "Why not pick up the griding pestle beside the canoe.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyon' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineCanyonWall' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineFreighter' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastJungle' 
			){
				return "There's an item to pick up around this area.";
			}else {
				return "There are other items waiting to be picked up on the island.";
			}
		}
		
		
		private function PourGooHint():String{
			if(game.SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if(game.SavedGame.SavedGameObj.data.LabPrinter['Goo'] == 'Attached'){
					return PrintHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter'
					){
						return "Try pouring the pink mush into the pyrex bowl.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
					){
						return "There's something that can be done with the 3d printer in here.";
					}else {
						return "There's something that can be done in the laboratory.";
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter'
				){
					return "Try pouring the pink mush into the pyrex bowl.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
				){
					return "There's something that can be done with the 3d printer in here.";
				}else {
					return "There's something that can be done in the laboratory.";
				}
			}
			
		}
		
		private function PrintHint():String{
			if(game.SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if(game.SavedGame.SavedGameObj.data.LabPrinter['Crystal'] == 'PickedUp'){
					return OpenSpaceDoorHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.LabEquipment != undefined){
						if(game.SavedGame.SavedGameObj.data.LabEquipment['Crystal'] == 'Printed'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter'
							){
								return "Why not pick up the green crystal?";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment'){
								return "Why not pick up the green crystal?";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
							){
								return "There's something on the printer to pick up.";
							}else {
								return "There's something in the laboratory that can be picked up.";
							}
						}else{
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMachine'
							){
								return "This is a good time to try and print.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabEquipment'){
								return "Try using the user interface of the machine in the corner";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Lab' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDesk' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabDeskDetail' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabPrinter' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabComputer'
							){
								return "Something can be done with the machine in the corner.";
							}else {
								return "There's something in the laboratory that can be picked up.";
							}
						}
					}else{
						return "No hint at this time.";
					}
				}
			}else{
				return "No hint at this time.";
			}
			
		}
		
		private function OpenSpaceDoorHint():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Solved'] == 'Yes'){
					return SpaceShipConsolHint();
				}else{
					return SpaceDoorMaster();
				}
			}else{
				return SpaceDoorMaster();
			}
			
		}
		
		private function SpaceDoorMaster():String{
			if(game.SavedGame.SavedGameObj.data.RavineDig != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineDig['Tricorder'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'PickedUp'){
						if(game.SavedGame.SavedGameObj.data.RavineRockFace != undefined){
							if(game.SavedGame.SavedGameObj.data.RavineRockFace['MessageOpen'] == 'Yes'){
								if(game.SavedGame.SavedGameObj.data.JungleVikingTVStatic != undefined){
									if(game.SavedGame.SavedGameObj.data.JungleVikingTVStatic["currentPage"] != undefined){
										if(game.SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
											if(game.SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['HandAttached'] == 'Yes'){
												if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipDoorPuzzle'
												){
													return "The symbols on this panel are like the ones on the TV aboard the " +
														"Viking ship, but arranged differently.";
												}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineRockFace'
												){
													return "These symbols also appear on the TV abord the longboat.";	
													
												}else {
													return "Compare the symbols on the rock face near the spaceship " +
														"with the pattern on the TV to reveal somthing about the spaceship's door puzzle.";
												}
											}else{
												return SpaceDoorPart05();
											}
										}else{
											return SpaceDoorPart05();
										}
									}else{
										return SpaceDoorPart04();
									}
								}else{
									return SpaceDoorPart04();
								}
							}else{
								return SpaceDoorPart02();
							}
						}else{
							return SpaceDoorPart02();
						}
					}else{
						if(game.SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'Opened'){
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'
							){
								return "Try picking up the hand now.";
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipPuzzle' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses'
							){
								return "There's an item around here that can be picked up.";
							}else {
								return "Look around the ravine, there's something that can be picked up.";
							}
						}else{
							return SpaceDoorPart03()
						}
					}
				}else{
					return SpaceDoorPart01();
				}
			}else{
				return SpaceDoorPart01();
			}
			
		}
		
		private function SpaceDoorPart01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'
			){
				return "Why not pick up the device buried in the sand?";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipPuzzle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses'
			){
				return "There's an item around here that can be picked up.";
			}else {
				return "Look around the ravine, there's an a useful item.";
			}
			
		}
		
		private function SpaceDoorPart02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineRockFace'
			){
				return "Try the futuristic device on the symbol.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipPuzzle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavinePlane' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses'
			){
				return "There's an a strange marking in this area that could be analyzed.";
			}else {
				return "Search for clues to help with the spacecraft's door.";
			}
		}
		
		private function SpaceDoorPart03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineDig'
			){
				return "The trowel can be used to remove the sediment from off of the hand bones.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipPuzzle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleHouses' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
			){
				return "There's an item around here that can be picked up.";
			}else {
				return "Look around the ravine, something can be picked up.";
			}
		}
		
		private function SpaceDoorPart04():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleViking' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingDeck' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTrunk' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingHead' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleVikingTV' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleDeep'
			){
				return "This is a good place to look for clues and information.";
			}else {
				return "Search the island, there are clues to be discovered.";
			}
		}
		
		private function SpaceDoorPart05():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipDoorPuzzle'){
				return "Try using the hand bones from the dig site on the door.";						
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
			){
				return "Take a closer look at the spacecraft.";
			}else {
				return "Try to find a place to use the hand bones found at the dig site.";
			}
		}
		
		private function SpaceShipConsolHint():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipConsole['Tricorder'] == 'Attached'){
					return SpaceShipPuzzleHint();
				}else{
					return SpaceShipConsoleText02();
				}
			}else{
				return SpaceShipConsoleText02();
			}
			
		}
		private function SpaceShipConsoleText02():String{
			if(game.SavedGame.SavedGameObj.data.RavineDig != undefined){
				if(game.SavedGame.SavedGameObj.data.RavineDig['Tricorder'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipConsole'){
						return "The hole in the console and futuristic sensor device are about the same size.";						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipInterior' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipOven'
					){
						return "Look around for a place to use the futuristic device found at the dig site.";
					}else {
						return "There's something that can be done aboard the spaceship.";
					}
					
					
				}else{
					return SpaceShipConsoleText01();
					
				}
			}else{
				return SpaceShipConsoleText01();
			}
		}
		
		private function SpaceShipConsoleText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipConsole'){
				return "Try using the hand bones from the dig site on the door.";						
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShip' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'RavineSpaceShipDoor' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'JungleRavine'
			){
				return "Take a closer look at the spacecraft.";
			}else {
				return "Try to find a place to use the hand bones found at the dig site.";
			}
		}
		
		
		private function SpaceShipPuzzleHint():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){				
				if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle['Solved'] == 'Yes'){
					return SpaceShipOvenOnHint();
				}else{
					return SpaceShipPuzzleText01();
				}
			}else{
				return SpaceShipPuzzleText01();
			}
		}
		private function SpaceShipPuzzleText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipPuzzle'){
				return "Try turning the dials until each open circle overlaps with another circle.";						
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipConsole' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipOven'
			){
				return "Try interfacing with the ship control system, it can be unlocked.";
			}else {
				return "There's something to do inside the spaceship.";
			}
		}
		
		
		private function SpaceShipOvenOnHint():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] == 'Yes'){
					return UseSpaceShipOvenHint();
				}else{
					return SpaceShipOvenOnText01();
				}
			}else{
				return SpaceShipOvenOnText01();
			}
			
		}
		private function SpaceShipOvenOnText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipPuzzle'){
				return "Try pressing buttons... just avoid the anti-matter containment protocals.";						
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipConsole' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipOven'
			){
				return "Try interfacing with the ship control system, there's more to do inside.";
			}else {
				return "There's something to do aboard the spaceship.";
			}
		}
		
		private function UseSpaceShipOvenHint():String{
			if(game.SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
				if(game.SavedGame.SavedGameObj.data.SpaceShipOven['Plasma'] == 'PickedUp'){
					return GreenChamberHint();
				}else{
					return UseOvenMaster();
				}
			}else{
				return UseOvenMaster();
			}
			
		}
		
		
		private function UseOvenMaster():String{
			if(game.SavedGame.SavedGameObj.data.CavePirateChest != undefined){
				if(game.SavedGame.SavedGameObj.data.CavePirateChest['Iridium'] == 'PickedUp'){
					if(game.SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
						if(game.SavedGame.SavedGameObj.data.SpaceShipOven['Bar'] == 'Attached'){
							
							if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipOven'){
								return "Try using the controls and closing the door to activate the machine.";						
							}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipConsole' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipInterior' ||
								game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipPuzzle'
							){
								return "Take a closer look at the device toward the rear of the craft.";
							}else {
								return "There's something to do aboard the spaceship.";
							}
							
							
						}else if(game.SavedGame.SavedGameObj.data.SpaceShipOven['Bar'] == 'Processed'){
							return "Why not pick up the transformed metal inside of the machine aboard the space ship?";
						}else{
							
							return UseOvenText02();
						}
					}else{
						return UseOvenText02();
					}
					
				}else{
					return UseOvenText01();
				}
			}else{
				return UseOvenText01();
			}
		}
		
		private function UseOvenText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateChest'){
				return "Why not pick up the shining bar in the chest?";						
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateEnclave' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateBarrels' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirate' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CavePirateDitch'
			){
				return "There's something in this area that can be picked up.";
			}else {
				return "Look in the cave surrounding the pirate ship, there's an item still to be picked up.";
			}
		}
		
		private function UseOvenText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipOven'){
				return "Try placing the bar of iridium inside this machine.";						
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipConsole' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipInterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'SpaceShipPuzzle'
			){
				return "Take a closer look at the device toward the rear of the craft.";
			}else {
				return "There's something to do aboard the spaceship.";
			}
		}
		
		private function GreenChamberHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberGreen != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberGreen['Crystal'] == 'PickedUp'){	
					return NautilusAttachHint();
				}else{
					return ChamberGreenMaster();
				}
			}else{
				return ChamberGreenMaster();
			}
			
			
		}
		
		private function ChamberGreenMaster():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['Green'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.ChamberGreen != undefined){
						if(game.SavedGame.SavedGameObj.data.ChamberGreen['Blue'] == 'Showing'){
							return "Why not pick up the blue crystal from the wall of the green chamber?";
						}else{
							return ChamberGreenText05();
						}
					}else{
						return ChamberGreenText05();
					}
					
				}else{
					return ChamberGreenText01();
				}
			}else{
				return "No hint at this time";
			}
		}
		
		private function ChamberGreenText05():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 0){
				return ChamberGreenText02();
			}else if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 1){
				return ChamberGreenText02();
			}else{
				if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
				){
					return "Try moving the mirror into various positions so that a light beam strikes the green crystal.";
					
				}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
					game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
				){							
					return "Have a closer look at the raised pedestal in the center of chamber, something can be done there.";
				}else {
					return "There's something to do inside the geometric chamber in the center of the mountain.";
				}
			}
		}
		
		private function ChamberGreenText04():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree'
			){
				return "Try placing the animated metal onto the stone's surface";										
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen'){
				return "Have a closer look at the large dodecahedron emerging out of the chamber floor.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
			){							
				return "Head to the green chamber with the tree shaped etching, there something there.";
			}else {
				return "There's something to do inside the geometric chamber in the center of the mountain.";
			}
		}
		
		private function ChamberGreenText03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen'
			){
				return "Pick up the blue crystal from out of the wall.";										
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree'){
				return "There's something in this chamber to pick up.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
			){							
				return "Head to the chamber with the tree shaped etching, there's something to do there.";
			}else {
				return "There's something to do inside the geometric chamber in the center of the mountain.";
			}
		}
		
		private function ChamberGreenText02():String{
			if(game.SavedGame.SavedGameObj.data.ChamberGreenTree != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberGreenTree['Plasma'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.ChamberGreenTree['Solved'] == 'Yes'){
						return ChamberGreenText03();
					}else{
						return "No hint at this time.";
					}
				}else{
					return ChamberGreenText04();
				}
			}else{
				return ChamberGreenText04();
			}
			
			
		}
		
		private function ChamberGreenText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
			){
				return "Try placing the green crystal into one of the holes on the rock's surface.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
			){							
				return "Have a closer look at the raised pedestal in the center of the chamber, something amazing can be done there.";
			}else {
				return "There's something to do inside the geometric chamber in the center of the mountain.";
			}
		}
		
		
		private function NautilusAttachHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus['Shell'] == 'Attached'){
					return ChamberBlueHint();
				}else{
					if(game.SavedGame.SavedGameObj.data.CoastSkeleton != undefined){			
						if(game.SavedGame.SavedGameObj.data.CoastSkeleton["Shell"] == "PickedUp"){
							return NautAttaachText02();
						}else{
							return NautAttaachText01();
						}
					}else{
						return NautAttaachText01();
					}
				}
			}else{
				if(game.SavedGame.SavedGameObj.data.CoastSkeleton != undefined){			
					if(game.SavedGame.SavedGameObj.data.CoastSkeleton["Shell"] == "PickedUp"){
						return NautAttaachText02();
					}else{
						return NautAttaachText01();
					}
				}else{
					return NautAttaachText01();
				}
			}
			
		}
		private function NautAttaachText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus'
			){
				return "The grooves bear a resemblence to a shell.";							
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue'){
				return "Take a closer look in the center of the spiral form in this chamber.";
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
			){							
				return "Something can be done in the upper most chamber of this cavern.";
			}else {
				return "There's something to do inside the geometric chamber in the center of the mountain.";
			}
		}
		
		private function NautAttaachText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastSkeleton'
			){
				return "Why not pick up the nautilus shell?";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveExterior' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCave' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCaveBox' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastMoai' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastMoaiEyes' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'CoastCorner' 
			){							
				return "There's an item nearby that can be picked up.";
			}else {
				return "There is another item that must be found.";
			}
		}
		
		
		
		private function ChamberBlueHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberBlueNautilus['Solved'] == 'Yes'){
					return WhiteCrystalHint();
				}else{
					return ChamberBlueTextMaster();
				}
			}else{
				return ChamberBlueTextMaster();
			}
			
		}
		private function ChamberBlueTextMaster():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['Blue'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){
						return ChamberBlueText03();
					}else if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 4){
						return ChamberBlueText03();
					}else{
						return ChamberBlueText02();
					}
				}else{
					return ChamberBlueText01();
				}
			}else{
				return ChamberBlueText01();
			}
		}
		
		private function ChamberBlueText03():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus'
			){
				return "A similar pattern was found while doing research in the laboratory.";							
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'LabMicroscope'){
				return "The molecules here form a multicolored spiral pattern.";
			}else{
				return "Try working on the spiral form in the blue geometric chamber.";
				
			}
		}
		
		private function ChamberBlueText02():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
			){
				return "Position the mirror so the blue crystal is illuminated.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
			){							
				return "Have a closer look at the raised pedestal in the center of the chamber, something can be done there.";
			}else {
				return "There's something to do inside the geometric chamber in the center of the mountain.";
			}
		}
		
		
		private function ChamberBlueText01():String{
			if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
			){
				return "Try placing the blue crystal into one of the holes on the rock's surface.";
				
			}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
				game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
			){							
				return "Have a closer look at the raised pedestal in the center of the chamber, something can be done there.";
			}else {
				return "There's something to do inside the geometric chamber in the center of the mountain.";
			}
		}
		
		private function WhiteCrystalHint():String{
			if(game.SavedGame.SavedGameObj.data.ChamberBlue != undefined){		
				if(game.SavedGame.SavedGameObj.data.ChamberBlue['Crystal'] == 'PickedUp'){
					return WhiteCrystalText01();
				}else{
					return "Why not pick up the white crystal from inside the uppermost geometric chamber.";
				}
			}else{
				return "Why not pick up the white crystal from inside the uppermost geometric chamber.";
			}
			
			
		}
		
		private function WhiteCrystalText01():String{
			if(game.SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if(game.SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
					if(game.SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
						return FinalHint();
					}else{
						if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
						){
							return "Position the mirror so to illuminate all the crystals.";
							
						}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
							game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
						){							
							return "Have a closer look at the raised pedestal in the center of the chamber, something can be done there.";
						}else {
							return "There's something to do inside the geometric chamber in the center of the mountain.";
						}
					}
				}else{
					if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberPrism'
					){
						return "Try placing the white crystal into the last remaining hole on the rock's surface.";
						
					}else if(game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'Chamber' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlue' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberBlueNautilus' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreen' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberGreenTree' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRed' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedSkulls' ||
						game.SavedGame.SavedGameObj.data.CurrentRoomClass == 'ChamberRedTriangle'
					){							
						return "Ascend to the pedestal in the center of the great chamber.";
					}else {
						return "There's something to do inside the geometric chamber in the center of the mountain.";
					}
				}
			}else{
				return "No hint at this time.";
			}
		}
		
		private function FinalHint():String{
			return "The portal...";
		}
	}
}









