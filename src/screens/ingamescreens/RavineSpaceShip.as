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
	
		
	public class RavineSpaceShip extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var spaceShipDoor:Image;
		private var rockfaceMessage:Image;
		
		
		private var hit_rockface:Shape;
		private var hit_spaceshipDoor:Shape;
		
		private var hit_root:Shape;
		private var hit_ship:Shape;
		private var hit_sky:Shape;
		private var hit_ground:Shape;
		private var hit_stone:Shape;
		private var ShipPhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function RavineSpaceShip(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineSpaceShip_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineSpaceShip/ravineSpaceShip_bg.jpg'));
				game.TrackAssets('ravineSpaceShip_01');
			}
			if(game.CheckAsset('ravineSpaceShip_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineSpaceShip/RavineSpaceShip_Sprite.png'));
				game.TrackAssets('ravineSpaceShip_02');
			}
			if(game.CheckAsset('ravineSpaceShip_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineSpaceShip/RavineSpaceShip_Sprite.xml'));
				game.TrackAssets('ravineSpaceShip_03');
			}
			//RavineSpaceShip_Sprite
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineSpaceShip","RavineSpaceShipObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineSpaceShip_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			rockfaceMessage = new Image(this.assets.getTexture('rockFace_message'));
			rockfaceMessage.touchable = false;
			rockfaceMessage.x = 562;
			rockfaceMessage.y = 113;

			spaceShipDoor = new Image(this.assets.getTexture('spaceShip_door'));
			spaceShipDoor.touchable = false;
			spaceShipDoor.x = 264;
			spaceShipDoor.y = 225;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRockFace['MessageOpen'] == 'Yes'){
					rockfaceMessage.alpha = 1;
				}else{
					rockfaceMessage.alpha = 0;
				}
			}else{
				rockfaceMessage.alpha = 0;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor['Door'] == 'Open'){
					spaceShipDoor.alpha = 1;
				}else{
					spaceShipDoor.alpha = 0;
				}
			}else{
				spaceShipDoor.alpha = 0;
			}
						
			this.addChildAt(rockfaceMessage,1);
			this.addChildAt(spaceShipDoor,2);
			CreateStoneHit();
			CreateGroundHit();
			CreateSkyHit();
			CreateRootHit();
			CreateShipHit();
			CreateRockFaceHit();
			CreateSpaceShipDoorHit();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');

		}
		//hit_stone
		private function CreateStoneHit():void{
			hit_stone = new Shape();
			hit_stone.touchable = false;
			hit_stone.graphics.beginFill(0xff0000);
			
			hit_stone.graphics.lineTo(397,350);				
			hit_stone.graphics.lineTo(443,171);				
			hit_stone.graphics.lineTo(633,0);				
			hit_stone.graphics.lineTo(800,230);				
			hit_stone.graphics.lineTo(800,369);				
			
			
			hit_stone.graphics.endFill(false);
			hit_stone.alpha = 0.0;
			
			hit_stone.graphics.precisionHitTest = true;	
			this.addChild(hit_stone);
		}
		
		private function CreateGroundHit():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(216,338);				
			hit_ground.graphics.lineTo(429,366);				
			hit_ground.graphics.lineTo(596,506);				
			hit_ground.graphics.lineTo(158,508);				
				
			
			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateSkyHit():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(158,0);				
			hit_sky.graphics.lineTo(625,0);				
			hit_sky.graphics.lineTo(501,147);				
			hit_sky.graphics.lineTo(431,158);				
			hit_sky.graphics.lineTo(158,87);				
								
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		private function CreateRootHit():void{
			hit_root = new Shape();
			hit_root.touchable = false;
			hit_root.graphics.beginFill(0xff0000);
			
			hit_root.graphics.lineTo(0,0);				
			hit_root.graphics.lineTo(89,85);				
			hit_root.graphics.lineTo(150,359);				
			hit_root.graphics.lineTo(2,342);				
			
			hit_root.graphics.endFill(false);
			hit_root.alpha = 0.0;
			
			hit_root.graphics.precisionHitTest = true;	
			this.addChild(hit_root);
		}
		
		private function CreateShipHit():void{
			hit_ship = new Shape();
			hit_ship.touchable = false;
			hit_ship.graphics.beginFill(0xff0000);
			
			hit_ship.graphics.lineTo(186,106);				
			hit_ship.graphics.lineTo(222,77);				
			hit_ship.graphics.lineTo(286,71);				
			hit_ship.graphics.lineTo(336,0);				
			hit_ship.graphics.lineTo(412,10);				
			hit_ship.graphics.lineTo(385,129);				
			hit_ship.graphics.lineTo(421,158);				
			hit_ship.graphics.lineTo(440,201);				
			hit_ship.graphics.lineTo(238,329);				
			
			
			hit_ship.graphics.endFill(false);
			hit_ship.alpha = 0.0;
			
			hit_ship.graphics.precisionHitTest = true;	
			this.addChild(hit_ship);
		}
		
		private function CreateRockFaceHit():void{
			hit_rockface = new Shape();
			hit_rockface.touchable = false;
			hit_rockface.graphics.beginFill(0xff0000);
			
			hit_rockface.graphics.lineTo(543,127);				
			hit_rockface.graphics.lineTo(651,60);				
			hit_rockface.graphics.lineTo(696,110);				
			hit_rockface.graphics.lineTo(759,120);				
			hit_rockface.graphics.lineTo(749,220);				
			hit_rockface.graphics.lineTo(566,274);				
				
			
			hit_rockface.graphics.endFill(false);
			hit_rockface.alpha = 0.0;
			
			hit_rockface.graphics.precisionHitTest = true;	
			this.addChild(hit_rockface);
		}
		//hit_spaceshipDoor
		private function CreateSpaceShipDoorHit():void{
			hit_spaceshipDoor = new Shape();
			hit_spaceshipDoor.touchable = false;
			hit_spaceshipDoor.graphics.beginFill(0xff0000);
			
			
			hit_spaceshipDoor.graphics.lineTo(311,160);	
			hit_spaceshipDoor.graphics.lineTo(396,178);		
			hit_spaceshipDoor.graphics.lineTo(394,365);				
			hit_spaceshipDoor.graphics.lineTo(383,380);				
			hit_spaceshipDoor.graphics.lineTo(295,380);				
			hit_spaceshipDoor.graphics.lineTo(249,326);				

			hit_spaceshipDoor.graphics.endFill(false);
			hit_spaceshipDoor.alpha = 0.0;
			
			hit_spaceshipDoor.graphics.precisionHitTest = true;	
			this.addChild(hit_spaceshipDoor);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleRavine as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleRavineObj,true
						);
					}else if(hit_rockface.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineRockFace as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineRockFaceObj,true
						);
						
					}else if(hit_spaceshipDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineSpaceShipDoor as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipDoorObj,true
						);
						
					}else if(hit_ship.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(ShipPhraseCounter == 0){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'm no expert, but that looks like a space ship.");
							ShipPhraseCounter = 1;
						}else if(ShipPhraseCounter == 1){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship appears to have crash landed.");
							ShipPhraseCounter = 2;
						}else if(ShipPhraseCounter == 2){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The spacecraft looks like it's been here for hundreds of years.");
							ShipPhraseCounter = 0;
						}
						
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The trees and hills are silhouetted against the overcast sky.");
						
					}else if(hit_root.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Roots cling to the ravine walls like vines.");
						
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Thousands of small stones make up the floor of the ravine.");
						
					}else if(hit_stone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This looks like an old river bed.");
						
					}
					
					/*
					private var hit_root:Shape;
					private var hit_ship:Shape;
					private var hit_sky:Shape;
					private var hit_ground:Shape;
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
			
			
			this.assets.removeTexture("ravineSpaceShip_bg",true);
			this.assets.removeTexture("RavineSpaceShip_Sprite",true);
			this.assets.removeTextureAtlas("RavineSpaceShip_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineSpaceShip_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineSpaceShip_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineSpaceShip_03");
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