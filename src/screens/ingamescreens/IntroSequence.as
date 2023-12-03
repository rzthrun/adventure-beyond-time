package screens.ingamescreens
{
	import flash.filesystem.File;

	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
//	import starling.display.MovieClip;
//	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
//	import starling.text.TextField;
//	import starling.textures.Texture;
	import starling.utils.AssetManager;
//	import starling.utils.HAlign;
//	import starling.utils.VAlign;
//	import starling.utils.deg2rad;
	
	public class IntroSequence extends Sprite
	{
		
		
		
		private var particle:PDParticleSystem
		
		private var assets:AssetManager;
		
		private var hit_area:Shape;
		
		private var cabinSprite:Sprite;
		private var cabin_ocean:Image;
		private var cabin_bg:Image;
		private var cabin_screen:Image;
		private var cabin_screenShot:Image;
		
		private var cabinTween:Tween;
		private var cabinscreenShotTween:Tween;
		
		
		private var emailSprite:Sprite;
		private var email_doctor:Image;
		private var email_bg:Image;
		private var email_back:Image;
		private var email_text:Image;
		
		private var email_doctorTween:Tween;
		private var email_bgTween:Tween;
		private var email_textTween:Tween;
		
		private var emailCurrentPage:Number = 0;
		
		private var delayedCall:DelayedCall;

		private var touches:Vector.<Touch>;
		private var targ:Object;
	
		private var animating:Boolean = true;
		
		private var game:Game;
		
		
		public function IntroSequence(_assets:AssetManager,_game:Game)
		{
			super();
			assets = _assets;
			game = _game;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);

			
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('intro_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequence_cabin.png'));
				game.TrackAssets('intro_01');
			}
			
			if(game.CheckAsset('intro_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequence_spriteSheet.png'));
				game.TrackAssets('intro_02');
			}
			if(game.CheckAsset('intro_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequence_spriteSheet.xml'));
				game.TrackAssets('intro_03');
			}
			if(game.CheckAsset('intro_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequence_spriteSheet_02.png'));
				game.TrackAssets('intro_04');
			}
			if(game.CheckAsset('intro_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequence_spriteSheet_02.xml'));
				game.TrackAssets('intro_05');
			}
			if(game.CheckAsset('intro_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequence_spriteSheet_02.png'));
				game.TrackAssets('intro_05');
			}
			if(game.CheckAsset('intro_06') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/IntroSequence/IntroSequence_spriteSheet_02.xml'));
				game.TrackAssets('intro_06');
			}
		
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});	
			
		}
		private function onLoadAssets():void{
			
			cabinSprite = new Sprite();
			cabinSprite.x = 0;
			cabinSprite.y = 0;
			
			cabin_ocean = new Image(this.assets.getTexture('cabin_ocean'));
			cabin_ocean.pivotX = 59;
			cabin_ocean.pivotY = 59;
			cabin_ocean.width = cabin_ocean.width*2;
			cabin_ocean.height = cabin_ocean.height*2;
			cabin_ocean.x = 250;
			cabin_ocean.y = 118;
			cabin_ocean.alpha = 1;
			this.cabinSprite.addChildAt(cabin_ocean,0);
			
			cabin_bg = new Image(this.assets.getTexture('IntroSequence_cabin'));
			cabin_bg.x = 0;
			cabin_bg.y = 0;
			cabin_bg.alpha = 1;
			this.cabinSprite.addChildAt(cabin_bg,1);
			
			cabin_screen= new Image(this.assets.getTexture('IntroSequence_cabin_overlay'));
			cabin_screen.x = 800-cabin_screen.width;
			cabin_screen.y = 0;
			cabin_screen.alpha = 0;
			this.cabinSprite.addChildAt(cabin_screen,2);
			
			cabin_screenShot = new Image(this.assets.getTexture('screen'));
			cabin_screenShot.x = 470;
			cabin_screenShot.y = 128;
			cabin_screenShot.alpha = 0;
			this.cabinSprite.addChildAt(cabin_screenShot,3);
			this.addChildAt(cabinSprite,0);
			
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,2,this.FadeInCabinComputer,1,false);
		
			this.addEventListener(Event.ENTER_FRAME, oceanAnimation);

		}
		
		
		private function oceanAnimation():void{
			var currentDate:Date = new Date();
			cabin_ocean.y = 118+ (Math.cos(currentDate.getTime()*0.002)*5);
			cabin_ocean.x = 250+ (Math.sin(currentDate.getTime()*0.002)*3);
		}
		
		public function FadeInCabinComputer(blackOut:Boolean = false):void{
			Starling.juggler.delayCall(FadeInScreen,1);
		}
		private function FadeInScreen():void{
			cabinTween = new Tween(cabin_screen, 2, Transitions.LINEAR);
			cabinTween.fadeTo(1);
			cabinTween.onComplete = function():void{
				cabinscreenShotTween = new Tween(cabin_screenShot, 1, Transitions.LINEAR);
				cabinscreenShotTween.fadeTo(1);
				cabinscreenShotTween.onComplete = function():void{
					Starling.juggler.purge();
					OnScreenFadeInComplete();
					
				}
				Starling.juggler.add(cabinscreenShotTween);
			};
			Starling.juggler.add(cabinTween);
		}
		
		private function OnScreenFadeInComplete():void{
			Starling.juggler.delayCall(CreateEmail,1);
		//	this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
		private function CreateHitArea():void{
			hit_area = new Shape();
			hit_area.graphics.beginFill(0xff0000);
			
			hit_area.graphics.lineTo(0,0);
			hit_area.graphics.lineTo(800,0);	
			hit_area.graphics.lineTo(800,512);	
			hit_area.graphics.lineTo(0,512);	
				
			
			hit_area.alpha = 0.0;
			hit_area.touchable = true;
			hit_area.graphics.precisionHitTest = true;	
			this.addChildAt(hit_area,2);
		}
		private function CreateEmail():void{
			emailSprite = new Sprite();
			emailSprite.touchable = false;
			
		
			
		//	email_doctor = new Image(this.assets.getTexture('doctor'));
		//	email_doctor.touchable = false;
		//	email_doctor.x = 492;
		//	email_doctor.y = 0;
		//	email_doctor.alpha = 0;
		//	emailSprite.addChildAt(email_doctor,0);
			
			email_text = new Image(this.assets.getTexture('eng_text_00'));
			email_text.touchable = false;
			email_text.x = 0;
			email_text.y = 190;
			email_text.alpha = 0;
			emailSprite.addChildAt(email_text,0);
			this.addChildAt(emailSprite,1);
			
			
		//	email_doctorTween = new Tween(email_doctor, 1, Transitions.LINEAR);
		//	email_doctorTween.fadeTo(1);
		//	email_doctorTween.onComplete = function():void{
		//		Starling.juggler.add(email_textTween);
				
		//	}
		
			
			email_textTween = new Tween(email_text, 0.5, Transitions.LINEAR);
			email_textTween.fadeTo(1);
			email_textTween.onComplete = function():void{
				animating = false;
				Starling.juggler.purge();
				CreateHitArea();
				addTouchListener();
			}
			Starling.juggler.add(email_textTween);

		}
		
		private function addTouchListener():void{
			//cabinSprite.touchable = true;
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
		private function EmailTextFadeIn():void{
			email_textTween = new Tween(email_text, 0.5, Transitions.LINEAR);
			email_textTween.fadeTo(1);
			email_textTween.onComplete = function():void{
				animating = false;
				
				
			//	addChild(hit_area);
			}
			Starling.juggler.add(email_textTween);
		}
		
		private function EmailTextFadeOut(num:Number):void{
			animating = true;
		//	removeChild(hit_area);
			email_textTween = new Tween(email_text, 0.5, Transitions.LINEAR);
			email_textTween.fadeTo(0);
			email_textTween.onComplete = function():void{
				SwapText(num);
			}
			Starling.juggler.add(email_textTween);
		}
		
		private function SwapText(num:Number):void{
			if(num == 1){
				email_text.texture = this.assets.getTexture('eng_text_01');
			}else if(num == 2){
				email_text.texture = this.assets.getTexture('eng_text_02');
			}else if(num == 3){
				email_text.texture = this.assets.getTexture('eng_text_03');
			}
			
			EmailTextFadeIn();
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			
			if(animating === false){
				if (touches.length > 0){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
							if(hit_area.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(emailCurrentPage == 0){
									emailCurrentPage = 1;
									EmailTextFadeOut(1);
								}else if(emailCurrentPage == 1){
									emailCurrentPage = 2;
									EmailTextFadeOut(2);
								}else if(emailCurrentPage == 2){
									
									(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(1);
									emailCurrentPage = 3;
									EmailTextFadeOut(3);
								}else if(emailCurrentPage == 3){
									
									FadeOut();
								}
							}
					//	}
					}
				}
			}
		}
		
		
		
		
		
		
		

		private function FadeOut():void{
			trace("FADE OUT");

			this.touchable = false;
			/*
			(stage.getChildAt(0) as Object).screenGamePlayHandler.addInventory();
			*/
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(1,2,this.Exit,false);

		}
		private function Exit(blackOut:Boolean = false):void{
			this.removeEventListeners();

			delayedCall = null;
			touches = null;
			targ.dispose();
			targ = null;


			
			this.assets.removeTexture("IntroSequence_spriteSheet",true);
			this.assets.removeTextureAtlas("IntroSequence_spriteSheet",true);
			this.assets.removeTexture("IntroSequence_cabin",true);
			this.assets.removeTexture("IntroSequence_spriteSheet_02",true);
			this.assets.removeTextureAtlas("IntroSequence_spriteSheet_02",true);
			
			(stage.getChildAt(0) as Object).falseAsset("intro_01");
			(stage.getChildAt(0) as Object).falseAsset("intro_02");
			(stage.getChildAt(0) as Object).falseAsset("intro_03");
			(stage.getChildAt(0) as Object).falseAsset("intro_04");
			(stage.getChildAt(0) as Object).falseAsset("intro_05");
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				LoadScene(
					IntroSequencePartTwo, 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.IntroSequencePartTwoObj
				);			
			
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,1.5,null,2,false);

		//	trace("EXIT INTRO");
		//	(stage.getChildAt(0) as Object).SavedGame.DeclareSavedGame();
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene();
			super.dispose();
	
		}
		
	}
}