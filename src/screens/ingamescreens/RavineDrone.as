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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class RavineDrone extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var satellite:Image;
		private var lid:Image;
		private var key:Image;
		
		private var hit_lid:Shape;
		private var hit_satellite:Shape;
		private var hit_key:Shape;
		
		private var hit_wing:Shape;
		private var hit_body:Shape;
		private var hit_engine:Shape;
		
		private var BodyPhraseCounter:int = 0;
		
		private var LidOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function RavineDrone(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineDrone_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineDrone/ravineDrone_bg.jpg'));
				game.TrackAssets('ravineDrone_01');
			}
			if(game.CheckAsset('ravineDrone_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineDrone/RavineDrone_Sprite.atf'));
				game.TrackAssets('ravineDrone_02');
			}
			if(game.CheckAsset('ravineDrone_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineDrone/RavineDrone_Sprite.xml'));
				game.TrackAssets('ravineDrone_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineDrone","RavineDroneObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineDrone_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			satellite = new Image(this.assets.getTexture('satellite'));
			satellite.smoothing = TextureSmoothing.NONE;

			satellite.touchable = false;
			satellite.x = 190;
			satellite.y = 284;
			
			lid = new Image(this.assets.getTexture('lid'));
			lid.smoothing = TextureSmoothing.NONE;

			lid.touchable = false;
			lid.x = 121;
			lid.y = 238;
			
			
			key = new Image(this.assets.getTexture('key'));
			key.smoothing = TextureSmoothing.NONE;

			key.touchable = false;
			key.x = 655;
			key.y = 204;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Lid"] == "open"){
					LidOpen = true;
					lid.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Satellite"] == "PickedUp"){
						satellite.alpha = 0;				
					}else{
						satellite.alpha = 1;
					}
					CreateHitSatellite();
				}else{
					lid.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Satellite"] == "PickedUp"){
						satellite.alpha = 0;				
					}else{
						satellite.alpha = 1;
					}
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Key"] == "PickedUp"){
					key.alpha = 0;
				}else{
					key.alpha = 1;
				}
			}else{
				satellite.alpha = 1;
				lid.alpha = 1;
				key.alpha = 1;
			}
			CreateHitEngine();
			CreateHitWing();
			CreateHitBody();
			
			this.addChildAt(satellite,1);
			this.addChildAt(lid,2);
			this.addChildAt(key,3);
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			CreateHitKey();
			CreateLidHit(LidOpen);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
		}
		
		
		private function CreateHitEngine():void{
			hit_engine = new Shape();
			hit_engine.touchable = false;
			hit_engine.graphics.beginFill(0xff0000);
			
			hit_engine.graphics.lineTo(454,104);	
			hit_engine.graphics.lineTo(553,0);	
			hit_engine.graphics.lineTo(618,0);	
			hit_engine.graphics.lineTo(550,142);	
			hit_engine.graphics.lineTo(490,162);	
			
			hit_engine.graphics.endFill(false);
			hit_engine.alpha = 0.0;
			
			hit_engine.graphics.precisionHitTest = true;	
			this.addChild(hit_engine);
		}
		
		
		private function CreateHitWing():void{
			hit_wing = new Shape();
			hit_wing.touchable = false;
			hit_wing.graphics.beginFill(0xff0000);
			
			hit_wing.graphics.lineTo(88,266);	
			hit_wing.graphics.lineTo(300,158);	
			hit_wing.graphics.lineTo(328,184);	
			hit_wing.graphics.lineTo(121,327);	
			
			hit_wing.graphics.endFill(false);
			hit_wing.alpha = 0.0;
			
			hit_wing.graphics.precisionHitTest = true;	
			this.addChild(hit_wing);
		}
		
		private function CreateHitBody():void{
			hit_body = new Shape();
			hit_body.touchable = false;
			hit_body.graphics.beginFill(0xff0000);
			
			hit_body.graphics.lineTo(173,0);	
			hit_body.graphics.lineTo(262,0);	
			hit_body.graphics.lineTo(624,213);	
			hit_body.graphics.lineTo(625,286);	
			hit_body.graphics.lineTo(525,247);	
			hit_body.graphics.lineTo(436,288);	
			hit_body.graphics.lineTo(364,250);	
			hit_body.graphics.lineTo(398,173);	
			
			hit_body.graphics.endFill(false);
			hit_body.alpha = 0.0;
			
			hit_body.graphics.precisionHitTest = true;	
			this.addChild(hit_body);
		}
		
		
		private function CreateHitKey():void{
			hit_key = new Shape();
			hit_key.touchable = false;
			hit_key.graphics.beginFill(0xff0000);
			
			hit_key.graphics.lineTo(633,231);	
			hit_key.graphics.lineTo(673,182);	
			hit_key.graphics.lineTo(793,262);	
			hit_key.graphics.lineTo(771,321);	
		
			hit_key.graphics.endFill(false);
			hit_key.alpha = 0.0;
			
			hit_key.graphics.precisionHitTest = true;	
			this.addChild(hit_key);
		}
		
		
		private function CreateHitSatellite():void{
			hit_satellite = new Shape();
			hit_satellite.touchable = false;
			hit_satellite.graphics.beginFill(0xff0000);
			
			hit_satellite.graphics.lineTo(213,315);	
			hit_satellite.graphics.lineTo(248,279);	
			hit_satellite.graphics.lineTo(323,280);	
			hit_satellite.graphics.lineTo(346,316);	
			hit_satellite.graphics.lineTo(338,366);	
			hit_satellite.graphics.lineTo(288,391);	
			hit_satellite.graphics.lineTo(236,379);	
			hit_satellite.graphics.endFill(false);
			hit_satellite.alpha = 0.0;
			
			hit_satellite.graphics.precisionHitTest = true;	
			this.addChild(hit_satellite);
		}
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				
				hit_lid.graphics.lineTo(100,393);	
				hit_lid.graphics.lineTo(171,307);	
				hit_lid.graphics.lineTo(267,264);	
				hit_lid.graphics.lineTo(375,262);	
				hit_lid.graphics.lineTo(401,305);	
				hit_lid.graphics.lineTo(388,340);	
				hit_lid.graphics.lineTo(315,394);	
				hit_lid.graphics.lineTo(209,439);	
				hit_lid.graphics.lineTo(124,451);	
				
				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(373,404);
				hit_lid.graphics.lineTo(442,279);
				hit_lid.graphics.lineTo(496,227);
				hit_lid.graphics.lineTo(558,240);
				hit_lid.graphics.lineTo(544,329);
				hit_lid.graphics.lineTo(483,428);
				hit_lid.graphics.lineTo(416,446);

				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			this.addChild(hit_lid);
			
		}	
		
	
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((RavineCanyonRear as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonRearObj,true
						);
					}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							LidHanlder();
					}else if(hit_key.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						KeyHandler();
					}else if(LidOpen === true){
						if(hit_satellite.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SatHandler();
						}
					}else if(hit_engine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The drone was equipped with a jet engine.");
					}else if(hit_wing.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The broken wing.");
					}else if(hit_body.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(BodyPhraseCounter == 0){
							BodyPhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A crashed drone.");
						}else if(BodyPhraseCounter == 1){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Also called a U.A.V.... Unmanned Aerial Vehicle.");
							BodyPhraseCounter = 2;
						}else if(BodyPhraseCounter == 2){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The body of the drone is chipped and cracked...");
							BodyPhraseCounter = 3;
						}else if(BodyPhraseCounter == 3){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The structure of the fuselage is starting to deteriorate. It'll become dust eventually.");
							BodyPhraseCounter = 0;
						}
							
					}
					
					
					/*
					private var hit_wing:Shape;
					private var hit_body:Shape;
					private var hit_engine:Shape;
					BodyPhraseCounter
					*/
				}
			}
		}
		
		private function KeyHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone['Key'] == 'PickedUp'){
					
				}else{
					key.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone;
					}
					SaveArray["Key"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDrone',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_SlenderKey,
						'item_SlenderKey',
						'inven_slenderKey_sm'
					);
				}
			}else{
				key.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone;
				}
				SaveArray["Key"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDrone',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_SlenderKey,
					'item_SlenderKey',
					'inven_slenderKey_sm'
				);
			}
		}
		
		private function SatHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone["Satellite"] == "PickedUp"){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					satellite.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone;
					}
					SaveArray['Satellite'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDrone',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Satellite,
						'item_Satellite',
						'inven_satellite_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				
				satellite.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone;
				}
				SaveArray['Satellite'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDrone',SaveArray);
				
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Satellite,
					'item_Satellite',
					'inven_satellite_sm'
				);
				
			}
			
			
		}
		
		private function LidHanlder():void{
			if(LidOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BoxOpen();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone;
				}
				SaveArray['Lid'] = "open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDrone',SaveArray);
				
				LidOpen = true;
				lid.alpha = 0;
				hit_lid.graphics.clear();
				CreateLidHit(true);
				CreateHitSatellite();
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BoxClose();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDrone;
				}
				SaveArray['Lid'] = "closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineDrone',SaveArray);
				
			
				
				LidOpen = false;
				lid.alpha = 1;
				hit_lid.graphics.clear();
				CreateLidHit(false);
				this.removeChild(hit_satellite);
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
			
			
			this.assets.removeTexture("ravineDrone_bg",true);
			this.assets.removeTexture("RavineDrone_Sprite",true);
			this.assets.removeTextureAtlas("RavineDrone_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineDrone_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineDrone_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineDrone_03");
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
