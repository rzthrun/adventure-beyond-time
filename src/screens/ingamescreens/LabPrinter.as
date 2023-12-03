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
	
	public class LabPrinter extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var goo:Image;
		private var crystal:Image;
		private var stone:Image;
		
		private var hit_left:Shape;
		private var hit_right:Shape;
		
		private var hit_nozzle:Shape;
		private var hit_grid:Shape;
		private var hit_body:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var StoneAttached:Boolean = false;
		private var GooAttached:Boolean = false;
		private var CrystalAvailable:Boolean = false;
		private var CrystalPickedUp:Boolean = false;
		
		
		private var goback:GoBackButton;
		
		public function LabPrinter(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('labPrinter_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabPrinter/labPrinter_bg.jpg'));
				game.TrackAssets('labPrinter_01');
			}
			if(game.CheckAsset('labPrinter_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabPrinter/LabPrinter_Sprite.png'));
				game.TrackAssets('labPrinter_02');
			}
			if(game.CheckAsset('labPrinter_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabPrinter/LabPrinter_Sprite.xml'));
				game.TrackAssets('labPrinter_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("LabPrinter","LabPrinterObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('labPrinter_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			goo = new Image(this.assets.getTexture('goo'));
			goo.touchable = false;
			goo.x = 123;
			goo.y = 165;		
			
			crystal = new Image(this.assets.getTexture('crystal'));
			crystal.touchable = false;
			crystal.x = 195;
			crystal.y = 92;			
			
			stone = new Image(this.assets.getTexture('stone'));
			stone.touchable = false;
			stone.x = 490;
			stone.y = 132;

			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Stone'] == 'Attached'){
					StoneAttached = true;
					stone.alpha = 1;
				}else{
					stone.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Goo'] == 'Attached'){
					GooAttached = true;
					goo.alpha = 1;
				}else{
					
					goo.alpha = 0;
				}
				
			}else{
				stone.alpha = 0;
				goo.alpha = 0;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Crystal'] == 'Printed'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Crystal'] == 'PickedUp'){
							CrystalPickedUp = true;
							crystal.alpha = 0;
						}else{
							CrystalAvailable = true;
							crystal.alpha = 1;
						}
					}else{
						CrystalAvailable = true;
						crystal.alpha = 1;
					}
				}else{
					crystal.alpha = 0;
				}
			}else{
				crystal.alpha = 0;
			}
			
			
			
			
			this.addChildAt(goo,1);		
			this.addChildAt(crystal,2);			
			this.addChildAt(stone,3);
			
			CreateHitBody();
			CreateHitGrid();
			CreateHitNozzle();
			CreateHitRight();
			CreateHitLeft();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
		}
		
		private function CreateHitBody():void{
			hit_body = new Shape();
			hit_body.touchable = false;
			hit_body.graphics.beginFill(0xff0000);
			
			hit_body.graphics.lineTo(0,288);							
			hit_body.graphics.lineTo(192,115);							
			hit_body.graphics.lineTo(741,195);							
			hit_body.graphics.lineTo(778,363);							
			hit_body.graphics.lineTo(527,505);							
			
			hit_body.graphics.endFill(false);
			
			hit_body.alpha = 0.0;
			
			hit_body.graphics.precisionHitTest = true;	
			this.addChild(hit_body);
		}
		
		private function CreateHitGrid():void{
			hit_grid = new Shape();
			hit_grid.touchable = false;
			hit_grid.graphics.beginFill(0xff0000);
			
			hit_grid.graphics.lineTo(205,0);							
			hit_grid.graphics.lineTo(669,0);							
			hit_grid.graphics.lineTo(683,184);							
			hit_grid.graphics.lineTo(218,116);							
							
			
			hit_grid.graphics.endFill(false);
			
			hit_grid.alpha = 0.0;
			
			hit_grid.graphics.precisionHitTest = true;	
			this.addChild(hit_grid);
		}
		
		private function CreateHitNozzle():void{
			hit_nozzle = new Shape();
			hit_nozzle.touchable = false;
			hit_nozzle.graphics.beginFill(0xff0000);
			
			hit_nozzle.graphics.lineTo(31,0);							
			hit_nozzle.graphics.lineTo(193,0);							
			hit_nozzle.graphics.lineTo(142,100);							
			hit_nozzle.graphics.lineTo(125,102);							
			hit_nozzle.graphics.lineTo(38,42);							
			
			hit_nozzle.graphics.endFill(false);
			
			hit_nozzle.alpha = 0.0;
			
			hit_nozzle.graphics.precisionHitTest = true;	
			this.addChild(hit_nozzle);
		}
		
		private function CreateHitRight():void{
			hit_right = new Shape();
			hit_right.touchable = false;
			hit_right.graphics.beginFill(0xff0000);
			
			hit_right.graphics.lineTo(408,215);							
			hit_right.graphics.lineTo(516,110);							
			hit_right.graphics.lineTo(611,121);							
			hit_right.graphics.lineTo(696,329);							
			hit_right.graphics.lineTo(590,433);							
			hit_right.graphics.lineTo(412,380);							
			
			hit_right.graphics.endFill(false);
			
			hit_right.alpha = 0.0;
			
			hit_right.graphics.precisionHitTest = true;	
			this.addChild(hit_right);
		}
		
		private function CreateHitLeft():void{
			hit_left = new Shape();
			hit_left.touchable = false;
			hit_left.graphics.beginFill(0xff0000);
			
			hit_left.graphics.lineTo(93,184);							
			hit_left.graphics.lineTo(193,80);							
			hit_left.graphics.lineTo(265,81);							
			hit_left.graphics.lineTo(371,182);							
			hit_left.graphics.lineTo(350,305);							
			hit_left.graphics.lineTo(224,332);							
			hit_left.graphics.lineTo(102,291);							
					
			
			hit_left.graphics.endFill(false);
			
			hit_left.alpha = 0.0;
			
			hit_left.graphics.precisionHitTest = true;	
			this.addChild(hit_left);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((LabEquipment as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.LabEquipmentObj,true
						);
					}else if(hit_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						RightHandler();
					}else if(hit_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LeftHandler();
					}else if(hit_nozzle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The printer's material output nozzle.");
					}else if(hit_grid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The grid probably helps the machine see what's been placed on it.");
					}else if(hit_body.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The base is painted with a shiny blue enamel.");
					}
					
					/*
					private var hit_nozzle:Shape;
					private var hit_grid:Shape;
					private var hit_body:Shape;
					*/
				}
			}
		}
		
		private function LeftHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Motor)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashTwo();
				goo.alpha = 1;
				GooAttached = true;
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Motor,
						"item_Motor"
					);	
					
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter;
				}
				SaveArray['Goo'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabPrinter',SaveArray);	
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've poured the mush into the Pyrex bowl.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_GourdWater)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pouring water into this bowl will not accomplish much.");
			
			}else if(GooAttached === true){
				if(CrystalAvailable === false){
					if(CrystalPickedUp === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Not appetizing...");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've poured the mush into the Pyrex bowl.");
					}
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
					CrystalPickedUp = true;
					CrystalAvailable = false;
					crystal.alpha = 0;
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CrystalGreen,
						'item_CrystalGreen',
						'inven_crystalGreen_sm'
					);
					
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter;
					}
					SaveArray['Crystal'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabPrinter',SaveArray);	
					
					
					

				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A Pyrex bowl resting on one of the printer's two surfaces.");
			}
		}
		
		private function RightHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Marble)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				stone.alpha = 1;
				StoneAttached = true;
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Marble,
						"item_Marble"
					);
					
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter;
				}
				SaveArray['Stone'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabPrinter',SaveArray);	
			}else if(StoneAttached === true){
				if(CrystalPickedUp === true){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'll leave this here.");
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've placed the petrified wood on one of the printer's surfaces.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An area presumably to place an item for copying.");
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
			
			
			this.assets.removeTexture("labPrinter_bg",true);
			this.assets.removeTexture("LabPrinter_Sprite",true);
			this.assets.removeTextureAtlas("LabPrinter_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("labPrinter_01");
			(stage.getChildAt(0) as Object).falseAsset("labPrinter_02");
			(stage.getChildAt(0) as Object).falseAsset("labPrinter_03");
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
