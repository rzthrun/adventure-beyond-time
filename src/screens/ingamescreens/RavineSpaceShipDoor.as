package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class RavineSpaceShipDoor extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var door:Image;
		private var panel:Image;
		
		private var hit_door:Shape;
		private var hit_plank:Shape;
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var hit_ship:Shape;
		private var hit_stone:Shape;
		private var hit_rock:Shape;
		private var PhraseCounter:int = 0;
		
		private var Animating:Boolean = false
		private var DoorOpen:Boolean = false;
		private var delayedCall:DelayedCall;
		private var goback:GoBackButton;
		
		public function RavineSpaceShipDoor(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineSpaceShipDoor_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineSpaceShipDoor/ravineSpaceShipDoor_bg.jpg'));
				game.TrackAssets('ravineSpaceShipDoor_01');
			}
			if(game.CheckAsset('ravineSpaceShipDoor_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineSpaceShipDoor/RavineSpaceShipDoor_Sprite.atf'));
				game.TrackAssets('ravineSpaceShipDoor_02');
			}
			if(game.CheckAsset('ravineSpaceShipDoor_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineSpaceShipDoor/RavineSpaceShipDoor_Sprite.xml'));
				game.TrackAssets('ravineSpaceShipDoor_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineSpaceShipDoor","RavineSpaceShipDoorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineSpaceShipDoor_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			panel = new Image(this.assets.getTexture('panel'));
			panel.smoothing = TextureSmoothing.NONE;

			panel.touchable = false;
			panel.x = 269;
			panel.y = 88;
			
			door = new Image(this.assets.getTexture('door_open'));
			door.smoothing = TextureSmoothing.NONE;

			door.touchable = false;
			door.x = 129;
			door.y = 20;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Solved'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor['Door'] == 'Open'){
							DoorOpen = true;
							panel.alpha = 0;
							door.alpha = 1;
							CreatePlankHit();
						}else{
							Animating = true;
							DoorOpen = true;
							panel.alpha = 1;
							door.alpha = 0;
							CreatePlankHit();
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor;	
							SaveArray['Door'] = 'Open';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineSpaceShipDoor',SaveArray);
							
							delayedCall = new DelayedCall(function():void{
								openDoor();
							},2);
							Starling.juggler.add(delayedCall);
						}
					}else{
						Animating = true;
						DoorOpen = true;
						panel.alpha = 1;
						door.alpha = 0;
						CreatePlankHit();
						SaveArray['Door'] = 'Open';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineSpaceShipDoor',SaveArray);
						
						delayedCall = new DelayedCall(function():void{
							openDoor();
						},2);
						Starling.juggler.add(delayedCall);
					}
				}else{
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['HandAttached'] == 'Yes'){
						panel.alpha = 1;
						door.alpha = 0;
					}else{
						panel.alpha = 0;
						door.alpha = 0;
					}
				}
				
			}else{
				panel.alpha = 0;
				door.alpha = 0;
			}
			
		
			
			this.addChildAt(panel,1);
			this.addChildAt(door,2);
			//FadeOutOcean(1);
			CreateStoneHit();
			CreateRockHit();
			CreateShipHit();
			CreateDoorHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("SpaceHum",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("SpaceHumPower",0,0.5,'stop');

			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineSpaceShipDoor',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,1);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineSpaceShipDoor',SaveArray);
					Starling.juggler.delayCall(function():void{
						
						(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,1);
					},0.5);
				}
			}
		//(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Crows",((stage.getChildAt(0) as Object).MusicObj.globalVol),1.0);

			
		}
		
		
		private function openDoor():void{
			
			
			game.SoundFXObj.PlaySFX_AirRelease();		
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,1.0,'stop');
				game.SoundFXObj.PlaySFX_CosmicDoor();
				game.SoundFXObj.PlaySFX_EnergyPulse();
				panel.alpha = 0;
				door.alpha = 1;
				Animating = false;
			},3);
			
			
			//	game.MusicObj.LoadTheThing(true,1,2);
			
			
			
		}
		
		private function CreateStoneHit():void{
			hit_stone = new Shape();
			hit_stone.touchable = false;
			hit_stone.graphics.beginFill(0xff0000);
			
			hit_stone.graphics.lineTo(430,265);	
			hit_stone.graphics.lineTo(447,163);	
			hit_stone.graphics.lineTo(504,60);	
			hit_stone.graphics.lineTo(640,28);	
			hit_stone.graphics.lineTo(745,292);	
			
			hit_stone.graphics.endFill(false);
			hit_stone.alpha = 0.0;
			
			hit_stone.graphics.precisionHitTest = true;	
			this.addChild(hit_stone);
		}
		
		private function CreateRockHit():void{
			hit_rock = new Shape();
			hit_rock.touchable = false;
			hit_rock.graphics.beginFill(0xff0000);
			
			hit_rock.graphics.lineTo(285,368);	
			hit_rock.graphics.lineTo(371,278);	
			hit_rock.graphics.lineTo(573,232);	
			hit_rock.graphics.lineTo(641,266);	
			hit_rock.graphics.lineTo(680,397);	
			hit_rock.graphics.lineTo(529,488);	
		
			hit_rock.graphics.endFill(false);
			hit_rock.alpha = 0.0;
			
			hit_rock.graphics.precisionHitTest = true;	
			this.addChild(hit_rock);
		}
		
		private function CreateShipHit():void{
			hit_ship = new Shape();
			hit_ship.touchable = false;
			hit_ship.graphics.beginFill(0xff0000);
			
			hit_ship.graphics.lineTo(0,0);	
			hit_ship.graphics.lineTo(522,0);	
			hit_ship.graphics.lineTo(364,291);	
			hit_ship.graphics.lineTo(283,378);	
			hit_ship.graphics.lineTo(0,305);	
			
			hit_ship.graphics.endFill(false);
			hit_ship.alpha = 0.0;
			
			hit_ship.graphics.precisionHitTest = true;	
			this.addChild(hit_ship);
		}
		
		private function CreatePlankHit():void{
			hit_plank = new Shape();
			hit_plank.touchable = false;
			hit_plank.graphics.beginFill(0xff0000);

			hit_plank.graphics.lineTo(176,203);	
			hit_plank.graphics.lineTo(280,225);	
			hit_plank.graphics.lineTo(370,206);	
			hit_plank.graphics.lineTo(436,318);	
			hit_plank.graphics.lineTo(425,458);	
			hit_plank.graphics.lineTo(364,480);	
			hit_plank.graphics.lineTo(225,344);	

			hit_plank.graphics.endFill(false);
			hit_plank.alpha = 0.0;
			
			hit_plank.graphics.precisionHitTest = true;	
			this.addChild(hit_plank);
		}
		
		private function CreateDoorHit():void{
			hit_door = new Shape();
			hit_door.touchable = false;
			hit_door.graphics.beginFill(0xff0000);
			
			
			hit_door.graphics.lineTo(244,71);	
			hit_door.graphics.lineTo(300,34);	
			hit_door.graphics.lineTo(419,55);	
			hit_door.graphics.lineTo(422,96);	
			hit_door.graphics.lineTo(381,195);	
			hit_door.graphics.lineTo(290,215);	
			hit_door.graphics.lineTo(211,181);	
			
			hit_door.graphics.endFill(false);
			hit_door.alpha = 0.0;
			
			hit_door.graphics.precisionHitTest = true;	
			this.addChild(hit_door);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((RavineSpaceShip as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipObj,true
							);
						}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(DoorOpen === false){
								FadeOut((SpaceShipDoorPuzzle as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipDoorPuzzleObj,true
								);
							}else{
								FadeOut((SpaceShipInterior as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipInteriorObj,false
								);
							}
							
						}else if(DoorOpen === true){
							if(hit_plank.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(PhraseCounter == 0){
									PhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walkway leading into the spaceship....");								
								}else if(PhraseCounter == 1){
									PhraseCounter = 2;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("... just like in the those cool old movies.");
								}else if(PhraseCounter == 2){
									PhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I have no idea how to close the ship's hatch.");
									
								}
								
								
								
							}
						}else if(hit_ship.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PhraseCounter == 0){
								PhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The body of the spacecraft is covered with thousands of micro-abrasions.");

							}else if(PhraseCounter == 1){
								PhraseCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are burn marks along the hull.");
							}else if(PhraseCounter == 2){
								PhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's incredible the ship survived impact after a fall from orbit...");

							}
							
						}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Huge boulders rest beside the spacecraft.");
							
						}else if(hit_stone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walls of the ravine converge to surround the starship.");
							
						}
						
						/*
						
						private var hit_ship:Shape;
						private var hit_stone:Shape;
						private var hit_rock:Shape;
						private var PhraseCounter;
						
						*/
						
					}
					
					
					//SpaceShipDoorPuzzleObj
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
			
			
			this.assets.removeTexture("ravineSpaceShipDoor_bg",true);
			this.assets.removeTexture("RavineSpaceShipDoor_Sprite",true);
			this.assets.removeTextureAtlas("RavineSpaceShipDoor_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineSpaceShipDoor_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineSpaceShipDoor_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineSpaceShipDoor_03");
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