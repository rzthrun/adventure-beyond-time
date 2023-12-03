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
	
	public class CavePirateDitch extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var plank:Image;
		private var mound:Image;
		private var plankMound:Image;
		private var jug:Image;
		private var coin:Image;
		
		private var hit_plank:Shape;
		private var hit_hole:Shape;
		private var hit_jug:Shape;
		private var hit_coin:Shape;
		
		private var hit_anchor:Shape;
		private var hit_ocean:Shape;
		private var hit_stream:Shape;
		private var hit_ship:Shape;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var HoleOpen:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function CavePirateDitch(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cavePirateDitch_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateDitch/cavePirateDitch_bg.jpg'));
				game.TrackAssets('cavePirateDitch_01');
			}
			if(game.CheckAsset('cavePirateDitch_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateDitch/CavePirateDitch_Sprite.atf'));
				game.TrackAssets('cavePirateDitch_02');
			}
			if(game.CheckAsset('cavePirateDitch_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateDitch/CavePirateDitch_Sprite.xml'));
				game.TrackAssets('cavePirateDitch_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateDitch","CavePirateDitchObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		/*
		private var plank:Image;
		private var mound:Image;
		private var plankMound:Image;
		private var jug:Image;
		*/
		private function onLoadAssets():void{
		
			
			bg = new Image(this.assets.getTexture('cavePirateDitch_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			plank = new Image(this.assets.getTexture('plank'));
			plank.smoothing = TextureSmoothing.NONE;
			plank.touchable = false;
			plank.x = 1;
			plank.y = 15;		
			
			mound = new Image(this.assets.getTexture('ditch'));
			mound.smoothing = TextureSmoothing.NONE;
			mound.touchable = false;
			mound.x = 1;
			mound.y = 217;
			
			plankMound = new Image(this.assets.getTexture('ditch_plank'));
			plankMound.smoothing = TextureSmoothing.NONE;
			plankMound.touchable = false;
			plankMound.x = 94;
			plankMound.y = 217;
	
			jug = new Image(this.assets.getTexture('jug'));
			jug.smoothing = TextureSmoothing.NONE;
			jug.touchable = false;
			jug.x = 576;
			jug.y = 243;

			coin = new Image(this.assets.getTexture('coin'));
			coin.smoothing = TextureSmoothing.NONE;
			coin.touchable = false;
			coin.x = 236;
			coin.y = 329;
			
			//FadeOutOcean(1);
			
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Plank"] == "PickedUp"){
					plank.alpha = 0;
				}else{
					plank.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Jug"] == "PickedUp"){
					jug.alpha = 0;
				}else{
					jug.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Hole"] == "open"){
					mound.alpha = 1;
					HoleOpen = true;
					
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Plank"] == "PickedUp"){
						plankMound.alpha = 0;
					}else{
						plankMound.alpha = 1;
					}	
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Coin"] == "PickedUp"){
						coin.alpha = 0;
					}else{
						coin.alpha = 1;
					}
					CreateCoinHit();
					
				}else{
					coin.alpha = 0;
					mound.alpha = 0;
					plankMound.alpha = 0;
				}
				
			}else{
				plank.alpha = 1;
				jug.alpha = 1;
				mound.alpha = 0;
				plankMound.alpha = 0;
				coin.alpha = 0;
			}

			this.addChildAt(plank,1);
			this.addChildAt(mound,2);
			this.addChildAt(plankMound,3);
			this.addChildAt(jug,4);
			this.addChildAt(coin,5);
			
			CreateAnchorHit();
			CreateStreamHit();
			CreateOceanHit();
			CreateShipHit();

			
			CreatePlankHit();
			CreateHoleHit();
			CreateJugHit();
			
						goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			
		//	(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
		//		(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Shovel,
		//		'item_Shovel',
		//		'inven_shovel_sm'
		//	);
			
		}
		
		//hit_plank
		//hit_jug
		//hit_coin
		//hit_anchor
	
		private function CreateOceanHit():void{
			hit_ocean = new Shape();
			hit_ocean.touchable = false;
			hit_ocean.graphics.beginFill(0xff0000);
			
			hit_ocean.graphics.lineTo(0,0);	
			hit_ocean.graphics.lineTo(260,0);	
			hit_ocean.graphics.lineTo(281,170);	
			hit_ocean.graphics.lineTo(0,158);	
			
			
			hit_ocean.graphics.endFill(false);
			hit_ocean.alpha = 0.0;
			
			hit_ocean.graphics.precisionHitTest = true;	
			this.addChild(hit_ocean);
		}
		
		private function CreateShipHit():void{
			hit_ship = new Shape();
			hit_ship.touchable = false;
			hit_ship.graphics.beginFill(0xff0000);
			
			hit_ship.graphics.lineTo(272,0);	
			hit_ship.graphics.lineTo(643,0);	
			hit_ship.graphics.lineTo(648,83);	
			hit_ship.graphics.lineTo(785,116);	
			//hit_ship.graphics.lineTo(83,120);	
			hit_ship.graphics.lineTo(791,182);	
			hit_ship.graphics.lineTo(546,200);	
			hit_ship.graphics.lineTo(279,91);	
		
			
			hit_ship.graphics.endFill(false);
			hit_ship.alpha = 0.0;
			
			hit_ship.graphics.precisionHitTest = true;	
			this.addChild(hit_ship);
		}
		
		
		private function CreateStreamHit():void{
			hit_stream = new Shape();
			hit_stream.touchable = false;
			hit_stream.graphics.beginFill(0xff0000);
			
			hit_stream.graphics.lineTo(540,284);	
			hit_stream.graphics.lineTo(576,207);	
			hit_stream.graphics.lineTo(726,206);	
			hit_stream.graphics.lineTo(795,231);	
			hit_stream.graphics.lineTo(793,369);	
			hit_stream.graphics.lineTo(716,388);	
		

			hit_stream.graphics.endFill(false);
			hit_stream.alpha = 0.0;
			
			hit_stream.graphics.precisionHitTest = true;	
			this.addChild(hit_stream);
		}
		

		
		private function CreateAnchorHit():void{
			hit_anchor = new Shape();
			hit_anchor.touchable = false;
			hit_anchor.graphics.beginFill(0xff0000);
			
			hit_anchor.graphics.lineTo(344,214);	
			hit_anchor.graphics.lineTo(363,121);	
			hit_anchor.graphics.lineTo(438,65);	
			hit_anchor.graphics.lineTo(458,77);	
			hit_anchor.graphics.lineTo(555,221);	
			hit_anchor.graphics.lineTo(531,273);	
				
		
			
			hit_anchor.graphics.endFill(false);
			hit_anchor.alpha = 0.0;
			
			hit_anchor.graphics.precisionHitTest = true;	
			this.addChild(hit_anchor);
		}
		
		private function CreateCoinHit():void{
			hit_coin = new Shape();
			hit_coin.touchable = false;
			hit_coin.graphics.beginFill(0xff0000);
			
			hit_coin.graphics.lineTo(248,359);	
			hit_coin.graphics.lineTo(269,323);	
			hit_coin.graphics.lineTo(320,322);	
			hit_coin.graphics.lineTo(350,353);	
			hit_coin.graphics.lineTo(340,403);	
			hit_coin.graphics.lineTo(273,412);	

			hit_coin.graphics.endFill(false);
			hit_coin.alpha = 0.0;
			
			hit_coin.graphics.precisionHitTest = true;	
			this.addChild(hit_coin);
		}
		
		private function CreateJugHit():void{
			hit_jug = new Shape();
			hit_jug.touchable = false;
			hit_jug.graphics.beginFill(0xff0000);
			
			hit_jug.graphics.lineTo(548,273);	
			hit_jug.graphics.lineTo(567,236);	
			hit_jug.graphics.lineTo(620,221);	
			hit_jug.graphics.lineTo(667,233);	
			hit_jug.graphics.lineTo(725,286);	
			hit_jug.graphics.lineTo(721,328);	
			hit_jug.graphics.lineTo(660,340);	
			hit_jug.graphics.lineTo(594,319);	
			hit_jug.graphics.endFill(false);
			hit_jug.alpha = 0.0;
			
			hit_jug.graphics.precisionHitTest = true;	
			this.addChild(hit_jug);
		}
		
		private function CreatePlankHit():void{
			hit_plank = new Shape();
			hit_plank.touchable = false;
			hit_plank.graphics.beginFill(0xff0000);
			
			hit_plank.graphics.lineTo(70,16);	
			hit_plank.graphics.lineTo(148,5);	
			hit_plank.graphics.lineTo(221,259);	
			hit_plank.graphics.lineTo(130,274);	
			hit_plank.graphics.endFill(false);
			hit_plank.alpha = 0.0;
			
			hit_plank.graphics.precisionHitTest = true;	
			this.addChild(hit_plank);
		}
		
		private function CreateHoleHit():void{
			hit_hole = new Shape();
			hit_hole.touchable = false;
			hit_hole.graphics.beginFill(0xff0000);
			
			hit_hole.graphics.lineTo(120,326);	
			hit_hole.graphics.lineTo(225,272);	
			hit_hole.graphics.lineTo(315,272);	
			hit_hole.graphics.lineTo(480,315);	
			hit_hole.graphics.lineTo(477,382);	
			hit_hole.graphics.lineTo(378,417);	
			hit_hole.graphics.lineTo(168,406);	
			hit_hole.graphics.endFill(false);
			hit_hole.alpha = 0.0;
			
			hit_hole.graphics.precisionHitTest = true;	
			this.addChild(hit_hole);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CavePirate as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateObj,true
						);
					}else if(hit_plank.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						PlankHandler();
					}else if(hit_jug.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						JugHandler();
					}else if(hit_anchor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old anchor. It's very heavy.");
					}else if(hit_stream.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fresh water stream, flowing into the salt water ocean.");
					}else if(hit_ship.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship is very old. The wood is stained with rot and mold.");
					}else if(hit_ocean.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Waves lap against the beach.");
														
						
						/*
						private var hit_anchor:Shape;
						private var hit_ocean:Shape;
						private var hit_stream:Shape;
						private var hit_ship:Shape;
						*/
						
					}else if(HoleOpen === true){
						if(hit_coin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CoinHandler();
						}else if(hit_hole.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HoleHandler();
						}
					}else{
						if(hit_hole.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HoleHandler();
						}
					}
				}
			}
		}
		private function CoinHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Coin"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Like sand in an hour glass...");
				}else{
					coin.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch;
					SaveArray['Coin'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateDitch',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinDragon,
						'item_CoinDragon',
						'inven_coinDragon_sm'
					);
					
					
				}
			}else{
				coin.alpha = 0;	
				SaveArray['Coin'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateDitch',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinDragon,
					'item_CoinDragon',
					'inven_coinDragon_sm'
				);
			}	
		}
		
		private function HoleHandler():void{
			if(HoleOpen === false){
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Shovel)
				{
				
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelTwo();
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Shovel,
							"item_Shovel"
						);
					
					
					mound.alpha = 1;
					coin.alpha = 1;
					HoleOpen = true;
					CreateCoinHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch;
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Plank"] == "PickedUp"){
							plankMound.alpha = 0;
						}else{
							plankMound.alpha = 1;
						}
					}else{
						plankMound.alpha = 1;
					}
					
					SaveArray['Hole'] = 'open';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateDitch',SaveArray);
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sand here is more loosely packed... and there's an 'X' lightly drawn into the surface.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That's the hole in the sand I dug. The tides will wash it away in time.");
			}
		}
		
		private function JugHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Jug"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The fresh water stream, flowing into the salt water ocean.");
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
					jug.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch;
					SaveArray['Jug'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateDitch',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Jug,
						'item_Jug',
						'inven_jug_sm'
					);
					
					
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
				jug.alpha = 0;
				SaveArray['Jug'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateDitch',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Jug,
					'item_Jug',
					'inven_jug_sm'
				);
			}	
		}
		
		private function PlankHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Plank"] == "PickedUp"){
					if(hit_ocean.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Waves lap against the beach.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelOne();
					plank.alpha = 0;
					plankMound.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch;
					SaveArray['Plank'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateDitch',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PlankOne,
						'item_PlankOne',
						'inven_plankOne_sm'
					);
					
					
				}
			}else{
				plank.alpha = 0;
				plankMound.alpha = 0;
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ShovelOne();
				SaveArray['Plank'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateDitch',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PlankOne,
					'item_PlankOne',
					'inven_plankOne_sm'
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
			
			
			this.assets.removeTexture("cavePirateDitch_bg",true);
			this.assets.removeTexture("CavePirateDitch_Sprite",true);
			this.assets.removeTextureAtlas("CavePirateDitch_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cavePirateDitch_01");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateDitch_02");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateDitch_03");
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