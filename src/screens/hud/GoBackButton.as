package screens.hud
{
	import flash.filesystem.File;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public  class GoBackButton extends Sprite{

		private var assets:AssetManager;
		public var SourceImage:Image;
		public function GoBackButton(_assets:AssetManager)
		{
			super();
			this.assets = _assets;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
	//		this.assets = new AssetManager();
			if((stage.getChildAt(0) as Object).CheckAsset('goback') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/GoBack/element_hud_goBack_v003a001.png'));
				(stage.getChildAt(0) as Object).TrackAssets('goback');
			}
		//	this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/HUD/GoBack/element_hud_goBack_v003a001.png'));
			//this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/IntroSequence'));
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});						
				
		}		
		private function onLoadAssets():void{
			SourceImage = new Image(this.assets.getTexture('element_hud_goBack_v003a001'));
			SourceImage.x = 690;
			SourceImage.y = 0;
			this.addChild(SourceImage);
		}
		
	}
}