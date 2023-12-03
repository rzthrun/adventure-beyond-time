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
	
	
	public class CavePirateBarrels extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var apple:Image;
		private var lid_left_off:Image;
		private var lid_left:Image;
		private var lid_right_off:Image;
		private var lid_right:Image;
		
		private var hit_left:Shape;
		private var hit_right:Shape;
		private var hit_apple:Shape;
		private var hit_leftOpen:Shape;
		
		private var LeftOpen:Boolean = false;
		private var RightOpen:Boolean = false;
		
		private var LeftUnlocked:Boolean = false;
		private var RightUnlocked:Boolean = false;
		
		private var Animating:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function CavePirateBarrels(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cavePirateBarrels_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateBarrels/cavePirateBarrels_bg.jpg'));
				game.TrackAssets('cavePirateBarrels_01');
			}
			if(game.CheckAsset('cavePirateBarrels_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateBarrels/CavePirateBarrels_Sprite.atf'));
				game.TrackAssets('cavePirateBarrels_02');
			}
			if(game.CheckAsset('cavePirateBarrels_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirateBarrels/CavePirateBarrels_Sprite.xml'));
				game.TrackAssets('cavePirateBarrels_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateBarrels","CavePirateBarrelsObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('cavePirateBarrels_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			apple = new Image(this.assets.getTexture('apple'));
			apple.smoothing = TextureSmoothing.NONE;
			apple.touchable = false;
			apple.x = 471;
			apple.y = 73;
		
			
			lid_left_off = new Image(this.assets.getTexture('lid_left_off'));
			lid_left_off.smoothing = TextureSmoothing.NONE;
			lid_left_off.touchable = false;
			lid_left_off.x = 250;
			lid_left_off.y = 279;

			lid_right_off = new Image(this.assets.getTexture('lid_right_off'));
			lid_right_off.smoothing = TextureSmoothing.NONE;
			lid_right_off.touchable = false;
			lid_right_off.x = 584;
			lid_right_off.y = 230;
			
			lid_left = new Image(this.assets.getTexture('lid_left'));
			lid_left.smoothing = TextureSmoothing.NONE;
			lid_left.touchable = false;
			lid_left.x = 37;
			lid_left.y = 125;
						
			lid_right = new Image(this.assets.getTexture('lid_right'));
			lid_right.smoothing = TextureSmoothing.NONE;
			lid_right.touchable = false;
			lid_right.x = 392;
			lid_right.y = 6;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['RightUnlocked'] == 'Yes'){
					RightUnlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Right'] == 'Open'){
						RightOpen = true;
						lid_right.alpha = 0;
						lid_right_off.alpha = 1;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Apple'] == 'PickedUp'){
							apple.alpha = 0;
						}else{
							apple.alpha = 1;
						}
						CreateAppleHit();
					}else{
						lid_right.alpha = 1;
						apple.alpha = 0;
						lid_right_off.alpha = 0;
					}
				}else{
					lid_right.alpha = 1;
					apple.alpha = 0;
					lid_right_off.alpha = 0;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['LeftUnlocked'] == 'Yes'){
					LeftUnlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Left'] == 'Open'){
						LeftOpen = true;
						lid_left.alpha = 0;
						lid_left_off.alpha = 1;
						
						CreateLeftOpenHit();
					}else{
						lid_left.alpha = 1;
						lid_left_off.alpha = 0;
					}
				}else{
					lid_left.alpha = 1;
					lid_left_off.alpha = 0;
				}
				
			}else{
				
				apple.alpha = 0;
				lid_left_off.alpha = 0;
				lid_right_off.alpha = 0;
				lid_left.alpha = 1;
				lid_right.alpha = 1;
			}

			this.addChildAt(apple,1);
			this.addChildAt(lid_left_off,2);
			this.addChildAt(lid_right_off,3);
			this.addChildAt(lid_left,4);
			this.addChildAt(lid_right,5);
			

			CreateRightHit(RightOpen);
			CreateLeftHit(LeftOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
		}
		
		private function CreateLeftHit(open:Boolean = false):void{
			hit_left = new Shape();
			
			if(open === false){
				
				hit_left.x = 0;
				hit_left.y = 0;
				hit_left.graphics.beginFill(0x0000FF);
				
				hit_left.graphics.lineTo(25,232);	
				hit_left.graphics.lineTo(76,135);	
				hit_left.graphics.lineTo(211,108);	
				hit_left.graphics.lineTo(316,165);	
				hit_left.graphics.lineTo(336,252);	
				hit_left.graphics.lineTo(283,339);	
				hit_left.graphics.lineTo(146,376);	
				hit_left.graphics.lineTo(48,327);	

				hit_left.graphics.endFill(false);
				
				hit_left.alpha = 0.0;
				
				hit_left.graphics.precisionHitTest = true;	
			}else{
					
				hit_left.x = 0;
				hit_left.y = 0;
				hit_left.graphics.beginFill(0x0000FF);		
				hit_left.graphics.lineTo(246,446);
				hit_left.graphics.lineTo(290,362);
				hit_left.graphics.lineTo(426,338);
				hit_left.graphics.lineTo(488,393);
				hit_left.graphics.lineTo(460,474);
				hit_left.graphics.lineTo(373,508);
				hit_left.graphics.lineTo(288,505);

				hit_left.graphics.endFill(false);
				hit_left.alpha = 0.0;
				
				hit_left.graphics.precisionHitTest = true;				
			}
			hit_left.touchable = false;
			this.addChild(hit_left);
			
		}	
		
		private function CreateRightHit(open:Boolean = false):void{
			hit_right = new Shape();
			
			if(open === false){
				
				hit_right.x = 0;
				hit_right.y = 0;
				hit_right.graphics.beginFill(0x0000FF);
				
				hit_right.graphics.lineTo(374,117);	
				hit_right.graphics.lineTo(411,25);	
				hit_right.graphics.lineTo(503,0);	
				hit_right.graphics.lineTo(633,29);	
				hit_right.graphics.lineTo(693,107);	
				hit_right.graphics.lineTo(670,200);	
				hit_right.graphics.lineTo(558,250);	
				hit_right.graphics.lineTo(422,206);	

				
				hit_right.graphics.endFill(false);
				
				hit_right.alpha = 0.0;
				
				hit_right.graphics.precisionHitTest = true;	
			}else{
				
				hit_right.x = 0;
				hit_right.y = 0;
				hit_right.graphics.beginFill(0x0000FF);		
				hit_right.graphics.lineTo(631,360);
				hit_right.graphics.lineTo(660,270);
				hit_right.graphics.lineTo(723,238);
				hit_right.graphics.lineTo(769,291);
				hit_right.graphics.lineTo(763,384);
				hit_right.graphics.lineTo(676,465);
				hit_right.graphics.lineTo(637,412);
				
				hit_right.graphics.endFill(false);
				hit_right.alpha = 0.0;
				
				hit_right.graphics.precisionHitTest = true;				
			}
			hit_right.touchable = false;
			this.addChild(hit_right);
			
		}	
		
		private function CreateAppleHit():void{
			hit_apple = new Shape();
			hit_apple.touchable = false;
			hit_apple.graphics.beginFill(0xff0000);
			
			hit_apple.graphics.lineTo(420,104);	
			hit_apple.graphics.lineTo(501,48);	
			hit_apple.graphics.lineTo(633,94);	
			hit_apple.graphics.lineTo(650,167);	
			hit_apple.graphics.lineTo(561,215);	
			hit_apple.graphics.lineTo(449,182);	

			
			hit_apple.graphics.endFill(false);
			
			hit_apple.alpha = 0.0;
			
			hit_apple.graphics.precisionHitTest = true;	
			this.addChild(hit_apple);
		}
		
		private function CreateLeftOpenHit():void{
			hit_leftOpen = new Shape();
			hit_leftOpen.touchable = false;
			hit_leftOpen.graphics.beginFill(0xff0000);
			
			hit_leftOpen.graphics.lineTo(47,263);	
			hit_leftOpen.graphics.lineTo(104,163);	
			hit_leftOpen.graphics.lineTo(225,143);	
			hit_leftOpen.graphics.lineTo(303,209);	
			hit_leftOpen.graphics.lineTo(271,316);	
			hit_leftOpen.graphics.lineTo(160,350);	
			
			hit_leftOpen.graphics.endFill(false);
			
			hit_leftOpen.alpha = 0.0;
			
			hit_leftOpen.graphics.precisionHitTest = true;	
			this.addChild(hit_leftOpen);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CavePirateEnclave as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateEnclaveObj,true
							);
						}else if(hit_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(LeftUnlocked === true){
								LidLeftHandler();
							}else{
								Unlocker('LEFT');
							}
							
						}else if(hit_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(RightUnlocked === true){
								LidRightHandler();
							}else{
								Unlocker('RIGHT');
							}	
							
						}else if(RightOpen === true){
							if(hit_apple.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								AppleHandler();
							}
						}else if(LeftOpen === true){
							if(hit_leftOpen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Empty... except for sand.");
							}
						}
					}
				}

			}
		}
		
		private function Unlocker(Side:String):void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Hammer)
			{
				if(Side == 'RIGHT'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'm removing the nails that seal the barrel lid...");
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RemoveNail3x();
					Animating = true;
					
					RightUnlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
					}
					SaveArray["RightUnlocked"] = "Yes";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);

					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['LidUnlocked'] == 'Yes'){
							if(LeftUnlocked === true){
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
									.InventoryObj.removeItemFromInventory(
										(stage.getChildAt(0) as Object)
										.screenGamePlayHandler
										.InventoryObj.item_Hammer,
										"item_Hammer"
									);
							}
							
						}
					}
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						
						Animating = false;
						LidRightHandler();
					},3);
					
					
					
					/*
					 NOTE: INSERT SPAGGETTI TO REMOVE HAMMER HERE AFTER CHECK ON DIG SITE 
					*/
					
				}else if(Side == 'LEFT'){
					LeftUnlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
					}
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'm removing the nails that seal the barrel lid...");
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RemoveNail3x();
					Animating = true;
					
					SaveArray["LeftUnlocked"] = "Yes";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);
					
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['LidUnlocked'] == 'Yes'){
							if(RightUnlocked === true){
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
									.InventoryObj.removeItemFromInventory(
										(stage.getChildAt(0) as Object)
										.screenGamePlayHandler
										.InventoryObj.item_Hammer,
										"item_Hammer"
									);
							}
							
						}
					}
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						
						Animating = false;
						LidLeftHandler();
					},3);
					
				}
				
			}else{
				if(Side == 'RIGHT'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The barrel is sealed with nails. I'll have to remove them to open it.");
				}else if(Side == 'LEFT'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The barrel is nailed shut. I can't open it.");
				}
			}
		}
		
		private function AppleHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Apple'] == 'PickedUp'){
					
				}else{
					apple.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
					}
					SaveArray["Apple"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Apple,
						'item_Apple',
						'inven_apple_sm'
					);
				}
			}else{
				apple.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
				}
				SaveArray["Apple"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Apple,
					'item_Apple',
					'inven_apple_sm'
				);
			}
		}
		
		private function LidRightHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			if(RightOpen === false){
				RightOpen = true;
				lid_right.alpha = 0;
				lid_right_off.alpha = 1;
				
				hit_right.graphics.clear();
				CreateRightHit(true);
				CreateAppleHit();
				
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Apple'] == 'PickedUp'){
						apple.alpha = 0;
					}else{
						apple.alpha = 1;
					}
				}
				SaveArray["Right"] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);
				
			}else{
				RightOpen = false;
				lid_right.alpha = 1;
				lid_right_off.alpha = 0;
				hit_right.graphics.clear();
				this.removeChild(hit_apple);
				CreateRightHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
				}
				SaveArray["Right"] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);
			}
		}
		
		private function LidLeftHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			if(LeftOpen === false){
				LeftOpen = true;
				lid_left.alpha = 0;
				lid_left_off.alpha = 1;
				
				hit_left.graphics.clear();
				CreateLeftHit(true);
				CreateLeftOpenHit();
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
				}
				SaveArray["Left"] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);
				
			}else{
				LeftOpen = false;
				lid_left.alpha = 1;
				lid_left_off.alpha = 0;
				hit_left.graphics.clear();
				this.removeChild(hit_leftOpen);
				CreateLeftHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels;
				}
				SaveArray["Left"] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateBarrels',SaveArray);
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
			
			
			this.assets.removeTexture("cavePirateBarrels_bg",true);
			this.assets.removeTexture("CavePirateBarrels_Sprite",true);
			this.assets.removeTextureAtlas("CavePirateBarrels_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cavePirateBarrels_01");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateBarrels_02");
			(stage.getChildAt(0) as Object).falseAsset("cavePirateBarrels_03");
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