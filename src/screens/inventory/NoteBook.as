package screens.inventory
{
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.display.Shape;
	
	public class NoteBook extends Sprite
	{
		public var assets:AssetManager;
		
		public var bg:Shape;
		public var openbookBg:Image;
		
		
		public function NoteBook(_assets:AssetManager)
		{
			super();
			assets = _assets;
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
				}				
			});	
		}
		
		private function onLoadAssets():void{
			CreateBg();
		}
		
		private function CreateBg():void{
			bg = new Shape();
			this.addChildAt(bg,0);
			bg.graphics.beginFill(0x000000);
			bg.graphics.lineTo(0,0);	
			bg.graphics.lineTo(800,0);	
			bg.graphics.lineTo(800,480);	
			bg.graphics.lineTo(0,480);	
			bg.touchable = true;
			bg.graphics.endFill(false);
			bg.alpha = 0.5;
			//	openBookbg.graphics.precisionHitTest = true;				
			
		}
	}
}