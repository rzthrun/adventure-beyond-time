package screens.hud
{
	import flash.filesystem.File;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class Menu extends Sprite
	{
		private var assets:AssetManager;
		private var MenuButton:Image;
	
		private var touches:Vector.<Touch>;
		private var targ:Object;	
		
		public function Menu(_assets:AssetManager)
		{
			super();
			assets = _assets;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
	//		if((stage.getChildAt(0) as Object).CheckAsset('hud_menu') === false){
	//			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/Menu/element_hud_menu_v003a001.png'));
	//			(stage.getChildAt(0) as Object).TrackAssets('hud_menu');
	//		}
			
	//		this.assets.loadQueue(function(n:Number):void{
	//			if(n==1){
					onLoadAssets();
	//			}				
	//		});						
			
		}		
		private function onLoadAssets():void{
			MenuButton = new Image(this.assets.getTexture('element_hud_menu_v003a001'));
			MenuButton.x = 0;
			MenuButton.y = 0;
			this.addChild(MenuButton);
			
			this.addEventListener(TouchEvent.TOUCH,OnClickHandler);

		}
		private function OnClickHandler(e:TouchEvent):void{
			targ = e.target;
			
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.BEGAN) {
					if(targ == MenuButton){
						Exit();
					}
				}
			}
		}		
		
		
		public function Exit():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowmThree();
			(stage.getChildAt(0) as Object).screenGamePlayHandler.FadeOut();
		}
		
	}
}