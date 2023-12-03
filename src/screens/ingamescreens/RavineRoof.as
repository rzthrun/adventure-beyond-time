package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class RavineRoof extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var roof_area:Image;
		private var sat_dish:Image;
		
		private var hit_roof_area:Shape;
		private var hit_sat_dish:Shape;
		private var hit_wires:Shape;
		
		private var hit_ground:Shape;
		private var hit_tree:Shape;
		
		private var TarAttached:Boolean = false;
		private var SolarPanelsAttached:Boolean = false;
		private var SatDishAttached:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function RavineRoof(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('ravineRoof_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRoof/ravineRoof_bg.jpg'));
				game.TrackAssets('ravineRoof_01');
			}
			if(game.CheckAsset('ravineRoof_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRoof/RavineRoof_Sprite.atf'));
				game.TrackAssets('ravineRoof_02');
			}
			if(game.CheckAsset('ravineRoof_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RavineRoof/RavineRoof_Sprite.xml'));
				game.TrackAssets('ravineRoof_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RavineRoof","RavineRoofObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('ravineRoof_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			roof_area = new Image(this.assets.getTexture('tar'));
			roof_area.smoothing = TextureSmoothing.NONE;

			roof_area.touchable = false;
			roof_area.x = 16;
			roof_area.y = 186;
			
			sat_dish = new Image(this.assets.getTexture('sat_dish'));
			sat_dish.smoothing = TextureSmoothing.NONE;

			sat_dish.touchable = false;
			sat_dish.x = 274;
			sat_dish.y = 28;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['SatDish'] == 'Attached'){
					SatDishAttached = true;
					sat_dish.alpha = 1;
				}else{
					sat_dish.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['Tar'] == 'Attached'){
					TarAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['SolarPanels'] == 'Attached'){
						SolarPanelsAttached = true;
						roof_area.texture = this.assets.getTexture('solar_panels')
						roof_area.alpha = 1;						
					}else{
						roof_area.alpha = 1;
					}
				}else{
					roof_area.alpha = 0;
				}
			}else{
				roof_area.alpha = 0;
				sat_dish.alpha = 0;
			}
			

			
			this.addChildAt(roof_area,1);
			this.addChildAt(sat_dish,2);
			
			CreateTreeHit();
			CreateGroundHit();
			CreateSatDishHit();
			CreateRoofHit();
			CreateWiresHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			},0.7);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineRoof',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineRoof',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,2);
					},0.5);
				}
			}
		}
		//hit_tree
		private function CreateTreeHit():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(376,0);		
			hit_tree.graphics.lineTo(639,0);		
			hit_tree.graphics.lineTo(662,114);		
			hit_tree.graphics.lineTo(400,116);		
			
			hit_tree.graphics.endFill(false);
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function CreateGroundHit():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(0,0);		
			hit_ground.graphics.lineTo(258,0);		
			hit_ground.graphics.lineTo(251,154);		
			hit_ground.graphics.lineTo(0,297);		

			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateWiresHit():void{
			hit_wires = new Shape();
			hit_wires.touchable = false;
			hit_wires.graphics.beginFill(0xff0000);
			
			hit_wires.graphics.lineTo(556,173);		
			hit_wires.graphics.lineTo(579,142);		
			hit_wires.graphics.lineTo(651,147);		
			hit_wires.graphics.lineTo(679,182);		
			hit_wires.graphics.lineTo(662,209);		
			hit_wires.graphics.lineTo(598,204);		
			
			hit_wires.graphics.endFill(false);
			hit_wires.alpha = 0.0;
			
			hit_wires.graphics.precisionHitTest = true;	
			this.addChild(hit_wires);
		}
		
		private function CreateRoofHit():void{
			hit_roof_area = new Shape();
			hit_roof_area.touchable = false;
			hit_roof_area.graphics.beginFill(0xff0000);
			
			hit_roof_area.graphics.lineTo(13,309);	
			hit_roof_area.graphics.lineTo(227,185);	
			hit_roof_area.graphics.lineTo(677,215);	
			hit_roof_area.graphics.lineTo(518,487);	
			hit_roof_area.graphics.lineTo(15,362);	
		
			hit_roof_area.graphics.endFill(false);
			hit_roof_area.alpha = 0.0;
			
			hit_roof_area.graphics.precisionHitTest = true;	
			this.addChild(hit_roof_area);
		}
		
		private function CreateSatDishHit():void{
			hit_sat_dish = new Shape();
			hit_sat_dish.touchable = false;
			hit_sat_dish.graphics.beginFill(0xff0000);
			
			hit_sat_dish.graphics.lineTo(263,30);	
			hit_sat_dish.graphics.lineTo(368,32);	
			hit_sat_dish.graphics.lineTo(358,179);	
			hit_sat_dish.graphics.lineTo(280,176);	
			
			hit_sat_dish.graphics.endFill(false);
			hit_sat_dish.alpha = 0.0;
			
			hit_sat_dish.graphics.precisionHitTest = true;	
			this.addChild(hit_sat_dish);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
						
						FadeOut((JungleHouses as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleHousesObj,true
						);
					}else if(hit_roof_area.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						RoofHandler();
					}else if(hit_sat_dish.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						SatDishHandler();
					}else if(hit_wires.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						WireHandler();
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Careful... it's a long way down.");
					}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Small birds jump and sing through the swaying leafy branches.");
					}
				}
			}
		}
		private function WireHandler():void{
			if(SolarPanelsAttached === false){
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PotatoesWired)
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Not a bad idea, but I doubt the potatoes could generate enough power.");
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Potatoes)
				{
				
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't think a handful of potatoes are enough to power this hut and all the equipment inside.");
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are a pair of red and black wires coming from two holes drilled in the roof.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wires are attached to the solar panels.");
			}
		}
		
		private function SatDishHandler():void{
			if(SatDishAttached === false){
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Satellite)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BoxOpen();
					SatDishAttached = true;
					sat_dish.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof;
					}	
					SaveArray['SatDish'] = 'Attached';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineRoof',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Satellite,
							"item_Satellite"
						);
					if(SolarPanelsAttached === false){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've attached the satellite dish to the roof, but without electricity it cannot receive any signal.");
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeeps();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've attached the satellite dish to the roof, and it appears to be receiving a signal.");

					}
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a steel tube emerging from the roof. Many multi-colored wires are spilling out of it.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder what information the dish is receiving...");
			}
		}
		
		private function RoofHandler():void{
			if(TarAttached === false){
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_BucketTar)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RemoveNail();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashTwo();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
					TarAttached = true;
					roof_area.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof;
					}	
					SaveArray['Tar'] = 'Attached';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineRoof',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_BucketTar,
							"item_BucketTar"
						);
				
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've poured the tar evenly over an area of the roof.");
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_SolarPanels)
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Great idea! But I need something to fix the solar panels into position.");
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The roof is made from thatched wood tiles.");
				}
			}else if(TarAttached === true){
				if(SolarPanelsAttached === false){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_SolarPanels)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RemoveNail();
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();

						SolarPanelsAttached = true;
						roof_area.texture = this.assets.getTexture('solar_panels');
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof;
						}	
						SaveArray['SolarPanels'] = 'Attached';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RavineRoof',SaveArray);
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_SolarPanels,
								"item_SolarPanels"
							);
						(stage.getChildAt(0) as Object).AmbientObj.LoadElectricHum(true,0);
						(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'BirdsOne';
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The solar panels are now stuck to the tar and connected to the wires.");
						
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,0);
							},0.5);
						}
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The roof has a thin coat of gooey adhesive tar.");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The solar panels are firmly attached to the roof.");
				}
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The roof is made of thatched grass.");

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
			
			
			this.assets.removeTexture("ravineRoof_bg",true);
			this.assets.removeTexture("RavineRoof_Sprite",true);
			this.assets.removeTextureAtlas("RavineRoof_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("ravineRoof_01");
			(stage.getChildAt(0) as Object).falseAsset("ravineRoof_02");
			(stage.getChildAt(0) as Object).falseAsset("ravineRoof_03");
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
