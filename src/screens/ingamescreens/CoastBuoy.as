package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.textures.TextureSmoothing;		
	
	
	public class CoastBuoy extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var stone:Image;
		private var wires:Image;
		private var solarPanels:Image;
		
		private var hit_stone:Shape;
		private var hit_solarPanels:Shape;
		private var hit_wires:Shape;
		
		private var hit_fern:Shape;
		private var hit_plants:Shape;
		private var hit_plantsTwo:Shape;
		private var hit_bouyTwo:Shape;
		private var hit_jungle:Shape;
		
		private var SolarPanelsOff:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public function CoastBuoy(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastBouy_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastBuoy/coastBouy_bg.jpg'));
				game.TrackAssets('coastBouy_01');
			}
			if(game.CheckAsset('coastBouy_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastBuoy/CoastBuoy_Sprite.atf'));
				game.TrackAssets('coastBouy_02');
			}
			if(game.CheckAsset('coastBouy_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastBuoy/CoastBuoy_Sprite.xml'));
				game.TrackAssets('coastBouy_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastBuoy","CoastBuoyObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastBouy_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			wires  = new Image(this.assets.getTexture('wires'));
			wires.smoothing = TextureSmoothing.NONE;
			wires.touchable = false;
			wires.x = 154;
			wires.y = 197;
			
			solarPanels  = new Image(this.assets.getTexture('solarPanels'));
			solarPanels.smoothing = TextureSmoothing.NONE;
			solarPanels.touchable = false;
			solarPanels.x = 154;
			solarPanels.y = 197;
			
			
			//FadeOutOcean(1);
			
			stone = new Image(this.assets.getTexture('redStone'));
			stone.smoothing = TextureSmoothing.NONE;
			stone.touchable = false;
			stone.x = 511;
			stone.y = 225;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["Stone"] == "PickedUp"){
					stone.alpha = 0;
				}else{
					stone.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy != undefined){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["SolarPanels"] == "PickedUp"){
						solarPanels.alpha = 0;
						SolarPanelsOff = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["Wires"] == "PickedUp"){
							wires.alpha = 0;
						}else{
							wires.alpha = 1;
						}
						CreateWiresHit();
					}else{
						
						wires.alpha = 0;
						solarPanels.alpha = 1;
						CreateSolarPanelHit();
					}
				}else{
					wires.alpha = 0;
					solarPanels.alpha = 1;
					CreateSolarPanelHit();
				}
				
			}else{
				wires.alpha = 0;
				solarPanels.alpha = 1;
				stone.alpha = 1;
				CreateSolarPanelHit();
			}
			
			
			this.addChildAt(wires,1);
			this.addChildAt(solarPanels,2);
			this.addChildAt(stone,3);
			
			CreateStoneHit();
			
			CreateFernHit();
			CreatePlantsHit();
			CreateBuoyTwoHit();
			CreateJungleHit();
			CreatePlantsTwoHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
		}
		
		/*
		
		private var hit_fern:Shape;
		private var hit_plants:Shape;
		private var hit_bouyTwo:Shape;
		hit_jungle
		*/
		private function CreateJungleHit():void{
			hit_jungle = new Shape();
			hit_jungle.touchable = false;
			hit_jungle.graphics.beginFill(0xff0000);
			
			hit_jungle.graphics.lineTo(408,0);	
			hit_jungle.graphics.lineTo(659,0);	
			hit_jungle.graphics.lineTo(665,100);	
			hit_jungle.graphics.lineTo(512,94);	
			hit_jungle.graphics.lineTo(462,36);	
		
			
			hit_jungle.graphics.endFill(false);
			hit_jungle.alpha = 0.0;
			
			hit_jungle.graphics.precisionHitTest = true;	
			this.addChild(hit_jungle);
		}
		
		private function CreateBuoyTwoHit():void{
			hit_bouyTwo = new Shape();
			hit_bouyTwo.touchable = false;
			hit_bouyTwo.graphics.beginFill(0xff0000);
			
			hit_bouyTwo.graphics.lineTo(163,47);	
			hit_bouyTwo.graphics.lineTo(215,0);	
			hit_bouyTwo.graphics.lineTo(333,0);	
			hit_bouyTwo.graphics.lineTo(366,44);	
			hit_bouyTwo.graphics.lineTo(351,168);	
			hit_bouyTwo.graphics.lineTo(266,197);	
			hit_bouyTwo.graphics.lineTo(198,170);	
			
			
			hit_bouyTwo.graphics.endFill(false);
			hit_bouyTwo.alpha = 0.0;
			
			hit_bouyTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_bouyTwo);
		}
		//hit_plantsTwo
		private function CreatePlantsTwoHit():void{
			hit_plantsTwo = new Shape();
			hit_plantsTwo.touchable = false;
			hit_plantsTwo.graphics.beginFill(0xff0000);
			
			hit_plantsTwo.graphics.lineTo(361,165);	
			hit_plantsTwo.graphics.lineTo(372,64);	
			hit_plantsTwo.graphics.lineTo(427,78);	
			hit_plantsTwo.graphics.lineTo(538,126);	
			hit_plantsTwo.graphics.lineTo(509,186);	
			hit_plantsTwo.graphics.lineTo(479,227);	
			hit_plantsTwo.graphics.lineTo(400,230);	
		
			hit_plantsTwo.graphics.endFill(false);
			hit_plantsTwo.alpha = 0.0;
			
			hit_plantsTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_plantsTwo);
		}
		private function CreatePlantsHit():void{
			hit_plants = new Shape();
			hit_plants.touchable = false;
			hit_plants.graphics.beginFill(0xff0000);
			
			hit_plants.graphics.lineTo(0,79);	
			hit_plants.graphics.lineTo(125,65);	
			hit_plants.graphics.lineTo(179,180);	
			hit_plants.graphics.lineTo(0,252);	
		
			
			hit_plants.graphics.endFill(false);
			hit_plants.alpha = 0.0;
			
			hit_plants.graphics.precisionHitTest = true;	
			this.addChild(hit_plants);
		}
		
		private function CreateFernHit():void{
			hit_fern = new Shape();
			hit_fern.touchable = false;
			hit_fern.graphics.beginFill(0xff0000);
			
			hit_fern.graphics.lineTo(522,323);	
			hit_fern.graphics.lineTo(644,308);	
			hit_fern.graphics.lineTo(761,337);	
			hit_fern.graphics.lineTo(785,391);	
			hit_fern.graphics.lineTo(653,447);	
			hit_fern.graphics.lineTo(522,400);	

			
			hit_fern.graphics.endFill(false);
			hit_fern.alpha = 0.0;
			
			hit_fern.graphics.precisionHitTest = true;	
			this.addChild(hit_fern);
		}
		
		private function CreateStoneHit():void{
			hit_stone = new Shape();
			hit_stone.touchable = false;
			hit_stone.graphics.beginFill(0xff0000);
			
			hit_stone.graphics.lineTo(489,231);	
			hit_stone.graphics.lineTo(516,194);	
			hit_stone.graphics.lineTo(589,188);	
			hit_stone.graphics.lineTo(628,216);	
			hit_stone.graphics.lineTo(636,250);	
			hit_stone.graphics.lineTo(593,288);	
			hit_stone.graphics.lineTo(534,301);	
			hit_stone.graphics.lineTo(505,281);	
			
			hit_stone.graphics.endFill(false);
			hit_stone.alpha = 0.0;
			
			hit_stone.graphics.precisionHitTest = true;	
			this.addChild(hit_stone);
		}
		//hit_solarPanels
		private function CreateSolarPanelHit():void{
			hit_solarPanels = new Shape();
			hit_solarPanels.touchable = false;
			hit_solarPanels.graphics.beginFill(0xff0000);
			
			hit_solarPanels.graphics.lineTo(201,180);	
			hit_solarPanels.graphics.lineTo(274,207);	
			hit_solarPanels.graphics.lineTo(355,180);	
			hit_solarPanels.graphics.lineTo(409,256);	
			hit_solarPanels.graphics.lineTo(392,318);	
			hit_solarPanels.graphics.lineTo(279,375);	
			hit_solarPanels.graphics.lineTo(170,312);

			hit_solarPanels.graphics.endFill(false);
			hit_solarPanels.alpha = 0.0;
			
			hit_solarPanels.graphics.precisionHitTest = true;	
			this.addChild(hit_solarPanels);
		}
		
		private function CreateWiresHit():void{
			hit_wires = new Shape();
			hit_wires.touchable = false;
			hit_wires.graphics.beginFill(0xff0000);
			
			hit_wires.graphics.lineTo(213,188);	
			hit_wires.graphics.lineTo(274,211);	
			hit_wires.graphics.lineTo(358,180);	
			hit_wires.graphics.lineTo(403,302);	
			hit_wires.graphics.lineTo(379,370);	
			hit_wires.graphics.lineTo(267,391);	
			hit_wires.graphics.lineTo(188,287);	

			hit_wires.graphics.endFill(false);
			hit_wires.alpha = 0.0;
			
			hit_wires.graphics.precisionHitTest = true;	
			this.addChild(hit_wires);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CoastJungle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastJungleObj,true
						);
					}else if(hit_jungle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleEdge as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEdgeObj,true
						);
					}else if(hit_fern.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A fern.");
					}else if(hit_plants.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An unusual plant. I've never seen it before.");
					}else if(hit_plantsTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Insects dart about the leaves in the brush.");
						
					}else if(hit_bouyTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Looks like a weather buoy.");
								
					}else if(hit_stone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						StoneHandler();
					}else if(SolarPanelsOff === false){
						if(hit_solarPanels.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SolarPanelHandler();
						}
					}else{
						if(hit_wires.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							WiresHandler();
						}

					}

				}
			}
		}
		
		
		private function WiresHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["Wires"] == "PickedUp"){
					
				}else{
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_WireCutters)
					{
						
	
						wires.alpha = 0;

						
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy;
						SaveArray['Wires'] = "PickedUp";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastBuoy',SaveArray);
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_WireCutters,
								"item_WireCutters"
							);
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Wires,
							'item_Wires',
							'inven_wires_sm'
						);
						
						
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wires run inside of the buoy. I need a way to cut them loose.");
					}
					
					
				}
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_WireCutters)
				{
					

					wires.alpha = 0;
					
					SaveArray['Wires'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastBuoy',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_WireCutters,
							"item_WireCutters"
						);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Wires,
						'item_Wires',
						'inven_wires_sm'
					);
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wires run inside of the buoy. I need a way to cut them loose.");
				}
			}	
		}
		
		
		
		
		private function SolarPanelHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["SolarPanels"] == "PickedUp"){
					
				}else{
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Wrench)
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoorTwo();
						solarPanels.alpha = 0;
						wires.alpha = 1;
						SolarPanelsOff = true;
						this.removeChild(hit_solarPanels);
						CreateWiresHit();
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Wrench,
								"item_Wrench"
							);
						
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy;
						SaveArray['SolarPanels'] = "PickedUp";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastBuoy',SaveArray);
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_SolarPanels,
							'item_SolarPanels',
							'inven_solarPanals_sm'
						);
						
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Screwdriver)
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The screwdriver is useless, I'll need a wrench to get these off.");

					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The solar panels are bolted to the bouy. I'll need a tool to remove the bolts.");
					}
					
					
				}
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Wrench)
				{
					
					solarPanels.alpha = 0;
					wires.alpha = 1;
					SolarPanelsOff = true;
					this.removeChild(hit_solarPanels);
					CreateWiresHit();
					
					SaveArray['SolarPanels'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastBuoy',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_SolarPanels,
						'item_SolarPanels',
						'inven_solarPanals_sm'
					);
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Wrench,
							"item_Wrench"
						);
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The solar panels are bolted to the buoy. I'll need a tool to remove the bolts.");
				}
			}	
		}
		
		
		private function StoneHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["Stone"] == "PickedUp"){
					
				}else{
					stone.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy;
					SaveArray['Stone'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastBuoy',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_RedStoneTwo,
						'item_RedStoneTwo',
						'inven_redStoneTwo_sm'
					);
					
					
				}
			}else{
				stone.alpha = 0;
				SaveArray['Stone'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastBuoy',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_RedStoneTwo,
					'item_RedStoneTwo',
					'inven_redStoneTwo_sm'
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
			
			
			this.assets.removeTexture("coastBouy_bg",true);
			this.assets.removeTexture("CoastBuoy_Sprite",true);
			this.assets.removeTextureAtlas("CoastBuoy_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("coastBouy_01");
			(stage.getChildAt(0) as Object).falseAsset("coastBouy_02");
			(stage.getChildAt(0) as Object).falseAsset("coastBouy_03");
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