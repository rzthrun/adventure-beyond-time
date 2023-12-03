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
	
	public class HeroBoatSteering extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var throttle:Image;
		private var screwdriver:Image;
		
		private var hit_throttle:Shape;
		private var hit_wheel:Shape;
		private var hit_screwdriver:Shape;
		
		private var hit_depthFinder:Shape;
		private var hit_chair:Shape;
		private var ThrottlePos:String = '0';
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function HeroBoatSteering(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('heroBoatSteering_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/HeroBoatSteering/heroBoatSteering_bg.jpg'));
				game.TrackAssets('heroBoatSteering_01');
			}
			if(game.CheckAsset('heroBoatSteering_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/HeroBoatSteering/HeroBoatSteering_Sprite.atf'));
				game.TrackAssets('heroBoatSteering_02');
			}
			if(game.CheckAsset('heroBoatSteering_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/HeroBoatSteering/HeroBoatSteering_Sprite.xml'));
				game.TrackAssets('heroBoatSteering_03');
			}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("HeroBoatSteering","HeroBoatSteeringObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('heroBoatSteering_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			throttle = new Image(this.assets.getTexture('throttle_down'));
			throttle.smoothing = TextureSmoothing.NONE;
			throttle.touchable = false;
			throttle.x = 195;
			throttle.y = 61;
			screwdriver = new Image(this.assets.getTexture('screwdriver'));
			screwdriver.smoothing = TextureSmoothing.NONE;
			screwdriver.touchable = false;
			screwdriver.x = 468;
			screwdriver.y = 326;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["Screwdriver"] == "PickedUp"){
					screwdriver.alpha = 0;
				}else{
					screwdriver.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "0"){
					ThrottlePos = '0';
					throttle.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "1"){
					ThrottlePos = '1';
					throttle.texture = this.assets.getTexture('throttle_up');
					throttle.alpha = 1;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "2"){
					ThrottlePos = '2';
					throttle.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["ThrottlePos"] == "3"){
					ThrottlePos = '3';
					throttle.texture = this.assets.getTexture('throttle_down');
					throttle.alpha = 1;
				}else{
					ThrottlePos = '0';
					throttle.alpha = 0;
				}
			}else{
				throttle.alpha = 0;
				screwdriver.alpha = 1;
			}
			
			
			
			this.addChildAt(throttle,1);
			this.addChildAt(screwdriver,2);
		
			//FadeOutOcean(1);
			CreateHitScrewdriver();
			CreateHitWheel();
			CreateHitThrottle();
			CreateHitDepthFinder();
			CreateHitChair();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
		}
		//hit_depthFinder
		//hit_chair
		private function CreateHitChair():void{
			hit_chair = new Shape();
			hit_chair.touchable = false;
			hit_chair.graphics.beginFill(0x00ff00);
			
			hit_chair.graphics.lineTo(0,169);	
			hit_chair.graphics.lineTo(95,332);	
			hit_chair.graphics.lineTo(304,348);	
			hit_chair.graphics.lineTo(351,512);	
			hit_chair.graphics.lineTo(0,512);	
		
			hit_chair.graphics.endFill(false);
			hit_chair.alpha = 0.0;
			hit_chair.graphics.precisionHitTest = true;	
			this.addChild(hit_chair);
			
		}
		
		private function CreateHitDepthFinder():void{
			hit_depthFinder = new Shape();
			hit_depthFinder.touchable = false;
			hit_depthFinder.graphics.beginFill(0x00ff00);
			
			hit_depthFinder.graphics.lineTo(55,185);	
			hit_depthFinder.graphics.lineTo(90,73);	
			hit_depthFinder.graphics.lineTo(202,55);	
			hit_depthFinder.graphics.lineTo(230,149);	
			hit_depthFinder.graphics.lineTo(198,250);	
		
			hit_depthFinder.graphics.endFill(false);
			hit_depthFinder.alpha = 0.0;
			hit_depthFinder.graphics.precisionHitTest = true;	
			this.addChild(hit_depthFinder);
			
		}
		
		private function CreateHitScrewdriver():void{
			hit_screwdriver = new Shape();
			hit_screwdriver.touchable = false;
			hit_screwdriver.graphics.beginFill(0x00ff00);
			
			hit_screwdriver.graphics.lineTo(454,354);	
			hit_screwdriver.graphics.lineTo(472,313);	
			hit_screwdriver.graphics.lineTo(529,313);	
			hit_screwdriver.graphics.lineTo(647,401);	
			hit_screwdriver.graphics.lineTo(643,456);	
			hit_screwdriver.graphics.lineTo(595,461);	
			hit_screwdriver.graphics.lineTo(480,400);	
			
			hit_screwdriver.graphics.endFill(false);
			hit_screwdriver.alpha = 0.0;
			hit_screwdriver.graphics.precisionHitTest = true;	
			this.addChild(hit_screwdriver);
			
		}
		
		private function CreateHitWheel():void{
			hit_wheel = new Shape();
			hit_wheel.touchable = false;
			hit_wheel.graphics.beginFill(0x00ff00);
			
			hit_wheel.graphics.lineTo(335,155);	
			hit_wheel.graphics.lineTo(369,114);	
			hit_wheel.graphics.lineTo(425,86);	
			hit_wheel.graphics.lineTo(482,96);	
			hit_wheel.graphics.lineTo(518,140);	
			hit_wheel.graphics.lineTo(525,202);	
			hit_wheel.graphics.lineTo(500,273);	
			hit_wheel.graphics.lineTo(439,318);	
			hit_wheel.graphics.lineTo(363,315);	
			hit_wheel.graphics.lineTo(324,262);	
			hit_wheel.graphics.lineTo(321,215);	

			hit_wheel.graphics.endFill(false);
			hit_wheel.alpha = 0.0;
			hit_wheel.graphics.precisionHitTest = true;	
			this.addChild(hit_wheel);
			
		}
		
		private function CreateHitThrottle():void{
			hit_throttle = new Shape();
			hit_throttle.touchable = false;
			hit_throttle.graphics.beginFill(0x00ff00);
			
			hit_throttle.graphics.lineTo(210,257);	
			hit_throttle.graphics.lineTo(230,181);	
			hit_throttle.graphics.lineTo(236,161);	
			hit_throttle.graphics.lineTo(280,109);	
			
			hit_throttle.graphics.lineTo(349,60);	
			hit_throttle.graphics.lineTo(390,59);	
			
			hit_throttle.graphics.lineTo(400,96);	
			hit_throttle.graphics.lineTo(366,115);	
			hit_throttle.graphics.lineTo(333,157);	
			hit_throttle.graphics.lineTo(320,204);	
			hit_throttle.graphics.lineTo(321,251);	
			hit_throttle.graphics.lineTo(296,287);	
			hit_throttle.graphics.lineTo(246,291);	
			hit_throttle.graphics.lineTo(211,279);	
			
			hit_throttle.graphics.endFill(false);
			hit_throttle.alpha = 0.0;
			hit_throttle.graphics.precisionHitTest = true;	
			this.addChild(hit_throttle);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((HeroBoat as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.HeroBoatObj,true
						);
					}else if(hit_screwdriver.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						ScrewdriverHandler();
						
					}else if(hit_throttle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						ThrottleHandler();
					}else if(hit_depthFinder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The depth finder... completely and utterly broken.");
					}else if(hit_chair.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Ah... my chair... it's seen better days.");

					}else if(hit_wheel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The steering wheel won't move. Sadly, I think this boat will never sail again.");
						
					}
				}
			}
		}
		
		private function ThrottleHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering;
			}
			
			if(ThrottlePos == '0'){
				ThrottlePos = '1';
				SaveArray['ThrottlePos'] = '1';
				throttle.texture = this.assets.getTexture('throttle_up');
				throttle.alpha = 1;
			}else if (ThrottlePos == '1'){
				ThrottlePos = '2';
				SaveArray['ThrottlePos'] = '2';
				throttle.alpha = 0;
			}else if (ThrottlePos == '2'){
				ThrottlePos = '3';
				SaveArray['ThrottlePos'] = '3';
				throttle.texture = this.assets.getTexture('throttle_down');
				throttle.alpha = 1;
			}else if (ThrottlePos == '3'){
				ThrottlePos = '0';
				SaveArray['ThrottlePos'] = '0';
				throttle.alpha = 0;
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoatSteering',SaveArray);
		}
		
		private function ScrewdriverHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering["Screwdriver"] == "PickedUp"){
					
				}else{
					screwdriver.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.HeroBoatSteering;
					SaveArray['Screwdriver'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoatSteering',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Screwdriver,
						'item_Screwdriver',
						'inven_screwdriver_sm'
					);
					
					
				}
			}else{
				screwdriver.alpha = 0;
				SaveArray['Screwdriver'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('HeroBoatSteering',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Screwdriver,
					'item_Screwdriver',
					'inven_screwdriver_sm'
				);
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
			
			
			this.assets.removeTexture("heroBoatSteering_bg",true);
			this.assets.removeTexture("HeroBoatSteering",true);
			this.assets.removeTextureAtlas("HeroBoatSteering",true);
			(stage.getChildAt(0) as Object).falseAsset("heroBoatSteering_01");
			(stage.getChildAt(0) as Object).falseAsset("heroBoatSteering_02");
			(stage.getChildAt(0) as Object).falseAsset("heroBoatSteering_03");
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