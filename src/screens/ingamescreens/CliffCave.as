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
	
	
	
	public class CliffCave extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var seal:Image;
		private var door:Image;
		
		private var waterFlowTop_mc:MovieClip;
		private var waterFlowBottom_mc:MovieClip;
		
		private var hit_door:Shape;
		private var hit_cave:Shape;
		private var hit_water:Shape;
		
		private var hit_waterUp:Shape;
		private var hit_caveWall:Shape;
		private var hit_rock:Shape;
		private var hit_rockTwo:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var doorOpen:Boolean = false;
		private var doorSolve:Boolean = false;
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function CliffCave(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cliffCave_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffCave/cliffCave_bg.jpg'));
				game.TrackAssets('cliffCave_01');
			}
			if(game.CheckAsset('cliffCave_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffCave/cliffCave_Sprite.atf'));
				game.TrackAssets('cliffCave_02');
			}
			if(game.CheckAsset('cliffCave_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CliffCave/cliffCave_Sprite.xml'));
				game.TrackAssets('cliffCave_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CliffCave","CliffCaveObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		
		
		private function onLoadAssets():void{
		//	(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
		//		(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Seal,
		//		'item_Seal',
		//		'inven_seal_sm'
		//	);
			
			
			/*
			SaveArray['Solved'] = 'no'; 
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCavePuzzle',SaveArray);	
			
			SaveArray['Door'] = 'no'; 
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCave',SaveArray);
			*/
			bg = new Image(this.assets.getTexture('cliffCave_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			door = new Image(this.assets.getTexture('door_open'));
			door.smoothing = TextureSmoothing.NONE;

			door.touchable = false;
			door.x = 279;
			door.y = 22;
			
			
			seal = new Image(this.assets.getTexture('door_seal'));
			seal.smoothing = TextureSmoothing.NONE;
			seal.touchable = false;
			seal.x = 540;
			seal.y = 138;
			
			
			waterFlowTop_mc = new MovieClip(this.assets.getTextures("waterflow_top_"),3);
			waterFlowTop_mc.smoothing = TextureSmoothing.NONE;
			waterFlowTop_mc.x = 47;
			waterFlowTop_mc.y = 116;
			waterFlowTop_mc.alpha = 1;
			waterFlowTop_mc.touchable = false;
			waterFlowTop_mc.loop = true;
		
			waterFlowBottom_mc = new MovieClip(this.assets.getTextures("waterflow_bottom_"),3);
			waterFlowBottom_mc.smoothing = TextureSmoothing.NONE;
			waterFlowBottom_mc.x = 137;
			waterFlowBottom_mc.y = 307;
			waterFlowBottom_mc.alpha = 1;
			waterFlowBottom_mc.touchable = false;
			waterFlowBottom_mc.loop = true; 

		
			
			//FadeOutOcean(1);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle != undefined){
				trace("1");

				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['Solved'] == 'Yes'){
					trace("2");
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave != undefined){
						trace("3");
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave['Door'] == 'open'){
							trace("4");
							door.alpha = 1;
							seal.alpha = 0;
							doorSolve = true;
							doorOpen = true;
							CreateCaveHit();
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave['Door'] == 'closed'){
							trace("5");
							door.alpha = 0;
							seal.alpha = 1;
							doorSolve = true;
							doorOpen = false;
						}else{
							trace("6");
							Animating = true;
							doorOpen = false;
							doorSolve = true;
							door.alpha = 0;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave;
							}
							SaveArray['Door'] = 'open'; 
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCave',SaveArray);	
							Starling.juggler.delayCall(OpenDoor,2);
						}
					}else{
						trace("6");
						Animating = true;
						doorOpen = false;
						doorSolve = true;
						door.alpha = 0;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave;
						}
						SaveArray['Door'] = 'open'; 
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCave',SaveArray);	
						Starling.juggler.delayCall(OpenDoor,2);
					}
				}else{
					trace('13');
					door.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCavePuzzle['Seal'] == 'Attached'){
						seal.alpha = 1;
					}else{
						seal.alpha = 0;
					}
				}
			}else{
				door.alpha = 0;
				seal.alpha = 0;
			}
			
			//door.alpha = 1;
			
			this.addChildAt(seal,1);
			this.addChildAt(door,2);
			this.addChildAt(waterFlowTop_mc,3);	
			this.addChildAt(waterFlowBottom_mc,4);	
			
			
			Starling.juggler.add(waterFlowTop_mc);
			Starling.juggler.add(waterFlowBottom_mc);
			CreateCaveWallHit();
			CreateRockTwoHit();
			CreateRockHit();
			CreateWaterUpHit();
			CreateWaterHit();
			CreateDoorHit(doorOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);

			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDripsStream",0,0.5,'stop');
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Waterfall",((stage.getChildAt(0) as Object).AmbientObj.globalVol),1.0);
			},0.7);
		}
		
		
		private function OpenDoor():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_HeavyStoneDrag();
			door.alpha = 1;
			seal.alpha = 0;
			Animating = false;
			doorOpen = true;
			hit_door.graphics.clear()
			CreateDoorHit(true);
			CreateCaveHit();
			
		}
		//hit_rockTwo
		
		private function CreateRockTwoHit():void{
			hit_rockTwo = new Shape();
			hit_rockTwo.touchable = false;
			hit_rockTwo.graphics.beginFill(0xff0000);
			
			hit_rockTwo.graphics.lineTo(602,39);	
			hit_rockTwo.graphics.lineTo(786,122);	
			hit_rockTwo.graphics.lineTo(780,375);	
			hit_rockTwo.graphics.lineTo(564,361);	
			
			hit_rockTwo.graphics.endFill(false);
			hit_rockTwo.alpha = 0.0;
			
			hit_rockTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_rockTwo);
		}
		private function CreateRockHit():void{
			hit_rock = new Shape();
			hit_rock.touchable = false;
			hit_rock.graphics.beginFill(0xff0000);
			
			hit_rock.graphics.lineTo(0,177);	
			hit_rock.graphics.lineTo(49,171);	
			hit_rock.graphics.lineTo(417,512);	
			hit_rock.graphics.lineTo(0,512);	
		
			hit_rock.graphics.endFill(false);
			hit_rock.alpha = 0.0;
			
			hit_rock.graphics.precisionHitTest = true;	
			this.addChild(hit_rock);
		}
		
		private function CreateCaveWallHit():void{
			hit_caveWall = new Shape();
			hit_caveWall.touchable = false;
			hit_caveWall.graphics.beginFill(0xff0000);
			
			hit_caveWall.graphics.lineTo(200,11);	
			hit_caveWall.graphics.lineTo(428,17);	
			hit_caveWall.graphics.lineTo(425,261);	
			hit_caveWall.graphics.lineTo(216,256);	
			
			hit_caveWall.graphics.endFill(false);
			hit_caveWall.alpha = 0.0;
			
			hit_caveWall.graphics.precisionHitTest = true;	
			this.addChild(hit_caveWall);
		}
		
		private function CreateWaterUpHit():void{
			hit_waterUp = new Shape();
			hit_waterUp.touchable = false;
			hit_waterUp.graphics.beginFill(0xff0000);
			
			hit_waterUp.graphics.lineTo(33,161);	
			hit_waterUp.graphics.lineTo(183,80);	
			hit_waterUp.graphics.lineTo(255,281);	
			hit_waterUp.graphics.lineTo(128,298);	
			
			hit_waterUp.graphics.endFill(false);
			hit_waterUp.alpha = 0.0;
			
			hit_waterUp.graphics.precisionHitTest = true;	
			this.addChild(hit_waterUp);
		}
		
		private function CreateWaterHit():void{
			hit_water = new Shape();
			hit_water.touchable = false;
			hit_water.graphics.beginFill(0xff0000);
			
			hit_water.graphics.lineTo(152,305);	
			hit_water.graphics.lineTo(258,289);	
			hit_water.graphics.lineTo(370,369);	
			hit_water.graphics.lineTo(604,406);	
			hit_water.graphics.lineTo(602,507);	
			hit_water.graphics.lineTo(435,506);	
			hit_water.graphics.lineTo(316,432);	
			hit_water.graphics.lineTo(311,407);	
			
			hit_water.graphics.endFill(false);
			hit_water.alpha = 0.0;
			
			hit_water.graphics.precisionHitTest = true;	
			this.addChild(hit_water);
		}
		
		private function CreateCaveHit():void{
			hit_cave = new Shape();
			hit_cave.touchable = false;
			hit_cave.graphics.beginFill(0xff0000);
			
			hit_cave.graphics.lineTo(460,87);	
			hit_cave.graphics.lineTo(565,53);	
			hit_cave.graphics.lineTo(583,62);	
			hit_cave.graphics.lineTo(577,270);	
			hit_cave.graphics.lineTo(461,273);	

			hit_cave.graphics.endFill(false);
			hit_cave.alpha = 0.0;
			
			hit_cave.graphics.precisionHitTest = true;	
			this.addChild(hit_cave);
		}
		
		private function CreateDoorHit(open:Boolean = false):void{
			hit_door = new Shape();
			hit_door.touchable = false;
			if(open === false){
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0xff0000);
				
				hit_door.graphics.lineTo(442,42);
				hit_door.graphics.lineTo(578,19);
				hit_door.graphics.lineTo(613,88);
				hit_door.graphics.lineTo(615,200);
				hit_door.graphics.lineTo(585,269);
				hit_door.graphics.lineTo(441,271);
				hit_door.graphics.endFill(false);
				
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;	
			}else{
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0xff0000);	
				
				hit_door.graphics.lineTo(321,32);
				hit_door.graphics.lineTo(449,60);
				hit_door.graphics.lineTo(456,276);
				hit_door.graphics.lineTo(328,282);
				
				hit_door.graphics.endFill(false);
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;				
			}
			
			this.addChild(hit_door);
			
		}	
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							
							FadeOut((FarCoastCliff as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastCliffObj,true
							);
						}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							DoorHandler();
						}else if(hit_water.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							WaterHandler();
						}else if(hit_waterUp.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The water flows from a narrow passage.");

						}else if(hit_caveWall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The water must have cut away the rock over centuries.");

						}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rocks are wet and slippery.");
						}else if(hit_rockTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walls drip with moisture.");
							//hit_rockTwo
							/*
							private var hit_waterUp:Shape;
							private var hit_caveWall:Shape;
							private var hit_rock:Shape;
							*/
							
						}else if(doorOpen === true){
							if(hit_cave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((CliffMonsterCave as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffMonsterCaveObj,true
								);
							}
						}
					}
				}
			}
		}
		
		private function WaterHandler():void{
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
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave;
				}
				SaveArray['Gourd'] = "Filled";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCave',SaveArray);
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a stream of fresh water flowing swiftly.");
			}
		}
		
		private function DoorHandler():void{
			if(doorSolve === false){
				FadeOut((CliffCavePuzzle as Class), 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.CliffCavePuzzleObj,true
				);
			}else{
				if(doorOpen === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_HeavyStoneDrag();
					doorOpen = true;
					door.alpha = 1;
					seal.alpha = 0;
					
					hit_door.graphics.clear()
					CreateDoorHit(true);
					CreateCaveHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave;
					}
					SaveArray['Door'] = 'open'; 
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCave',SaveArray);	
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
					doorOpen = false;
					door.alpha = 0;
					seal.alpha = 1;
					
					this.removeChild(hit_cave);
					hit_door.graphics.clear()
					CreateDoorHit(false);
					
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CliffCave;
					}
					SaveArray['Door'] = 'closed'; 
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CliffCave',SaveArray);	
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
			
			
			this.assets.removeTexture("cliffCave_bg",true);
			this.assets.removeTexture("cliffCave_Sprite",true);
			this.assets.removeTextureAtlas("cliffCave_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cliffCave_01");
			(stage.getChildAt(0) as Object).falseAsset("cliffCave_02");
			(stage.getChildAt(0) as Object).falseAsset("cliffCave_03");
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