package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class CoastCave extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var door:Image;
		private var door_cylander:Image;
		private var sticks_and_logs:Image;
		private var box_lid:Image;
		private var box_celtic:Image;
		private var burning_logs:Image;
		
		private var fire_mc:MovieClip;
		
		private var hit_fire:Shape;
		private var hit_door:Shape;
		private var hit_box:Shape;
		private var hit_cave:Shape;
		private var hit_lanter:Shape;
		private var hit_rock:Shape;
		
		private var doorOpen:Boolean = false;
		private var doorSolve:Boolean = false;
		private var fireLit:Boolean = false;
		private var logsAttached:Boolean = false;
		private var sticksAttached:Boolean = false;
		
		
		private var Animating:Boolean = false;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CoastCave(_assets:AssetManager,_game:Game)
		{
			super();
			//	this.assets = new AssetManager();
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('coastCave_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCave/coastCave_bg.jpg'));
				game.TrackAssets('coastCave_01');
			}
			if(game.CheckAsset('coastCave_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCave/CoastCave_SpriteSheet.png'));
				game.TrackAssets('coastCave_02');
			}
			if(game.CheckAsset('coastCave_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCave/CoastCave_SpriteSheet.xml'));
				game.TrackAssets('coastCave_03');
			}
			if(game.CheckAsset('coastCave_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCave/Fire_SpriteSheet.png'));
				game.TrackAssets('coastCave_04');
			}
			if(game.CheckAsset('coastCave_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCave/Fire_SpriteSheet.xml'));
				game.TrackAssets('coastCave_05');
			}
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastCave","CoastCaveObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			//if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
			//	SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;
			//}
			//SaveArray['Door'] = 'n0'; 
			
			bg = new Image(this.assets.getTexture('coastCave_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			door = new Image(this.assets.getTexture('door_door'));
			door.touchable = false;
			door.x = 64;
			door.y = 44;
			
			
			
			door_cylander = new Image(this.assets.getTexture('door_comboLock_missingOne'));
			door_cylander.touchable = false;
			door_cylander.x = 230;
			door_cylander.y = 106;
		
				
			burning_logs = new Image(this.assets.getTexture('buring_logs'));
			burning_logs.touchable = false;
			burning_logs.x = 142;
			burning_logs.y = 266;
			
						
			sticks_and_logs = new Image(this.assets.getTexture('sticks'));
			sticks_and_logs.touchable = false;
			sticks_and_logs.x = 309;
			sticks_and_logs.y = 270;
			
						
			box_lid = new Image(this.assets.getTexture('box_open'));
			box_lid.touchable = false;
			box_lid.x = 500;
			box_lid.y = 223;
			
			
			box_celtic = new Image(this.assets.getTexture('box_celtic'));
			box_celtic.touchable = false;
			box_celtic.x = 535;
			box_celtic.y = 249;
			
			
			fire_mc = new MovieClip(this.assets.getTextures('fire_'),6);
			
			fire_mc.x = 316;
			fire_mc.y = 242;
			fire_mc.touchable = false;
			fire_mc.loop = true; // default: true
			fire_mc.stop();
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveDoor['ComboLock'] == 'Attached'){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Third'] == 'Attached'){
							door_cylander.texture = this.assets.getTexture('door_comboLock');
							door_cylander.alpha = 1;
						}else{
							door_cylander.alpha = 1;
						}						
						
						
					}else{
						door_cylander.alpha = 1;
					}
				}else{
					door_cylander.alpha = 0;
				}
			}else{
				door_cylander.alpha = 0;
			}
			
		
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
				trace("1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Solved'] == 'Yes'){
					trace("2");
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
						trace("3");
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Door'] == 'open'){
							trace("4");
							door.alpha = 0;
							door_cylander.alpha = 0;
							doorSolve = true;
							doorOpen = true;
							CreateCaveHit();
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Door'] == 'closed'){
							trace("5");
							door.alpha = 1;
							door_cylander.alpha = 1;
							doorSolve = true;
							doorOpen = false;
							
						}else{
							trace("6");
							Animating = true;
							doorOpen = false;
							doorSolve = true;
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;
							}
							SaveArray['Door'] = 'open'; 
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);	
							Starling.juggler.delayCall(OpenDoor,2);
						}
					}else{
						trace("7");
						Animating = true;
						doorOpen = false;
						doorSolve = true;
						
						SaveArray['Door'] = 'open'; 	
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);	
						Starling.juggler.delayCall(OpenDoor,2);
					}
				}else{
					trace("8");
					door.alpha = 1;
				
				}
			}else{
				trace("9");
				door.alpha = 1;
				
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
				trace("3");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					burning_logs.alpha = 1;
					sticks_and_logs.alpha = 0;
					fire_mc.alpha = 1;
					fire_mc.play();
					Starling.juggler.add(fire_mc);
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'LogsAndSticks'){
					burning_logs.alpha = 0;
					sticks_and_logs.texture = this.assets.getTexture('sticks_and_logs');
					sticks_and_logs.alpha = 1;
					fire_mc.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Logs'){
					burning_logs.alpha = 0;
					sticks_and_logs.texture = this.assets.getTexture('logs');
					sticks_and_logs.alpha = 1;
					fire_mc.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Sticks'){
					burning_logs.alpha = 0;
					sticks_and_logs.texture = this.assets.getTexture('sticks');
					sticks_and_logs.alpha = 1;
					fire_mc.alpha = 0;
				}else{
					burning_logs.alpha = 0;
					sticks_and_logs.alpha = 0;
					fire_mc.alpha = 0;
				}
			}else{
				burning_logs.alpha = 0;
				sticks_and_logs.alpha = 0;
				fire_mc.alpha = 0;
			}
				
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Celtic'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Lid'] == 'open'){
						box_celtic.alpha = 0;
						box_lid.alpha = 1;
					}else{
						box_celtic.alpha = 1;
						box_lid.alpha = 0;
					}
				}else{
					box_lid.alpha = 0;
					box_celtic.alpha = 0;
				}
			}else{
				box_lid.alpha = 0;
				box_celtic.alpha = 0;
			}
			

			
			this.addChildAt(door,1);
			this.addChildAt(door_cylander,2);
			this.addChildAt(burning_logs,3);
			this.addChildAt(sticks_and_logs,4);
			this.addChildAt(box_lid,5);
			this.addChildAt(box_celtic,6);
			this.addChildAt(fire_mc,7);
			
		//	Starling.juggler.add(fire_mc);
			
			
			CreateFireHit();
			CreateBoxHit();
			CreateDoorHit(doorOpen);
			CreateLanterHit();
			CreateRockHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDripsStream",0,0.7,'stop');
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
					},0.5);
					
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			}
			
			
			
		}
		
		private function OpenDoor():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoorTwo();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_HeavyStoneDrag();
			door.alpha = 0;
			door_cylander.alpha = 0;
			Animating = false;
			doorOpen = true;
			hit_door.graphics.clear()
			CreateDoorHit(true);
			CreateCaveHit();
			if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).MusicObj.LoadBeatNowOne(true,2);	
				},1);
			}
			
		}
		
		private function CreateDoorHit(open:Boolean = false):void{
			hit_door = new Shape();
			hit_door.touchable = false;
			
			if(open === false){
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x0000FF);
				hit_door.graphics.lineTo(78,80);	
				hit_door.graphics.lineTo(126,35);	
				hit_door.graphics.lineTo(276,39);	
				hit_door.graphics.lineTo(290,225);	
				hit_door.graphics.lineTo(270,246);	
				hit_door.graphics.lineTo(245,254);	
				hit_door.graphics.lineTo(100,249);	
				hit_door.graphics.lineTo(92,227);	

				hit_door.graphics.endFill(false);
				
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x00FF00);		
				hit_door.graphics.lineTo(59,70);
				hit_door.graphics.lineTo(85,36);
				hit_door.graphics.lineTo(112,38);
				hit_door.graphics.lineTo(139,251);
				hit_door.graphics.lineTo(125,277);
				hit_door.graphics.lineTo(106,280);
				hit_door.graphics.lineTo(60,144);

				hit_door.graphics.endFill(false);
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;				
			}
			this.addChild(hit_door);
			
		}		
		
		//hit_lanter
		
		private function CreateRockHit():void{
			hit_rock = new Shape();
			hit_rock.touchable = false;
			hit_rock.graphics.beginFill(0xff0000);
			
			hit_rock.graphics.lineTo(354,38);	
			hit_rock.graphics.lineTo(391,3);	
			hit_rock.graphics.lineTo(595,10);	
			hit_rock.graphics.lineTo(666,138);	
			hit_rock.graphics.lineTo(596,209);	
			hit_rock.graphics.lineTo(342,178);	
			
			hit_rock.graphics.endFill(false);
			
			hit_rock.alpha = 0.0;
			
			hit_rock.graphics.precisionHitTest = true;	
			this.addChild(hit_rock);
		}
		
		private function CreateLanterHit():void{
			hit_lanter = new Shape();
			hit_lanter.touchable = false;
			hit_lanter.graphics.beginFill(0xff0000);
			
			hit_lanter.graphics.lineTo(561,352);	
			hit_lanter.graphics.lineTo(590,320);	
			hit_lanter.graphics.lineTo(633,323);	
			hit_lanter.graphics.lineTo(713,360);	
			hit_lanter.graphics.lineTo(675,445);	
			
			hit_lanter.graphics.endFill(false);
			
			hit_lanter.alpha = 0.0;
			
			hit_lanter.graphics.precisionHitTest = true;	
			this.addChild(hit_lanter);
		}
		
		private function CreateBoxHit():void{
			hit_box = new Shape();
			hit_box.touchable = false;
			hit_box.graphics.beginFill(0xff0000);
			
			hit_box.graphics.lineTo(472,302);	
			hit_box.graphics.lineTo(469,241);	
			hit_box.graphics.lineTo(493,214);	
			hit_box.graphics.lineTo(610,224);	
			hit_box.graphics.lineTo(621,246);	
			hit_box.graphics.lineTo(626,298);	
			hit_box.graphics.lineTo(602,319);	
			hit_box.graphics.lineTo(531,328);	
			
			hit_box.graphics.endFill(false);
			
			hit_box.alpha = 0.0;
			
			hit_box.graphics.precisionHitTest = true;	
			this.addChild(hit_box);
		}
		
		
		private function CreateFireHit():void{
			hit_fire = new Shape();
			hit_fire.touchable = false;
			hit_fire.graphics.beginFill(0xff0000);
			
			hit_fire.graphics.lineTo(233,336);	
			hit_fire.graphics.lineTo(324,261);	
			hit_fire.graphics.lineTo(390,254);	
			hit_fire.graphics.lineTo(521,346);	
			hit_fire.graphics.lineTo(510,419);	
			hit_fire.graphics.lineTo(470,437);	
			hit_fire.graphics.lineTo(279,423);	

			hit_fire.graphics.endFill(false);
			
			hit_fire.alpha = 0.0;
			
			hit_fire.graphics.precisionHitTest = true;	
			this.addChild(hit_fire);
		}
		
		
		private function CreateCaveHit():void{
			hit_cave = new Shape();
			hit_cave.touchable = false;
			hit_cave.graphics.beginFill(0xff0000);
			
			hit_cave.graphics.lineTo(121,78);	
			hit_cave.graphics.lineTo(243,85);	
			hit_cave.graphics.lineTo(254,227);	
			hit_cave.graphics.lineTo(141,238);	

			hit_cave.graphics.endFill(false);
			
			hit_cave.alpha = 0.0;
			
			hit_cave.graphics.precisionHitTest = true;	
			this.addChild(hit_cave);
		}

		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					trace("Animating: "+Animating)
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CoastCaveExterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveExteriorObj,true
							);
						}else if(hit_box.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((CoastCaveBox as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveBoxObj,true
							);
						}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rock is cold.");
						
						}else if(hit_lanter.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The lantern is weathered beyond use.");
						}else if(hit_fire.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FireHandler();
						}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(doorOpen === false){	
								trace("1");
								if(doorSolve === false){
									trace("2");
									FadeOut((CoastCaveDoor as Class), 
										(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveDoorObj,true
									);
								}else{
									trace("3");
									door.alpha = 0;
									door_cylander.alpha = 0;
									hit_door.graphics.clear()
									CreateDoorHit(true);
									doorOpen = true;
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
										SaveArray= (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;
									}
									SaveArray['Door'] = 'open'; 
									
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);	
								}
							}else{
								trace("4");
								door.alpha = 1;
								door_cylander.alpha = 1;
								hit_door.graphics.clear()
								doorOpen = false;
								CreateDoorHit(false);
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
									SaveArray= (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;
								}
								SaveArray['Door'] = 'closed'; 
								
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);	
								
							}
						}
						else if(doorOpen === true){	
							if(hit_cave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((Cave as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.CaveObj,true
								);
							}
						}
					}
					
				}
			}
		}
		
		private function FireHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_TorchTar)
						
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_TorchBurning,
							'item_TorchBurning',
							'inven_torchBurning_sm',
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_TorchTar,
							'item_TorchTar'
						);
						
						//Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
						//},0.1);
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
						}
						SaveArray['TorchTar'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
						
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Torch)
						
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cloth will burn away too quickly. To make an effective torch, I must apply an agent to the cloth to keep the flame going.");
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_CannonTorch)
						
					{
						trace("Cannon Torch is Armed");
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CannonTorchBurning,
							'item_CannonTorchBurning',
							'inven_cannonTorchBurning_sm',
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CannonTorch,
							'item_CannonTorch'
						);
						//Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
						//},0.5);
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
							}
							SaveArray['CannonTorch'] = 'Yes';
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
							
						
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fire is warm and burning steadily.");
					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'LogsAndSticks'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_FlintAndMarcasite)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Match();
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_FlintAndMarcasite,
								"item_FlintAndMarcasite"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
						}
						SaveArray['Fire'] = 'Lit';
						burning_logs.alpha = 1;
						sticks_and_logs.alpha = 0;
						fire_mc.alpha = 1;
						fire_mc.play();
						Starling.juggler.add(fire_mc);
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
						},0.5);
						
						//sticks_and_logs.texture = this.assets.getTexture('sticks_and_logs');
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
						(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadPianoOne(true,2);	
							},1);
						}
						
					}else{
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fire is burning steadily.");
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should try to light this.");

						}
					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Sticks'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Logs)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Logs,
								"item_Logs"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
						}
						SaveArray['Fire'] = 'LogsAndSticks';
						sticks_and_logs.texture = this.assets.getTexture('sticks_and_logs');
						sticks_and_logs.alpha = 1;
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_FlintAndMarcasite)
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sticks alone will burn too quickly by themselves. I need to add something more substantial to build a lasting fire.");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("More substantial pieces of wood are needed for a lasting fire.");

					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Logs'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Sticks)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Sticks,
								"item_Sticks"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
						}
						SaveArray['Fire'] = 'LogsAndSticks';
						sticks_and_logs.texture = this.assets.getTexture('sticks_and_logs');
						sticks_and_logs.alpha = 1;
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_FlintAndMarcasite)
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The logs are too difficult to ignite by themselves. I need something easier to catch the sparks with.");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some small sticks will help the logs to catch fire.");

					}
				}else{
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Sticks)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Sticks,
								"item_Sticks"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
						}
						SaveArray['Fire'] = 'Sticks';
						sticks_and_logs.texture = this.assets.getTexture('sticks');
						sticks_and_logs.alpha = 1;
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Logs)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Logs,
								"item_Logs"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
						}
						SaveArray['Fire'] = 'Logs';
						sticks_and_logs.texture = this.assets.getTexture('logs');
						sticks_and_logs.alpha = 1;
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
						
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A fire pit, formed by a circle of rocks.");

					}
				}
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Sticks)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Sticks,
							"item_Sticks"
						);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
					}
					SaveArray['Fire'] = 'Sticks';
					sticks_and_logs.texture = this.assets.getTexture('sticks');
					sticks_and_logs.alpha = 1;
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Logs)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Logs,
							"item_Logs"
						);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave;			
					}
					SaveArray['Fire'] = 'Logs';
					sticks_and_logs.texture = this.assets.getTexture('logs');
					sticks_and_logs.alpha = 1;
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCave',SaveArray);
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A fire pit, formed by a circle of rocks.");

				}
			}
		}
		
		private function FadeOut(loadClass:Class,loadObj:Object,Fade:Boolean = false):void{
			trace("FADE OUT");
			this.removeEventListener(TouchEvent.TOUCH,TouchHandler);
			
			//goBackButton.touchable = false;
			this.touchable = false;
			if(Fade === false){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(1,0.5,this.Exit);
				(stage.getChildAt(0) as Object).screenGamePlayHandler.
					LoadScene(
						loadClass, 
						loadObj
					);		
			}else{
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.
					LoadSceneAlphaFade(
						loadClass, 
						loadObj,
						this.Exit
					);				
			}
			
		}
		
		public function Exit(blackOut:Boolean = false):void{
			
			
			this.removeChild(goback);
			goback = null;			
			
			
			this.assets.removeTexture("coastCave_bg",true);
			this.assets.removeTexture("coastCave_bg",true);
			this.assets.removeTexture("coastCave_bg",true);
			this.assets.removeTextureAtlas("CoastCave_SpriteSheet",true);
			this.assets.removeTexture("Fire_SpriteSheet",true);
			this.assets.removeTextureAtlas("Fire_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("coastCave_01");
			(stage.getChildAt(0) as Object).falseAsset("coastCave_02");
			(stage.getChildAt(0) as Object).falseAsset("coastCave_03");
			(stage.getChildAt(0) as Object).falseAsset("coastCave_04");
			(stage.getChildAt(0) as Object).falseAsset("coastCave_05");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
		
	}
}