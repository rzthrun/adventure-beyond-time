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
	
	
	public class JungleVikingTrunk extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var handle:Image;
		private var lid:Image;
		
		private var hit_lid:Shape;
		private var hit_handle:Shape;
		
		private var hit_bear:Shape;
		private var hit_doll:Shape;
		
		private var Unlocked:Boolean = false;
		private var LidOpen:Boolean = false;
		
		private var BearPhraseCounter:int = 0;
		private var DollPhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;		
		
		
		public function JungleVikingTrunk(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleVikingTrunk_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTrunk/jungleVikingTrunk_bg.jpg'));
				game.TrackAssets('jungleVikingTrunk_01');
			}
			if(game.CheckAsset('jungleVikingTrunk_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTrunk/JungleVikingTrunk_Sprite.atf'));
				game.TrackAssets('jungleVikingTrunk_02');
			}
			if(game.CheckAsset('jungleVikingTrunk_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTrunk/JungleVikingTrunk_Sprite.xml'));
				game.TrackAssets('jungleVikingTrunk_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleVikingTrunk","JungleVikingTrunkObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleVikingTrunk_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			handle = new Image(this.assets.getTexture('handle'));
			handle.smoothing = TextureSmoothing.NONE;
			handle.touchable = false;
			handle.x = 300;
			handle.y = 189;
			
			
			lid = new Image(this.assets.getTexture('t_lid'));
			lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 1;
			lid.y = 1;
			
			//FadeOutOcean(1);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk['Unlocked'] == 'Yes'){
					Unlocked = true
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk['Lid'] == 'open'){
					LidOpen = true;
					lid.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk['Handle'] == 'PickedUp'){
						handle.alpha = 0;
					}else{
						handle.alpha = 1;
					}
					CreateHitHandle();
				}else{
				
					handle.alpha = 0;
					lid.alpha = 1;
				}
			}else{
				handle.alpha = 0;		
				lid.alpha = 1;
			}
			
			
			this.addChildAt(handle,1);
			this.addChildAt(lid,2);
					
					
					
			CreateHitBear();	
			CreateHitDoll();
			CreateidHit(LidOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			//(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("BirdsOne",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
		}
		private function CreateHitDoll():void{
			hit_doll = new Shape();
			hit_doll.touchable = false;
			hit_doll.graphics.beginFill(0xff0000);
			
			hit_doll.graphics.lineTo(490,241);				
			hit_doll.graphics.lineTo(585,144);				
			hit_doll.graphics.lineTo(636,181);				
			hit_doll.graphics.lineTo(590,320);				
			hit_doll.graphics.lineTo(493,320);				
							
			hit_doll.graphics.endFill(false);
			hit_doll.alpha = 0.0;
			
			hit_doll.graphics.precisionHitTest = true;	
			this.addChild(hit_doll);
		}
		
		private function CreateHitBear():void{
			hit_bear = new Shape();
			hit_bear.touchable = false;
			hit_bear.graphics.beginFill(0xff0000);
			
			hit_bear.graphics.lineTo(150,114);				
			hit_bear.graphics.lineTo(290,110);				
			hit_bear.graphics.lineTo(355,325);				
			hit_bear.graphics.lineTo(168,320);				
	
			hit_bear.graphics.endFill(false);
			hit_bear.alpha = 0.0;
			
			hit_bear.graphics.precisionHitTest = true;	
			this.addChild(hit_bear);
		}
		
		private function CreateHitHandle():void{
			hit_handle = new Shape();
			hit_handle.touchable = false;
			hit_handle.graphics.beginFill(0xff0000);
			
			hit_handle.graphics.lineTo(291,186);				
			hit_handle.graphics.lineTo(316,160);				
			hit_handle.graphics.lineTo(509,268);				
			hit_handle.graphics.lineTo(496,317);				
			hit_handle.graphics.lineTo(470,318);				
			hit_handle.graphics.lineTo(314,237);				
			hit_handle.graphics.lineTo(296,209);				

			hit_handle.graphics.endFill(false);
			hit_handle.alpha = 0.0;
			
			hit_handle.graphics.precisionHitTest = true;	
			this.addChild(hit_handle);
		}
		
		
		private function CreateidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(116,105);	
				hit_lid.graphics.lineTo(689,106);	
				hit_lid.graphics.lineTo(753,291);	
				hit_lid.graphics.lineTo(726,344);	
				hit_lid.graphics.lineTo(437,396);	
				hit_lid.graphics.lineTo(366,395);	
				hit_lid.graphics.lineTo(70,346);	
				hit_lid.graphics.lineTo(43,289);	
				

				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		

				hit_lid.graphics.lineTo(119,0);	
				hit_lid.graphics.lineTo(685,0);	
				hit_lid.graphics.lineTo(661,112);	
				hit_lid.graphics.lineTo(146,108);	

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
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((JungleVikingDeck as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingDeckObj,true
							);
						}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(Unlocked === false){
								Unlocker();
							}else{
								LidHandler();
							}
							
						}else if(LidOpen === true){
							if(hit_handle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								HandleHandler();
							}else if(hit_bear.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(BearPhraseCounter == 0){
									BearPhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A... teddy bear?");
								}else if(BearPhraseCounter == 1){
									BearPhraseCounter = 2;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Where did Vikings get a teddy bear?");
								}else if(BearPhraseCounter == 2){
									BearPhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I guess we all have a soft spot.");
								}
							}else if(hit_doll.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(DollPhraseCounter == 0){
									DollPhraseCounter = 1;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A doll?");
								}else if(DollPhraseCounter == 1){
									DollPhraseCounter = 2;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This doll is from the modern era...");

								}else if(DollPhraseCounter == 2){
									DollPhraseCounter = 0;
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The Vikings must have found... or plundered... the doll.");

								}
							}
							
							/*
							private var hit_bear:Shape;
							private var hit_doll:Shape;
							*/
						}
					}
				}
			}
		}
		
		private function Unlocker():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_PirateKey)
			{
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Unlock();
				Unlocked = true;
				LidOpen = true;
				
				hit_lid.graphics.clear();
				CreateidHit(true);
				CreateHitHandle();
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_PirateKey,
						"item_PirateKey"
					);
					
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk;
				}
				SaveArray['Unlocked'] = "Yes";
				SaveArray['Lid'] = "open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTrunk',SaveArray);
				Animating = true;
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ChestOpen();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
					Animating = false;
					lid.alpha = 0;
					handle.alpha = 1;
				},1);
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_SlenderKey)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The key doesn't fit the lock on the trunk.");
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();	
			}else{
					
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();	
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The trunk is locked.");
			}
		}
		
		private function HandleHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk['Handle'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					
					handle.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk;
					}
					SaveArray["Handle"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTrunk',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_ArmSun,
						'item_ArmSun',
						'inven_armSun_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				handle.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk;
				}
				SaveArray["Handle"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTrunk',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_ArmSun,
					'item_ArmSun',
					'inven_armSun_sm'
				);
			}
		}
		
		private function LidHandler():void{
			if(LidOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
				LidOpen = true;
				lid.alpha = 0;
				hit_lid.graphics.clear();
				CreateidHit(true);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk['Handle'] == 'PickedUp'){
						handle.alpha = 0;
					}else{
						handle.alpha = 1;
					}
					
				}else{
					handle.alpha = 1;
				}
				
				CreateHitHandle();
				
				SaveArray['Lid'] = "open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTrunk',SaveArray);

				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
				LidOpen = false;
				lid.alpha = 1;
				hit_lid.graphics.clear();
				CreateidHit(false);
				handle.alpha = 0;
				
				this.removeChild(hit_handle);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTrunk;
					
				}
				SaveArray['Lid'] = "closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTrunk',SaveArray);
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
			
			
			this.assets.removeTexture("jungleVikingTrunk_bg",true);
			//	this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTrunk_01");
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