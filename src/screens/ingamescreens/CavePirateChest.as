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
	import starling.utils.AssetManager;
	import starling.textures.TextureSmoothing;
	
	public class CavePirateChest extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hammer:Image;
		private var iridium:Image;
		private var coin_left:Image;
		private var coin_right:Image;
		private var lid:Image;
		
		private var hit_lid:Shape
		private var hit_skull:Shape;
		private var hit_iridium:Shape;
		private var hit_hammer:Shape;
		
		private var LidOpen:Boolean = false;
		private var Unlocked:Boolean = false;
		private var CoinRightAttached:Boolean = false;
		private var CoinLeftAttached:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function CavePirateChest(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cavePirateChest_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateChest/cavePirateChest_bg.jpg'));
				game.TrackAssets('cavePirateChest_01');
			}
			if(game.CheckAsset('cavePirateChest_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateChest/CavePirateChest_Sprite.atf'));
				game.TrackAssets('cavePirateChest_02');
			}
			if(game.CheckAsset('cavePirateChest_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateChest/CavePirateChest_Sprite.xml'));
				game.TrackAssets('cavePirateChest_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateChest","CavePirateChestObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('cavePirateChest_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			hammer = new Image(this.assets.getTexture('hammer'));
			hammer.smoothing = TextureSmoothing.NONE;
			hammer.touchable = false;
			hammer.x = 143;
			hammer.y = 115;

			iridium = new Image(this.assets.getTexture('iridium'));
			iridium.smoothing = TextureSmoothing.NONE;
			iridium.touchable = false;
			iridium.x = 407;
			iridium.y = 170;

			lid = new Image(this.assets.getTexture('lid'));
			//lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 49;
			lid.y = 0;
			
			coin_right = new Image(this.assets.getTexture('coin_right'));
			coin_right.smoothing = TextureSmoothing.NONE;

			coin_right.touchable = false;
			coin_right.x = 356;
			coin_right.y = 202;
			
			coin_left = new Image(this.assets.getTexture('coin_left'));
			coin_left.smoothing = TextureSmoothing.NONE;

			coin_left.touchable = false;
			coin_left.x = 425;
			coin_left.y = 212;
			

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Unlocked'] == 'Yes'){
					Unlocked = true;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Lid'] == 'Open'){
					LidOpen = true;
					lid.alpha = 0;
					coin_right.alpha = 0;
					coin_left.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Iridium'] == 'PickedUp'){
						iridium.alpha = 0;	
					}else{
						iridium.alpha = 1;	
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Hammer'] == 'PickedUp'){
						hammer.alpha = 0;	
					}else{
						hammer.alpha = 1;	
					}
					CreateHammerHit();
					CreateIridiumHit();
					
				}else{
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['CoinRight'] == 'Attached'){
						CoinRightAttached = true;
						coin_right.alpha = 1;
					}else{
						coin_right.alpha = 0;
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['CoinLeft'] == 'Attached'){
						CoinLeftAttached = true;
						coin_left.alpha = 1;
					}else{
						coin_left.alpha = 0;
					}
				}
				
			}else{
				hammer.alpha = 0;
				iridium.alpha = 0;
				lid.alpha = 1;
				coin_right.alpha = 0;
				coin_left.alpha = 0;
			}
			
			
			
			this.addChildAt(hammer,1);
			this.addChildAt(iridium,2);
			this.addChildAt(lid,3);
			this.addChildAt(coin_right,4);
			this.addChildAt(coin_left,5);
			
			/*
			private var hammer:Image;
			private var iridium:Image;
			private var coin_left:Image;
			private var coin_right:Image;
			private var lid:Image;
			*/
			CreateLidHit(LidOpen);
			CreateSkullHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		//	(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("Waves_02",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
		}
		
		
		/*
		private var hit_lid:Shape
		private var hit_skull:Shape;
		private var hit_iridium:Shape;
		private var hit_hammer:Shape;
		*/
		
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(58,229);	
				hit_lid.graphics.lineTo(78,110);	
				hit_lid.graphics.lineTo(108,35);	
				hit_lid.graphics.lineTo(151,12);	
				hit_lid.graphics.lineTo(656,89);	
				hit_lid.graphics.lineTo(735,132);	
				hit_lid.graphics.lineTo(752,212);	
				hit_lid.graphics.lineTo(743,295);	
				hit_lid.graphics.lineTo(730,327);	

				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(156,0);
				hit_lid.graphics.lineTo(663,0);
				hit_lid.graphics.lineTo(667,96);
				hit_lid.graphics.lineTo(683,101);
				hit_lid.graphics.lineTo(611,220);
				hit_lid.graphics.lineTo(182,158);

				
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			this.addChild(hit_lid);
			
		}	
		
		
		private function CreateIridiumHit():void{
			hit_iridium = new Shape();
			hit_iridium.touchable = false;
			hit_iridium.graphics.beginFill(0xff0000);
			
			hit_iridium.graphics.lineTo(470,144);	
			hit_iridium.graphics.lineTo(571,186);	
			hit_iridium.graphics.lineTo(526,286);	
			hit_iridium.graphics.lineTo(470,292);	
			hit_iridium.graphics.lineTo(451,346);	
			hit_iridium.graphics.lineTo(388,316);	
			
			hit_iridium.graphics.endFill(false);
			
			hit_iridium.alpha = 0.0;
			
			hit_iridium.graphics.precisionHitTest = true;	
			this.addChild(hit_iridium);
		}
		
		private function CreateHammerHit():void{
			hit_hammer = new Shape();
			hit_hammer.touchable = false;
			hit_hammer.graphics.beginFill(0xff0000);
			
			hit_hammer.graphics.lineTo(140,199);	
			hit_hammer.graphics.lineTo(147,152);	
			hit_hammer.graphics.lineTo(306,101);	
			hit_hammer.graphics.lineTo(320,147);	
			hit_hammer.graphics.lineTo(293,270);	
			hit_hammer.graphics.lineTo(217,256);	
			
			hit_hammer.graphics.endFill(false);
			
			hit_hammer.alpha = 0.0;
			
			hit_hammer.graphics.precisionHitTest = true;	
			this.addChild(hit_hammer);
		}
		
		private function CreateSkullHit():void{
			hit_skull = new Shape();
			hit_skull.touchable = false;
			hit_skull.graphics.beginFill(0xff0000);
			
			hit_skull.graphics.lineTo(271,226);	
			hit_skull.graphics.lineTo(327,133);	
			hit_skull.graphics.lineTo(391,108);	
			hit_skull.graphics.lineTo(465,119);	
			hit_skull.graphics.lineTo(531,177);	
			hit_skull.graphics.lineTo(546,275);	
			hit_skull.graphics.lineTo(497,350);	
			hit_skull.graphics.lineTo(400,378);	
			hit_skull.graphics.lineTo(299,331);	

			hit_skull.graphics.endFill(false);
			
			hit_skull.alpha = 0.0;
			
			hit_skull.graphics.precisionHitTest = true;	
			this.addChild(hit_skull);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CavePirateEnclave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateEnclaveObj,true
						);
					}else if(LidOpen === false){
						if(hit_skull.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SkullHandler();
						}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Unlocked === true){
								LidHandler();
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't open it.");
							}
						}
					}else{
						if(hit_iridium.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							IridiumHandler();
						}else if(hit_hammer.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HammerHandler();
						}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							LidHandler();
						}
					}
				}
			}
		}
		
		private function HammerHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Hammer'] == 'PickedUp'){
					
				}else{
					hammer.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
					}
					SaveArray["Hammer"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hammer,
						'item_Hammer',
						'inven_hammer_sm'
					);
				}
			}else{
				hammer.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
				}
				SaveArray["Hammer"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Hammer,
					'item_Hammer',
					'inven_hammer_sm'
				);
			}
		}
		
		private function IridiumHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Iridium'] == 'PickedUp'){
					
				}else{
					iridium.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
					}
					SaveArray["Iridium"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Iridium,
						'item_Iridium',
						'inven_iridium_sm'
					);
				}
			}else{
				iridium.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
				}
				SaveArray["Iridium"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Iridium,
					'item_Iridium',
					'inven_iridium_sm'
				);
			}
		}
		
		
		private function LidHandler():void{
			if(LidOpen === false){
				LidOpen = true;
				lid.alpha = 0;
				coin_right.alpha = 0;
				coin_left.alpha = 0;
				hit_lid.graphics.clear();
				CreateLidHit(true);
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ChestOpen();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Iridium'] == 'PickedUp'){
						iridium.alpha = 0;
					}else{
						iridium.alpha = 1;
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest['Hammer'] == 'PickedUp'){
						hammer.alpha = 0;
					}else{
						hammer.alpha = 1;
					}
				}
				CreateIridiumHit();
				CreateHammerHit();
				
				SaveArray['Lid'] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
				LidOpen = false;
				lid.alpha = 1;
				coin_right.alpha = 1;
				coin_left.alpha = 1;
				hit_lid.graphics.clear();
				this.removeChild(hit_iridium);
				this.removeChild(hit_hammer);
				CreateLidHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
				}
				
				SaveArray['Lid'] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);
			}
		}
		private function SkullHandler():void{
			if(Unlocked === true){
				LidHandler();	
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_AncientCoinOne)
				{
					CoinRightAttached = true;
					coin_right.alpha = 1;
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
					}		
					
					SaveArray['CoinRight'] = "Attached";
					
					if(CoinLeftAttached === true){
						Unlocked = true;
						SaveArray['Unlocked'] = "Yes";
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadBeachStrings(true,2);
							},0.5);
						}
					}
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);	
					
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_AncientCoinOne,
							"item_AncientCoinOne"
						);
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_AncientCoinTwo)
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
					CoinLeftAttached = true;
					coin_left.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateChest;
					}		
					
					SaveArray['CoinLeft'] = "Attached";
					
					if(CoinRightAttached === true){
						Unlocked = true;
						SaveArray['Unlocked'] = "Yes";
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadBeachStrings(true,2);
							},0.5);
						}
					
						
					}
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateChest',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_AncientCoinTwo,
							"item_AncientCoinTwo"
						);
					
				}else{
					if(CoinRightAttached === true || CoinLeftAttached === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();	
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've placed a coin into one of the skull's sockets, but nothing happens.");
				
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The chest is locked ... and creepy.");
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
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
			
			
			this.assets.removeTexture("cavePirateChest_bg",true);
			this.assets.removeTexture("CavePirateChest_Sprite",true);
			this.assets.removeTextureAtlas("CavePirateChest_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cavePirateChest_01");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateChest_02");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateChest_03");
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