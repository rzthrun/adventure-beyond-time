package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class OuttroStars extends Sprite
	{	
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Shape;
		
		private var stars_mc:MovieClip;
		private var light:Image;
		private var white:Shape;
		private var title:Image;
		private var credits:Image;
		
		
		
		public var delayedCall:DelayedCall;
		public var delayRemoveInventory:DelayedCall;
		private var LightTween:Tween;
		private var WhiteTween:Tween;
		private var TitleTween:Tween;
		private var CreditTween:Tween;
		
		private var FromCrater:Boolean = false;
		private var CreditState:String = 'title';
		private var touches:Vector.<Touch>;
		private var targ:Object;

		private var Animating:Boolean = true;
		
		public function OuttroStars(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('outtroStars_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroStars/OuttroStars_Sprite.png'));
				game.TrackAssets('outtroStars_01');
			}
			if(game.CheckAsset('outtroStars_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroStars/OuttroStars_Sprite.xml'));
				game.TrackAssets('outtroStars_02');
			}
			if(game.CheckAsset('outtroStars_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroStars/Title_Sprite.png'));
				game.TrackAssets('outtroStars_03');
			}
			if(game.CheckAsset('outtroStars_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroStars/Title_Sprite.xml'));
				game.TrackAssets('outtroStars_04');
			}
			if(game.CheckAsset('outtroStars_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroStars/Light_Sprite.png'));
				game.TrackAssets('outtroStars_05');
			}
			if(game.CheckAsset('outtroStars_06') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/OuttroStars/Light_Sprite.xml'));
				game.TrackAssets('outtroStars_06');
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

		}
		
		private function onLoadAssets():void{
	
			(stage.getChildAt(0) as Object).screenGamePlayHandler.removeInventory();

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.OuttroStars != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.OuttroStars['FromCrater'] == 'Yes'){
					FromCrater = true;
				}
					
			}
			SaveArray['FromCrater'] = "No";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('OuttroStars',SaveArray);

			bg = new Shape();
			bg.touchable = true;
			bg.graphics.beginFill(0x000000);
			
			bg.graphics.lineTo(0,0);												
			bg.graphics.lineTo(800,0);												
			bg.graphics.lineTo(800,512);												
			bg.graphics.lineTo(0,512);												

			bg.graphics.endFill(false);
			bg.alpha = 0.0;
			
			bg.graphics.precisionHitTest = true;	
			this.addChild(bg);
				
			stars_mc = new MovieClip(this.assets.getTextures("stars_frame__"),12);
			stars_mc.x = 0;
			stars_mc.y = 0;
			stars_mc.width = stars_mc.width*2;
			stars_mc.height = stars_mc.height*2;
			stars_mc.touchable = true;
			stars_mc.loop = true; 

			stars_mc.play();
			
			
			light = new Image(this.assets.getTexture('light'));
			light.touchable = false;
			light.pivotX = 142.5
			light.pivotY = 142.5
			light.x = 398;
			light.y = 253;
			light.width = 1;
			light.height = 1;
			light.alpha = 0;
			
			
			white = new Shape();
			white.touchable = false;
			white.graphics.beginFill(0xffffff);
			white.graphics.lineTo(0,0);	
			white.graphics.lineTo(800,0);	
			white.graphics.lineTo(800,512);	
			white.graphics.lineTo(0,512);	
			white.graphics.endFill(false);
			white.alpha = 1;
			
			title = new Image(this.assets.getTexture('Title_two'));
			title.x = 0;
			title.y = 60;
			title.alpha = 0;
			title.touchable = false;
			
			credits = new Image(this.assets.getTexture('credit'));
			credits.x = 0;
			credits.y = 0;
			credits.alpha = 0;
			credits.touchable = false;
			
			this.addChild(title);	
			this.addChild(stars_mc);
			this.addChild(light);
			this.addChild(credits);
			this.addChild(title);
			this.addChild(white);
		
			Starling.juggler.add(stars_mc);
			
			delayedCall = new DelayedCall(function():void{
				FadeOutWhite();
			},2);
			Starling.juggler.add(delayedCall);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("WindOne",0,0.7,'stop');
		}
		
		private function FadeOutWhite():void{
			WhiteTween = new Tween(white, 2, Transitions.LINEAR);
			WhiteTween.fadeTo(0);
			WhiteTween.onComplete = function():void{
				//AddPortalEnterFrame();	
				ZoomLight();
				
				WhiteTween = null;
				
			}
			Starling.juggler.add(WhiteTween);
		}
		
		
		private function DelayZoom():void{
			delayedCall = new DelayedCall(ZoomLight,1);
			Starling.juggler.add(delayedCall);
		}
		
		private function ZoomLight():void{
			light.alpha = 1;
			LightTween = new Tween(light, 4.5, Transitions.EASE_IN);
			LightTween.animate('width', 1710);
			LightTween.animate('height', 1710);
			LightTween.onComplete = function():void{
				//AddPortalEnterFrame();	
				if(FromCrater === false){
					FadeInWhite();
				}else{
					FadeInWhiteTwo();
				}
				delayedCall = null;
				LightTween = null
				
			}
			Starling.juggler.add(LightTween);
		}
		
		private function GoToSurface():void{
	//		(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
			FadeOut((OuttroSurface as Class), 			
				(stage.getChildAt(0) as Object).screenGamePlayHandler.OuttroSurfaceObj,true
			);
		}
		
		private function GoToEnd():void{
			
		}
		
		private function FadeInWhite():void{
			WhiteTween = new Tween(white, 2, Transitions.LINEAR);
			WhiteTween.fadeTo(1);
			WhiteTween.onComplete = function():void{
				//AddPortalEnterFrame();	
				
					GoToSurface();
				
				WhiteTween = null;
				
			}
			Starling.juggler.add(WhiteTween);
		}
		private function FadeInWhiteTwo():void{
			WhiteTween = new Tween(white, 1, Transitions.LINEAR);
			WhiteTween.fadeTo(1);
			WhiteTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.removeMenuButton();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.OuttroStars != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.OuttroStars;
				}
				SaveArray['FromCrater'] = "No";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('OuttroStars',SaveArray);
				
				stars_mc.stop();
				stars_mc.alpha = 0;
				light.alpha = 0;
				title.alpha = 1;
				
				
				Delayed();
				FadeOutWhiteTwo();
				WhiteTween = null;
				
			}
			Starling.juggler.add(WhiteTween);
		}
		private function Delayed():void{
			
			(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("LightBeam",0,2.0,'stop');
			Starling.juggler.delayCall(function():void{
				Animating = false;
				(stage.getChildAt(0) as Object).MusicObj.LoadJamLoop(true,999);
			},2);
			
		}
		
		private function FadeOutWhiteTwo():void{
			WhiteTween = new Tween(white, 1, Transitions.LINEAR);
			WhiteTween.fadeTo(0);
			WhiteTween.onComplete = function():void{
				
				WhiteTween = null;
				
			}
			Starling.juggler.add(WhiteTween);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(CreditState == 'title'){
							CreditState = 'credit';
							Animating = true;
							FadeTitle();
						}else if(CreditState == 'credit'){
							CreditState = 'credit';
							Animating = true;
							FadeOutCredits();
						}
					}
				}
			}
		}
		
		private function FadeTitle():void{
			TitleTween = new Tween(title, 2, Transitions.LINEAR);
			TitleTween.fadeTo(0);
			TitleTween.onComplete = function():void{
				FadeInCredits();
	
			}
			Starling.juggler.add(TitleTween);
		}
		private function FadeInCredits():void{
			CreditTween = new Tween(credits, 2, Transitions.LINEAR);
			CreditTween.fadeTo(1);
			CreditTween.onComplete = function():void{
				Animating = false;
				TitleTween = null;
				CreditTween = null;
			}
			Starling.juggler.add(CreditTween);
		}
		private function FadeOutCredits():void{
			CreditTween = new Tween(credits, 2, Transitions.LINEAR);
			CreditTween.fadeTo(0);
			CreditTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("JamLoop",0,2,'stop');
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(1,2,
					(stage.getChildAt(0) as Object).addMainMenuFromFinish
				);
				Animating = false;
			}
			Starling.juggler.add(CreditTween);
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

			
			
			this.assets.removeTexture("OuttroStars_Sprite",true);
			this.assets.removeTexture("Title_Sprite",true);
			this.assets.removeTexture("Light_Sprite",true);
			this.assets.removeTextureAtlas("OuttroStars_Sprite",true);
			this.assets.removeTextureAtlas("Title_Sprite",true);
			this.assets.removeTextureAtlas("Light_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("outtroStars_01");
			(stage.getChildAt(0) as Object).falseAsset("outtroStars_02");
			(stage.getChildAt(0) as Object).falseAsset("outtroStars_03");
			(stage.getChildAt(0) as Object).falseAsset("outtroStars_04");
			(stage.getChildAt(0) as Object).falseAsset("outtroStars_05");
			(stage.getChildAt(0) as Object).falseAsset("outtroStars_06");
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