package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class FarCoastCorner extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var waterFall_mc:MovieClip;

		private var hit_TriremeDeck:Shape;
		private var hit_FarCoastCliff:Shape;
	
		private var hit_waterfall:Shape;
		private var hit_cave:Shape;
		private var hit_water:Shape;
		private var hit_sand:Shape;
		private var hit_sky:Shape;
		
		private var touches:Vector.<Touch>;	
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function FarCoastCorner(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('farCoastCorner_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCorner/farCoastCorner_bg.jpg'));
				game.TrackAssets('farCoastCorner_01');
			}
			if(game.CheckAsset('farCoastCorner_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCorner/FarCoastCorner_Sprite.png'));
				game.TrackAssets('farCoastCorner_02');
			}
			if(game.CheckAsset('farCoastCorner_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastCorner/FarCoastCorner_Sprite.xml'));
				game.TrackAssets('farCoastCorner_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FarCoastCorner","FarCoastCornerObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('farCoastCorner_bg'));
			bg.touchable = true;
			this.addChild(bg);
						
			//FadeOutOcean(1);
			
			waterFall_mc = new MovieClip(this.assets.getTextures("waterfall_"),3);
			//		LargeWheel_mc.smoothing = TextureSmoothing.NONE;
			waterFall_mc.x = 142;
			waterFall_mc.y = 120;
			waterFall_mc.width = 420;
			waterFall_mc.height = 304;
			waterFall_mc.alpha = 0.8;
			waterFall_mc.touchable = false;
			waterFall_mc.loop = true; // default: true
		//	waterFall_mc.play();
			this.addChild(waterFall_mc);	
			Starling.juggler.add(waterFall_mc);
			
			CreateHitCave();
			CreateHitSand();
			CreateHitWaterfall();
			CreateHitWater();
			CreateHitSky();
			CreateHitTriemeDeck();
			CreateHitFarCoastCliff();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
		

			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.2,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipCreaks",0,0.2,'stop');
			if((stage.getChildAt(0) as Object).AmbientObj.currentAmbient == 'Waterfall'){
				trace("BARK1");
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
			}else{
				trace("BARK2");
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999,2);
				},0.7);
			}
		
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Waterfall';
		}
		
		private function CreateHitSky():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(383,0);																																																																																																																														
			hit_sky.graphics.lineTo(657,0);																																																																																																																														
			hit_sky.graphics.lineTo(666,122);																																																																																																																														
			hit_sky.graphics.lineTo(525,122);																																																																																																																														
			hit_sky.graphics.lineTo(387,40);																																																																																																																														
			
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		private function CreateHitWater():void{
			hit_water = new Shape();
			hit_water.touchable = false;
			hit_water.graphics.beginFill(0xff0000);
			
			hit_water.graphics.lineTo(436,374);																																																																																																																														
			hit_water.graphics.lineTo(523,355);																																																																																																																														
			hit_water.graphics.lineTo(791,386);																																																																																																																														
			hit_water.graphics.lineTo(605,505);																																																																																																																														
			hit_water.graphics.lineTo(437,508);																																																																																																																														
			hit_water.graphics.lineTo(514,425);																																																																																																																														
		
			hit_water.graphics.endFill(false);
			hit_water.alpha = 0.0;
			
			hit_water.graphics.precisionHitTest = true;	
			this.addChild(hit_water);
		}
		
		private function CreateHitWaterfall():void{
			hit_waterfall = new Shape();
			hit_waterfall.touchable = false;
			hit_waterfall.graphics.beginFill(0xff0000);
			
			hit_waterfall.graphics.lineTo(208,154);																																																																																																																														
			hit_waterfall.graphics.lineTo(331,161);																																																																																																																														
			hit_waterfall.graphics.lineTo(401,335);																																																																																																																														
			hit_waterfall.graphics.lineTo(378,366);																																																																																																																														
			hit_waterfall.graphics.lineTo(244,307);																																																																																																																														
			hit_waterfall.graphics.lineTo(206,234);																																																																																																																														
																																																																																																																																
			
			hit_waterfall.graphics.endFill(false);
			hit_waterfall.alpha = 0.0;
			
			hit_waterfall.graphics.precisionHitTest = true;	
			this.addChild(hit_waterfall);
		}
		
		private function CreateHitSand():void{
			hit_sand = new Shape();
			hit_sand.touchable = false;
			hit_sand.graphics.beginFill(0xff0000);
			
			hit_sand.graphics.lineTo(93,419);																																																																																																																														
			hit_sand.graphics.lineTo(216,387);																																																																																																																														
			hit_sand.graphics.lineTo(336,416);																																																																																																																														
			hit_sand.graphics.lineTo(411,512);																																																																																																																														
			hit_sand.graphics.lineTo(0,512);																																																																																																																														
			
			hit_sand.graphics.endFill(false);
			hit_sand.alpha = 0.0;
			
			hit_sand.graphics.precisionHitTest = true;	
			this.addChild(hit_sand);
		}
		
		
		private function CreateHitCave():void{
			hit_cave = new Shape();
			hit_cave.touchable = false;
			hit_cave.graphics.beginFill(0xff0000);
			
			hit_cave.graphics.lineTo(158,64);																																																																																																																														
			hit_cave.graphics.lineTo(233,17);																																																																																																																														
			hit_cave.graphics.lineTo(317,44);																																																																																																																														
			hit_cave.graphics.lineTo(326,149);																																																																																																																														
			hit_cave.graphics.lineTo(240,161);																																																																																																																														
			hit_cave.graphics.lineTo(172,126);																																																																																																																														
																																																																																																																																
			hit_cave.graphics.endFill(false);
			hit_cave.alpha = 0.0;
			
			hit_cave.graphics.precisionHitTest = true;	
			this.addChild(hit_cave);
		}
		
		private function CreateHitFarCoastCliff():void{
			hit_FarCoastCliff = new Shape();
			hit_FarCoastCliff.touchable = false;
			hit_FarCoastCliff.graphics.beginFill(0xff0000);
			
			hit_FarCoastCliff.graphics.lineTo(0,83);																																																																																																																														
			hit_FarCoastCliff.graphics.lineTo(68,105);																																																																																																																														
			hit_FarCoastCliff.graphics.lineTo(123,182);																																																																																																																														
			hit_FarCoastCliff.graphics.lineTo(169,296);																																																																																																																														
			hit_FarCoastCliff.graphics.lineTo(206,372);																																																																																																																														
			hit_FarCoastCliff.graphics.lineTo(170,402);																																																																																																																														
			hit_FarCoastCliff.graphics.lineTo(96,379);																																																																																																																														
			hit_FarCoastCliff.graphics.lineTo(0,370);																																																																																																																														
			hit_FarCoastCliff.graphics.endFill(false);
			hit_FarCoastCliff.alpha = 0.0;
			
			hit_FarCoastCliff.graphics.precisionHitTest = true;	
			this.addChild(hit_FarCoastCliff);
		}
		
		private function CreateHitTriemeDeck():void{
			hit_TriremeDeck = new Shape();
			hit_TriremeDeck.touchable = false;
			hit_TriremeDeck.graphics.beginFill(0xff0000);
			
			hit_TriremeDeck.graphics.lineTo(425,179);																																																																																																																														
			hit_TriremeDeck.graphics.lineTo(559,140);																																																																																																																														
			hit_TriremeDeck.graphics.lineTo(703,220);																																																																																																																														
			hit_TriremeDeck.graphics.lineTo(744,301);																																																																																																																														
			hit_TriremeDeck.graphics.lineTo(793,341);																																																																																																																														
			hit_TriremeDeck.graphics.lineTo(783,375);																																																																																																																														
			hit_TriremeDeck.graphics.lineTo(547,352);																																																																																																																														
			hit_TriremeDeck.graphics.lineTo(450,334);																																																																																																																														
																																																																																																																															
			hit_TriremeDeck.graphics.endFill(false);
			hit_TriremeDeck.alpha = 0.0;
			
			hit_TriremeDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_TriremeDeck);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((FarCoast as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastObj,true
						);
					}else if(hit_TriremeDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
						
						FadeOut((TriremeDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.TriremeDeckObj,true
						);	
					}else if(hit_FarCoastCliff.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FarCoastCliff as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastCliffObj,true
						);	
					}else if(hit_waterfall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The waterfall is pouring down into the sea, sending plumes of mist rising into the air.');
					}else if(hit_cave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Water is rushing out of an opening in the cliffs.');
					}else if(hit_water.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The water is churning rapidly under the force of the waterfall.');
					}else if(hit_sand.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Sand... the bones and shells of countless long dead sea creatures...');
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Trees poke out about the rim of the cliffs.');
					}
					
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
			
			
			this.assets.removeTexture("farCoastCorner_bg",true);
			(stage.getChildAt(0) as Object).falseAsset("farCoastCorner_01");
			this.assets.removeTexture("FarCoastCorner_SpriteSheet_01",true);
			(stage.getChildAt(0) as Object).falseAsset("farCoastCorner_02");
			this.assets.removeTextureAtlas("FarCoastCorner_SpriteSheet_01",true);
			(stage.getChildAt(0) as Object).falseAsset("farCoastCorner_03");
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
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


