package screens
{


	import screens.ingamescreens.FreightWheelEmbedded;
	import screens.ingamescreens.PirateTopDeckEmbedded;
	import screens.ingamescreens.QueensBookEmbedded;

	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import screens.ingamescreens.FarCoastDingyEmbedded;
	import screens.ingamescreens.TriremeDeviceEmbedded;
	import screens.ingamescreens.SubmarineCaptainsEmbedded;
	import screens.ingamescreens.TemplePascalEmbedded;
	import screens.ingamescreens.ChamberBlueNautilusEmbedded;


	public class PreLoader extends Sprite
	{
		public var QueensBookImages:QueensBookEmbedded;
		public var FreighterWheelImages:FreightWheelEmbedded;
		public var PirateTopDeckImages:PirateTopDeckEmbedded;
		public var FarCoastDingyImages:FarCoastDingyEmbedded;
		public var TriremeDeviceImages:TriremeDeviceEmbedded;
		public var SubmarineCaptainsImages:SubmarineCaptainsEmbedded;
		public var TemplePascalImages:TemplePascalEmbedded;
		public var ChamberBlueNautilusImages:ChamberBlueNautilusEmbedded;
		//public var PirateCaptainsCouchImages:PirateCaptainsCouchEmbedded
		
		public var LoadBar:Shape;
		
		private var FadeTween:Tween;
		public var delayedCall:DelayedCall;
		public var assets:AssetManager;
		
	//	public var NoteBookImages = NoteBookEmbedded;
		
		public function PreLoader(_assets:AssetManager)
		{
			assets = _assets;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			
		}
		private function onAddedToStage(event:starling.events.Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			CreateLoadBar();
			QueensBookImages = new QueensBookEmbedded(this.assets,IncreaseBarSize,SecondLoad);
			//QueensBookImages = new QueensBookEmbedded(this.assets,IncreaseBarSize,SecondLoad);
		}
		public function SecondLoad():void{
			trace("SECOND LOAD");
			FreighterWheelImages = new FreightWheelEmbedded(this.assets,IncreaseBarSize,ThirdLoad);
			//QueensBookImages = new QueensBookEmbedded(this.assets,IncreaseBarSize,SecondLoad);
		}
		public function ThirdLoad():void{
			PirateTopDeckImages = new PirateTopDeckEmbedded(this.assets,IncreaseBarSize,ForthLoad);
		//	IncreaseBarSize(true);
		}
		public function ForthLoad():void{
			FarCoastDingyImages = new FarCoastDingyEmbedded(this.assets,IncreaseBarSize,FifthLoad);
			//	IncreaseBarSize(true);
		}
		public function FifthLoad():void{
			TriremeDeviceImages = new TriremeDeviceEmbedded(this.assets,IncreaseBarSize,SixthLoad);
			//	IncreaseBarSize(true);
		}
		//	public var SubmarineCaptainsImages:SubmarineCaptainsEmbedded;
		public function SixthLoad():void{
			//	FourDiscImages = new FourDiscEmbedded(this.assets,IncreaseBarSize,ThirdLoad);
			SubmarineCaptainsImages = new SubmarineCaptainsEmbedded(this.assets,IncreaseBarSize,SeventhLoad);
		}
		
		public function SeventhLoad():void{
			//	FourDiscImages = new FourDiscEmbedded(this.assets,IncreaseBarSize,ThirdLoad);
			TemplePascalImages = new TemplePascalEmbedded(this.assets,IncreaseBarSize,EigthLoad);
		}
		public function EigthLoad():void{
			//	FourDiscImages = new FourDiscEmbedded(this.assets,IncreaseBarSize,ThirdLoad);
			ChamberBlueNautilusImages = new ChamberBlueNautilusEmbedded(this.assets,IncreaseBarSize,NinthLoad);
		}
		public function NinthLoad():void{
			//	FourDiscImages = new FourDiscEmbedded(this.assets,IncreaseBarSize,ThirdLoad);
			IncreaseBarSize(true);
		}
		private function CreateLoadBar():void{
			LoadBar = new Shape();
			this.addChild(LoadBar);
			LoadBar.graphics.beginFill(0xffffff);
			LoadBar.graphics.lineTo(0,0);	
			LoadBar.graphics.lineTo(10,0);	
			LoadBar.graphics.lineTo(10,10);	
			LoadBar.graphics.lineTo(0,10);	
			
			
			LoadBar.graphics.endFill(false);
			LoadBar.alpha = 1;
			LoadBar.touchable = false;
			LoadBar.x = 195;
			LoadBar.y = 283+25;
			//	openBookbg.graphics.precisionHitTest = true;	
			trace("LOADBAR WIDTH: "+LoadBar.width);
			//LoadBar.width = 200;
			trace("LOADBAR WIDTH: "+LoadBar.width);
			
		//	OnLoadComplete();
		}
		
		public function IncreaseBarSize(complete:Boolean = false):void{
			trace("Incrementing");
			LoadBar.width = LoadBar.width+40;
			if(complete === true){
				OnLoadComplete();
			}
		}
		public function OnLoadComplete():void{
			LoadBar.width = 410;
			trace("Load Complete");
			(stage.getChildAt(0) as Object).QueensBookImages = QueensBookImages;
			(stage.getChildAt(0) as Object).FreighterWheelImages = FreighterWheelImages;
			(stage.getChildAt(0) as Object).PirateTopDeckImages = PirateTopDeckImages;
			(stage.getChildAt(0) as Object).FarCoastDingyImages = FarCoastDingyImages;
			(stage.getChildAt(0) as Object).TriremeDeviceImages = TriremeDeviceImages;
			(stage.getChildAt(0) as Object).SubmarineCaptainsImages = SubmarineCaptainsImages;
			(stage.getChildAt(0) as Object).TemplePascalImages = TemplePascalImages;
			(stage.getChildAt(0) as Object).ChamberBlueNautilusImages = ChamberBlueNautilusImages;
			delayedCall = new DelayedCall(function():void{
				(stage.getChildAt(0) as Object).screenStartUp.fadeOutCompany();
				fadeOut();
		//		(stage.getChildAt(0) as Object).addMainMenu(false);
			},1);
			Starling.juggler.add(delayedCall);
		}
		public function fadeOut():void{
			//	this.removeEventListener(TouchEvent.TOUCH,forceFadeOutCompany);
			FadeTween = new Tween(this, 2, Transitions.LINEAR);
			FadeTween.fadeTo(0);
			FadeTween.onComplete = function():void{
				DisposeOf();
			};
			Starling.juggler.add(FadeTween);			
		}
		public function DisposeOf():void{
			this.dispose();
		}
	}
}