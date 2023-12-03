package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;
	//import net.hires.debug.Stats;
	
	import starling.core.Starling;
	import starling.events.Event;

	import flash.desktop.NativeApplication;		
	
	[SWF(framerate="60",width="800",height="512",backgroundColor="0x000000"]
	
	
	//331100
	public class Main extends Sprite
	{

	//	private var stats:Stats;
		public var myStarling:Starling;		
		public static const STAGE_WIDTH:int = 800;
		public static const STAGE_HEIGHT:int = 512;
		
		
		public var viewPort:Rectangle
		public var screenWidth:int;
		public var screenHeight:int;
		
	//	public var thinFat:Boolean;
		
		public function Main()
		{
			super();

		//	stats = new Stats();
		//	this.addChild(stats);	
			SetUpStage();
		}
		
	//	public function get_thinfat():Boolean{
		//	return thinFat;
	//	}
		
		private function SetUpStage():void{
			screenWidth  = stage.fullScreenWidth;
			screenHeight = stage.fullScreenHeight;
			viewPort = new Rectangle();

			
			viewPort.height = screenHeight;
			viewPort.width  = screenWidth;
			if(screenWidth == 1024){
				viewPort.height = screenHeight-70;
				viewPort.y = 35
			
			}else if(screenWidth == 2048){
				viewPort.height = screenHeight-140;
				viewPort.y = 70
			}
			/*
			
			if(screenWidth == 1024){
			viewPort.height = screenHeight-144;
			viewPort.y = 72;
			}else if(screenWidth == 2048){
			viewPort.height = screenHeight-288;
			viewPort.width  = screenWidth;
			viewPort.y = 144;
			//viewPort.height = screenHeight;
			
			//			viewPort.width  = int(viewPort.height / (STAGE_HEIGHT/STAGE_WIDTH));
			//			viewPort.y = int((screenHeight - viewPort.height) / 2);
			//	viewPort.x = int((screenWidth - viewPort.width) / 2);
			//thinFat = true;
			}
			
			
			if ((screenHeight / screenWidth) < (STAGE_HEIGHT/STAGE_WIDTH))
			{
				trace("ONE");
				viewPort.height = screenHeight;
				viewPort.width  = screenWidth;
	//			viewPort.width  = int(viewPort.height / (STAGE_HEIGHT/STAGE_WIDTH));
	//			viewPort.y = int((screenHeight - viewPort.height) / 2);
			//	viewPort.x = int((screenWidth - viewPort.width) / 2);
				//thinFat = true;
			}
			else
			{
				trace("TWO");
				viewPort.width = screenWidth; 
				viewPort.height = screenHeight;
		//		viewPort.height = int(viewPort.width * (STAGE_HEIGHT/STAGE_WIDTH));
			//	viewPort.x = int((screenWidth - viewPort.width) / 2);
			}				
			*/
			

			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			myStarling = new Starling(Game,stage,viewPort);	
			
			myStarling.antiAliasing = 1;
			myStarling.start();		
			myStarling.stage.stageWidth  = STAGE_WIDTH;
			myStarling.stage.stageHeight = STAGE_HEIGHT;
			
			if((stage.fullScreenWidth/myStarling.stage.stageWidth) < (stage.fullScreenHeight/myStarling.stage.stageHeight)){
		//		trace(stage.fullScreenWidth/myStarling.stage.stageWidth);
		//		trace(stage.fullScreenHeight/myStarling.stage.stageHeight);
		//		viewPort.y = int((screenHeight - viewPort.height) / 2);
			}	
			// iOS formatting,
			// 100% width.
			/*
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle();
			trace("screenWidth: "+screenWidth);
			trace("screenHeight: "+screenHeight);
			trace("Ratio: "+(screenHeight / screenWidth));
			trace("Ratio2: "+(480/800));
			trace("Ratio3: "+(1536/2048));
			
			viewPort.width = screenWidth; 
			viewPort.height = screenHeight;
			viewPort.x = 0;
			viewPort.y = 0;
			
			if(screenWidth == 1024){
			viewPort.height = screenHeight-144;
			viewPort.y = 72;
			}else if(screenWidth == 2048){
			viewPort.height = screenHeight-288;
			viewPort.y = 144;
			}else if(screenWidth == 960){
			viewPort.height = screenHeight-72;
			viewPort.y = 36;
			
			}else if(screenWidth == 480){
			viewPort.height = screenHeight-36;
			viewPort.y = 18;
			}
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			myStarling = new Starling(Game, stage,viewPort);	
			
			myStarling.antiAliasing = 1;
			myStarling.start();		
			myStarling.stage.stageWidth  = STAGE_WIDTH;
			myStarling.stage.stageHeight = STAGE_HEIGHT;
			
			*/
			
			//
		}
		
		
		
	}
}