package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class FreighterInterior extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var lockerDoorOne:Image;
		private var lockerDoorTwo:Image;
		private var lockerDoorThree:Image;
		private var lockerCeltic:Image;
	//	private var lockerPiggy:Image;
		private var tablePull:Image;
		
		
		private var hit_FreighterTable:Shape;
		private var hit_FreighterLocker:Shape;
		private var hit_FreighterUpper:Shape;
		private var hit_Chair:Shape;
		
		private var hit_lowerlevel:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function FreighterInterior(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterInterior_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterInterior/freighterInterior_bg.jpg'));
				game.TrackAssets('freighterInterior_01');
			}
			if(game.CheckAsset('freighterInterior_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterInterior/FreighterInterior_Sprite.png'));
				game.TrackAssets('freighterInterior_02');
			}
			if(game.CheckAsset('freighterInterior_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterInterior/FreighterInterior_Sprite.xml'));
				game.TrackAssets('freighterInterior_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterInterior","FreighterInteriorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('freighterInterior_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			lockerCeltic = new Image(this.assets.getTexture('locker_celtic'));
			lockerCeltic.touchable = false;
			lockerCeltic.x = 126;
			lockerCeltic.y = 125;
			

			lockerDoorOne = new Image(this.assets.getTexture('locker_door_one'));
			lockerDoorOne.touchable = false;
			lockerDoorOne.x = 101;
			lockerDoorOne.y = 24;

			lockerDoorTwo = new Image(this.assets.getTexture('locker_door_two'));
			lockerDoorTwo.touchable = false;
			lockerDoorTwo.x = 155;
			lockerDoorTwo.y = 35;

			lockerDoorThree = new Image(this.assets.getTexture('locker_door_three'));
			lockerDoorThree.touchable = false;
			lockerDoorThree.x = 205;
			lockerDoorThree.y = 44;	

			//lockerPiggy = new Image(this.assets.getTexture('locker_piggy'));
			//lockerPiggy.touchable = false;
			//lockerPiggy.x = 309;
			//lockerPiggy.y = 126;
				
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorOne'] == 'open'){
					lockerDoorOne.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['CelticTriangle'] == 'PickedUp'){
						lockerCeltic.alpha = 0;
					}else{
						lockerCeltic.alpha = 1;
					}
				}else{
					lockerDoorOne.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorTwo'] == 'open'){
					lockerDoorTwo.alpha = 0;
				}else{
					lockerDoorTwo.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorThree'] == 'open'){
					lockerDoorThree.alpha = 0;
				}else{
					lockerDoorThree.alpha = 1;
				}
				//if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["Piggy"] == "PickedUp"){
			//	lockerPiggy.alpha = 0;
			//	}else{
			//		lockerPiggy.alpha = 1;
			//	}
			}else{
				lockerCeltic.alpha = 1;
				lockerDoorOne.alpha = 1;
				lockerDoorTwo.alpha = 1;
				lockerDoorThree.alpha = 1;
			//	lockerPiggy.alpha = 1;
			}

			this.addChildAt(lockerCeltic,1);
			this.addChildAt(lockerDoorOne,2);
			this.addChildAt(lockerDoorTwo,3);
			this.addChildAt(lockerDoorThree,4);
			//this.addChildAt(lockerPiggy,5);

			tablePull = new Image(this.assets.getTexture('table_puller'));
			tablePull.touchable = false;
			tablePull.x = 197;
			tablePull.y = 279;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable['Puller'] == 'PickedUp'){
					tablePull.alpha = 0;
				}else{
					tablePull.alpha = 1;
				}
			}else{
				tablePull.alpha = 1;
			}
			
			
			
			this.addChildAt(tablePull,5);
			
			//FadeOutOcean(1);
			CreateHitFreighterUpper();
			CreateHitFreighterLocker();
			CreateHitFreighterTable();
			CreateHitLowerLevel();
			CreateHitChair();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,3);
		}
		//hit_Chair
		private function CreateHitChair():void{
			hit_Chair = new Shape();
			hit_Chair.touchable = false;
			hit_Chair.graphics.beginFill(0xff0000);
			
			hit_Chair.graphics.lineTo(90,332);	
			hit_Chair.graphics.lineTo(241,378);	
			hit_Chair.graphics.lineTo(250,487);	
			hit_Chair.graphics.lineTo(184,499);	
			hit_Chair.graphics.lineTo(82,422);	
	
			hit_Chair.graphics.endFill(false);
			
			hit_Chair.alpha = 0.0;
			
			hit_Chair.graphics.precisionHitTest = true;	
			this.addChild(hit_Chair);
		}
		
		
		private function CreateHitLowerLevel():void{
			hit_lowerlevel = new Shape();
			hit_lowerlevel.touchable = false;
			hit_lowerlevel.graphics.beginFill(0xff0000);
			
			hit_lowerlevel.graphics.lineTo(624,173);	
			hit_lowerlevel.graphics.lineTo(716,178);	
			hit_lowerlevel.graphics.lineTo(756,245);	
			hit_lowerlevel.graphics.lineTo(697,387);	
			hit_lowerlevel.graphics.lineTo(620,389);	
			hit_lowerlevel.graphics.lineTo(604,353);	
			hit_lowerlevel.graphics.lineTo(633,234);	
			
			hit_lowerlevel.graphics.endFill(false);
			
			hit_lowerlevel.alpha = 0.0;
			
			hit_lowerlevel.graphics.precisionHitTest = true;	
			this.addChild(hit_lowerlevel);
		}
		
		
		private function CreateHitFreighterTable():void{
			hit_FreighterTable = new Shape();
			hit_FreighterTable.touchable = false;
			hit_FreighterTable.graphics.beginFill(0xff0000);
			
			hit_FreighterTable.graphics.lineTo(165,274);	
			hit_FreighterTable.graphics.lineTo(290,261);	
			hit_FreighterTable.graphics.lineTo(431,319);	
			hit_FreighterTable.graphics.lineTo(445,355);	
			hit_FreighterTable.graphics.lineTo(418,389);	
			hit_FreighterTable.graphics.lineTo(305,403);	
			hit_FreighterTable.graphics.lineTo(212,330);	
			hit_FreighterTable.graphics.lineTo(191,351);	
			hit_FreighterTable.graphics.endFill(false);

			hit_FreighterTable.alpha = 0.0;
			
			hit_FreighterTable.graphics.precisionHitTest = true;	
			this.addChild(hit_FreighterTable);
		}
		
		private function CreateHitFreighterLocker():void{
			hit_FreighterLocker = new Shape();
			hit_FreighterLocker.touchable = false;
			hit_FreighterLocker.graphics.beginFill(0xff0000);
			
			hit_FreighterLocker.graphics.lineTo(114,9);
			hit_FreighterLocker.graphics.lineTo(436,63);
			hit_FreighterLocker.graphics.lineTo(421,198);
			hit_FreighterLocker.graphics.lineTo(351,200);
			hit_FreighterLocker.graphics.lineTo(280,190);
			hit_FreighterLocker.graphics.lineTo(273,255);
			hit_FreighterLocker.graphics.lineTo(164,268);
			hit_FreighterLocker.graphics.lineTo(100,266);
			hit_FreighterLocker.graphics.endFill(false);

			hit_FreighterLocker.alpha = 0.0;
			
			hit_FreighterLocker.graphics.precisionHitTest = true;	
			this.addChild(hit_FreighterLocker);
		}
		//
		
		private function CreateHitFreighterUpper():void{
			hit_FreighterUpper = new Shape();
			hit_FreighterUpper.touchable = false;
			hit_FreighterUpper.graphics.beginFill(0xff0000);
			
			hit_FreighterUpper.graphics.lineTo(491,56);
			hit_FreighterUpper.graphics.lineTo(588,37);
			hit_FreighterUpper.graphics.lineTo(666,53);
			hit_FreighterUpper.graphics.lineTo(651,110);
			hit_FreighterUpper.graphics.lineTo(613,156);
			hit_FreighterUpper.graphics.lineTo(628,239);
			hit_FreighterUpper.graphics.lineTo(599,357);
			hit_FreighterUpper.graphics.lineTo(510,359);
			hit_FreighterUpper.graphics.lineTo(482,174);
			hit_FreighterUpper.graphics.endFill(false);

			hit_FreighterUpper.alpha = 0.0;
			
			hit_FreighterUpper.graphics.precisionHitTest = true;	
			this.addChild(hit_FreighterUpper);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((RavineFreighterDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineFreighterDeckObj,true
						);
					}
					else if(hit_FreighterLocker.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FreighterLocker as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterLockerObj,true
						);
					}
					else if(hit_FreighterTable.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FreighterTable as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterTableObj,true
						);
					}
					else if(hit_FreighterUpper.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
						FadeOut((FreighterUpper as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterUpperObj,true
						);
					}
					else if(hit_lowerlevel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The stairway to the lower level is flooded with boulders.");

					}else if(hit_Chair.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An overturned chair.");
						
					}		
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
			
			
			this.assets.removeTexture("freighterInterior_bg",true);
			this.assets.removeTexture("FreighterInterior_Sprite",true);
			this.assets.removeTextureAtlas("FreighterInterior_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterInterior_01");
			(stage.getChildAt(0) as Object).falseAsset("freighterInterior_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterInterior_03");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				//		(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
	}
}