package screens.ingamescreens
{
	//coastCaveBox_bg

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
	
	public class CoastCaveBox extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var stone:Image;
		private var lid:Image;
		private var celtic:Image;
		
		private var hit_lid:Shape;
		private var hit_stone:Shape;
		
		private var LidOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CoastCaveBox(_assets:AssetManager,_game:Game)
		{
			super();
			//	this.assets = new AssetManager();
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		//CoastCaveBox_Sprite
		
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('coastCaveBox_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveBox/coastCaveBox_bg.jpg'));
				game.TrackAssets('coastCaveBox_01');
			}
			if(game.CheckAsset('coastCaveBox_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveBox/CoastCaveBox_Sprite.atf'));
				game.TrackAssets('coastCaveBox_02');
			}
			if(game.CheckAsset('coastCaveBox_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveBox/CoastCaveBox_Sprite.xml'));
				game.TrackAssets('coastCaveBox_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastCaveBox","CoastCaveBoxObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastCaveBox_bg'));
			bg.touchable = true;
			this.addChild(bg);
			
			stone = new Image(this.assets.getTexture('stone'));
			stone.smoothing = TextureSmoothing.NONE;
			stone.touchable = false;
			stone.x = 332;
			stone.y = 229;
			
			lid = new Image(this.assets.getTexture('lid'));
			lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 79;
			lid.y = 0;

			celtic = new Image(this.assets.getTexture('celtic'));
			celtic.smoothing = TextureSmoothing.NONE;
			celtic.touchable = false;
			celtic.x = 326;
			celtic.y = 64;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Celtic'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Lid'] == 'open'){
						LidOpen = true;
						lid.alpha = 0;
						celtic.alpha = 0;
						CreateStoneHit();
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Stone'] == 'PickedUp'){
							stone.alpha = 0;
						}else{
							stone.alpha = 1;
						}
					}else{
						LidOpen = false;
						lid.alpha = 1;
						celtic.alpha = 1;
						stone.alpha = 0;
					}
					
				}else{
					LidOpen = false;
					stone.alpha = 0;
					lid.alpha = 1;
					celtic.alpha = 0;
				}
			}else{
				LidOpen = false;
				stone.alpha = 0;
				lid.alpha = 1;
				celtic.alpha = 0;
			}
			

			
			this.addChildAt(stone,1);
			this.addChildAt(lid,2);
			this.addChildAt(celtic,3);
			
			CreateLidHit(LidOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
					},1);
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			}
			
			
		}
		
		private function CreateStoneHit():void{
			hit_stone = new Shape();
			hit_stone.touchable = false;
			hit_stone.graphics.beginFill(0xff0000);
			
			hit_stone.graphics.lineTo(319,202);	
			hit_stone.graphics.lineTo(503,223);	
			hit_stone.graphics.lineTo(484,355);	
			hit_stone.graphics.lineTo(294,327);	
			
			hit_stone.graphics.endFill(false);
			hit_stone.alpha = 0.0;
			
			hit_stone.graphics.precisionHitTest = true;	
			this.addChild(hit_stone);
		}
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				hit_lid.graphics.lineTo(76,216);
				hit_lid.graphics.lineTo(81,170);
				hit_lid.graphics.lineTo(163,7);
				hit_lid.graphics.lineTo(640,58);
				hit_lid.graphics.lineTo(693,110);
				hit_lid.graphics.lineTo(713,258);
				hit_lid.graphics.lineTo(703,314);
				hit_lid.graphics.lineTo(615,474);
				hit_lid.graphics.lineTo(138,412);

				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(164,0);
				hit_lid.graphics.lineTo(701,0);
				hit_lid.graphics.lineTo(640,147);
				hit_lid.graphics.lineTo(190,101);

				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			
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
					}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Celtic'] == 'Attached'){
								LidHandler();
							}else{
								AttachCeltic();
							}	
						}else{
							AttachCeltic();
						}
						
					}
					
					else if(LidOpen === true){
						if(hit_stone.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							StoneHandler();
						}
					}

				}
			}
		}
		
		private function StoneHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox["Stone"] == "PickedUp"){
					
				}else{
					stone.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox;
					SaveArray['Stone'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveBox',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_RedStoneOne,
						'item_RedStoneOne',
						'inven_redStoneOne_sm'
					);
					
					
				}
			}else{
				stone.alpha = 0;
				SaveArray['Stone'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveBox',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_RedStoneOne,
					'item_RedStoneOne',
					'inven_redStoneOne_sm'
				);
			}	
		}
		
		private function LidHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			trace("touch lid");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Lid'] != 'open'){
					trace(1);
					SaveArray['Lid'] = 'open';
					
					lid.alpha = 0;
					celtic.alpha = 0;
					hit_lid.graphics.clear();
					CreateLidHit(true);
					//CreateFrighterLowerHit();
					LidOpen = true;
					//CreateJunkInteriorHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Stone'] == 'PickedUp'){
						stone.alpha = 0;
					}else{
						stone.alpha = 1;
					}
					CreateStoneHit();
					
				}else{
					trace(2);
					SaveArray['Lid'] = 'close';
					
					lid.alpha = 1;
					celtic.alpha = 1;
					removeChild(hit_stone);
					hit_lid.graphics.clear();
					
					CreateLidHit(false);
					LidOpen = false;
					stone.alpha = 0;
					//CelticTriangle.alpha = 0;
				}
				
			}else{
				trace(3)
				SaveArray['Lid'] = 'open';
				
				lid.alpha = 0;
				celtic.alpha = 0;
				hit_lid.graphics.clear();
				CreateLidHit(true);
				//CreateFrighterLowerHit();
				LidOpen = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox['Stone'] == 'PickedUp'){
						stone.alpha = 0;
					}else{
						stone.alpha = 1;
					}
				}else{
					stone.alpha = 1;
				}
				CreateStoneHit();
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveBox',SaveArray);	
			
		}
		private function AttachCeltic():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Celtic)
			{
				trace("Celtic Triangle Armed");
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Celtic,
						"item_Celtic"
					);
				
				celtic.alpha = 1;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveBox;			
				}
				
				SaveArray['Celtic'] = 'Attached';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveBox',SaveArray);
				
			}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_RedStoneOne)
				{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The box could be useful. I shouldn't use a rock on it.");

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_RedStoneOne)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The box could be useful. I shouldn't use a rock on it.");
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's locked. There is an impression on the top.");
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
			
			
			this.assets.removeTexture("coastCaveBox_bg",true);
			this.assets.removeTexture("CoastCaveBox_Sprite",true);
			this.assets.removeTextureAtlas("CoastCaveBox_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("coastCaveBox_01");
			(stage.getChildAt(0) as Object).falseAsset("coastCaveBox_02");
			(stage.getChildAt(0) as Object).falseAsset("coastCaveBox_03");
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