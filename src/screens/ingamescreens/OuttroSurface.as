package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class OuttroSurface extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;

		
		public function OuttroSurface(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('outtroSurface_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroSurface/outtroSurface_bg.jpg'));
				game.TrackAssets('outtroSurface_01');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Chamber","ChamberObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
			
			
			bg = new Image(this.assets.getTexture('outtroSurface_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
		
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopAllSounds();
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("SpaceHumPower",0,1,'stop');
			
			Starling.juggler.delayCall(function():void{
				game.MusicObj.LoadMountainFluteOne(true,1,0);
			
			},5);

		}
	
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					//	if(targ == goback.SourceImage){
					//		(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((OuttroCrater as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.OuttroCraterObj,true
						);
					//}
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
			
			
			
			this.assets.removeTexture("outtroSurface_bg",true);
			(stage.getChildAt(0) as Object).falseAsset("outtroSurface_01");
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