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
	import starling.utils.AssetManager;
	import starling.textures.TextureSmoothing;	
	
	public class CaveCorridor extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var marcasite:Image;
		private var torch:Image;
		private var fire_mc:MovieClip;
		
		private var hit_marcasite:Shape;
		private var hit_tunnel:Shape;
		private var hit_flame:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CaveCorridor(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('caveCorridor_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CaveCorridor/caveCorridor_bg.jpg'));
				game.TrackAssets('caveCorridor_01');
			}
			if(game.CheckAsset('caveCorridor_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CaveCorridor/caveCorridor_Sprite.atf'));
				game.TrackAssets('caveCorridor_02');
			}
			if(game.CheckAsset('caveCorridor_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CaveCorridor/caveCorridor_Sprite.xml'));
				game.TrackAssets('caveCorridor_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CaveCorridor","CaveCorridorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('caveCorridor_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			marcasite = new Image(this.assets.getTexture('marcasite'));
			marcasite.smoothing = TextureSmoothing.NONE;
			marcasite.touchable = false;
			marcasite.x = 133;
			marcasite.y = 268;
		
			
			
			torch = new Image(this.assets.getTexture('torch'));
			torch.smoothing = TextureSmoothing.NONE;
			torch.touchable = false;
			torch.x = 284;
			torch.y = 0;
			
			
			
			fire_mc = new MovieClip(this.assets.getTextures('fire_'),6);
			fire_mc.smoothing = TextureSmoothing.NONE;
			//puller_mc.smoothing = TextureSmoothing.NONE;
			fire_mc.x = 468;
			fire_mc.y = 80;
			fire_mc.touchable = false;
			fire_mc.loop = true; // default: true
			//	fire_mc.stop();
			
		//if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
		//		if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
			//Starling.juggler.add(fire_mc);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Marcasite"] == "PickedUp"){
					marcasite.alpha = 0;
				}else{
					marcasite.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
					torch.alpha = 1;
					fire_mc.alpha = 1;
					fire_mc.play();
					Starling.juggler.add(fire_mc);
				}else{
					torch.alpha = 0;
					fire_mc.alpha = 0;
				}
			}else{
				marcasite.alpha = 1;
				torch.alpha = 0;
				fire_mc.alpha = 0;
			}
		
			
			
			this.addChildAt(marcasite,1);
			this.addChildAt(torch,2);
			this.addChildAt(fire_mc,3);
			
			CreateMarcasiteHit();
			CreateTunnelHit();
			CreateFlameHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_02",0,0.5,'stop');
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
					(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
					},1.5);
					
				 
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDripsStream(true,999);
			}
		}
		
		private function CreateMarcasiteHit():void{
			hit_marcasite = new Shape();
			hit_marcasite.touchable = false;
			hit_marcasite.graphics.beginFill(0xff0000);
			
			hit_marcasite.graphics.lineTo(120,314);	
			hit_marcasite.graphics.lineTo(153,243);	
			hit_marcasite.graphics.lineTo(244,263);	
			hit_marcasite.graphics.lineTo(253,253);	
			hit_marcasite.graphics.lineTo(228,373);	
			hit_marcasite.graphics.lineTo(131,362);	

			hit_marcasite.graphics.endFill(false);
			
			hit_marcasite.alpha = 0.0;
			
			hit_marcasite.graphics.precisionHitTest = true;	
			this.addChild(hit_marcasite);
		}
		//hit_flame
		private function CreateFlameHit():void{
			hit_flame = new Shape();
			hit_flame.touchable = false;
			hit_flame.graphics.beginFill(0x00ff00);
			
			hit_flame.graphics.lineTo(446,106);	
			hit_flame.graphics.lineTo(477,74);	
			hit_flame.graphics.lineTo(530,82);	
			hit_flame.graphics.lineTo(553,158);	
			hit_flame.graphics.lineTo(528,188);	
			hit_flame.graphics.lineTo(478,177);	

			hit_flame.graphics.endFill(false);
			
			hit_flame.alpha = 0.0;
			
			hit_flame.graphics.precisionHitTest = true;	
			this.addChild(hit_flame);
		}
		private function CreateTunnelHit():void{
			hit_tunnel = new Shape();
			hit_tunnel.touchable = false;
			hit_tunnel.graphics.beginFill(0xff0000);
			
			hit_tunnel.graphics.lineTo(327,145);	
			hit_tunnel.graphics.lineTo(392,18);	
			hit_tunnel.graphics.lineTo(530,12);	
			hit_tunnel.graphics.lineTo(580,112);	
			hit_tunnel.graphics.lineTo(607,237);	
			hit_tunnel.graphics.lineTo(565,309);	
			hit_tunnel.graphics.lineTo(493,362);	
			hit_tunnel.graphics.lineTo(415,359);	
			hit_tunnel.graphics.lineTo(345,295);	
			hit_tunnel.graphics.lineTo(328,216);	

			hit_tunnel.graphics.endFill(false);
			
			hit_tunnel.alpha = 0.0;
			
			hit_tunnel.graphics.precisionHitTest = true;	
			this.addChild(hit_tunnel);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Cave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CaveObj,true
						);
					}else if(hit_flame.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
						FlameHandler();
					}else if(hit_marcasite.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						MarcasiteHandler();
					}else if(hit_tunnel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						TunnelHandler();
					}
				}
			}
		}
		
		private function FlameHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_CannonTorch)
				
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
				trace("Cannon Torch is Armed");
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CannonTorchBurning,
					'item_CannonTorchBurning',
					'inven_cannonTorchBurning_sm',
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CannonTorch,
					'item_CannonTorch'
				);
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor;			
				}
				SaveArray['CannonTorch'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveCorridor',SaveArray);
				
				
			}else{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The torch is burning steadily. It illuminates deep into the tunnel.");
					}else{
						TunnelHandler();
					}
				}else{
					TunnelHandler();
				}
				
			}
		}
		
		private function TunnelHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Torch"] == "Attached"){
					FadeOut((CavePirate as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateObj,true
					);
				}else{
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_TorchBurning)
						
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
						(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_TorchBurning,
								"item_TorchBurning"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor;			
						}
						SaveArray['Torch'] = 'Attached';
						torch.alpha = 1;
						fire_mc.alpha = 1;
						fire_mc.play();
						Starling.juggler.add(fire_mc);
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveCorridor',SaveArray);
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I cannot see anything. It would be dangerous to go forward without light: the tunnel is too dark and wet.");
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
					.item_TorchBurning)
					
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
					(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_TorchBurning,
							"item_TorchBurning"
						);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor;			
					}
					SaveArray['Torch'] = 'Attached';
					torch.alpha = 1;
					fire_mc.alpha = 1;
					fire_mc.play();
					Starling.juggler.add(fire_mc);
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveCorridor',SaveArray);
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's pitch black and too dangerous to try to enter without some sort of light.");
				}
			}
			
		}
		
		private function MarcasiteHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor["Marcasite"] == "PickedUp"){
					
				}else{
					marcasite.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveCorridor;
					SaveArray['Marcasite'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveCorridor',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Marcasite,
						'item_Marcasite',
						'inven_marcasite_sm'
					);
					
					
				}
			}else{
				marcasite.alpha = 0;
				SaveArray['Marcasite'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveCorridor',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Marcasite,
					'item_Marcasite',
					'inven_marcasite_sm'
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
			
			
			this.assets.removeTexture("caveCorridor_bg",true);
			this.assets.removeTexture("caveCorridor_Sprite",true);
			this.assets.removeTextureAtlas("caveCorridor_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("caveCorridor_01");
			(stage.getChildAt(0) as Object).falseAsset("caveCorridor_02");
			(stage.getChildAt(0) as Object).falseAsset("caveCorridor_03");
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