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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class HeroBoat extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var shovel:Image;
		private var door:Image;
		private var screwdriver:Image;
		private var throttle:Image;
		
		private var hit_stairs:Shape;
		private var hit_vista:Shape;
		private var hit_steering:Shape;
		private var hit_door:Shape;
		private var hit_shovel:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var DoorOpen:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function HeroBoat(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('heroBoat_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/HeroBoat/heroBoat_bg.jpg'));
				game.TrackAssets('heroBoat_01');
			}
			if(game.CheckAsset('heroBoat_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/HeroBoat/HeroBoat_Sprite.atf'));
				game.TrackAssets('heroBoat_02');
			}
			if(game.CheckAsset('heroBoat_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/HeroBoat/HeroBoat_Sprite.xml'));
				game.TrackAssets('heroBoat_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("HeroBoat","HeroBoatObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		/*
		
		private var hit_stairs:Shape;
		private var hit_vista:Shape;
		private var hit_steering:Shape;
		*/
		
		
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('heroBoat_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			
			
			door = new Image(this.assets.getTexture('door_closed'));
			door.smoothing = TextureSmoothing.NONE;
			door.touchable = false;
			door.x = 236;
			door.y = 37;
			
			
			shovel = new Image(this.assets.getTexture('shovel_door_closed'));
			shovel.smoothing = TextureSmoothing.NONE;
			shovel.touchable = false;
			shovel.x = 249;
			shovel.y = 292;
			
			
			throttle = new Image(this.assets.getTexture('steering_handle_down'));
			throttle.smoothing = TextureSmoothing.NONE;
			throttle.touchable = false;
			throttle.x = 511;
			throttle.y = 133;
			
			
			screwdriver = new Image(this.assets.getTexture('steering_screwdriver'));
			screwdriver.smoothing = TextureSmoothing.NONE;
			screwdriver.touchable = false;
			screwdriver.x = 648;
			screwdriver.y = 267;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat != undefined){				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat["Door"] == "open"){
					DoorOpen = true;
					door.alpha = 0;
					shovel.texture = this.assets.getTexture('shovel_door_open');
					CreateHitVista();
				}else{
					door.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat["Shovel"] == "PickedUp"){
					shovel.alpha = 0;
				}else{
					shovel.alpha = 1;
				}
			
			}else{
				door.alpha = 1;
				shovel.alpha = 1;
				
				screwdriver.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["Screwdriver"] == "PickedUp"){
					screwdriver.alpha = 0;
				}else{
					screwdriver.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "0"){
				
					throttle.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "1"){
					
					throttle.texture = this.assets.getTexture('steering_handle_up');
					throttle.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "2"){
					
					throttle.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "3"){
					
					throttle.texture = this.assets.getTexture('steering_handle_down');
					throttle.alpha = 1;
				}else{
					
					throttle.alpha = 0;
				}
				
			}else{
				throttle.alpha = 0;
				screwdriver.alpha = 1;
			}
			
			
			this.addChildAt(door,1);
			this.addChildAt(shovel,2);			
			this.addChildAt(throttle,3);			
			this.addChildAt(screwdriver,4);
			
			CreateHitStairs();
			CreateHitSteering();
			CreateDoorHit(DoorOpen);
			CreateHitShovel();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
		//	(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,1.5,'stop');
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoat',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadBeachStrings(true,4);
						},1.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoat',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadBeachStrings(true,4);
					},1.5);
				}
			}
			
			
			
		//	(stage.getChildAt(0) as Object).MusicObj.LoadBeachStrings(true,2);
		}
		
		private function CreateHitShovel():void{
			hit_shovel = new Shape();
			hit_shovel.touchable = false;
			hit_shovel.graphics.beginFill(0x00ff00);
			
			hit_shovel.graphics.lineTo(235,407);	
			hit_shovel.graphics.lineTo(259,371);	
			hit_shovel.graphics.lineTo(374,282);	
			hit_shovel.graphics.lineTo(386,293);	
			hit_shovel.graphics.lineTo(388,310);	
			hit_shovel.graphics.lineTo(320,453);	
			hit_shovel.graphics.lineTo(262,444);	

			hit_shovel.graphics.endFill(false);
			hit_shovel.alpha = 0.0;
			hit_shovel.graphics.precisionHitTest = true;	
			this.addChild(hit_shovel);
			
		}
		
		private function CreateHitStairs():void{
			hit_stairs = new Shape();
			hit_stairs.touchable = false;
			hit_stairs.graphics.beginFill(0x00ff00);
			
			hit_stairs.graphics.lineTo(0,145);	
			hit_stairs.graphics.lineTo(55,136);	
			hit_stairs.graphics.lineTo(61,170);	
			hit_stairs.graphics.lineTo(209,192);	
			hit_stairs.graphics.lineTo(238,382);	
			hit_stairs.graphics.lineTo(168,405);	
			hit_stairs.graphics.lineTo(0,416);	
			
			hit_stairs.graphics.endFill(false);
			hit_stairs.alpha = 0.0;
			hit_stairs.graphics.precisionHitTest = true;	
			this.addChild(hit_stairs);
			
		}
		private function CreateHitSteering():void{
			hit_steering = new Shape();
			hit_steering.touchable = false;
			hit_steering.graphics.beginFill(0x00ff00);
			
			hit_steering.graphics.lineTo(376,157);	
			hit_steering.graphics.lineTo(462,145);	
			hit_steering.graphics.lineTo(500,130);	
			hit_steering.graphics.lineTo(606,69);	
			hit_steering.graphics.lineTo(794,107);	
			hit_steering.graphics.lineTo(793,230);	
			hit_steering.graphics.lineTo(715,369);	
			hit_steering.graphics.lineTo(397,350);	
	
			hit_steering.graphics.endFill(false);
			hit_steering.alpha = 0.0;
			hit_steering.graphics.precisionHitTest = true;	
			this.addChild(hit_steering);
			
		}
		
		private function CreateHitVista():void{
			hit_vista = new Shape();
			hit_vista.touchable = false;
			hit_vista.graphics.beginFill(0x00ff00);
			
			hit_vista.graphics.lineTo(237,45);	
			hit_vista.graphics.lineTo(311,49);	
			hit_vista.graphics.lineTo(312,226);	
			hit_vista.graphics.lineTo(329,252);	
			hit_vista.graphics.lineTo(249,261);	

			hit_vista.graphics.endFill(false);
			hit_vista.alpha = 0.0;
			hit_vista.graphics.precisionHitTest = true;	
			this.addChild(hit_vista);
			
		}
		
		private function CreateDoorHit(open:Boolean = false):void{
			hit_door = new Shape();
			
			if(open === false){
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x0000FF);
				
				hit_door.graphics.lineTo(240,43);	
				hit_door.graphics.lineTo(364,48);	
				hit_door.graphics.lineTo(358,253);	
				hit_door.graphics.lineTo(249,263);	

				
				hit_door.graphics.endFill(false);
				
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;	
			}else{
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x0000FF);		
				hit_door.graphics.lineTo(310,50);
				hit_door.graphics.lineTo(364,52);
				hit_door.graphics.lineTo(357,252);
				hit_door.graphics.lineTo(345,254);
				hit_door.graphics.lineTo(311,223);

				hit_door.graphics.endFill(false);
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;				
			}
			hit_door.touchable = false;
			this.addChild(hit_door);
			
		}	
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CoastCorner as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCornerObj,true
						);
					}else if(hit_stairs.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((HeroBoatStairs as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.HeroBoatStairsObj,true
						);
						
					}else if(hit_steering.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((HeroBoatSteering as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.HeroBoatSteeringObj,true
						);
						
					}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						DoorHandler();
						
					}else if(hit_shovel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						ShovelHandler();
						
					}else if(DoorOpen === true){
						if(hit_vista.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((HeroBoatVista as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.HeroBoatVistaObj,true
							);
						}
					}
				}
			}
		}
		
		private function ShovelHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat["Shovel"] == "PickedUp"){
					
				}else{
					shovel.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat;
					SaveArray['Shovel'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoat',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Shovel,
						'item_Shovel',
						'inven_shovel_sm'
					);
					
					
				}
			}else{
				shovel.alpha = 0;
				SaveArray['Shovel'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoat',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Shovel,
					'item_Shovel',
					'inven_shovel_sm'
				);
			}	
		}
		
		private function DoorHandler():void{
			if(DoorOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MailBox();
				DoorOpen = true;
				door.alpha = 0;
				
				shovel.texture = this.assets.getTexture('shovel_door_open');
				
				//this.removeChild(hit_blowtorch);
				//this.removeChild(hit_tunnel_left);
				hit_door.graphics.clear();
				CreateDoorHit(true);
				CreateHitVista();
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat;
				}
				SaveArray['Door'] = "open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoat',SaveArray);
			
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MailBox();
				DoorOpen = false;
				door.alpha = 1;
				
				shovel.texture = this.assets.getTexture('shovel_door_closed');
				
				this.removeChild(hit_vista);
				hit_door.graphics.clear();
				CreateDoorHit(false);
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoat;
				}
				SaveArray['Door'] = "closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoat',SaveArray);
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
			
			
			this.assets.removeTexture("heroBoat_bg",true);
			this.assets.removeTexture("HeroBoat",true);
			this.assets.removeTextureAtlas("HeroBoat",true);
			(stage.getChildAt(0) as Object).falseAsset("heroBoat_01");
			(stage.getChildAt(0) as Object).falseAsset("heroBoat_02");
			(stage.getChildAt(0) as Object).falseAsset("heroBoat_03");
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