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
	
	
	public class Cave extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
	
		private var flint:Image;
		private var jaw:Image;
		private var marcasite:Image;
		private var fire:Image;
		private var fire_mc:MovieClip;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var hit_CaveBones:Shape;
		private var hit_CaveCorridor:Shape;
		private var hit_painting:Shape;
		private var hit_pool:Shape;
		private var hit_hole:Shape;
		
		private var poolBool:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function Cave(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cave_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Cave/cave_bg.jpg'));
				game.TrackAssets('cave_01');
			}
			if(game.CheckAsset('cave_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Cave/Cave_Sprite.png'));
				game.TrackAssets('cave_02');
			}
			if(game.CheckAsset('cave_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Cave/Cave_Sprite.xml'));
				game.TrackAssets('cave_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Cave","CaveObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('cave_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			flint = new Image(this.assets.getTexture('bones_flint'));
			flint.touchable = false;
			flint.x = 272;
			flint.y = 262;			
		
			
			
			jaw = new Image(this.assets.getTexture('bones_jaw'));
			jaw.touchable = false;
			jaw.x = 120;
			jaw.y = 279;			
			
			
			fire = new Image(this.assets.getTexture('corridor_burningTorch'));
			fire.touchable = false;
			fire.x = 548;
			fire.y = 182;			
			
			
			marcasite = new Image(this.assets.getTexture('corridor_marcasite'));
			marcasite.touchable = false;
			marcasite.x = 538;
			marcasite.y = 309;			
			marcasite.alpha = 1;
		
			
			
			fire_mc = new MovieClip(this.assets.getTextures('corridor_fire_'),6);
			//puller_mc.smoothing = TextureSmoothing.NONE;
			fire_mc.touchable = false;
			fire_mc.x = 620;
			fire_mc.y = 247;
		
			
			fire_mc.loop = true; 
			fire_mc.play();
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones["Flint"] == "PickedUp"){
					flint.alpha = 0;
				}else{
					flint.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones["Jaw"] == "PickedUp"){
					jaw.alpha = 0;
				}else{
					jaw.alpha = 1;
				}
			}else{
				flint.alpha = 1;
				jaw.alpha = 1;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Marcasite"] == "PickedUp"){
					marcasite.alpha = 0;
				}else{
					marcasite.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
					fire.alpha = 1;		
					fire_mc.alpha = 1;
					fire_mc.play();
					Starling.juggler.add(fire_mc);
				}else{
					fire.alpha = 0;		
					fire_mc.alpha = 0;
				}
			}else{
				marcasite.alpha = 1;
				fire.alpha = 0;		
				fire_mc.alpha = 0;
			}
			
			
			
			this.addChildAt(flint,1);
			this.addChildAt(jaw,2);
			this.addChildAt(fire,3);
			this.addChildAt(marcasite,4);
			this.addChildAt(fire_mc,5);
		
			
			CreateCaveBonesHit();
			CreateCavePirateHit();
			CreatePainting();
			CreatePool();
			CreateHoleHit();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDrips",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
			//(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("CaveDripsStream",0,1.5,'stop');

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
					(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
					},1);
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
					(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BurningFireOne",0,0.5,'stop');
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BurningFireOne",0,0.5,'stop');
			}
		}
		/*
		private var hit_pool:Shape;
		private var hit_hole:Shape;
		*/
		
		
		private function CreateHoleHit():void{
			hit_hole = new Shape();
			hit_hole.touchable = false;
			hit_hole.graphics.beginFill(0xff0000);
				
			hit_hole.graphics.lineTo(135,25);	
			hit_hole.graphics.lineTo(173,1);	
			hit_hole.graphics.lineTo(264,10);	
			hit_hole.graphics.lineTo(257,37);	
			hit_hole.graphics.lineTo(196,56);	
					
			hit_hole.alpha = 0.0;
			
			hit_hole.graphics.precisionHitTest = true;	
			this.addChild(hit_hole);
		}
		
		private function CreatePool():void{
			hit_pool = new Shape();
			hit_pool.touchable = false;
			hit_pool.graphics.beginFill(0xff0000);
			
			hit_pool.graphics.lineTo(156,366);	
			hit_pool.graphics.lineTo(220,348);	
			hit_pool.graphics.lineTo(444,376);	
			hit_pool.graphics.lineTo(607,368);	
			hit_pool.graphics.lineTo(693,398);	
			hit_pool.graphics.lineTo(559,435);	
			hit_pool.graphics.lineTo(532,476);	
			hit_pool.graphics.lineTo(387,466);	
			hit_pool.graphics.lineTo(195,400);	
			hit_pool.graphics.lineTo(176,380);	

			hit_pool.alpha = 0.0;
			
			hit_pool.graphics.precisionHitTest = true;	
			this.addChild(hit_pool);
		}
		
		
		
		private function CreatePainting():void{
			hit_painting = new Shape();
			hit_painting.touchable = false;
			hit_painting.graphics.beginFill(0xff0000);
			
			hit_painting.graphics.lineTo(382,137);	
			hit_painting.graphics.lineTo(445,90);	
			hit_painting.graphics.lineTo(512,92);	
			hit_painting.graphics.lineTo(581,133);	
			hit_painting.graphics.lineTo(521,241);	
			hit_painting.graphics.lineTo(510,276);	
			hit_painting.graphics.lineTo(426,272);	
			hit_painting.graphics.lineTo(391,209);	
			
			
			hit_painting.alpha = 0.0;
			
			hit_painting.graphics.precisionHitTest = true;	
			this.addChild(hit_painting);
		}
		
		
		private function CreateCaveBonesHit():void{
			hit_CaveBones = new Shape();
			hit_CaveBones.touchable = false;
			hit_CaveBones.graphics.beginFill(0xff0000);
			
			hit_CaveBones.graphics.lineTo(0,172);	
			hit_CaveBones.graphics.lineTo(66,137);	
			hit_CaveBones.graphics.lineTo(165,99);	
			hit_CaveBones.graphics.lineTo(287,147);	
			hit_CaveBones.graphics.lineTo(364,190);	
			hit_CaveBones.graphics.lineTo(360,245);	
			hit_CaveBones.graphics.lineTo(320,311);	
			hit_CaveBones.graphics.lineTo(209,332);	
			hit_CaveBones.graphics.lineTo(77,334);	
			hit_CaveBones.graphics.lineTo(0,264);	

			hit_CaveBones.alpha = 0.0;
			
			hit_CaveBones.graphics.precisionHitTest = true;	
			this.addChild(hit_CaveBones);
		}
		
		
		private function CreateCavePirateHit():void{
			hit_CaveCorridor = new Shape();
			hit_CaveCorridor.touchable = false;
			hit_CaveCorridor.graphics.beginFill(0xff0000);
			
			hit_CaveCorridor.graphics.lineTo(529,247);	
			hit_CaveCorridor.graphics.lineTo(583,168);	
			hit_CaveCorridor.graphics.lineTo(703,160);	
			hit_CaveCorridor.graphics.lineTo(766,215);	
			hit_CaveCorridor.graphics.lineTo(763,321);	
			hit_CaveCorridor.graphics.lineTo(720,366);	
			hit_CaveCorridor.graphics.lineTo(580,364);	
			hit_CaveCorridor.graphics.lineTo(516,343);	
			
			hit_CaveCorridor.alpha = 0.0;
			
			hit_CaveCorridor.graphics.precisionHitTest = true;	
			this.addChild(hit_CaveCorridor);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CoastCave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveObj,true
						);
					}else if(hit_CaveCorridor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CaveCorridor as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CaveCorridorObj,true
						);
					}else if(hit_CaveBones.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CaveBones as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CaveBonesObj,true
						);
					}else if(hit_painting.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CavePainting as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePaintingObj,true
						);	
						
					}else if(hit_pool.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						PoolHandler();
					}else if(hit_hole.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						HoleHandler();
					}
				}
			}
		}
		
		private function PoolHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Gourd)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_GourdWater,
					'item_GourdWater',
					'inven_gourdWater_sm',
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Gourd,
					'item_Gourd'
				);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Cave != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Cave;
				}
				SaveArray['Gourd'] = "Filled";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Cave',SaveArray);
				
			}else{
				if(poolBool === false){
					poolBool = true;
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Fresh water flows from underground. The water is rich in minerals.");
				}else{
					poolBool = false;
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The trench is very deep. The bottom is not visible.");
				}
			}
			
		}
		
		private function HoleHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Ladder)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ladder is not tall enough to reach the hole.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Rope)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is nothing to tie the rope to.");
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Drops of water and rays of light fall from a small hole in the cave ceiling.");
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
			
			
			this.assets.removeTexture("cave_bg",true);
			this.assets.removeTexture("Cave_Sprite",true);
			this.assets.removeTextureAtlas("Cave_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cave_01");
			(stage.getChildAt(0) as Object).falseAsset("cave_02");
			(stage.getChildAt(0) as Object).falseAsset("cave_03");
			
			
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