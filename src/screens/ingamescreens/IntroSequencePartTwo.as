package screens.ingamescreens
{	
	import flash.filesystem.File;
	
	import events.ImageLoadEvent;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;

	public class IntroSequencePartTwo extends Sprite
	{
		
		private var game:Game;
		private var assets:AssetManager;
		private var animating:Boolean = true;
		private var delayedCall:DelayedCall;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var bg:Image;
		private var bgTween:Tween;
		
		private var bgTwo:Image;
		private var bgTwoTween:Tween;
		
		private var lightning_one:Image;
		private var lightning_two:Image
		private var lightning_oneTween:Tween;
		private var lightning_oneTween2:Tween;
		private var lightning_twoTween:Tween;
		private var lightning_twoTween2:Tween;

		private var rain:PDParticleSystem;
		
		public function IntroSequencePartTwo(_assets:AssetManager,_game:Game)
		{
			super();
			assets = _assets;
			game = _game;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(game.CheckAsset('introPartTwo_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/particles/rain/particle.pex'));
				game.TrackAssets('introPartTwo_01');
			}
			if(game.CheckAsset('introPartTwo_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/particles/rain/texture2.png'));
				game.TrackAssets('introPartTwo_02');
			}
			if(game.CheckAsset('introPartTwo_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequencePartTwo/IntroSequencePartTwo_spriteSheet_01.jpg'));
				game.TrackAssets('introPartTwo_03');
			}
			if(game.CheckAsset('introPartTwo_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequencePartTwo/IntroSequencePartTwo_spriteSheet_01.xml'));
				game.TrackAssets('introPartTwo_04');
			}
			
			if(game.CheckAsset('introPartTwo_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequencePartTwo/IntroSequencePartTwo_spriteSheet_02.png'));
				game.TrackAssets('introPartTwo_05');
			}
			
			if(game.CheckAsset('introPartTwo_06') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequencePartTwo/IntroSequencePartTwo_spriteSheet_02.xml'));
				game.TrackAssets('introPartTwo_06');
			}
			
			
			
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});	
			
		}
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('roughstorm_bg'));
			bg.touchable = false;
			bg.x = 0;
			bg.y = 0;
			bg.alpha = 0;
			this.addChildAt(bg,0);
			
			bgTwo = new Image(this.assets.getTexture('roughstorm_bg_two'));
			bgTwo.touchable = false;
			bgTwo.x = 0;
			bgTwo.y = 0;
			bgTwo.alpha = 0;
			this.addChildAt(bgTwo,1);
			
			lightning_one = new Image(this.assets.getTexture('lightning_one'));
			lightning_one.touchable = false;
			lightning_one.width = lightning_one.width*4;
			lightning_one.height = lightning_one.height*4;
			lightning_one.x = -50;
			lightning_one.y = -50;
			lightning_one.alpha = 0;
			
			this.addChildAt(lightning_one,2);
			
			lightning_two = new Image(this.assets.getTexture('lightning_three'));
			lightning_two.touchable = false;
			lightning_two.width = lightning_two.width*3;
			lightning_two.height = lightning_two.height*3;
			lightning_two.x = 300;
			lightning_two.y = -200;
			lightning_two.alpha = 0;
		
			this.addChildAt(lightning_two,3);
			
			
			rain = new PDParticleSystem(this.assets.getXml('particle'),this.assets.getTexture('texture2'));
			
			rain.y = 300;
			rain.x = 400;
			rain.scaleX = 9;
			rain.scaleY = 4;
		//	rain.rotation = deg2rad(45);
			Starling.juggler.add(rain);
			this.addChildAt(rain,3);
			rain.start();
			
			/*
			private var waveSprite:Image;
			private var wave:Image;
			private var wavebg:Image;
			private var waveTween:Tween;
			
			*/
		
			Starling.juggler.delayCall(LightningFade,1.5);
			

		}
		
		
		
		private function LightningFade():void{
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Lightning_01();
			lightning_twoTween2  = new Tween(lightning_one, 1, Transitions.EASE_IN_OUT_BOUNCE);
			lightning_twoTween2.fadeTo(0);
			lightning_twoTween2.onComplete = function():void{
			//	Starling.juggler.purge();
				fadeInBgTwo(1);
				
			}
			
			lightning_twoTween = new Tween(lightning_one, 1, Transitions.EASE_IN_OUT_BOUNCE);
			lightning_twoTween.fadeTo(1);
			lightning_twoTween.onComplete = function():void{
				
				Starling.juggler.add(lightning_twoTween2);
				fadeInBg(0);
				
			}
			
			lightning_oneTween2 = new Tween(lightning_one, 1, Transitions.EASE_IN_OUT_BOUNCE);
			lightning_oneTween2.fadeTo(0);
			lightning_oneTween2.onComplete = function():void{
			//	lightning_one.width = -lightning_one.width;
				lightning_one.rotation = deg2rad(90);
				lightning_one.x = 850;
				Starling.juggler.add(lightning_twoTween);
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Lightning_01();
				
				fadeInBg(1);
				
				//Starling.juggler.purge();
			}
			
			lightning_oneTween = new Tween(lightning_one, 1, Transitions.EASE_IN_OUT_BOUNCE);
			lightning_oneTween.fadeTo(1);
			lightning_oneTween.onComplete = function():void{
				
				Starling.juggler.add(lightning_oneTween2);
				fadeInBg(0);
			//	Starling.juggler.purge();
			}
			Starling.juggler.add(lightning_oneTween);
			fadeInBg(1);
		}
		
		private function fadeInBg(FadeToVal:Number = 1):void{
		
			bgTween = new Tween(bg, 1, Transitions.EASE_IN_OUT_BOUNCE);
			bgTween.fadeTo(FadeToVal);
			bgTween.onComplete = function():void{
				//Starling.juggler.purge();
			}
			Starling.juggler.add(bgTween);
		}
	
		
		private function fadeInBgTwo(FadeToVal:Number = 0):void{
		//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Lightning_01();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thunder_01();
			bgTwoTween = new Tween(bgTwo, 2, Transitions.LINEAR);
			bgTwoTween.fadeTo(FadeToVal);
			bgTwoTween.onComplete = function():void{
				
				if(FadeToVal == 1){
					
					Starling.juggler.delayCall(FadeOut,1.5);
				}
				//Starling.juggler.purge();
			}
			Starling.juggler.add(bgTwoTween);
		}
		
		private function FadeOut():void{
			trace("FADE OUT");
			(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolume("MountainViolin",0,1.5);
			this.touchable = false;
			/*
			(stage.getChildAt(0) as Object).screenGamePlayHandler.addInventory();
			*/
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(1,2,this.delayExit,false);
			
		}
		
		private function delayExit(blackOut:Boolean = false):void{
			

			
			bgTwo.alpha = 0;
			rain.alpha = 0;
			Starling.juggler.delayCall(this.Exit,2);
		
		}
		private function delayExitTwo():void{
			Starling.juggler.delayCall(Exit,2);
		}
		
		private function Exit(blackOut:Boolean = false):void{
			(stage.getChildAt(0) as Object).screenGamePlayHandler.addInventory();
			Starling.juggler.purge();
			this.removeEventListeners();
			
		//	delayedCall = null;
		//	touches = null;
		//	targ.dispose();
		//	targ = null;
			
		
			
			this.assets.removeTexture("texture2",true);
			this.assets.removeTextureAtlas("particle",true);
			this.assets.removeTexture("IntroSequencePartTwo_spriteSheet_01",true);
			this.assets.removeTextureAtlas("IntroSequencePartTwo_spriteSheet_01",true);
			this.assets.removeTexture("IntroSequencePartTwo_spriteSheet_02",true);
			this.assets.removeTextureAtlas("IntroSequencePartTwo_spriteSheet_02",true);
			
			(stage.getChildAt(0) as Object).falseAsset("introPartTwo_01");
			(stage.getChildAt(0) as Object).falseAsset("introPartTwo_02");
			(stage.getChildAt(0) as Object).falseAsset("introPartTwo_03");
			(stage.getChildAt(0) as Object).falseAsset("introPartTwo_04");
			(stage.getChildAt(0) as Object).falseAsset("introPartTwo_05");
			(stage.getChildAt(0) as Object).falseAsset("introPartTwo_06");
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				LoadScene(
					Raft, 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.RaftObj
				);			
			
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,2,null,2,false);
			
			trace("EXIT INTRO");
			(stage.getChildAt(0) as Object).SavedGame.DeclareSavedGame();
			(stage.getChildAt(0) as Object).screenGamePlayHandler.UnloadScene();
			super.dispose();
			
		}
		
	}
}