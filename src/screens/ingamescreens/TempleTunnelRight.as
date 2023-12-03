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
	
	
	public class TempleTunnelRight extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var ballFiveBlack:Image;
		private var ballSevenBlack:Image;
		private var ballFiveRed:Image;
		private var ballSevenRed:Image;
		
		private var TweenBallFive:Tween;
		private var TweenBallSeven:Tween;
		
		private var hit_ballSeven:Shape;
		private var hit_ballFive:Shape;
		
		private var hit_stone:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var BallFiveAttached:Boolean = false;
		private var BallSevenAttached:Boolean = false;
		
		public var delayedcall:DelayedCall;

		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function TempleTunnelRight(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('templeTunnelRight_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnelRight/templeTunnelRight_bg.jpg'));
				game.TrackAssets('templeTunnelRight_01');
			}
			if(game.CheckAsset('templeTunnelRight_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnelRight/TempleTunnelRight_Sprite.png'));
				game.TrackAssets('templeTunnelRight_02');
			}
			if(game.CheckAsset('templeTunnelRight_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TempleTunnelRight/TempleTunnelRight_Sprite.xml'));
				game.TrackAssets('templeTunnelRight_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("TempleTunnelRight","TempleTunnelRightObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('templeTunnelRight_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			ballSevenBlack = new Image(this.assets.getTexture('seven_black'));
		//	ballSevenBlack.smoothing = TextureSmoothing.NONE;

			ballSevenBlack.touchable = false;
			ballSevenBlack.x = 139;
			ballSevenBlack.y = 89;
			
			ballSevenRed = new Image(this.assets.getTexture('seven_red'));
		//	ballSevenRed.smoothing = TextureSmoothing.NONE;

			ballSevenRed.touchable = false;
			ballSevenRed.x = 139;
			ballSevenRed.y = 89;
			
			ballFiveBlack = new Image(this.assets.getTexture('five_black'));
		//	ballFiveBlack.smoothing = TextureSmoothing.NONE;

			ballFiveBlack.touchable = false;
			ballFiveBlack.x = 382;
			ballFiveBlack.y = 203;
			
			ballFiveRed = new Image(this.assets.getTexture('five_red'));
		//	ballFiveRed.smoothing = TextureSmoothing.NONE;

			ballFiveRed.touchable = false;
			ballFiveRed.x = 382;
			ballFiveRed.y = 203;

			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight['BallSeven'] == 'Attached'){
					BallSevenAttached = true;
					ballSevenRed.alpha = 1;
				
				}else{
					ballSevenRed.alpha = 0;
					ballSevenBlack.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight['BallFive'] == 'Attached'){
					BallFiveAttached = true;
					ballFiveRed.alpha = 1;
					
				}else{
					ballFiveRed.alpha = 0;
					ballFiveBlack.alpha = 0;
				}
			}else{
				ballFiveBlack.alpha = 0;
				ballFiveRed.alpha = 0;
				ballSevenRed.alpha = 0;
				ballSevenBlack.alpha = 0;
			}
			
			
	//		ballSevenBlack.alpha = 0;
	//		ballSevenRed.alpha = 0;
			
			
			this.addChildAt(ballSevenBlack,1);
			this.addChildAt(ballSevenRed,2);
			this.addChildAt(ballFiveBlack,3);
			this.addChildAt(ballFiveRed,4);
			CreateStoneHit();
			CreateBallHits();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
		}
	//hit_stone
		private function CreateStoneHit():void{
			
			hit_stone = new Shape();
			hit_stone.touchable = false;
			hit_stone.graphics.beginFill(0xff0000);
			
			hit_stone.graphics.lineTo(103,163);		
			hit_stone.graphics.lineTo(193,0);		
			hit_stone.graphics.lineTo(592,0);		
			hit_stone.graphics.lineTo(710,296);		
			hit_stone.graphics.lineTo(589,512);		
			hit_stone.graphics.lineTo(142,512);		
						
			hit_stone.graphics.endFill(false);
			hit_stone.alpha = 0.0;
			
			hit_stone.graphics.precisionHitTest = true;	
			this.addChild(hit_stone);
		}
		
		private function CreateBallHits():void{
			
			hit_ballFive = new Shape();
			hit_ballFive.touchable = false;
			hit_ballFive.graphics.beginFill(0xff0000);
			
			hit_ballFive.graphics.lineTo(423,249);		
			hit_ballFive.graphics.lineTo(504,190);		
			hit_ballFive.graphics.lineTo(604,208);		
			hit_ballFive.graphics.lineTo(648,305);		
			hit_ballFive.graphics.lineTo(600,380);		
			hit_ballFive.graphics.lineTo(483,377);		
			hit_ballFive.graphics.lineTo(439,334);		
			
			hit_ballFive.graphics.endFill(false);
			hit_ballFive.alpha = 0.0;
			
			hit_ballFive.graphics.precisionHitTest = true;	
			this.addChild(hit_ballFive);
			
			
			hit_ballSeven = new Shape();
			hit_ballSeven.touchable = false;
			hit_ballSeven.graphics.beginFill(0xff0000);
			
			hit_ballSeven.graphics.lineTo(150,121);		
			hit_ballSeven.graphics.lineTo(233,62);		
			hit_ballSeven.graphics.lineTo(341,101);		
			hit_ballSeven.graphics.lineTo(332,196);		
			hit_ballSeven.graphics.lineTo(251,254);		
			hit_ballSeven.graphics.lineTo(166,215);		
				
			
			hit_ballSeven.graphics.endFill(false);
			hit_ballSeven.alpha = 0.0;
			
			hit_ballSeven.graphics.precisionHitTest = true;	
			this.addChild(hit_ballSeven);
			
			
		
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
						}else if(hit_ballSeven.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BallSevenAttached === false){
								BallSevenHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The smooth areas are now glowing bright red.");
							}
						}else if(hit_ballFive.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BallFiveAttached === false){
								BallFiveHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sphere is vibrating softly.");
							}
						}else if(hit_stone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PhraseCounter == 0){
								PhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walls resemble a living organism.");
							}else if(PhraseCounter == 1){
								PhraseCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder if this cave could have been made by natural geologic forces.");
								
							}else if(PhraseCounter == 2){
								PhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The round beads appear to be slowly rising out of the stone.");
								
							}

						}
					}
				}
			}
		}
		
		private function BallSevenHandler():void{
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
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should look for a recess with same number of dots.");
				
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
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				Animating = true;
				BallSevenAttached = true;
				ballSevenBlack.alpha = 1;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight;
				}
				SaveArray['BallSeven'] = 'Attached';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TempleTunnelRight',SaveArray);	
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_DragonBallSeven,
						"item_DragonBallSeven"
					);
				

				
				delayedcall = new DelayedCall(AnimateBallSeven,1.33);
				Starling.juggler.add(delayedcall);
				
				
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The recess is a near perfectly smooth semi-sphere.");
			}
		}
		
		private function BallFiveHandler():void{
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
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should look for a recess with same number of dots.");
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallFive)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				Animating = true;
				BallFiveAttached = true;
				ballFiveBlack.alpha = 1;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight;
				}
				SaveArray['BallFive'] = 'Attached';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TempleTunnelRight',SaveArray);	
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_DragonBallFive,
						"item_DragonBallFive"
					);
				
				
				
				delayedcall = new DelayedCall(AnimateBallFive,1.33);
				Starling.juggler.add(delayedcall);

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_DragonBallSeven)
			{
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't think that's where this one goes.");
								
			}else{
				
			
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are five round dots inside.");
			}
		}
		
		private function AnimateBallSeven():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			TweenBallSeven = new Tween(ballSevenRed, 3.5, Transitions.LINEAR);
			TweenBallSeven.fadeTo(1);
			TweenBallSeven.onComplete = function():void{
				ballSevenBlack.alpha = 0;
				Animating = false;
				TweenBallSeven = null
			}
			Starling.juggler.add(TweenBallSeven);
		}
		
		private function AnimateBallFive():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
			TweenBallFive = new Tween(ballFiveRed, 3.5, Transitions.LINEAR);
			TweenBallFive.fadeTo(1);
			TweenBallFive.onComplete = function():void{
				ballFiveBlack.alpha = 0;
				Animating = false;
				TweenBallFive = null
			}
			Starling.juggler.add(TweenBallFive);
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
			
			
			this.assets.removeTexture("templeTunnelRight_bg",true);
			this.assets.removeTexture("TempleTunnelRight_Sprite",true);
			this.assets.removeTextureAtlas("TempleTunnelRight_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("templeTunnelRight_01");
			(stage.getChildAt(0) as Object).falseAsset("templeTunnelRight_02");
			(stage.getChildAt(0) as Object).falseAsset("templeTunnelRight_03");
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

