package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class TempleTunnelLeft extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		
		
		private var ballThreeBlack:Image;
		private var ballTwoBlack:Image;
		private var ballOneBlack:Image;
		
		private var ballThreeRed:Image;
		private var ballTwoRed:Image;
		private var ballOneRed:Image;
		
		private var TweenBallThree:Tween;
		private var TweenBallTwo:Tween;
		private var TweenBallOne:Tween;
		
		private var hit_ballThree:Shape;
		private var hit_ballTwo:Shape;
		private var hit_ballOne:Shape;
		
		private var BallThreeAttached:Boolean = false;
		private var BallTwoAttached:Boolean = false;
		private var BallOneAttached:Boolean = false;
		
		public var delayedcall:DelayedCall;
		
		private var hit_stone:Shape;
		
		private var hit_growth:Shape;
		
		private var Animating:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function TempleTunnelLeft(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('templeTunnelLeft_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnelLeft/templeTunnelLeft_bg.jpg'));
				game.TrackAssets('templeTunnelLeft_01');
			}
			if(game.CheckAsset('templeTunnelLeft_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnelLeft/TempleTunnelLeft_Sprite.png'));
				game.TrackAssets('templeTunnelLeft_02');
			}
			if(game.CheckAsset('templeTunnelLeft_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnelLeft/TempleTunnelLeft_Sprite.xml'));
				game.TrackAssets('templeTunnelLeft_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("TempleTunnelLeft","TempleTunnelLeftObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('templeTunnelLeft_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			ballThreeBlack = new Image(this.assets.getTexture('three_black'));
	//		ballThreeBlack.smoothing = TextureSmoothing.NONE;

			ballThreeBlack.touchable = false;
			ballThreeBlack.x = 187;
			ballThreeBlack.y = 253;
			
			
			ballThreeRed = new Image(this.assets.getTexture('three_red'));
	//		ballThreeRed.smoothing = TextureSmoothing.NONE;

			ballThreeRed.touchable = false;
			ballThreeRed.x = 187;
			ballThreeRed.y = 253;
			
			
			ballTwoBlack = new Image(this.assets.getTexture('two_black'));
	//		ballTwoBlack.smoothing = TextureSmoothing.NONE;

			ballTwoBlack.touchable = false;
			ballTwoBlack.x = 320;
			ballTwoBlack.y = 106;
			
			
			ballTwoRed = new Image(this.assets.getTexture('two_red'));
	//		ballTwoRed.smoothing = TextureSmoothing.NONE;

			ballTwoRed.touchable = false;
			ballTwoRed.x = 320;
			ballTwoRed.y = 106;
			
			
			ballOneBlack = new Image(this.assets.getTexture('one_black'));
	//		ballOneBlack.smoothing = TextureSmoothing.NONE;

			ballOneBlack.touchable = false;
			ballOneBlack.x = 511;
			ballOneBlack.y = 37;
			
			
			ballOneRed = new Image(this.assets.getTexture('one_red'));
	//		ballOneRed.smoothing = TextureSmoothing.NONE;

			ballOneRed.touchable = false;
			ballOneRed.x = 511;
			ballOneRed.y = 37;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallThree'] == 'Attached'){
					BallThreeAttached = true;
					ballThreeRed.alpha = 1;
				}else{
					ballThreeRed.alpha = 0;
					ballThreeBlack.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallTwo'] == 'Attached'){
					BallTwoAttached = true;
					ballTwoRed.alpha = 1;
				}else{
					ballTwoRed.alpha = 0;
					ballTwoBlack.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallOne'] == 'Attached'){
					BallOneAttached = true;
					ballOneRed.alpha = 1;
				}else{
					ballOneRed.alpha = 0;
					ballOneBlack.alpha = 0;
				}
			}else{
				ballThreeRed.alpha = 0;
				ballTwoRed.alpha = 0;
				ballOneRed.alpha = 0;
			}
			ballThreeBlack.alpha = 0;			
			ballTwoBlack.alpha = 0;
			ballOneBlack.alpha = 0;
			
		
			
			this.addChildAt(ballThreeBlack,1);	
			this.addChildAt(ballThreeRed,2);			
			this.addChildAt(ballTwoBlack,3);			
			this.addChildAt(ballTwoRed,4);			
			this.addChildAt(ballOneBlack,5);			
			this.addChildAt(ballOneRed,6);
			CreateGrowthHit();
			CreateStoneHit();
			CreateBallHits();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);

			
		}
		
		
		private function CreateGrowthHit():void{
			
			hit_growth = new Shape();
			hit_growth.touchable = false;
			hit_growth.graphics.beginFill(0xff0000);
			
			hit_growth.graphics.lineTo(0,0);		
			hit_growth.graphics.lineTo(215,0);		
			hit_growth.graphics.lineTo(279,229);		
			hit_growth.graphics.lineTo(0,242);		
			
			hit_growth.graphics.endFill(false);
			hit_growth.alpha = 0.0;
			
			hit_growth.graphics.precisionHitTest = true;	
			this.addChild(hit_growth);
		}
		
		private function CreateStoneHit():void{
			
			hit_stone = new Shape();
			hit_stone.touchable = false;
			hit_stone.graphics.beginFill(0xff0000);
			
			hit_stone.graphics.lineTo(39,339);		
			hit_stone.graphics.lineTo(126,204);		
			hit_stone.graphics.lineTo(506,0);		
			hit_stone.graphics.lineTo(648,23);		
			hit_stone.graphics.lineTo(651,181);		
			hit_stone.graphics.lineTo(301,463);		
			hit_stone.graphics.lineTo(150,468);		
			
			hit_stone.graphics.endFill(false);
			hit_stone.alpha = 0.0;
			
			hit_stone.graphics.precisionHitTest = true;	
			this.addChild(hit_stone);
		}
		
		private function CreateBallHits():void{
			
			hit_ballOne = new Shape();
			hit_ballOne.touchable = false;
			hit_ballOne.graphics.beginFill(0xff0000);
			
			hit_ballOne.graphics.lineTo(491,112);		
			hit_ballOne.graphics.lineTo(510,47);		
			hit_ballOne.graphics.lineTo(565,29);		
			hit_ballOne.graphics.lineTo(618,56);		
			hit_ballOne.graphics.lineTo(636,88);		
			hit_ballOne.graphics.lineTo(626,132);		
			hit_ballOne.graphics.lineTo(586,166);		
			hit_ballOne.graphics.lineTo(533,157);		
			
			hit_ballOne.graphics.endFill(false);
			hit_ballOne.alpha = 0.0;
			
			hit_ballOne.graphics.precisionHitTest = true;	
			this.addChild(hit_ballOne);
			
			hit_ballTwo = new Shape();
			hit_ballTwo.touchable = false;
			hit_ballTwo.graphics.beginFill(0xff0000);
			
			hit_ballTwo.graphics.lineTo(282,180);		
			hit_ballTwo.graphics.lineTo(312,104);		
			hit_ballTwo.graphics.lineTo(376,87);		
			hit_ballTwo.graphics.lineTo(445,105);		
			hit_ballTwo.graphics.lineTo(472,157);		
			hit_ballTwo.graphics.lineTo(469,208);		
			hit_ballTwo.graphics.lineTo(417,248);		
			hit_ballTwo.graphics.lineTo(343,236);		
			
			hit_ballTwo.graphics.endFill(false);
			hit_ballTwo.alpha = 0.0;
			
			hit_ballTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_ballTwo);
			
			
			
			hit_ballThree = new Shape();
			hit_ballThree.touchable = false;
			hit_ballThree.graphics.beginFill(0xff0000);
			
			hit_ballThree.graphics.lineTo(156,337);		
			hit_ballThree.graphics.lineTo(176,263);		
			hit_ballThree.graphics.lineTo(248,234);		
			hit_ballThree.graphics.lineTo(322,257);		
			hit_ballThree.graphics.lineTo(345,311);		
			hit_ballThree.graphics.lineTo(324,380);		
			hit_ballThree.graphics.lineTo(255,408);		
			hit_ballThree.graphics.lineTo(183,379);		
			
			hit_ballThree.graphics.endFill(false);
			hit_ballThree.alpha = 0.0;
			
			hit_ballThree.graphics.precisionHitTest = true;	
			this.addChild(hit_ballThree);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((TempleTunnel as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.TempleTunnelObj,true
							);
					
						}else if(hit_ballThree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BallThreeAttached === false){
								BallThreeHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The smooth areas are now glowing bright red.");
							}
						}else if(hit_ballTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BallTwoAttached === false){
								BallTwoHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sphere is vibrating softly.");
							}
						}else if(hit_ballOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BallOneAttached === false){
								BallOneHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The stone is full of an immense energy.");
							}
						}else if(hit_stone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Three clearly delineated shapes emerge from the stone here.");
						}else if(hit_growth.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The round growths are as hard and cold as the rest of the stone.");
						}
						
						
						//hit_stone
						
						
						//private var hit_growth:Shape;
					}
				}
			}
		}
		
		private function BallThreeHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallOne)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ball doesn't fit.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallTwo)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't get it in...");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallThree)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				Animating = true;
				BallThreeAttached = true;
				ballThreeBlack.alpha = 1;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft;
				}
				SaveArray['BallThree'] = 'Attached';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TempleTunnelLeft',SaveArray);	
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_DragonBallThree,
						"item_DragonBallThree"
					);
				
			
				delayedcall = new DelayedCall(AnimateBallThree,1.33);
				Starling.juggler.add(delayedcall);
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallFive)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't think that's where this one goes.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallSeven)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should look for a recess with the same number of dots.");
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The recess is a near perfectly smooth semi-sphere.");
			}
		}

		
		private function BallTwoHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallOne)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should look for a recess that has one circle.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallTwo)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				Animating = true;
				BallTwoAttached = true;
				ballTwoBlack.alpha = 1;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft;
				}
				SaveArray['BallTwo'] = 'Attached';
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_DragonBallTwo,
						"item_DragonBallTwo"
					);
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TempleTunnelLeft',SaveArray);	
				
				delayedcall = new DelayedCall(AnimateBallTwo,1.33);
				Starling.juggler.add(delayedcall);
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallThree)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't get it in...");
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallFive)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't think that's where this one goes.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallSeven)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ball doesn't fit.");
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are two dark circles on the surface of this cavity.");
			}
		}
		
		private function BallOneHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallOne)
			{
				Animating = true;
				BallOneAttached = true;
				ballOneBlack.alpha = 1;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft;
				}
				SaveArray['BallOne'] = 'Attached';
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_DragonBallOne,
						"item_DragonBallOne"
					);
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TempleTunnelLeft',SaveArray);	

				delayedcall = new DelayedCall(AnimateBallOne,1.33);
				Starling.juggler.add(delayedcall);
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallTwo)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should look for an opening that has two circles.");
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallThree)
			{
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't think that's where this one goes.");
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallFive)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't get it in...");
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallSeven)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ball doesn't fit.");
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walls of the cave have a smooth spherical niche.");
			}
		}
		
		private function AnimateBallThree():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			TweenBallThree = new Tween(ballThreeRed, 3.5, Transitions.LINEAR);
			TweenBallThree.fadeTo(1);
			TweenBallThree.onComplete = function():void{
				ballThreeBlack.alpha = 0;
				Animating = false;
				TweenBallThree = null
			}
			Starling.juggler.add(TweenBallThree);
		}
		
		private function AnimateBallTwo():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			TweenBallTwo = new Tween(ballTwoRed, 3.5, Transitions.LINEAR);
			TweenBallTwo.fadeTo(1);
			TweenBallTwo.onComplete = function():void{
				ballThreeBlack.alpha = 0;
				Animating = false;
				TweenBallTwo = null
			}
			Starling.juggler.add(TweenBallTwo);
		}
		
		private function AnimateBallOne():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			TweenBallOne = new Tween(ballOneRed, 3.5, Transitions.LINEAR);
			TweenBallOne.fadeTo(1);
			TweenBallOne.onComplete = function():void{
				ballThreeBlack.alpha = 0;
				Animating = false;
				TweenBallOne = null
			}
			Starling.juggler.add(TweenBallOne);
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
			
			
			this.assets.removeTexture("templeTunnelLeft_bg",true);
			this.assets.removeTexture("templeTunnelLeft_bg",true);
			this.assets.removeTextureAtlas("TempleTunnelLeft_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("templeTunnelLeft_01");
			(stage.getChildAt(0) as Object).falseAsset("templeTunnelLeft_02");
			(stage.getChildAt(0) as Object).falseAsset("templeTunnelLeft_03");
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
import starling.utils.AssetManager;

