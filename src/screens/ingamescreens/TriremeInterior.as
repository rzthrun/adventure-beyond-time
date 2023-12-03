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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class TriremeInterior extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var ladder:Image;
		private var waterfall_mc:MovieClip;
		private var lid:Image;
		private var lid_corner:Image;
		private var rope:Image;
		private var rope_corner:Image;
		private var coin:Image;
		
		
		private var hit_ladder:Shape;
		private var hit_lid:Shape;
		private var hit_rope:Shape;
		private var hit_device:Shape;
		private var hit_ropeTwo:Shape;
		
		private var hit_sheild:Shape;
		private var hit_waterfall:Shape;
		private var hit_oar:Shape;
		private var hit_helmut:Shape;
		private var hit_artifacts:Shape;
		private var hit_big_rope:Shape;
		
		
		private var LidOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function TriremeInterior(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('triremeInterior_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeInterior/triremeInterior_bg.jpg'));
				game.TrackAssets('triremeInterior_01');
			}
			if(game.CheckAsset('triremeInterior_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeInterior/TriremeInterior_Sprite.atf'));
				game.TrackAssets('triremeInterior_02');
			}
			if(game.CheckAsset('triremeInterior_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeInterior/TriremeInterior_Sprite.xml'));
				game.TrackAssets('triremeInterior_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("TriremeInterior","TriremeInteriorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('triremeInterior_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			waterfall_mc = new MovieClip(this.assets.getTextures('waterfallWindow_pos_'),12);
			waterfall_mc.smoothing = TextureSmoothing.NONE;

			//		LargeWheel_mc.smoothing = TextureSmoothing.NONE;
			waterfall_mc.x = 1;
			waterfall_mc.y = 1;
			waterfall_mc.touchable = false;
			waterfall_mc.loop = true; // default: true
			waterfall_mc.play();
			this.addChildAt(waterfall_mc,1);	
			Starling.juggler.add(waterfall_mc);
			
			ladder = new Image(this.assets.getTexture('ladder'));
			ladder.smoothing = TextureSmoothing.NONE;

			ladder.touchable = false;
			ladder.x = 238;
			ladder.y = 100;

			lid = new Image(this.assets.getTexture('d_device_lid'));
			lid.smoothing = TextureSmoothing.NONE;

			lid.touchable = false;
			lid.x = 345;
			lid.y = 154;
			

			lid_corner = new Image(this.assets.getTexture('lid_corner'));
			lid_corner.smoothing = TextureSmoothing.NONE;

			lid_corner.touchable = false;
			lid_corner.x = 345;
			lid_corner.y = 154;
			
			
			coin = new Image(this.assets.getTexture('d_device_coin'));
			coin.smoothing = TextureSmoothing.NONE;

			coin.touchable = false;
			coin.x = 345+133;
			coin.y = 154+72;
			
			rope = new Image(this.assets.getTexture('rope'));
			rope.smoothing = TextureSmoothing.NONE;

			rope.touchable = false;
			rope.x = 595;
			rope.y = 1;

			
			rope_corner = new Image(this.assets.getTexture('rope_corner'));
			rope_corner.smoothing = TextureSmoothing.NONE;

			rope_corner.touchable = false;
			rope_corner.x = 468;
			rope_corner.y = 1;
			
		
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior["Ladder"] == "PickedUp"){
					ladder.alpha = 0; 
				}else{
					ladder.alpha = 1; 
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior["Rope"] == "PickedUp"){
					rope.alpha = 0;
					rope_corner.alpha = 0;
				}else{
					rope.alpha = 1;
					rope_corner.alpha = 1;
				}
			}else{
				ladder.alpha = 1; 
				rope.alpha = 1;
				rope_corner.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Lid'] == 'Open'){
					lid.alpha = 1;
					LidOpen = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior["Ladder"] == "PickedUp"){
							lid_corner.alpha = 0;
						}else{
							lid_corner.alpha = 1;
						}
					}else{
						lid_corner.alpha = 1;
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Coin'] == 'PickedUp'){
						coin.alpha = 0;
					}else{
						coin.alpha = 1;
					}
					
					
				}else{
					coin.alpha = 0;
					lid.alpha = 0;
					lid_corner.alpha = 0;
				}
			}else{
				coin.alpha = 0;
				lid.alpha = 0;
				lid_corner.alpha = 0;
			}
			
			
			
			this.addChildAt(ladder,2);
			this.addChildAt(lid,3);
			this.addChildAt(lid_corner,4);
			this.addChildAt(coin,5);
			this.addChildAt(rope,6);
			this.addChildAt(rope_corner,7);

			CreateArtifactHit();
			CreateOarHit();
			CreateHelmutHit()
			CreateWaterFallHit();
			CreateSheildHit();
			CreateBigRopeHit();
			CreateLadderHit();
			CreateLidHit(LidOpen);
			CreateRopeHit();
			CreateHitRopeTwo();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
		
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
			if((stage.getChildAt(0) as Object).AmbientObj.currentAmbient == 'Waterfall'){
				trace("BARK1");
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
			}else{
				trace("BARK2");
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999,2);
				},0.7);
			}
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Waterfall';
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Waterfall",((stage.getChildAt(0) as Object).MusicObj.globalVol),1.0);
		}
		
		//hit_ropeTwo
		private function CreateHitRopeTwo():void{
			hit_ropeTwo = new Shape();
			hit_ropeTwo.touchable = false;
			hit_ropeTwo.graphics.beginFill(0xff0000);
			
			hit_ropeTwo.graphics.lineTo(462,0);	
			hit_ropeTwo.graphics.lineTo(547,0);	
			hit_ropeTwo.graphics.lineTo(525,51);	
			hit_ropeTwo.graphics.lineTo(484,51);	
			
			
			hit_ropeTwo.graphics.endFill(false);
			hit_ropeTwo.alpha = 0.0;
			
			hit_ropeTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_ropeTwo);
		}
		
		private function CreateArtifactHit():void{
			hit_artifacts = new Shape();
			hit_artifacts.touchable = false;
			hit_artifacts.graphics.beginFill(0xff0000);
			
			hit_artifacts.graphics.lineTo(236,413);	
			hit_artifacts.graphics.lineTo(200,225);	
			hit_artifacts.graphics.lineTo(380,183);	
			hit_artifacts.graphics.lineTo(425,129);	
			hit_artifacts.graphics.lineTo(669,97);	
			hit_artifacts.graphics.lineTo(780,275);	
			hit_artifacts.graphics.lineTo(434,353);	
			hit_artifacts.graphics.lineTo(297,439);	
				
			
			hit_artifacts.graphics.endFill(false);
			hit_artifacts.alpha = 0.0;
			
			hit_artifacts.graphics.precisionHitTest = true;	
			this.addChild(hit_artifacts);
		}
		
		private function CreateHelmutHit():void{
			hit_helmut = new Shape();
			hit_helmut.touchable = false;
			hit_helmut.graphics.beginFill(0xff0000);
			
			hit_helmut.graphics.lineTo(577,337);	
			hit_helmut.graphics.lineTo(601,225);	
			hit_helmut.graphics.lineTo(768,219);	
			hit_helmut.graphics.lineTo(772,316);	
			hit_helmut.graphics.lineTo(605,335);	
			
			hit_helmut.graphics.endFill(false);
			hit_helmut.alpha = 0.0;
			
			hit_helmut.graphics.precisionHitTest = true;	
			this.addChild(hit_helmut);
		}
		
		private function CreateOarHit():void{
			hit_oar = new Shape();
			hit_oar.touchable = false;
			hit_oar.graphics.beginFill(0xff0000);
			
			hit_oar.graphics.lineTo(527,408);	
			hit_oar.graphics.lineTo(800,302);	
			hit_oar.graphics.lineTo(800,346);	
			hit_oar.graphics.lineTo(575,454);	
		
			hit_oar.graphics.endFill(false);
			hit_oar.alpha = 0.0;
			
			hit_oar.graphics.precisionHitTest = true;	
			this.addChild(hit_oar);
		}
		
		private function CreateWaterFallHit():void{
			hit_waterfall = new Shape();
			hit_waterfall.touchable = false;
			hit_waterfall.graphics.beginFill(0xff0000);
			
			hit_waterfall.graphics.lineTo(0,50);	
			hit_waterfall.graphics.lineTo(281,84);	
			hit_waterfall.graphics.lineTo(211,199);	
			hit_waterfall.graphics.lineTo(0,225);	
			
			hit_waterfall.graphics.endFill(false);
			hit_waterfall.alpha = 0.0;
			
			hit_waterfall.graphics.precisionHitTest = true;	
			this.addChild(hit_waterfall);
		}
		
		private function CreateBigRopeHit():void{
			hit_big_rope = new Shape();
			hit_big_rope.touchable = false;
			hit_big_rope.graphics.beginFill(0xff0000);
			
			hit_big_rope.graphics.lineTo(274,433);	
			hit_big_rope.graphics.lineTo(323,373);	
			hit_big_rope.graphics.lineTo(462,346);	
			hit_big_rope.graphics.lineTo(559,341);	
			hit_big_rope.graphics.lineTo(553,374);	
			hit_big_rope.graphics.lineTo(363,442);	
		
			hit_big_rope.graphics.endFill(false);
			hit_big_rope.alpha = 0.0;
			
			hit_big_rope.graphics.precisionHitTest = true;	
			this.addChild(hit_big_rope);
		}
		
		private function CreateSheildHit():void{
			hit_sheild = new Shape();
			hit_sheild.touchable = false;
			hit_sheild.graphics.beginFill(0xff0000);
			
			hit_sheild.graphics.lineTo(73,375);	
			hit_sheild.graphics.lineTo(110,305);	
			hit_sheild.graphics.lineTo(205,299);	
			hit_sheild.graphics.lineTo(214,405);	
			hit_sheild.graphics.lineTo(100,434);	
			
			hit_sheild.graphics.endFill(false);
			hit_sheild.alpha = 0.0;
			
			hit_sheild.graphics.precisionHitTest = true;	
			this.addChild(hit_sheild);
		}
		
		
		private function CreateLadderHit():void{
			hit_ladder = new Shape();
			hit_ladder.touchable = false;
			hit_ladder.graphics.beginFill(0xff0000);
			
			hit_ladder.graphics.lineTo(293,102);	
			hit_ladder.graphics.lineTo(319,95);	
			hit_ladder.graphics.lineTo(373,132);	
			hit_ladder.graphics.lineTo(308,419);	
			hit_ladder.graphics.lineTo(291,426);	
			hit_ladder.graphics.lineTo(231,398);	

			hit_ladder.graphics.endFill(false);
			hit_ladder.alpha = 0.0;
			
			hit_ladder.graphics.precisionHitTest = true;	
			this.addChild(hit_ladder);
		}
		
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(430,327);
				hit_lid.graphics.lineTo(450,200);
				hit_lid.graphics.lineTo(587,172);
				hit_lid.graphics.lineTo(601,190);
				hit_lid.graphics.lineTo(595,332);
				hit_lid.graphics.lineTo(446,347);

				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		

				hit_lid.graphics.lineTo(342,286);
				hit_lid.graphics.lineTo(370,156);
				hit_lid.graphics.lineTo(381,154);
				hit_lid.graphics.lineTo(469,213);
				hit_lid.graphics.lineTo(593,188);
				hit_lid.graphics.lineTo(590,332);
				hit_lid.graphics.lineTo(450,348);
				
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			
		}		
		private function CreateDeviceHit():void{
			hit_device = new Shape();
			hit_device.touchable = false;
			hit_device.graphics.beginFill(0xff0000);
			
			hit_device.graphics.lineTo(461,332);	
			hit_device.graphics.lineTo(472,215);	
			hit_device.graphics.lineTo(472,215);	
			hit_device.graphics.lineTo(588,190);	
			hit_device.graphics.lineTo(581,322);	

			hit_device.graphics.endFill(false);
			hit_device.alpha = 0.0;
			
			hit_device.graphics.precisionHitTest = true;	
			this.addChild(hit_device);
		}
		
		private function CreateRopeHit():void{
			hit_rope = new Shape();
			hit_rope.touchable = false;
			hit_rope.graphics.beginFill(0xff0000);
			
			hit_rope.graphics.lineTo(591,0);	
			hit_rope.graphics.lineTo(644,0);	
			hit_rope.graphics.lineTo(645,117);	
			hit_rope.graphics.lineTo(663,204);	
			hit_rope.graphics.lineTo(671,284);	
			hit_rope.graphics.lineTo(615,291);	
			hit_rope.graphics.lineTo(611,210);	
			hit_rope.graphics.lineTo(581,96);	

			hit_rope.graphics.endFill(false);
			hit_rope.alpha = 0.0;
			
			hit_rope.graphics.precisionHitTest = true;	
			this.addChild(hit_rope);
		}
		
		/*
		private var hit_ladder:Shape;
		private var hit_lid:Shape;
		private var hit_rope:Shape;
		private var hit_device:Shape;
		
		*/
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();
						FadeOut((TriremeDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.TriremeDeckObj,true
						);
					}else if(hit_ladder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LadderHandler();
					}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((TriremeDevice as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.TriremeDeviceObj,true
						);
					}else if(hit_rope.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						RopeHandler();
					}else if(hit_ropeTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						RopeHandler();			
					}else if(hit_sheild.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A large metal shield depicting an angry face with snakes for hair.");
					}else if(hit_waterfall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cascade vibrates the hull of the vessel.");
					}else if(hit_oar.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The end of a rowing oar.");
					}else if(hit_big_rope.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A piece of very thick rope. Loaded with water and too heavy to carry.");
					}else if(hit_helmut.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Ancient helmets.");
					}else if(hit_artifacts.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor is covered with priceless artifacts from antiquity.");
					}




					/*
					
					private var hit_sheild:Shape;
					private var hit_waterfall:Shape;
					private var hit_oar:Shape;
					private var hit_helmut:Shape;
					private var hit_artifacts:Shape;
					private var hit_big_rope:Shape;
					*/
					
				}
			}
		}
		
		private function RopeHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior["Rope"] == "PickedUp"){
					if(hit_artifacts.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor is covered with priceless artifacts from antiquity.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					rope.alpha = 0;
					rope_corner.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior;
					SaveArray['Rope'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeInterior',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Rope,
						'item_Rope',
						'inven_rope_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				rope.alpha = 0;
				rope_corner.alpha = 0;
				SaveArray['Rope'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeInterior',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Rope,
					'item_Rope',
					'inven_rope_sm'
				);
			}	
		}		
		private function LadderHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior["Ladder"] == "PickedUp"){
					if(hit_artifacts.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor is covered with priceless artifacts from antiquity.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
					ladder.alpha = 0;
					lid_corner.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior;
					SaveArray['Ladder'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeInterior',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ladder,
						'item_Ladder',
						'inven_ladder_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
				ladder.alpha = 0;
				lid_corner.alpha = 0;
				SaveArray['Ladder'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeInterior',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ladder,
					'item_Ladder',
					'inven_ladder_sm'
				);
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
			
			
			this.assets.removeTexture("triremeInterior_bg",true);
			this.assets.removeTexture("TriremeInterior_Sprite",true);
			this.assets.removeTextureAtlas("TriremeInterior_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("triremeInterior_01");
			(stage.getChildAt(0) as Object).falseAsset("triremeInterior_02");
			(stage.getChildAt(0) as Object).falseAsset("triremeInterior_03");
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