package screens.hud
{

	import flash.filesystem.File;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.text.BitmapFont;

	
	public class ReadOut extends Sprite
	{
		private var assets:AssetManager;
		public var containerSprite:Sprite;
		public var bg:Image;
		public var textBlock:TextField;
		public var hit_container:Shape;
		
		private var Toggle:Boolean = false;
		private var ToggleTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;	
		
		private var delayedCall:DelayedCall;
		/*
		[Embed(source = "../../../underwood_champion.ttf",
			fontName = "Underwood Champion",
			mimeType = "application/x-font",
			fontWeight="Bold",
			fontStyle="Bold",
			advancedAntiAliasing = "true",
			embedAsCFF="false")]
		
		public static const fontMergeBold:Class;
		*/
		
		public function ReadOut(_assets:AssetManager)
		{
			super();
			
			assets = _assets;

			
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
	//		if((stage.getChildAt(0) as Object).CheckAsset('hud_readOut') === false){
	//			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/ReadOut/readOutBar_v003a001.png'));
	//			(stage.getChildAt(0) as Object).TrackAssets('hud_readOut');
	//		}
		
			//this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/IntroSequence'));
//			this.assets.loadQueue(function(n:Number):void{
//				if(n==1){
					
					onLoadAssets();
				//	(stage.getChildAt(0) as Object).createMenuButton();
//				}				
//			});						
			
		}		
		private function onLoadAssets():void{
	//		TextField.registerBitmapFont(new BitmapFont(this.assets.getTexture('UnderWood_0'),this.assets.getXml("UnderWood")),"Underwood_Champion");
			trace("this.assets.getTexture('UnderWoodPNG'): "+this.assets.getTexture('UnderWoodPNG'));
			
			
			trace("TEXT TEXTURE"+this.assets.getTexture('UnderWood_0.png'));
			trace("TEXT XML"+this.assets.getXml("UnderWood"));
			
			containerSprite = new Sprite();
			containerSprite.x = 0;
			containerSprite.y = -113;
			this.addChild(containerSprite)
			bg = new Image(this.assets.getTexture('readOutBar_v003a001'));
			bg.x = 0;
			bg.y = 0;
			this.containerSprite.addChild(bg);
		//	TextField.registerBitmapFont(new BitmapFont(this.assets.getTexture('UnderWood_0.png'),this.assets.getTexture("UnderWood.xml")));
			textBlock = new TextField(638,95,"!!!!1","Underwood Champion", 24, 0x00ffff);
			textBlock.hAlign = starling.utils.HAlign.LEFT;
			textBlock.vAlign = starling.utils.VAlign.TOP;
			textBlock.fontSize = 24;
			textBlock.x = 16;
			textBlock.y = 16;
			this.containerSprite.addChild(textBlock);
			CreateContainerHit();
			
			this.addEventListener(TouchEvent.TOUCH,onClickHandler);	
		}
		public function CreateContainerHit():void{
		
			hit_container = new Shape();
			this.containerSprite.addChild(hit_container);
			hit_container.graphics.beginFill(0x00FF00);
			hit_container.graphics.lineTo(0,0);	
			hit_container.graphics.lineTo(650,0);	
			hit_container.graphics.lineTo(650,90);	
			hit_container.graphics.lineTo(0,90);	
		
			hit_container.touchable = false;
			hit_container.graphics.endFill(false);
			hit_container.alpha = 0.0;
			hit_container.graphics.precisionHitTest = true;	
		}
		
		
		public function ToggleReadOut(ReadText:String = null):void{
			if(Toggle === false){
				Toggle = true;
				textBlock.text = ReadText;
				ToggleTween = new Tween(containerSprite,0.25,Transitions.LINEAR);
				ToggleTween.animate("y",0);
				ToggleTween.onComplete = function():void{
					delayedCall = new DelayedCall(function():void{
						//ToggleReadOut();
						HideReadOut();
						delayedCall = null;
					},3.25);
					Starling.juggler.add(delayedCall);
				};
				Starling.juggler.add(ToggleTween);
				
			}else{
				Starling.juggler.remove(delayedCall);
				delayedCall = null;
				//START NEW EDIT
				textBlock.text = ReadText;
				delayedCall = new DelayedCall(function():void{
					ToggleTween = new Tween(containerSprite,0.25,Transitions.LINEAR);
					ToggleTween.animate("y",-113);
					ToggleTween.onComplete  = function():void{
						Toggle = false;
						
					};
					Starling.juggler.add(ToggleTween);
				},3.25);
				Starling.juggler.add(delayedCall);
				//END NEW EDIT
				/*
				//REMOVED
				ToggleTween = new Tween(containerSprite,0.25,Transitions.LINEAR);
				ToggleTween.animate("y",-113);
				ToggleTween.onComplete  = function():void{
					Toggle = false;
				
				};
				Starling.juggler.add(ToggleTween);
				//END REMOVED
				*/
			}
			//	toggleButton.readjustSize();
			
		}
		
		public function HideReadOut():void{
			if(Toggle === true){
				Starling.juggler.remove(delayedCall);
				Toggle = false;
			
				ToggleTween = new Tween(containerSprite,0.25,Transitions.LINEAR);
				ToggleTween.animate("y",-113);
				ToggleTween.onComplete  = function():void{};
				Starling.juggler.add(ToggleTween);
			}
		}
		
		private function onClickHandler(e:TouchEvent):void{
			targ = e.target;
			//	c_targ = e.currentTarget;
			touches = e.getTouches(this);
			if (touches.length > 0){
				
				if (touches[0].phase == TouchPhase.BEGAN) {
					if(hit_container.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						trace('hit Containter');
						HideReadOut();
						//ToggleReadOut();
					}
				}
			}
		}
		
	}
}


