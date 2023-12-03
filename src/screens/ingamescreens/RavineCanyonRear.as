package screens.ingamescreens
{

	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class RavineCanyonRear extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var drone_lid:Image;
		private var drone_sat:Image;
		
		private var hit_FreighterLowerLevel:Shape;
		private var hit_drone:Shape;
		private var hit_ravine:Shape;
		
		private var hit_door:Shape;
		private var hit_cliffOne:Shape;
		private var hit_cliffTwo:Shape;
		private var hit_plants:Shape;
		private var hit_sky:Shape;
		private var hit_ship:Shape;
		
		private var ShipPhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function RavineCanyonRear(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('RavineCanyonRear_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanyonRear/ravineCanyonRear_bg.jpg'));
				game.TrackAssets('RavineCanyonRear_01');
			}
			if(game.CheckAsset('RavineCanyonRear_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanyonRear/RavineCanyonRear_Sprite.png'));
				game.TrackAssets('RavineCanyonRear_02');
			}
			if(game.CheckAsset('RavineCanyonRear_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineCanyonRear/RavineCanyonRear_Sprite.xml'));
				game.TrackAssets('RavineCanyonRear_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineCanyonRear","RavineCanyonRearObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineCanyonRear_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			drone_sat = new Image(this.assets.getTexture('drone_satellite'));
			drone_sat.touchable = false;
			drone_sat.x = 308;
			drone_sat.y = 333;
		
			drone_lid = new Image(this.assets.getTexture('drone_lid'));
			drone_lid.touchable = false;
			drone_lid.x = 271;
			drone_lid.y = 311;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Lid"] == "open"){
					drone_lid.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Satellite"] == "PickedUp"){
						drone_sat.alpha = 0;				
					}else{
						drone_sat.alpha = 1;
					}
				}else{
					drone_lid.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Satellite"] == "PickedUp"){
						drone_sat.alpha = 0;				
					}else{
						drone_sat.alpha = 1;
					}
				}
			}else{
				drone_sat.alpha = 1;
				drone_lid.alpha = 1;
			}
			
			
			this.addChildAt(drone_sat,1);
			this.addChildAt(drone_lid,2);
			//FadeOutOcean(1);
			
		//	goback = new GoBackButton(this.assets);
		//	this.addChild(goback);
			CreateSkyHit();
			CreatePlantsHit();
			CreateCliffsOneHit();
			CreateCliffsTwoHit();
			CreateDoorHit();
			CreateShipHit();
			CreateLowerLevelHit();
			
			CreateDroneHit();			
			CreateRavineHit();
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipGroansOne",0,0.5,'stop');
			//	(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("WindOne",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanyonRear != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanyonRear['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineCanyonRear;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanyonRear',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,2);
							
						},1.5);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineCanyonRear',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						//(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
						(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,2);
						//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
					},1.5);
				}
			}
		}
		//hit_ravine
		
		private function CreateShipHit():void{
			hit_ship = new Shape();
			hit_ship.touchable = false;
			hit_ship.graphics.beginFill(0xff0000);
			
			hit_ship.graphics.lineTo(538,0);	
			hit_ship.graphics.lineTo(800,0);	
			hit_ship.graphics.lineTo(800,307);	
			hit_ship.graphics.lineTo(689,407);	
			hit_ship.graphics.lineTo(513,346);	
			
			hit_ship.graphics.endFill(false);
			hit_ship.alpha = 0.0;
			hit_ship.graphics.precisionHitTest = true;	
			this.addChild(hit_ship);
			
		}
		
		private function CreateSkyHit():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(145,0);	
			hit_sky.graphics.lineTo(296,0);	
			hit_sky.graphics.lineTo(242,178);	
			hit_sky.graphics.lineTo(203,190);	
			
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
			
		}
		
		private function CreatePlantsHit():void{
			hit_plants = new Shape();
			hit_plants.touchable = false;
			hit_plants.graphics.beginFill(0xff0000);
			
			hit_plants.graphics.lineTo(0,129);	
			hit_plants.graphics.lineTo(82,133);	
			hit_plants.graphics.lineTo(126,248);	
			hit_plants.graphics.lineTo(116,397);	
			hit_plants.graphics.lineTo(0,397);	
			
			hit_plants.graphics.endFill(false);
			hit_plants.alpha = 0.0;
			hit_plants.graphics.precisionHitTest = true;	
			this.addChild(hit_plants);
			
		}
		
		private function CreateDoorHit():void{
			hit_door = new Shape();
			hit_door.touchable = false;
			hit_door.graphics.beginFill(0xff0000);
			
			hit_door.graphics.lineTo(299,406);	
			hit_door.graphics.lineTo(563,400);	
			hit_door.graphics.lineTo(653,453);	
			hit_door.graphics.lineTo(331,492);	
					
			hit_door.graphics.endFill(false);
			hit_door.alpha = 0.0;
			hit_door.graphics.precisionHitTest = true;	
			this.addChild(hit_door);
			
		}
		
		private function CreateCliffsTwoHit():void{
			hit_cliffTwo = new Shape();
			hit_cliffTwo.touchable = false;
			hit_cliffTwo.graphics.beginFill(0xff0000);
			
			hit_cliffTwo.graphics.lineTo(246,101);	
			hit_cliffTwo.graphics.lineTo(500,23);	
			hit_cliffTwo.graphics.lineTo(502,156);	
			hit_cliffTwo.graphics.lineTo(270,300);	
			
			
			hit_cliffTwo.graphics.endFill(false);
			hit_cliffTwo.alpha = 0.0;
			hit_cliffTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_cliffTwo);
			
		}
		
		private function CreateCliffsOneHit():void{
			hit_cliffOne = new Shape();
			hit_cliffOne.touchable = false;
			hit_cliffOne.graphics.beginFill(0xff0000);
			
			hit_cliffOne.graphics.lineTo(88,0);	
			hit_cliffOne.graphics.lineTo(142,6);	
			hit_cliffOne.graphics.lineTo(195,90);	
			hit_cliffOne.graphics.lineTo(201,186);	
			hit_cliffOne.graphics.lineTo(183,294);	
			hit_cliffOne.graphics.lineTo(130,254);	
		
			
			hit_cliffOne.graphics.endFill(false);
			hit_cliffOne.alpha = 0.0;
			hit_cliffOne.graphics.precisionHitTest = true;	
			this.addChild(hit_cliffOne);
			
		}
		
		private function CreateRavineHit():void{
			hit_ravine = new Shape();
			hit_ravine.touchable = false;
			hit_ravine.graphics.beginFill(0xff0000);
			
			hit_ravine.graphics.lineTo(197,205);	
			hit_ravine.graphics.lineTo(251,189);	
			hit_ravine.graphics.lineTo(270,269);	
			hit_ravine.graphics.lineTo(268,335);	
			hit_ravine.graphics.lineTo(238,354);	
			hit_ravine.graphics.lineTo(199,334);	
			hit_ravine.graphics.lineTo(191,312);	

			hit_ravine.graphics.endFill(false);
			hit_ravine.alpha = 0.0;
			hit_ravine.graphics.precisionHitTest = true;	
			this.addChild(hit_ravine);
			
		}
		
		private function CreateLowerLevelHit():void{
			hit_FreighterLowerLevel = new Shape();
			hit_FreighterLowerLevel.touchable = false;
			hit_FreighterLowerLevel.graphics.beginFill(0xff0000);
			
			hit_FreighterLowerLevel.graphics.lineTo(615,67);	
			hit_FreighterLowerLevel.graphics.lineTo(711,19);	
			hit_FreighterLowerLevel.graphics.lineTo(765,266);	
			hit_FreighterLowerLevel.graphics.lineTo(741,336);	
			hit_FreighterLowerLevel.graphics.lineTo(620,334);	
			hit_FreighterLowerLevel.graphics.lineTo(628,276);	

			hit_FreighterLowerLevel.alpha = 0.0;
			hit_FreighterLowerLevel.graphics.endFill(false);
			hit_FreighterLowerLevel.graphics.precisionHitTest = true;	
			this.addChild(hit_FreighterLowerLevel);
			
		}
		
		private function CreateDroneHit():void{
			hit_drone = new Shape();
			hit_drone.touchable = false;
			hit_drone.graphics.beginFill(0xff0000);
			
			hit_drone.graphics.lineTo(273,329);	
			hit_drone.graphics.lineTo(321,290);	
			hit_drone.graphics.lineTo(341,203);	
			hit_drone.graphics.lineTo(430,151);	
			hit_drone.graphics.lineTo(495,165);	
			hit_drone.graphics.lineTo(489,208);	
			hit_drone.graphics.lineTo(436,323);	
			hit_drone.graphics.lineTo(318,377);	
			hit_drone.graphics.lineTo(276,371);	
			
			hit_drone.alpha = 0.0;
			hit_drone.graphics.endFill(false);
			hit_drone.graphics.precisionHitTest = true;	
			this.addChild(hit_drone);
			
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);

					if(hit_FreighterLowerLevel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FreighterLower as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterLowerObj,false
						);
					}else if(hit_ravine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleRavine as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleRavineObj,true
						);
					}else if(hit_drone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineDrone as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleRavineObj,true
						);
					}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The section of the ship’s hull I cut away with the blowtorch.");
					
					}else if(hit_ship.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(ShipPhraseCounter == 0){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The freighter is being slowly reclaimed by the land.");
							ShipPhraseCounter = 1;
						}else if(ShipPhraseCounter == 1){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal bears witness to long periods of harsh weathering.");
							ShipPhraseCounter = 2;
						}else if(ShipPhraseCounter == 2){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The paint still clings to the side of the vessel.");
							ShipPhraseCounter = 0;
						}
					}else if(hit_cliffOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The canyon walls rise almost straight up.");
					}else if(hit_cliffTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Trees and plants grow up the side of vertical rockface.");
					}else if(hit_plants.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A hardy and tough plant.");
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A thin sliver of sky shows through walls of canyon.");
					}
					/*
					hit_ship
					private var hit_door:Shape;
					private var hit_cliffOne:Shape;
					private var hit_cliffTwo:Shape;
					private var hit_plants:Shape;
					private var hit_sky:Shape;
					
					*/
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
			
			
			this.assets.removeTexture("ravineCanyonRear_bg",true);
			this.assets.removeTexture("RavineCanyonRear_Sprite",true);
			this.assets.removeTextureAtlas("RavineCanyonRear_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("RavineCanyonRear_01");
			(stage.getChildAt(0) as Object).falseAsset("RavineCanyonRear_02");
			(stage.getChildAt(0) as Object).falseAsset("RavineCanyonRear_03");
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
