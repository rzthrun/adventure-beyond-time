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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class SubmarineCaptainsBed extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var lid:Image;
		private var wire_cutters:Image;
		private var pillow:Image;
		private var coin:Image;
		
		private var hit_lid:Shape;
		private var hit_wirecutters:Shape;
		private var hit_pillow:Shape;
		private var hit_coin:Shape;
		
		private var hit_mig:Shape;
		private var hit_akuza:Shape;
		private var hit_photos:Shape;
		private var hit_hat:Shape;
		private var hit_bed:Shape;
		private var hit_fan:Shape;
		private var hit_lamp:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var LidOpen:Boolean = false;
		private var PillowOff:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function SubmarineCaptainsBed(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineCaptainsBed_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsBed/submarineCaptainsBed_bg.jpg'));
				game.TrackAssets('submarineCaptainsBed_01');
			}
			if(game.CheckAsset('submarineCaptainsBed_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsBed/SubmarineCaptainsBed_Sprite_01.atf'));
				game.TrackAssets('submarineCaptainsBed_02');
			}
			if(game.CheckAsset('submarineCaptainsBed_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptainsBed/SubmarineCaptainsBed_Sprite_01.xml'));
				game.TrackAssets('submarineCaptainsBed_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineCaptainsBed","SubmarineCaptainsBedObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
	
			bg = new Image(this.assets.getTexture('submarineCaptainsBed_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			coin = new Image(this.assets.getTexture('coin'));
			coin.smoothing = TextureSmoothing.NONE;

			coin.touchable = true;
			coin.x = 460;
			coin.y = 305;
			
			wire_cutters = new Image(this.assets.getTexture('cutters'));
			wire_cutters.smoothing = TextureSmoothing.NONE;

			wire_cutters.touchable = true;
			wire_cutters.x = 481;
			wire_cutters.y = 80;
			
			pillow = new Image(this.assets.getTexture('pillow'));
			pillow.smoothing = TextureSmoothing.NONE;

			pillow.touchable = true;
			pillow.x = 62;
			pillow.y = 226;		
			
			lid = new Image(this.assets.getTexture('lid'));
			lid.smoothing = TextureSmoothing.NONE;

			lid.touchable = true;
			lid.x = 245;
			lid.y = 1;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
				trace("GIMMA 1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Pillow'] == 'Off'){
					trace("GIMMA 2");
					PillowOff = true;
					pillow.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Coin'] == 'PickedUp'){
						trace("GIMMA 3");
						coin.alpha = 0;
					}else{
						trace("GIMMA 4");
						coin.alpha = 1;
					}
					CreateHitCoin();
				}else{
					trace("GIMMA 5");
					pillow.alpha = 1;
					coin.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Lid'] == 'Off'){
					trace("GIMMA 6");
					LidOpen = true
					lid.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['WireCutters'] == 'PickedUp'){
						trace("GIMMA 7");
						wire_cutters.alpha = 0;
					}else{
						trace("GIMMA 8");
						wire_cutters.alpha = 1;
					}
					CreateHitWireCutters();
				}else{
					trace("GIMMA 9");
					lid.alpha = 1;
					wire_cutters.alpha = 0;
				}
				
			}else{
				trace("GIMMA 10");
				coin.alpha = 0;
				wire_cutters.alpha = 0;
				pillow.alpha = 1;
				lid.alpha = 1;
			}

			this.addChildAt(coin,1);
			this.addChildAt(wire_cutters,2);			
			this.addChildAt(pillow,3);			
			this.addChildAt(lid,4);
			
		//	CreateHitCoin();
		//	CreateHitWiteCutters();
			CreateLampHit();
			CreateFanHit();
			CreateMigHit();
			CreatePhotosHit();
			CreateHitAkuza();
			CreateHitHat();
			CreateBedHit();
			
			CreatePillowHit(PillowOff);
			CreateLidHit(LidOpen);
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
	//hit_lamp
		
		private function CreateLampHit():void{
			hit_lamp = new Shape();
			hit_lamp.touchable = false;
			hit_lamp.graphics.beginFill(0x00ff00);
			
			hit_lamp.graphics.lineTo(261,124);	
			hit_lamp.graphics.lineTo(411,154);	
			hit_lamp.graphics.lineTo(391,245);	
			hit_lamp.graphics.lineTo(264,192);	
			
			
			hit_lamp.graphics.endFill(false);
			hit_lamp.alpha = 0.0;
			hit_lamp.graphics.precisionHitTest = true;	
			this.addChild(hit_lamp);
			
		}
		
		private function CreateFanHit():void{
			hit_fan = new Shape();
			hit_fan.touchable = false;
			hit_fan.graphics.beginFill(0x00ff00);
			
			hit_fan.graphics.lineTo(530,46);	
			hit_fan.graphics.lineTo(668,58);	
			hit_fan.graphics.lineTo(636,192);	
			hit_fan.graphics.lineTo(508,154);	
			
			
			hit_fan.graphics.endFill(false);
			hit_fan.alpha = 0.0;
			hit_fan.graphics.precisionHitTest = true;	
			this.addChild(hit_fan);
			
		}
		
		private function CreateBedHit():void{
			hit_bed = new Shape();
			hit_bed.touchable = false;
			hit_bed.graphics.beginFill(0x00ff00);
			
			hit_bed.graphics.lineTo(107,448);	
			hit_bed.graphics.lineTo(298,368);	
			hit_bed.graphics.lineTo(595,463);	
			hit_bed.graphics.lineTo(586,505);	
			hit_bed.graphics.lineTo(98,506);	
		
			hit_bed.graphics.endFill(false);
			hit_bed.alpha = 0.0;
			hit_bed.graphics.precisionHitTest = true;	
			this.addChild(hit_bed);
			
		}
		
		private function CreateMigHit():void{
			hit_mig = new Shape();
			hit_mig.touchable = false;
			hit_mig.graphics.beginFill(0x00ff00);
			
			hit_mig.graphics.lineTo(79,0);	
			hit_mig.graphics.lineTo(301,0);	
			hit_mig.graphics.lineTo(315,43);	
			hit_mig.graphics.lineTo(291,113);	
			hit_mig.graphics.lineTo(70,103);	
		
			hit_mig.graphics.endFill(false);
			hit_mig.alpha = 0.0;
			hit_mig.graphics.precisionHitTest = true;	
			this.addChild(hit_mig);
			
		}
		
		private function CreatePhotosHit():void{
			hit_photos = new Shape();
			hit_photos.touchable = false;
			hit_photos.graphics.beginFill(0x00ff00);
			
			hit_photos.graphics.lineTo(223,242);	
			hit_photos.graphics.lineTo(304,227);	
			hit_photos.graphics.lineTo(352,236);	
			hit_photos.graphics.lineTo(351,286);	
			hit_photos.graphics.lineTo(318,320);	
			hit_photos.graphics.lineTo(241,335);	
			
			hit_photos.graphics.endFill(false);
			hit_photos.alpha = 0.0;
			hit_photos.graphics.precisionHitTest = true;	
			this.addChild(hit_photos);
			
		}
		
		private function CreateHitHat():void{
			hit_hat = new Shape();
			hit_hat.touchable = false;
			hit_hat.graphics.beginFill(0x00ff00);
			
			hit_hat.graphics.lineTo(80,314);	
			hit_hat.graphics.lineTo(143,273);	
			hit_hat.graphics.lineTo(228,336);	
			hit_hat.graphics.lineTo(182,389);	
			hit_hat.graphics.lineTo(112,390);	
			
			hit_hat.graphics.endFill(false);
			hit_hat.alpha = 0.0;
			hit_hat.graphics.precisionHitTest = true;	
			this.addChild(hit_hat);
			
		}
		private function CreateHitAkuza():void{
			hit_akuza = new Shape();
			hit_akuza.touchable = false;
			hit_akuza.graphics.beginFill(0x00ff00);
			
			hit_akuza.graphics.lineTo(71,145);	
			hit_akuza.graphics.lineTo(258,147);	
			hit_akuza.graphics.lineTo(258,216);	
			hit_akuza.graphics.lineTo(69,247);	
		
			hit_akuza.graphics.endFill(false);
			hit_akuza.alpha = 0.0;
			hit_akuza.graphics.precisionHitTest = true;	
			this.addChild(hit_akuza);
			
		}
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			hit_lid.touchable = false;
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(457,21);	
				hit_lid.graphics.lineTo(663,33);	
				hit_lid.graphics.lineTo(687,96);	
				hit_lid.graphics.lineTo(663,221);	
				hit_lid.graphics.lineTo(438,188);	
				
				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(367,0);
				hit_lid.graphics.lineTo(384,0);
				hit_lid.graphics.lineTo(474,32);
				hit_lid.graphics.lineTo(455,189);
				hit_lid.graphics.lineTo(365,213);
				hit_lid.graphics.lineTo(341,209);

				
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			
			this.addChild(hit_lid);
			
		}	
		
		
		private function CreatePillowHit(open:Boolean = false):void{
			hit_pillow = new Shape();
			hit_pillow.touchable = false;
			if(open === false){
				
				hit_pillow.x = 0;
				hit_pillow.y = 0;
				hit_pillow.graphics.beginFill(0x0000FF);
				
				hit_pillow.graphics.lineTo(290,360);	
				hit_pillow.graphics.lineTo(413,236);	
				hit_pillow.graphics.lineTo(676,294);	
				hit_pillow.graphics.lineTo(605,458);	

				hit_pillow.graphics.endFill(false);
				
				hit_pillow.alpha = 0.0;
				
				hit_pillow.graphics.precisionHitTest = true;	
			}else{
				
				hit_pillow.x = 0;
				hit_pillow.y = 0;
				hit_pillow.graphics.beginFill(0x0000FF);		
				hit_pillow.graphics.lineTo(106,255);
				hit_pillow.graphics.lineTo(320,221);
				hit_pillow.graphics.lineTo(391,379);
				hit_pillow.graphics.lineTo(183,464);

				hit_pillow.graphics.endFill(false);
				hit_pillow.alpha = 0.0;
				
				hit_pillow.graphics.precisionHitTest = true;				
			}
			
			this.addChild(hit_pillow);
			
		}	
		
		
		
		private function CreateHitWireCutters():void{
			hit_wirecutters = new Shape();
			hit_wirecutters.touchable = false;
			hit_wirecutters.graphics.beginFill(0x00ff00);
			
			hit_wirecutters.graphics.lineTo(480,65);	
			hit_wirecutters.graphics.lineTo(524,73);	
			hit_wirecutters.graphics.lineTo(565,184);	
			hit_wirecutters.graphics.lineTo(497,205);	
			hit_wirecutters.graphics.lineTo(469,123);	

			hit_wirecutters.graphics.endFill(false);
			hit_wirecutters.alpha = 0.0;
			hit_wirecutters.graphics.precisionHitTest = true;	
			this.addChild(hit_wirecutters);
			
		}
		
		private function CreateHitCoin():void{
			hit_coin = new Shape();
			hit_coin.touchable = false;
			hit_coin.graphics.beginFill(0x00ff00);
			
			hit_coin.graphics.lineTo(469,282);	
			hit_coin.graphics.lineTo(585,314);	
			hit_coin.graphics.lineTo(564,399);	
			hit_coin.graphics.lineTo(496,392);	
			hit_coin.graphics.lineTo(446,368);	
		
			hit_coin.graphics.endFill(false);
			hit_coin.alpha = 0.0;
			hit_coin.graphics.precisionHitTest = true;	
			this.addChild(hit_coin);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((SubmarineCaptains as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsObj,true
						);
					}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LidHandler();
					}else if(hit_pillow.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						PillowHandler();
					}else if(hit_mig.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A model jet fighter and various other personal affects.");						

					}else if(hit_akuza.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A small inscription reads 'Akula-Class Submarine'.");						

					}else if(hit_bed.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The bedsheets are made from a fibrous synthetic material.");	
					}else if(PillowOff === true){
						if(hit_coin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CoinHandler();
						}else if(LidOpen === true){
							if(hit_wirecutters.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								WireCuttersHandler();
							}else if(hit_fan.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("One of the submarine's ventilation fans.");	
								
							}
						}else if(hit_lamp.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A small reading lamp.");	

						}
					}else{
						if(hit_photos.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Photos of an older couple and a young lady in a bridal dress.");	
						}
						else if(hit_hat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A captain's hat.");	
						}else if(LidOpen === true){
							if(hit_wirecutters.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								WireCuttersHandler();
							}else if(hit_fan.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("One of the submarine's ventilation fans.");	
								
							}
						}else if(hit_lamp.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A small reading lamp.");	
							
						
							
						}

					}
						
						/*
						private var hit_mig:Shape;
						private var hit_akuza:Shape;
						private var hit_photos:Shape;
						private var hit_hat:Shape;
						private var hit_bed:Shape;
						private var hit_fan:Shape;
						*/	
						
					
					
				}
			}
		}
		private function CoinHandler():void{	
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Coin'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
					coin.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
					}
					SaveArray['Coin'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinPhoenix,
						'item_CoinPhoenix',
						'inven_coinPhoenix_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				coin.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
				}
				SaveArray['Coin'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinPhoenix,
					'item_CoinPhoenix',
					'inven_coinPhoenix_sm'
				);	
			}
		}
		
		private function WireCuttersHandler():void{	
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['WireCutters'] == 'PickedUp'){
					if(hit_fan.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("One of the submarine's ventilation fans.");	
						
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					wire_cutters.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
					}
					SaveArray['WireCutters'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_WireCutters,
						'item_WireCutters',
						'inven_wireCutters_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				wire_cutters.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
				}
				SaveArray['WireCutters'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_WireCutters,
					'item_WireCutters',
					'inven_wireCutters_sm'
				);	
			}
		}
		
		
		
		private function LidHandler():void{
			if(LidOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeOpen();
				LidOpen = true;
				lid.alpha = 0;
				hit_lid.graphics.clear();
				CreateLidHit(true);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['WireCutters'] == 'PickedUp'){
						wire_cutters.alpha = 0;
					}else{
						wire_cutters.alpha = 1;
					}
				}else{
					wire_cutters.alpha = 1;
				}
				SaveArray['Lid'] = 'Off';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
				
				CreateHitWireCutters();
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeClose();
				LidOpen = false;
				lid.alpha = 1;
				hit_lid.graphics.clear();
				CreateLidHit(false);
				this.removeChild(hit_wirecutters);
				wire_cutters.alpha = 0;
	
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
				}

				SaveArray['Lid'] = 'On';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
			}
		}
		
		private function PillowHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			if(PillowOff === false){
				PillowOff = true;
				pillow.alpha = 0;
				hit_pillow.graphics.clear();
				CreatePillowHit(true);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Coin'] == 'PickedUp'){
						coin.alpha = 0;
					}else{
						coin.alpha = 1;
					}
				}else{
					coin.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
				}
				SaveArray['Pillow'] = 'Off';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
				
				CreateHitCoin();
			}else{
				PillowOff = false;
				pillow.alpha = 1;
				hit_pillow.graphics.clear();
				CreatePillowHit(false);
				this.removeChild(hit_coin);
				coin.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed;
				}
				SaveArray['Pillow'] = 'On';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptainsBed',SaveArray);
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
			
			
			this.assets.removeTexture("submarineCaptainsBed_bg",true);
			this.assets.removeTexture("SubmarineCaptainsBed_Sprite_01",true);
			this.assets.removeTextureAtlas("SubmarineCaptainsBed_Sprite_01",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsBed_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsBed_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptainsBed_03");
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