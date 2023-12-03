package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class CavePirateDeck extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var rope:Image;
		private var powder:Image;
		private var torch:Image;
		
		
		private var hit_PirateTopDeck:Shape;
		private var hit_PirateJunk:Shape;
		
		private var hit_water:Shape;
		private var hit_ocean:Shape;	
		private var hit_PirateTopDeckTwo:Shape;
		private var hit_gunwale:Shape
		private var hit_mast:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CavePirateDeck(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('pirateDeck_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateDeck/pirateDeck_bg.jpg'));
				game.TrackAssets('pirateDeck_01');
			}
			if(game.CheckAsset('pirateDeck_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateDeck/CavePirateDeck_Sprite.png'));
				game.TrackAssets('pirateDeck_02');
			}
			if(game.CheckAsset('pirateDeck_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateDeck/CavePirateDeck_Sprite.xml'));
				game.TrackAssets('pirateDeck_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateDeck","CavePirateDeckObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('pirateDeck_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			rope = new Image(this.assets.getTexture('junk_rope'));
			rope.touchable = false;
			rope.x = 638;
			rope.y = 272;
			

			powder = new Image(this.assets.getTexture('junk_powder'));
			powder.touchable = false;
			powder.x = 547;
			powder.y = 265;

			torch = new Image(this.assets.getTexture('junk_torch'));
			torch.touchable = false;
			torch.x = 526;
			torch.y = 269;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk['Barrel'] == 'Open'){
					powder.alpha = 1;
				}else{
					powder.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["Torch"] == "PickedUp"){
					torch.alpha = 0;
				}else{
					torch.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["Rope"] == "PickedUp"){
					rope.alpha = 0;
				}else{
					rope.alpha = 1;
				}
			}else{
				rope.alpha = 1;
				powder.alpha = 0;
				torch.alpha = 1;
				
			}
			

			this.addChildAt(rope,1);
			this.addChildAt(powder,2);		
			this.addChildAt(torch,3);
			/*
			private var rope:Image;
			private var powder:Image;
			private var torch:Image;
			*/
			CreateGunWaleHit();
			CreateWaterHit();
			CreateMastHit();
			CreateOceanHit();
			CreatePirateTopDeckTwoHit();
			CreatePirateTopDeckHit();
			CreatePirateJunkHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			},1);
		}
		
	
		
		private function CreateOceanHit():void{
			hit_ocean = new Shape();
			hit_ocean.touchable = false;
			hit_ocean.graphics.beginFill(0xff0000);
			
			hit_ocean.graphics.lineTo(0,0);	
			hit_ocean.graphics.lineTo(112,0);	
			hit_ocean.graphics.lineTo(213,112);	
			hit_ocean.graphics.lineTo(225,169);	
			hit_ocean.graphics.lineTo(190,182);	
			hit_ocean.graphics.lineTo(93,345);	
			hit_ocean.graphics.lineTo(0,369);	
		
			hit_ocean.alpha = 0.0;
			
			hit_ocean.graphics.precisionHitTest = true;	
			this.addChild(hit_ocean);
		}
		
		private function CreatePirateTopDeckTwoHit():void{
			hit_PirateTopDeckTwo = new Shape();
			hit_PirateTopDeckTwo.touchable = false;
			hit_PirateTopDeckTwo.graphics.beginFill(0xff0000);
			
			hit_PirateTopDeckTwo.graphics.lineTo(567,104);	
			hit_PirateTopDeckTwo.graphics.lineTo(615,0);	
			hit_PirateTopDeckTwo.graphics.lineTo(676,0);	
			hit_PirateTopDeckTwo.graphics.lineTo(676,122);	
		
			hit_PirateTopDeckTwo.alpha = 0.0;
			
			hit_PirateTopDeckTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_PirateTopDeckTwo);
		}
		
		private function CreateMastHit():void{
			hit_mast = new Shape();
			hit_mast.touchable = false;
			hit_mast.graphics.beginFill(0xff0000);
			
			hit_mast.graphics.lineTo(394,247);	
			hit_mast.graphics.lineTo(418,185);	
			hit_mast.graphics.lineTo(458,190);	
			hit_mast.graphics.lineTo(490,106);	
			hit_mast.graphics.lineTo(573,0);	
			hit_mast.graphics.lineTo(607,0);	
			hit_mast.graphics.lineTo(520,183);	
			hit_mast.graphics.lineTo(491,204);	
			hit_mast.graphics.lineTo(476,298);	
			hit_mast.graphics.lineTo(416,279);	
			
			hit_mast.alpha = 0.0;
			
			hit_mast.graphics.precisionHitTest = true;	
			this.addChild(hit_mast);
		}
		
		private function CreateGunWaleHit():void{
			hit_gunwale = new Shape();
			hit_gunwale.touchable = false;
			hit_gunwale.graphics.beginFill(0xff0000);
			
			hit_gunwale.graphics.lineTo(180,277);	
			hit_gunwale.graphics.lineTo(206,192);	
			hit_gunwale.graphics.lineTo(281,170);	
			hit_gunwale.graphics.lineTo(268,254);	
		
			hit_gunwale.alpha = 0.0;
			
			hit_gunwale.graphics.precisionHitTest = true;	
			this.addChild(hit_gunwale);
		}
		
		private function CreateWaterHit():void{
			hit_water = new Shape();
			hit_water.touchable = false;
			hit_water.graphics.beginFill(0xff0000);
			
			hit_water.graphics.lineTo(118,337);	
			hit_water.graphics.lineTo(191,300);	
			hit_water.graphics.lineTo(376,291);	
			hit_water.graphics.lineTo(501,326);	
			hit_water.graphics.lineTo(543,374);	
			hit_water.graphics.lineTo(644,392);	
			hit_water.graphics.lineTo(583,505);	
			hit_water.graphics.lineTo(145,504);	
			hit_water.graphics.lineTo(104,413);	
			
		
			
			hit_water.alpha = 0.0;
			
			hit_water.graphics.precisionHitTest = true;	
			this.addChild(hit_water);
		}
		
		private function CreatePirateTopDeckHit():void{
			hit_PirateTopDeck = new Shape();
			hit_PirateTopDeck.touchable = false;
			hit_PirateTopDeck.graphics.beginFill(0xff0000);
			
			hit_PirateTopDeck.graphics.lineTo(314,69);	
			hit_PirateTopDeck.graphics.lineTo(475,0);	
			hit_PirateTopDeck.graphics.lineTo(573,0);	
			hit_PirateTopDeck.graphics.lineTo(486,106);	
			hit_PirateTopDeck.graphics.lineTo(454,178);	
			
			hit_PirateTopDeck.graphics.lineTo(404,172);	
			
			hit_PirateTopDeck.graphics.lineTo(382,256);	
			hit_PirateTopDeck.graphics.lineTo(283,240);	
		
			
			hit_PirateTopDeck.alpha = 0.0;
			
			hit_PirateTopDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_PirateTopDeck);
		}
		private function CreatePirateJunkHit():void{
			hit_PirateJunk = new Shape();
			hit_PirateJunk.touchable = false;
			hit_PirateJunk.graphics.beginFill(0xff0000);
			
			hit_PirateJunk.graphics.lineTo(502,211);	
			hit_PirateJunk.graphics.lineTo(567,156);	
			hit_PirateJunk.graphics.lineTo(757,175);	
			hit_PirateJunk.graphics.lineTo(749,216);	
			hit_PirateJunk.graphics.lineTo(696,282);	
			hit_PirateJunk.graphics.lineTo(700,387);	
			hit_PirateJunk.graphics.lineTo(539,352);	
			hit_PirateJunk.graphics.lineTo(488,311);	

			
			hit_PirateJunk.alpha = 0.0;
			
			hit_PirateJunk.graphics.precisionHitTest = true;	
			this.addChild(hit_PirateJunk);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CavePirate as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateObj,true
						);
					}else if(hit_PirateTopDeckTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();	
						FadeOut((CavePirateTopDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateTopDeckObj,true
						);
						
					}else if(hit_PirateTopDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();	
							FadeOut((CavePirateTopDeck as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateTopDeckObj,true
							);
					}else if(hit_PirateJunk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CavePirateJunk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateJunkObj,true
						);
					}else if(hit_water.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship has been torn in two. Debris is scattered about the water.");
					}else if(hit_ocean.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A breeze drifts in through the cave's opening.");

					}else if(hit_gunwale.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("One of the ship's old gunports. Must have been designed for combat.");
					}else if(hit_mast.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The mast has snapped. It is held up by jumbles of rope.");
					}
					/*
					private var hit_water:Shape;
					private var hit_ocean:Shape;	
					private var hit_PirateTopDeckTwo:Shape;
					private var hit_gunwale:Shape
					private var hit_mast:Shape;
					*/
				}
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
			
			
			this.assets.removeTexture("pirateDeck_bg",true);
			this.assets.removeTexture("CavePirateDeck_Sprite",true);
			//this.assets.removeTexture("CavePirateDeck_Sprite",true);
			this.assets.removeTextureAtlas("CavePirateDeck_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateDeck_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateDeck_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateDeck_03");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
		
	}
}