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
	
	
	public class HeroBoatVista extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_sea:Shape;
		private var hit_sky:Shape;
		private var hit_seaTwo:Shape;
		
		private var SeaPhraseTracker:int = 0;
		private var SeaTwoPhraseTracker:int = 0;
		private var SkyPhraseTracker:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function HeroBoatVista(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('heroBoatVista_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/HeroBoatVista/heroBoatVista_bg.jpg'));
				game.TrackAssets('heroBoatVista_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("HeroBoatVista","HeroBoatVistaObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('heroBoatVista_bg'));
			bg.touchable = true;
			this.addChild(bg);
			
			
			//FadeOutOcean(1);
			CreateHitSky();
			CreateHitSea();
			CreateHitSeaTwo();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
		}
		
		/*
		private var hit_sea:Shape;
		private var hit_sky:Shape;
		private var hit_seaTwo:Shape;
		*/
		private function CreateHitSeaTwo():void{
			hit_seaTwo = new Shape();
			hit_seaTwo.touchable = false;
			hit_seaTwo.graphics.beginFill(0x00ff00);
			
			hit_seaTwo.graphics.lineTo(0,297);	
			hit_seaTwo.graphics.lineTo(800,297);	
			hit_seaTwo.graphics.lineTo(800,512);	
			hit_seaTwo.graphics.lineTo(0,512);	
		
			hit_seaTwo.graphics.endFill(false);
			hit_seaTwo.alpha = 0.0;
			hit_seaTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_seaTwo);
			
		}
		
		private function CreateHitSky():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0x00ff00);
			
			hit_sky.graphics.lineTo(0,0);	
			hit_sky.graphics.lineTo(800,0);	
			hit_sky.graphics.lineTo(800,167);	
			hit_sky.graphics.lineTo(0,167);	
			
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
			
		}
		
		private function CreateHitSea():void{
			hit_sea = new Shape();
			hit_sea.touchable = false;
			hit_sea.graphics.beginFill(0x00ff00);
			
			hit_sea.graphics.lineTo(0,168);	
			hit_sea.graphics.lineTo(800,168);	
			hit_sea.graphics.lineTo(800,296);	
			hit_sea.graphics.lineTo(0,296);	

			hit_sea.graphics.endFill(false);
			hit_sea.alpha = 0.0;
			hit_sea.graphics.precisionHitTest = true;	
			this.addChild(hit_sea);
			
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
					}else if(hit_sea.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						SeaHandler();
					}else if(hit_seaTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						SeaTwoHandler();
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						SkyHandler();
					}
				}
			}
		}
		private function SkyHandler():void{
			if(SkyPhraseTracker == 0){
				SkyPhraseTracker = 1;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What strange clouds....");
				
			}else if(SkyPhraseTracker == 1){
				SkyPhraseTracker = 2;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is light... but where is the sun.");
				
			}else if(SkyPhraseTracker == 2){
				SkyPhraseTracker = 3;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's like a wall of mist upon the horizon.");
				
			}else if(SkyPhraseTracker == 3){
				SkyPhraseTracker = 0;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've got to explore this place... it's the only way");
				
			}
		}
		
		private function SeaTwoHandler():void{
			if(SeaTwoPhraseTracker == 0){
				SeaTwoPhraseTracker = 1;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The waves are lapping against the side of the boat.");
				
			}else if(SeaTwoPhraseTracker == 1){
				SeaTwoPhraseTracker = 2;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The water is a crystal clear blue.");
				
			}else if(SeaTwoPhraseTracker == 2){
				SeaTwoPhraseTracker = 3;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Sometimes I wonder what the future holds for me... I hope there is a future.");
				
			}else if(SeaTwoPhraseTracker == 3){
				SeaTwoPhraseTracker = 0;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("'No person is an island...' - I hope that's true...");
				
			}
		}
		
		
		private function SeaHandler():void{
			if(SeaPhraseTracker == 0){
				SeaPhraseTracker = 1;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ocean is so peaceful.");

			}else if(SeaPhraseTracker == 1){
				SeaPhraseTracker = 2;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("How am I ever going to get off this island ?");

			}else if(SeaPhraseTracker == 2){
				SeaPhraseTracker = 3;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Just stay calm... have to stay calm and figure this out.");

			}else if(SeaPhraseTracker == 3){
				SeaPhraseTracker = 0;
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ocean... it is vast... I feel so small.");

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
			
			
			this.assets.removeTexture("heroBoatVista_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("heroBoatVista_01");
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
