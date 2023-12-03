package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	
	public class ChamberBlueNautilusEmbedded extends Sprite
	{
		public var Loaded:Boolean = false;
		
		public var _increment:Function;
		public var _callback:Function;
		
		public var assets:AssetManager;
		
		public function ChamberBlueNautilusEmbedded(_assets:AssetManager,increment:Function,callback:Function)
		{
			super();
			assets = _assets;
			_increment = increment;
			_callback = callback;
			//	this.assets = new AssetManager();
			//this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/WheelLock/LargeWheelAnima/part_01/SpriteSheet/LargeWheelPart_01_Sprite.png'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlueNautilus/ChamberBlueNautilus_Sprite_01.png'));
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlueNautilus/ChamberBlueNautilus_Sprite_01.xml'));
			
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/WheelLock/LargeWheelPart_02_Sprite.png'));
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/WheelLock/LargeWheelPart_02_Sprite.xml'));
			
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/WheelLock/MidWheelPart_01_Sprite.png'));
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/WheelLock/MidWheelPart_01_Sprite.xml'));
			
			this.assets.loadQueue(function(n:Number):void{
				trace("n0: "+n);
				
				//	(stage.getChildAt(0) as Object).PreLoaderObj.IncreaseBarSize()
				//this.parent.IncreaseBarSize();
				if(n==1){
					_increment();
					_callback();
					trace("n2: "+n);
					//		Loaded = true;
					Loaded = true;
					return;
				}		
			});		
		}
	}
}