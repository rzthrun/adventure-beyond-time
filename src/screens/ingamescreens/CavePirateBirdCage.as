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

	public class CavePirateBirdCage extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var lid:Image;
		private var coin:Image;
		
		private var hit_coin:Shape;
		private var hit_lid:Shape;
		private var hit_lock:Shape;
		private var hit_cage:Shape;
		
		private var LidOpen:Boolean = false;
		private var Unlocked:Boolean = false;
	//	private var CoinPickedUp:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function CavePirateBirdCage(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('pirateBirdCage_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateBirdCage/pirateBirdCage_bg.jpg'));
				game.TrackAssets('pirateBirdCage_01');
			}
			if(game.CheckAsset('pirateBirdCage_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateBirdCage/PirateBirdCage_Sprite.atf'));
				game.TrackAssets('pirateBirdCage_02');
			}
			if(game.CheckAsset('pirateBirdCage_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateBirdCage/PirateBirdCage_Sprite.xml'));
				game.TrackAssets('pirateBirdCage_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateBirdCage","CavePirateBirdCageObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('pirateBirdCage_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			lid = new Image(this.assets.getTexture('lid'));
			lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 1;
			lid.y = 97;
			
			
			coin = new Image(this.assets.getTexture('coin_lid'));
			coin.smoothing = TextureSmoothing.NONE;
			coin.touchable = false;
			coin.x = 307;
			coin.y = 242;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage['Unlocked'] == 'Yes'){
					Unlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage['Lid'] == 'Open'){
						lid.alpha = 0;
						LidOpen = true;
						coin.texture = this.assets.getTexture('coin')
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage['Coin'] == 'PickedUp'){
							coin.alpha = 0;
						}else{
							coin.alpha = 1;
						}
					}else{
						lid.alpha = 1;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage['Coin'] == 'PickedUp'){
							coin.alpha = 0;
						}else{
							coin.alpha = 1;
						}
					}
				}else{
					lid.alpha = 1;
					coin.alpha = 1;
				}
			}else{
				lid.alpha = 1;
				coin.alpha = 1;
			}
			
			
			this.addChildAt(lid,1);
			this.addChildAt(coin,2);
			//FadeOutOcean(1);
			
			CreateCageHit();
			CreateLidHit(LidOpen);
			CreateLockHit();
			CreateCoinHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			},1);
		}
		//hit_cage
		private function CreateCageHit():void{
			hit_cage = new Shape();
			hit_cage.touchable = false;
			hit_cage.graphics.beginFill(0xff0000);
			
			hit_cage.graphics.lineTo(495,165);	
			hit_cage.graphics.lineTo(502,1);	
			hit_cage.graphics.lineTo(665,5);	
			hit_cage.graphics.lineTo(618,378);	
			hit_cage.graphics.lineTo(540,446);	
			hit_cage.graphics.lineTo(536,163);	
			
			
			hit_cage.graphics.endFill(false);
			hit_cage.alpha = 0.0;
			
			hit_cage.graphics.precisionHitTest = true;	
			this.addChild(hit_cage);
		}
		
		private function CreateCoinHit():void{
			hit_coin = new Shape();
			hit_coin.touchable = false;
			hit_coin.graphics.beginFill(0xff0000);
			
			hit_coin.graphics.lineTo(291,256);	
			hit_coin.graphics.lineTo(328,225);	
			hit_coin.graphics.lineTo(401,228);	
			hit_coin.graphics.lineTo(430,266);	
			hit_coin.graphics.lineTo(429,292);	
			hit_coin.graphics.lineTo(390,323);	
			hit_coin.graphics.lineTo(330,318);	
			hit_coin.graphics.lineTo(288,286);	
			
			hit_coin.graphics.endFill(false);
			hit_coin.alpha = 0.0;
			
			hit_coin.graphics.precisionHitTest = true;	
			this.addChild(hit_coin);
		}
		
		
		private function CreateLockHit():void{
			hit_lock = new Shape();
			hit_lock.touchable = false;
			hit_lock.graphics.beginFill(0xff0000);
			
			hit_lock.graphics.lineTo(451,189);	
			hit_lock.graphics.lineTo(536,172);	
			hit_lock.graphics.lineTo(531,259);	
			hit_lock.graphics.lineTo(457,278);	
		
			
			hit_lock.graphics.endFill(false);
			hit_lock.alpha = 0.0;
			
			hit_lock.graphics.precisionHitTest = true;	
			this.addChild(hit_lock);
		}
	
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(231,95);	
				hit_lid.graphics.lineTo(496,93);	
				hit_lid.graphics.lineTo(485,330);	
				hit_lid.graphics.lineTo(254,328);	
				
				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(3,186);
				hit_lid.graphics.lineTo(243,95);
				hit_lid.graphics.lineTo(273,324);
				hit_lid.graphics.lineTo(78,453);

				
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			this.addChild(hit_lid);
			
		}	
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CavePirateTopDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateTopDeckObj,true
						);
						
					}else if(hit_cage.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cage is made of brass.");
					}else if(hit_lock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(Unlocked === true){
							LidHandler();
						}else{
							LockHandler();
						}
					}else if(hit_coin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(LidOpen === true){
							CoinHandler();
						}else{
							if(Unlocked === true){
								LidHandler();
							}else{
								
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's an antique coin inside the cage. I can't reach it.");
							}
						}
						
					}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
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
								.item_Compass)
							{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("hmm... maybe I can pick the lock with this...");
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RattleOne();
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The gate of the cage is locked !");
							}
						}
					}
				}
			}
		}
		
		private function LidHandler():void{
			if(LidOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyCloseTwo();
				LidOpen = true;
				lid.alpha = 0;
				coin.texture = this.assets.getTexture('coin')
				
				hit_lid.graphics.clear();
				CreateLidHit(true);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage;
				}		
				
				SaveArray['Lid'] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBirdCage',SaveArray);	
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
				LidOpen = false;
				lid.alpha = 1;
				coin.texture = this.assets.getTexture('coin_lid')
				
				hit_lid.graphics.clear();
				CreateLidHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage;
				}		
				
				SaveArray['Lid'] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBirdCage',SaveArray);	
			}
		}
		
		private function CoinHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage['Coin'] == 'PickedUp'){
					
				}else{
					coin.alpha = 0;
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage;
					}
					SaveArray["Coin"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBirdCage',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_AncientCoinOne,
						'item_AncientCoinOne',
						'inven_ancientCoinOne_sm'
					);
				}
			}else{
				coin.alpha = 0;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage;
				}
				SaveArray["Coin"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBirdCage',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_AncientCoinOne,
					'item_AncientCoinOne',
					'inven_ancientCoinOne_sm'
				);
			}
		}
		
		private function LockHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Compass)
			{
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,1);
				}
				Unlocked = true;
				LidOpen = true;
				lid.alpha = 0;
				coin.texture = this.assets.getTexture('coin')
				
				hit_lid.graphics.clear();
				CreateLidHit(true);
					
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBirdCage;
				}		
				
				SaveArray['Unlocked'] = "Yes";
				SaveArray['Lid'] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBirdCage',SaveArray);	
					
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Compass,
						"item_Compass"
					);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've used the thin compass needle to trip the lock of the bird cage.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_PirateKey)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RattleOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The key is too large for the lock.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_SlenderKey)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RattleOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The key is too large for the lock.");
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_WireCutters)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RattleOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal is too thick to cut.");
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RattleOne();
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a very small lock - not sophisticated, but still sturdy.");
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
			
			
			this.assets.removeTexture("pirateBirdCage_bg",true);
			this.assets.removeTexture("PirateBirdCage_Sprite",true);
			this.assets.removeTextureAtlas("PirateBirdCage_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateBirdCage_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateBirdCage_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateBirdCage_03");
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