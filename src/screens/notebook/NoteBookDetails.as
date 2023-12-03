package screens.notebook
{
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class NoteBookDetails extends Sprite
	{
		
		public var assets:AssetManager;
		
		public var bg:Shape;
		public var openbookBg:Image;
		
		public var game:Game;
		public function NoteBookDetails(_assets:AssetManager)
		{
			super();
			
			this.assets = _assets;
			
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					//		(stage.getChildAt(0) as Object).screenGamePlayHandler.hud.toggleGoBack(FrontDoorObj,true);
					onLoadAssets();
					
				}				
			});	
		}
		
		private function onLoadAssets():void{
			//	CreateBg();
			openbookBg = new Image(this.assets.getTexture('notebook_bg'));
			openbookBg.alpha =1;
			openbookBg.x = 0;
			openbookBg.y = 0;
			openbookBg.touchable = false;
			this.addChild(openbookBg);
			
			CreateBg();
		}		
		
		private function CreateBg():void{
			bg = new Shape();
			this.addChildAt(bg,0);
			bg.graphics.beginFill(0x000000);
			bg.graphics.lineTo(0,0);	
			bg.graphics.lineTo(800,0);	
			bg.graphics.lineTo(800,512);	
			bg.graphics.lineTo(0,512);	
			bg.touchable = true;
			bg.graphics.endFill(false);
			bg.alpha = 0.5;
			//	openBookbg.graphics.precisionHitTest = true;				
			
		}
		
	}
}