package screens
{
	import flash.filesystem.File;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.utils.AssetManager;
	
	public class StartUpScreen extends Sprite
	{
		
		private var CompanyPlate:Image;
		public var CompanyFadeTween:Tween;
		private var delayedCall:DelayedCall;
		
		private var assets:AssetManager;	
		
		public function StartUpScreen(_assets:AssetManager)
		{
			super();
			
			this.assets = _assets;
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/MainMenu/startup/plate_AirCamp_v003a001.png'));
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});			
		}
		
		private function onLoadAssets():void{
			//switch(e.params.image
			trace("WE HAVE LOADED, SIR");
			CompanyPlate = new Image(this.assets.getTexture('plate_AirCamp_v003a001'));
			CompanyPlate.x = 184;
			CompanyPlate.y = 100+25;
			CompanyPlate.alpha = 0;
			this.addChild(CompanyPlate);	
			//		this.addEventListener(TouchEvent.TOUCH,forceFadeOutCompany);
			CompanyFadeTween = new Tween(CompanyPlate, 2, Transitions.LINEAR);
			CompanyFadeTween.fadeTo(1);
			CompanyFadeTween.onComplete = afterFadeInCompany;
			Starling.juggler.add(CompanyFadeTween);		
			
		}
		private function afterFadeInCompany():void{
			(stage.getChildAt(0) as Object).addPreLoader();
			//	delayedCall = new DelayedCall(fadeOutCompany, 2.0);
			//	Starling.juggler.add(delayedCall)
		}
		public function fadeOutCompany():void{
			//	this.removeEventListener(TouchEvent.TOUCH,forceFadeOutCompany);
			CompanyFadeTween = new Tween(this, 2, Transitions.LINEAR);
			CompanyFadeTween.fadeTo(0);
			CompanyFadeTween.onComplete = Exit;
			Starling.juggler.add(CompanyFadeTween);	
			//		(stage.getChildAt(0) as Object).PreLoaderObj.fadeOut();
		}
		private function forceFadeOutCompany(e:Event):void{			
			Starling.juggler.remove(CompanyFadeTween);
			Starling.juggler.remove(CompanyFadeTween);
			fadeOutCompany();;
			
		}		
		private function Exit():void{
			this.assets.removeTexture("plate_AirCamp_v002a002",true);
			
			
			//this.assets = null;
			CompanyPlate = null;
			CompanyFadeTween = null;
			//		(stage.getChildAt(0) as Object).addPreLoader();
			(stage.getChildAt(0) as Object).addMainMenu(false);
			this.dispose();
		}
		
		
	}
}