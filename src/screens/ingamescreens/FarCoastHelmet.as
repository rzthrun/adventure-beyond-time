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
	
	
	public class FarCoastHelmet extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var key:Image;
		private var lid:Image;
		private var key_closed:Image;
		
		private var hit_lid:Shape;
		private var hit_key:Shape;
		
		private var hit_helmut:Shape;
		
		private var LidOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function FarCoastHelmet(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('farCoastHelmet_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastHelmet/farCoastHelmet_bg.jpg'));
				game.TrackAssets('farCoastHelmet_01');
			}
			if(game.CheckAsset('farCoastHelmet_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastHelmet/FarCoastHelmet_Sprite.atf'));
				game.TrackAssets('farCoastHelmet_02');
			}
			if(game.CheckAsset('farCoastHelmet_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastHelmet/FarCoastHelmet_Sprite.xml'));
				game.TrackAssets('farCoastHelmet_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FarCoastHelmet","FarCoastHelmetObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('farCoastHelmet_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			/*
			private var hit_key:Image;
			private var hit_lid	:Image;
			private var hit_key_closed:Image;
			*/
			key = new Image(this.assets.getTexture('key_open'));
			key.smoothing = TextureSmoothing.NONE;
			key.touchable = false;
			key.x = 237;
			key.y = 177;
			
			lid = new Image(this.assets.getTexture('d_lid'));
			lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 1;
			lid.y = 1;

			key_closed = new Image(this.assets.getTexture('key_close'));
			key_closed.smoothing = TextureSmoothing.NONE;
			key_closed.touchable = false;
			key_closed.x = 237;
			key_closed.y = 177;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
				trace(":::1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Lid'] == 'Open'){
					trace(":::2");
					lid.alpha = 0;
					key_closed.alpha = 0;
					LidOpen = true;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Key'] == 'PickedUp'){
						key.alpha = 0;
					
					}else{
						key.alpha = 1;
					
					}	
				}else{
					trace(":::3");
					lid.alpha = 1;
					LidOpen = false;
					key.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Key'] == 'PickedUp'){
						key_closed.alpha = 0;
					}else{
						key_closed.alpha = 1;
					}	
				}
			}else{
				trace(":::4");
				key.alpha = 0;
				lid.alpha = 1;
				key_closed.alpha = 1;
			}
			
		
	
			this.addChildAt(key,1);
			this.addChildAt(lid,2);
			this.addChildAt(key_closed,3);
			
			CreateHitHelmut();
			CreateLidHit(LidOpen);
			CreateHitKey();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
		
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
		}
		
		//hit_helmut
		private function CreateHitHelmut():void{
			hit_helmut = new Shape();
			hit_helmut.touchable = false;
			hit_helmut.graphics.beginFill(0xff0000);
			
			hit_helmut.graphics.lineTo(16,256);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(48,109);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(142,0);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(624,0);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(705,194);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(654,395);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(525,507);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(232,505);																																																																																																																																																																																																																																																									
			hit_helmut.graphics.lineTo(95,423);																																																																																																																																																																																																																																																									
		
			hit_helmut.graphics.endFill(false);
			hit_helmut.alpha = 0.0;
			
			hit_helmut.graphics.precisionHitTest = true;	
			this.addChild(hit_helmut);
		}
		
		private function CreateHitKey():void{
			hit_key = new Shape();
			hit_key.touchable = false;
			hit_key.graphics.beginFill(0xff0000);
			
			hit_key.graphics.lineTo(235,272);																																																																																																																																																																																																																																																									
			hit_key.graphics.lineTo(251,251);																																																																																																																																																																																																																																																									
			hit_key.graphics.lineTo(477,165);																																																																																																																																																																																																																																																									
			hit_key.graphics.lineTo(525,192);																																																																																																																																																																																																																																																									
			hit_key.graphics.lineTo(525,248);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																			
			hit_key.graphics.lineTo(300,385);		
			hit_key.graphics.lineTo(243,330);
			
			hit_key.graphics.endFill(false);
			hit_key.alpha = 0.0;
			
			hit_key.graphics.precisionHitTest = true;	
			this.addChild(hit_key);
		}
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				hit_lid.graphics.lineTo(146,254);
				hit_lid.graphics.lineTo(182,116);
				hit_lid.graphics.lineTo(272,42);
				hit_lid.graphics.lineTo(381,21);
				hit_lid.graphics.lineTo(495,60);
				hit_lid.graphics.lineTo(568,138);
				hit_lid.graphics.lineTo(591,268);
				hit_lid.graphics.lineTo(538,394);
				hit_lid.graphics.lineTo(405,462);
				hit_lid.graphics.lineTo(253,429);
				hit_lid.graphics.lineTo(172,334);

				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
			
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(0,84);
				hit_lid.graphics.lineTo(69,124);
				hit_lid.graphics.lineTo(127,175);
				hit_lid.graphics.lineTo(175,273);
				hit_lid.graphics.lineTo(188,357);
				hit_lid.graphics.lineTo(177,430);
				hit_lid.graphics.lineTo(147,512);
				hit_lid.graphics.lineTo(0,512);

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
						FadeOut((FarCoastDingy as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastDingyObj,true
						);
					}if(LidOpen === true){
						if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							lid.alpha = 1;
							key.alpha = 0;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxClose();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Key'] == 'PickedUp'){
									key_closed.alpha = 0;
								}else{
									key_closed.alpha = 1;
								}
							}else{
								key_closed.alpha = 1;
							}
							hit_lid.graphics.clear();
							CreateLidHit(false);
							LidOpen = false;
							
							SaveArray['Lid'] = "Closed";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastHelmet',SaveArray);
						}else if(hit_key.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							KeyHandler();
						}else if(hit_helmut.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal has been corroded by the salt water.");
						}
							
							//hit_helmut
					}else{
						if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxOpen();
							lid.alpha = 0;
							key_closed.alpha = 0;
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Key'] == 'PickedUp'){
									key.alpha = 0;
								}else{
									key.alpha = 1;
								}
							}else{
								key.alpha = 1;
							}
							hit_lid.graphics.clear();
							CreateLidHit(true);
							LidOpen = true;
							
							SaveArray['Lid'] = "Open";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastHelmet',SaveArray);
						}else if(hit_helmut.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The helmet was made from copper.. or bronze... or some alloy of the two.");

						}
				
					}
	
				}
			}
		}
		private function KeyHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Key'] == 'PickedUp'){
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Diving suits like this were used during the first attempts to explore under the seas.');
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					key.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet;
					}
					SaveArray['Key'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastHelmet',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateKey,
						'item_PirateKey',
						'inven_pirateKey_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				key.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet;
				}
				SaveArray['Key'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastHelmet',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateKey,
					'item_PirateKey',
					'inven_pirateKey_sm'
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
			
			
			this.assets.removeTexture("farCoastHelmet_bg",true);
			this.assets.removeTexture("FarCoastHelmet_Sprite",true);
			this.assets.removeTextureAtlas("FarCoastHelmet_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("farCoastHelmet_01");
			(stage.getChildAt(0) as Object).falseAsset("farCoastHelmet_02");
			(stage.getChildAt(0) as Object).falseAsset("farCoastHelmet_03");
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