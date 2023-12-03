package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	
	public class SubmarineHatchPuzzle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var bg_forward:Image;
		
		private var card:Image;
		private var enterButton:Image;
		private var resetButton:Image;
		private var screen:Image;
		private var lid:Image;
		
		private var hit_lid:Shape;
		private var hit_enterButton:Shape;
		private var hit_resetButton:Shape;
		private var hit_card:Shape;
		
		private var tBlock01:TextField;
		private var tBlock02:TextField;
		private var tBlock03:TextField;
		private var tBlock04:TextField;
		private var tBlock05:TextField;
		private var tBlock06:TextField;
		private var tBlock07:TextField;
		private var tBlock08:TextField;
		
		private var hit_tBlock01Up:Shape;
		private var hit_tBlock01Down:Shape;		
		private var hit_tBlock02Up:Shape;
		private var hit_tBlock02Down:Shape;		
		private var hit_tBlock03Up:Shape;
		private var hit_tBlock03Down:Shape;		
		private var hit_tBlock04Up:Shape;
		private var hit_tBlock04Down:Shape;		
		private var hit_tBlock05Up:Shape;
		private var hit_tBlock05Down:Shape;	
		private var hit_tBlock06Up:Shape;
		private var hit_tBlock06Down:Shape;	
		private var hit_tBlock07Up:Shape;
		private var hit_tBlock07Down:Shape;
		private var hit_tBlock08Up:Shape;
		private var hit_tBlock08Down:Shape;
		
		private var animating:Boolean = false;
		private var CardAttached:Boolean = false;
		private var LidOpen:Boolean = false;
		private var delayedCall:DelayedCall;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function SubmarineHatchPuzzle(_assets:AssetManager,_game:Game)
		{
			super();
			//	this.assets = new AssetManager();
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(game.CheckAsset('submarineHatchPuzzle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineHatchPuzzle/submarineHatchPuzzle_Sprite.png'));
				game.TrackAssets('submarineHatchPuzzle_01');
			}
			if(game.CheckAsset('submarineHatchPuzzle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineHatchPuzzle/submarineHatchPuzzle_Sprite.xml'));
				game.TrackAssets('submarineHatchPuzzle_02');
			}
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineHatchPuzzle","SubmarineHatchPuzzleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineHatchPuzzle_black_bg'));
			bg.touchable = true;
			bg.width = 800;
			bg.height = 512;
			this.addChildAt(bg,0);
			
			tBlock01 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock01.hAlign = starling.utils.HAlign.LEFT;
			tBlock01.x = 35;
			tBlock01.y = 200;
			
			
			tBlock02 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock02.hAlign = starling.utils.HAlign.LEFT;
			tBlock02.x = 127;
			tBlock02.y = 200;
			
			
			tBlock03 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock03.hAlign = starling.utils.HAlign.LEFT;
			tBlock03.x = 220;
			tBlock03.y = 200;
			
			tBlock04 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock04.hAlign = starling.utils.HAlign.LEFT;
			tBlock04.x = 316;
			tBlock04.y = 200;
			
			
			tBlock05 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock05.hAlign = starling.utils.HAlign.LEFT;
			tBlock05.x = 413;
			tBlock05.y = 200;
			
			
			tBlock06 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock06.hAlign = starling.utils.HAlign.LEFT;
			tBlock06.x = 510;
			tBlock06.y = 200;
			
			
			tBlock07 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock07.hAlign = starling.utils.HAlign.LEFT;
			tBlock07.x = 603;
			tBlock07.y = 200;
			
			
			tBlock08 = new TextField(150,120,"*","digital", 120, 0x000000);
			tBlock08.hAlign = starling.utils.HAlign.LEFT;
			tBlock08.x = 695;
			tBlock08.y = 200;
			
			bg_forward = new Image(this.assets.getTexture('hatch_forward_'));
			bg_forward.touchable = false;
		
			card = new Image(this.assets.getTexture('card'));
			card.touchable = false;
			card.x = 433;
			card.y = 17;

			enterButton = new Image(this.assets.getTexture('button_enter'));
			enterButton.touchable = false;
			enterButton.x = 75;
			enterButton.y = 37;
		
			resetButton = new Image(this.assets.getTexture('button_reset'));
			resetButton.touchable = false;
			resetButton.x = 225;
			resetButton.y = 37;
		
			screen = new Image(this.assets.getTexture('access_star'));
			screen.touchable = false;
			screen.x = 311;
			screen.y = 33;
	
			lid = new Image(this.assets.getTexture('panel'));
			lid.touchable = false;
			lid.x = 38;
			lid.y = 1;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Card'] == 'Attached'){
					bg.texture = this.assets.getTexture('submarineHatchPuzzle_yello_bg');
					card.alpha = 1;
					enterButton.alpha = 1;
					resetButton.alpha = 1;
					CardAttached = true;

					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock01'] != undefined){
						tBlock01.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock01'];
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock02'] != undefined){
						tBlock02.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock02'];
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock03'] != undefined){
						tBlock03.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock03'];
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock04'] != undefined){
						tBlock04.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock04'];
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock05'] != undefined){
						tBlock05.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock05'];
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock06'] != undefined){
						tBlock06.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock06'];
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock07'] != undefined){
						tBlock07.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock07'];
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock08'] != undefined){
						tBlock08.text = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['tBlock08'];
					}
					
					tBlock01.alpha = 1;
					tBlock02.alpha = 1;
					tBlock03.alpha = 1;
					tBlock04.alpha = 1;
					tBlock05.alpha = 1;
					tBlock06.alpha = 1;
					tBlock07.alpha = 1;
					tBlock08.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Lid'] == 'Open'){
						screen.alpha = 1;
						lid.alpha = 0;
						LidOpen = true;
					}else{
						screen.alpha = 1;
						lid.alpha = 1;
						LidOpen = false;
					}
					
				}else{
					card.alpha = 0;
					enterButton.alpha = 0;
					resetButton.alpha = 0;
					CardAttached = false;
					
					tBlock01.alpha = 0;
					tBlock02.alpha = 0;
					tBlock03.alpha = 0;
					tBlock04.alpha = 0;
					tBlock05.alpha = 0;
					tBlock06.alpha = 0;
					tBlock07.alpha = 0;
					tBlock08.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle['Lid'] == 'Open'){
						screen.alpha = 0;
						lid.alpha = 0;
						LidOpen = true;
					}else{
						screen.alpha = 0;
						lid.alpha = 1;
						LidOpen = false;
					}
				}
				
				
				
			}else{
				card.alpha = 0;
				enterButton.alpha = 0;
				resetButton.alpha = 0;
				screen.alpha = 0;
				lid.alpha = 1;
				CardAttached = false;
				
				tBlock01.alpha = 0;
				tBlock02.alpha = 0;
				tBlock03.alpha = 0;
				tBlock04.alpha = 0;
				tBlock05.alpha = 0;
				tBlock06.alpha = 0;
				tBlock07.alpha = 0;
				tBlock08.alpha = 0;
			}
			
			
			
			this.addChild(tBlock01);
			this.addChild(tBlock02);
			this.addChild(tBlock03);
			this.addChild(tBlock04);
			this.addChild(tBlock05);
			this.addChild(tBlock06);
			this.addChild(tBlock07);
			this.addChild(tBlock08);
			
			this.addChild(bg_forward);
			this.addChild(card);
			this.addChild(enterButton);
			this.addChild(resetButton);
			this.addChild(screen);
			this.addChild(lid);
			
			CreateHitCard();
			CreateHitlid();
			CreateHitEnterButton();
			CreateHitResetButton();
			
			CreateTBlockHits();

			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			},0.7);
		
			
		}
	
		private function CreateHitResetButton():void{
			hit_resetButton = new Shape();
			hit_resetButton.touchable = false;
			hit_resetButton.graphics.beginFill(0xff0000);
			
			hit_resetButton.graphics.lineTo(228,37);																																																																																																																														
			hit_resetButton.graphics.lineTo(294,37);																																																																																																																														
			hit_resetButton.graphics.lineTo(295,107);																																																																																																																														
			hit_resetButton.graphics.lineTo(228,107);																																																																																																																														
			
			hit_resetButton.graphics.endFill(false);
			hit_resetButton.alpha = 0.0;
			
			hit_resetButton.graphics.precisionHitTest = true;	
			this.addChild(hit_resetButton);
		}
	
		private function CreateHitEnterButton():void{
			hit_enterButton = new Shape();
			hit_enterButton.touchable = false;
			hit_enterButton.graphics.beginFill(0xff0000);
			
			hit_enterButton.graphics.lineTo(75,37);																																																																																																																														
			hit_enterButton.graphics.lineTo(212,36);																																																																																																																														
			hit_enterButton.graphics.lineTo(212,108);																																																																																																																														
			hit_enterButton.graphics.lineTo(74,106);																																																																																																																																																																																																																																																											
			
			hit_enterButton.graphics.endFill(false);
			hit_enterButton.alpha = 0.0;
			
			hit_enterButton.graphics.precisionHitTest = true;	
			this.addChild(hit_enterButton);
		}
	
		private function CreateHitlid():void{
			hit_lid = new Shape();
			hit_lid.touchable = false;
			hit_lid.graphics.beginFill(0xff0000);
			
			hit_lid.graphics.lineTo(53,0);																																																																																																																														
			hit_lid.graphics.lineTo(426,0);																																																																																																																														
			hit_lid.graphics.lineTo(426,120);																																																																																																																														
			hit_lid.graphics.lineTo(53,120);																																																																																																																														

			hit_lid.graphics.endFill(false);
			hit_lid.alpha = 0.0;
			
			hit_lid.graphics.precisionHitTest = true;	
			this.addChild(hit_lid);
		}
		
		private function CreateHitCard():void{
			hit_card = new Shape();
			hit_card.touchable = false;
			hit_card.graphics.beginFill(0xff0000);
			
			hit_card.graphics.lineTo(437,0);																																																																																																																														
			hit_card.graphics.lineTo(666,0);																																																																																																																														
			hit_card.graphics.lineTo(666,115);																																																																																																																														
			hit_card.graphics.lineTo(437,115);																																																																																																																														

			hit_card.graphics.endFill(false);
			hit_card.alpha = 0.0;
			
			hit_card.graphics.precisionHitTest = true;	
			this.addChild(hit_card);
		}
		
		private function CreateTBlockHits():void{
			hit_tBlock01Up = new Shape();
			this.addChild(hit_tBlock01Up);
			hit_tBlock01Up.graphics.beginFill(0x0000FF);
			hit_tBlock01Up.graphics.lineTo(16,124);	
			hit_tBlock01Up.graphics.lineTo(108,124);	
			hit_tBlock01Up.graphics.lineTo(108,253);	
			hit_tBlock01Up.graphics.lineTo(16,253);	
			
			hit_tBlock01Up.graphics.endFill(false);
			hit_tBlock01Up.alpha = 0.0;
			hit_tBlock01Up.touchable = true;
			hit_tBlock01Up.graphics.precisionHitTest = true;	
			
			hit_tBlock01Down = new Shape();
			this.addChild(hit_tBlock01Down);
			hit_tBlock01Down.graphics.beginFill(0x0000FF);
			hit_tBlock01Down.graphics.lineTo(16,124+130);	
			hit_tBlock01Down.graphics.lineTo(108,124+130);	
			hit_tBlock01Down.graphics.lineTo(108,253+130+15);	
			hit_tBlock01Down.graphics.lineTo(16,253+130+15);	
				
			hit_tBlock01Down.graphics.endFill(false);
			hit_tBlock01Down.alpha = 0.0;
			hit_tBlock01Down.touchable = true;
			hit_tBlock01Down.graphics.precisionHitTest = true;	
			
			
			hit_tBlock02Up = new Shape();
			this.addChild(hit_tBlock02Up);
			hit_tBlock02Up.graphics.beginFill(0x0000FF);
			hit_tBlock02Up.graphics.lineTo(109,124);	
			hit_tBlock02Up.graphics.lineTo(204,124);	
			hit_tBlock02Up.graphics.lineTo(204,253);	
			hit_tBlock02Up.graphics.lineTo(109,253);	
			
			hit_tBlock02Up.graphics.endFill(false);
			hit_tBlock02Up.alpha = 0.0;
			hit_tBlock02Up.touchable = true;
			hit_tBlock02Up.graphics.precisionHitTest = true;	
			
			hit_tBlock02Down = new Shape();
			this.addChild(hit_tBlock02Down);
			hit_tBlock02Down.graphics.beginFill(0x0000FF);
			hit_tBlock02Down.graphics.lineTo(109,124+130);	
			hit_tBlock02Down.graphics.lineTo(204,124+130);	
			hit_tBlock02Down.graphics.lineTo(204,253+130+15);	
			hit_tBlock02Down.graphics.lineTo(109,253+130+15);	
			
			hit_tBlock02Down.graphics.endFill(false);
			hit_tBlock02Down.alpha = 0.0;
			hit_tBlock02Down.touchable = true;
			hit_tBlock02Down.graphics.precisionHitTest = true;	
			
			hit_tBlock03Up = new Shape();
			this.addChild(hit_tBlock03Up);
			hit_tBlock03Up.graphics.beginFill(0x0000FF);
			hit_tBlock03Up.graphics.lineTo(205,124);	
			hit_tBlock03Up.graphics.lineTo(295,124);	
			hit_tBlock03Up.graphics.lineTo(295,253);	
			hit_tBlock03Up.graphics.lineTo(205,253);	
			
			hit_tBlock03Up.graphics.endFill(false);
			hit_tBlock03Up.alpha = 0.0;
			hit_tBlock03Up.touchable = true;
			hit_tBlock03Up.graphics.precisionHitTest = true;	
			
			hit_tBlock03Down = new Shape();
			this.addChild(hit_tBlock03Down);
			hit_tBlock03Down.graphics.beginFill(0x0000FF);
			hit_tBlock03Down.graphics.lineTo(205,124+130);	
			hit_tBlock03Down.graphics.lineTo(295,124+130);	
			hit_tBlock03Down.graphics.lineTo(295,253+130+15);	
			hit_tBlock03Down.graphics.lineTo(205,253+130+15);	
			
			hit_tBlock03Down.graphics.endFill(false);
			hit_tBlock03Down.alpha = 0.0;
			hit_tBlock03Down.touchable = true;
			hit_tBlock03Down.graphics.precisionHitTest = true;	
			
			hit_tBlock04Up = new Shape();
			this.addChild(hit_tBlock04Up);
			hit_tBlock04Up.graphics.beginFill(0x0000FF);
			hit_tBlock04Up.graphics.lineTo(296,124);	
			hit_tBlock04Up.graphics.lineTo(391,124);	
			hit_tBlock04Up.graphics.lineTo(391,253);	
			hit_tBlock04Up.graphics.lineTo(296,253);	
			
			hit_tBlock04Up.graphics.endFill(false);
			hit_tBlock04Up.alpha = 0.0;
			hit_tBlock04Up.touchable = true;
			hit_tBlock04Up.graphics.precisionHitTest = true;	
			
			hit_tBlock04Down = new Shape();
			this.addChild(hit_tBlock04Down);
			hit_tBlock04Down.graphics.beginFill(0x0000FF);
			hit_tBlock04Down.graphics.lineTo(296,124+130);	
			hit_tBlock04Down.graphics.lineTo(391,124+130);	
			hit_tBlock04Down.graphics.lineTo(391,253+130+15);	
			hit_tBlock04Down.graphics.lineTo(296,253+130+15);	
			
			hit_tBlock04Down.graphics.endFill(false);
			hit_tBlock04Down.alpha = 0.0;
			hit_tBlock04Down.touchable = true;
			hit_tBlock04Down.graphics.precisionHitTest = true;	
			
			hit_tBlock05Up = new Shape();
			this.addChild(hit_tBlock05Up);
			hit_tBlock05Up.graphics.beginFill(0x0000FF);
			hit_tBlock05Up.graphics.lineTo(392,124);	
			hit_tBlock05Up.graphics.lineTo(488,124);	
			hit_tBlock05Up.graphics.lineTo(488,253);	
			hit_tBlock05Up.graphics.lineTo(392,253);	
			
			hit_tBlock05Up.graphics.endFill(false);
			hit_tBlock05Up.alpha = 0.0;
			hit_tBlock05Up.touchable = true;
			hit_tBlock05Up.graphics.precisionHitTest = true;	
			
			hit_tBlock05Down = new Shape();
			this.addChild(hit_tBlock05Down);
			hit_tBlock05Down.graphics.beginFill(0x0000FF);
			hit_tBlock05Down.graphics.lineTo(392,124+130);	
			hit_tBlock05Down.graphics.lineTo(488,124+130);	
			hit_tBlock05Down.graphics.lineTo(488,253+130+15);	
			hit_tBlock05Down.graphics.lineTo(392,253+130+15);	
			
			hit_tBlock05Down.graphics.endFill(false);
			hit_tBlock05Down.alpha = 0.0;
			hit_tBlock05Down.touchable = true;
			hit_tBlock05Down.graphics.precisionHitTest = true;	
			
			hit_tBlock06Up = new Shape();
			this.addChild(hit_tBlock06Up);
			hit_tBlock06Up.graphics.beginFill(0x0000FF);
			hit_tBlock06Up.graphics.lineTo(489,124);	
			hit_tBlock06Up.graphics.lineTo(580,124);	
			hit_tBlock06Up.graphics.lineTo(580,253);	
			hit_tBlock06Up.graphics.lineTo(489,253);	
			
			hit_tBlock06Up.graphics.endFill(false);
			hit_tBlock06Up.alpha = 0.0;
			hit_tBlock06Up.touchable = true;
			hit_tBlock06Up.graphics.precisionHitTest = true;	
			
			hit_tBlock06Down = new Shape();
			this.addChild(hit_tBlock06Down);
			hit_tBlock06Down.graphics.beginFill(0x0000FF);
			hit_tBlock06Down.graphics.lineTo(489,124+130);	
			hit_tBlock06Down.graphics.lineTo(580,124+130);	
			hit_tBlock06Down.graphics.lineTo(580,253+130+15);	
			hit_tBlock06Down.graphics.lineTo(489,253+130+15);	
			
			hit_tBlock06Down.graphics.endFill(false);
			hit_tBlock06Down.alpha = 0.0;
			hit_tBlock06Down.touchable = true;
			hit_tBlock06Down.graphics.precisionHitTest = true;	
			
			hit_tBlock07Up = new Shape();
			this.addChild(hit_tBlock07Up);
			hit_tBlock07Up.graphics.beginFill(0x0000FF);
			hit_tBlock07Up.graphics.lineTo(582,124);	
			hit_tBlock07Up.graphics.lineTo(675,124);	
			hit_tBlock07Up.graphics.lineTo(675,253);	
			hit_tBlock07Up.graphics.lineTo(582,253);	
			
			hit_tBlock07Up.graphics.endFill(false);
			hit_tBlock07Up.alpha = 0.0;
			hit_tBlock07Up.touchable = true;
			hit_tBlock07Up.graphics.precisionHitTest = true;	
			
			
			hit_tBlock07Down = new Shape();
			this.addChild(hit_tBlock07Down);
			hit_tBlock07Down.graphics.beginFill(0x0000FF);
			hit_tBlock07Down.graphics.lineTo(582,124+130);	
			hit_tBlock07Down.graphics.lineTo(675,124+130);	
			hit_tBlock07Down.graphics.lineTo(675,253+130+15);	
			hit_tBlock07Down.graphics.lineTo(582,253+130+15);	
			
			hit_tBlock07Down.graphics.endFill(false);
			hit_tBlock07Down.alpha = 0.0;
			hit_tBlock07Down.touchable = true;
			hit_tBlock07Down.graphics.precisionHitTest = true;	
			
			hit_tBlock08Up = new Shape();
			this.addChild(hit_tBlock08Up);
			hit_tBlock08Up.graphics.beginFill(0x0000FF);
			hit_tBlock08Up.graphics.lineTo(676,124);	
			hit_tBlock08Up.graphics.lineTo(770,124);	
			hit_tBlock08Up.graphics.lineTo(770,253);	
			hit_tBlock08Up.graphics.lineTo(676,253);	
			
			hit_tBlock08Up.graphics.endFill(false);
			hit_tBlock08Up.alpha = 0.0;
			hit_tBlock08Up.touchable = true;
			hit_tBlock08Up.graphics.precisionHitTest = true;	
			
			hit_tBlock08Down = new Shape();
			this.addChild(hit_tBlock08Down);
			hit_tBlock08Down.graphics.beginFill(0x0000FF);
			hit_tBlock08Down.graphics.lineTo(676,124+130);	
			hit_tBlock08Down.graphics.lineTo(770,124+130);	
			hit_tBlock08Down.graphics.lineTo(770,253+130+15);	
			hit_tBlock08Down.graphics.lineTo(676,253+130+15);	
			
			hit_tBlock08Down.graphics.endFill(false);
			hit_tBlock08Down.alpha = 0.0;
			hit_tBlock08Down.touchable = true;
			hit_tBlock08Down.graphics.precisionHitTest = true;	
			
			
		}		
		
		
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((JungleSubmarineDoor as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleSubmarineDoorObj,true
							);
						}else if(CardAttached === false){	
							if(hit_card.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								CardHandler(true);
							}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(LidOpen === false){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a panel here, but I can't open it.");
								}else{
									if(hit_enterButton.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Nothing happens when I press the button.");
									}else if(hit_resetButton.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The button is inactive.");
									}
								}
							}						
						}else if(CardAttached === true){
							if(hit_card.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								CardHandler(false);
							}else if(LidOpen === false){
								if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
									lid.alpha = 0;
									LidOpen = true;
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle;
									}
									SaveArray['Lid'] = "Open";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineHatchPuzzle',SaveArray);
								}else{
									Blocktouches(e);
								}
							}else{
								if(hit_enterButton.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlop();
									Solve();
								}else if(hit_resetButton.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlop();
									ResetHandler();
								}else{
									Blocktouches(e);
								}
							}
						}	
					}
				}
			}
		}
		
	
		
		private function ResetHandler():void{
			
			screen.texture = this.assets.getTexture('access_star');
			
			tBlock01.text = '*';
			tBlock02.text = '*';
			tBlock03.text = '*';
			tBlock04.text = '*';
			tBlock05.text = '*';
			tBlock06.text = '*';
			tBlock07.text = '*';
			tBlock08.text = '*';
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle;
			}
			
			SaveArray['tBlock01'] = '*';
			SaveArray['tBlock02'] = '*';
			SaveArray['tBlock03'] = '*';
			SaveArray['tBlock04'] = '*';
			SaveArray['tBlock05'] = '*';
			SaveArray['tBlock06'] = '*';
			SaveArray['tBlock07'] = '*';
			SaveArray['tBlock08'] = '*';
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineHatchPuzzle',SaveArray);
			
			
		}
		
		private function Blocktouches(e:TouchEvent):void{
			
			if(hit_tBlock01Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('1UP');					
				BlockHandler('1','Up');
			}
			else if(hit_tBlock01Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('1d');					
				BlockHandler('1','Down');
			}
			else if(hit_tBlock02Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('2UP');					
				BlockHandler('2','Up');
			}
			else if(hit_tBlock02Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('2d');					
				BlockHandler('2','Down');
			}
			else if(hit_tBlock03Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('3UP');					
				BlockHandler('3','Up');
			}
			else if(hit_tBlock03Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('3d');					
				BlockHandler('3','Down');
			}
			else if(hit_tBlock04Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('4u');					
				BlockHandler('4','Up');
			}
			else if(hit_tBlock04Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('4d');					
				BlockHandler('4','Down');
			}
			else if(hit_tBlock05Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('5UP');					
				BlockHandler('5','Up');
			}
			else if(hit_tBlock05Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('5d');					
				BlockHandler('5','Down');
			}
			else if(hit_tBlock06Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('6u');					
				BlockHandler('6','Up');
			}
			else if(hit_tBlock06Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('6d');					
				BlockHandler('6','Down');
			}
			else if(hit_tBlock07Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('7u');					
				BlockHandler('7','Up');
			}
			else if(hit_tBlock07Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('7d');					
				BlockHandler('7','Down');
			}
			else if(hit_tBlock08Up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('8u');					
				BlockHandler('8','Up');
			}
			else if(hit_tBlock08Down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				trace('8d');					
				BlockHandler('8','Down');
			}
			
		}
		
		
		private function CardHandler(AddRemoveCard:Boolean):void{
			/*
			AddRemoveCard 
			true = add card
			false = remove card
			*/
			if(AddRemoveCard === true){
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Card)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
					bg.texture = this.assets.getTexture('submarineHatchPuzzle_yello_bg');
					card.alpha = 1;
					enterButton.alpha = 1;
					resetButton.alpha = 1;
					screen.alpha = 1;
					CardAttached = true;
					
					tBlock01.alpha = 1;
					tBlock02.alpha = 1;
					tBlock03.alpha = 1;
					tBlock04.alpha = 1;
					tBlock05.alpha = 1;
					tBlock06.alpha = 1;
					tBlock07.alpha = 1;
					tBlock08.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle;
					}
					SaveArray['Card'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineHatchPuzzle',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Card,
							"item_Card"
						);
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a thin horizontal slot with a red arrow indicating something is to be inserted");
				}
			
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
				bg.texture = this.assets.getTexture('submarineHatchPuzzle_black_bg');
				card.alpha = 0;
				enterButton.alpha = 0;
				resetButton.alpha = 0;
				screen.alpha = 0;
				CardAttached = false;
				
				tBlock01.alpha = 0;
				tBlock02.alpha = 0;
				tBlock03.alpha = 0;
				tBlock04.alpha = 0;
				tBlock05.alpha = 0;
				tBlock06.alpha = 0;
				tBlock07.alpha = 0;
				tBlock08.alpha = 0;
				
				tBlock01.text = '*';
				tBlock02.text = '*';
				tBlock03.text = '*';
				tBlock04.text = '*';
				tBlock05.text = '*';
				tBlock06.text = '*';
				tBlock07.text = '*';
				tBlock08.text = '*';
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle;
				}
				
				SaveArray['Card'] = "PickedUp";
				SaveArray['tBlock01'] = '*';
				SaveArray['tBlock02'] = '*';
				SaveArray['tBlock03'] = '*';
				SaveArray['tBlock04'] = '*';
				SaveArray['tBlock05'] = '*';
				SaveArray['tBlock06'] = '*';
				SaveArray['tBlock07'] = '*';
				SaveArray['tBlock08'] = '*';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineHatchPuzzle',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Card,
					'item_Card',
					'inven_card_sm'
				);	
			}
			
		}

		
		private function BlockHandler(blockNum:String,blockDirc:String):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
			screen.texture = this.assets.getTexture('access_star');
			if(this[('tBlock0'+blockNum)].text == '*'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'z';
				}else{
					this[('tBlock0'+blockNum)].text = '9';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '9'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '*';
				}else{
					this[('tBlock0'+blockNum)].text = '8';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '8'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '9';
				}else{
					this[('tBlock0'+blockNum)].text = '7';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '7'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '8';
				}else{
					this[('tBlock0'+blockNum)].text = '6';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '6'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '7';
				}else{
					this[('tBlock0'+blockNum)].text = '5';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '5'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '6';
				}else{
					this[('tBlock0'+blockNum)].text = '4';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '4'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '5';
				}else{
					this[('tBlock0'+blockNum)].text = '3';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '3'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '4';
				}else{
					this[('tBlock0'+blockNum)].text = '2';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '2'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '3';
				}else{
					this[('tBlock0'+blockNum)].text = '1';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '1'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '2';
				}else{
					this[('tBlock0'+blockNum)].text = '0';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == '0'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '1';
				}else{
					this[('tBlock0'+blockNum)].text = 'a';
				}
			}
			else if(this[('tBlock0'+blockNum)].text == 'a'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = '0';
				}else{
					this[('tBlock0'+blockNum)].text = 'b';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'b'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'a';
				}else{
					this[('tBlock0'+blockNum)].text = 'c';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'c'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'b';
				}else{
					this[('tBlock0'+blockNum)].text = 'd';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'd'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'c';
				}else{
					this[('tBlock0'+blockNum)].text = 'e';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'e'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'd';
				}else{
					this[('tBlock0'+blockNum)].text = 'f';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'f'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'e';
				}else{
					this[('tBlock0'+blockNum)].text = 'g';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'g'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'f';
				}else{
					this[('tBlock0'+blockNum)].text = 'h';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'h'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'g';
				}else{
					this[('tBlock0'+blockNum)].text = 'i';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'i'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'h';
				}else{
					this[('tBlock0'+blockNum)].text = 'j';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'j'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'i';
				}else{
					this[('tBlock0'+blockNum)].text = 'k';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'k'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'j';
				}else{
					this[('tBlock0'+blockNum)].text = 'l';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'l'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'k';
				}else{
					this[('tBlock0'+blockNum)].text = 'm';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'm'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'l';
				}else{
					this[('tBlock0'+blockNum)].text = 'n';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'n'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'm';
				}else{
					this[('tBlock0'+blockNum)].text = 'o';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'o'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'n';
				}else{
					this[('tBlock0'+blockNum)].text = 'p';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'p'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'o';
				}else{
					this[('tBlock0'+blockNum)].text = 'q';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'q'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'p';
				}else{
					this[('tBlock0'+blockNum)].text = 'r';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'r'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'q';
				}else{
					this[('tBlock0'+blockNum)].text = 's';
				}
			}else if(this[('tBlock0'+blockNum)].text == 's'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'r';
				}else{
					this[('tBlock0'+blockNum)].text = 't';
				}
			}else if(this[('tBlock0'+blockNum)].text == 't'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 's';
				}else{
					this[('tBlock0'+blockNum)].text = 'u';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'u'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 't';
				}else{
					this[('tBlock0'+blockNum)].text = 'v';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'v'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'u';
				}else{
					this[('tBlock0'+blockNum)].text = 'w';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'w'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'v';
				}else{
					this[('tBlock0'+blockNum)].text = 'x';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'x'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'w';
				}else{
					this[('tBlock0'+blockNum)].text = 'y';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'y'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'x';
				}else{
					this[('tBlock0'+blockNum)].text = 'z';
				}
			}else if(this[('tBlock0'+blockNum)].text == 'z'){
				if(blockDirc == 'Up'){
					this[('tBlock0'+blockNum)].text = 'y';
				}else{
					this[('tBlock0'+blockNum)].text = '*';
				}
			}
			
			SaveBlockVal(blockNum);
			
		}
		private function SaveBlockVal(blockNum:String):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle;
			}
			SaveArray['tBlock0'+blockNum] = this[('tBlock0'+blockNum)].text;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineHatchPuzzle',SaveArray);
		}
		
		
		private function Solve():void{
			trace("SOLVING");
			if(tBlock01.text == 'n'){
				trace("N");
				if(tBlock02.text == 'a'){
					trace("A");
					if(tBlock03.text == 'u'){
						trace("U");
						if(tBlock04.text == 't'){
							trace("T");
							if(tBlock05.text == 'i'){
								trace("I");
								if(tBlock06.text == 'l'){
									trace("L");
									if(tBlock07.text == 'u'){
										trace("U")
										if(tBlock08.text == 's'){
											trace("S")
											animating = true;
											(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
											(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
											
											trace('Solved');
											//greenLight.alpha = 1;
											//errorText.text = "Opening Capsule Hatch...";
										
											
											
											if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle != undefined){
												SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineHatchPuzzle;
											}
											SaveArray['Solved'] = 'yes';
											(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineHatchPuzzle',SaveArray);
											
											
											delayedCall = new DelayedCall(function():void{
												(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
												tBlock01.text = 'a';
												tBlock02.text = 'c';
												tBlock03.text = 'c';
												tBlock04.text = 'e';
												tBlock05.text = 'p';
												tBlock06.text = 't';
												tBlock07.text = 'e';
												tBlock08.text = 'd';
												
												//access_number
												ChangeScreenTexture(false);
												
												FadeOut(JungleSubmarineDoor,
													(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleSubmarineDoorObj,true
												);
												animating = false;
											}, 1.5);
											Starling.juggler.add(delayedCall);
										}else{
											SolveRejection();
										}
									}else{
										SolveRejection();
									}
								}else{
									SolveRejection();
								}
							}else{
								SolveRejection();
							}
						}else{
							SolveRejection();
						}
					}else{
						SolveRejection();
					}
				}else{
					SolveRejection();
				}
			}else{
				SolveRejection();
			}			

		}
		private function SolveRejection():void{
			
			animating = true;
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();

			delayedCall = new DelayedCall(function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
				
				ChangeScreenTexture(true);
				
				
				animating = false;
			}, 1);
			Starling.juggler.add(delayedCall);
		}
		
		private function ChangeScreenTexture(XorNum):void{
			if(XorNum === true){
				this[('screen')].texture = this.assets.getTexture('access_x');
			}else{
				this[('screen')].texture = this.assets.getTexture('access_number');
			}
		}
		
		private function FadeOut(loadClass:Class,loadObj:Object,Fade:Boolean = false):void{
			trace("FADE OUT");
			this.removeEventListener(TouchEvent.TOUCH,TouchHandler);
			
			//goBackButton.touchable = false;
			this.touchable = false;
			if(Fade === false){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(1,0.5,this.Exit);
				(stage.getChildAt(0) as Object).screenGamePlayHandler.
					LoadScene(
						loadClass, 
						loadObj
					);		
			}else{
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.
					LoadSceneAlphaFade(
						loadClass, 
						loadObj,
						this.Exit
					);				
			}
			
		}
		
		public function Exit(blackOut:Boolean = false):void{
			
			
			this.removeChild(goback);
			goback = null;			
			
			
			this.assets.removeTexture("submarineHatchPuzzle_Sprite",true);
			this.assets.removeTextureAtlas("submarineHatchPuzzle_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineHatchPuzzle_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineHatchPuzzle_02");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				//		(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
	}
}