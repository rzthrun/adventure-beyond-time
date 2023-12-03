package screens.hud
{
	import flash.filesystem.File;
	
	//import screens.ingamescreens.BirdHouse;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class HUD extends Sprite
	{
		private var assets:AssetManager;

	//	private var goback:Image;		
	//	public var GoBackValue:String;
		
		
		private var targ:Object;
		private var touches:Vector.<Touch>;
		
		public function HUD()
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.assets = new AssetManager();
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD'));
			//this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/IntroSequence'));
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});						
			
		}		
		private function onLoadAssets():void{
	//		goback = new Image(this.assets.getTexture('element_hud_goBack_v003a001'));
	//		goback.x = 670;
	//		goback.y = 5;
	//		this.addChild(goback);
	//		this.addEventListener(TouchEvent.TOUCH,OnClickHandler);		
		}
		public function toggleGoBack(show:Boolean = false,value:String = null):void{
		//	GoBackValue = value;
		//	if(show === true){
		//		goback.touchable = true;
		//		goback.visible = true;			
		//	}else{
		//		goback.touchable = false;
		//		goback.visible = false;
		//	}
		}
		public function OnClickHandler(e:TouchEvent){
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.BEGAN) {
					trace("HUD CLICK");
		//			if(targ == goback){
		//				trace("HUD - GoBack");
		//				(stage.getChildAt(0) as Object).screenGamePlayHandler.LoadScene(0,
		//					0.5,
		//					this,
		//					(stage.getChildAt(0) as Object).screenGamePlayHandler.(GoBackValue,
		//					(stage.getChildAt(0) as Object).screenGamePlayHandler.BirdHouseObj)
		//					;
					//	FadeOut();
		//			}					
				}
			}
			
		}
	}
}