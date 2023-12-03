package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.textures.TextureSmoothing;
	
	public class CavePirateTopDeck extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		
		
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var cabinDoor:Image;
		private var cage:Image;
		private var cage_lid:Image;
		private var cannon_lid:Image;
		
		private var wheel_mc:MovieClip;
		
		
		private var hit_PirateCannon:Shape;
		private var hit_CabinDoor:Shape;
		private var hit_OpenDoor:Shape;
		private var hit_Wheel:Shape;
		private var hit_Cage:Shape;
		private var hit_ropes:Shape;
		private var hit_back:Shape;
		
		private var Animating:Boolean = false;
		private var CageDown:Boolean = false;
		private var DoorOpen:Boolean = false;
		private var DoorUnlocked:Boolean = false;
		private var wheelRotCount:int = 0;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CavePirateTopDeck(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('pirateTopDeck_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateTopDeck/pirateTopDeck_bg.jpg'));
				game.TrackAssets('pirateTopDeck_01');
			}
			/*
			if(game.CheckAsset('pirateTopDeck_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateTopDeck/CavePirateTopDeck_Sprite.png'));
				game.TrackAssets('pirateTopDeck_02');
			}
			if(game.CheckAsset('pirateTopDeck_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateTopDeck/CavePirateTopDeck_Sprite.xml'));
				game.TrackAssets('pirateTopDeck_03');
			}
			*/
			if(game.CheckAsset('pirateTopDeck_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateTopDeck/CavePirateTopDeck_Sprite_Two.png'));
				game.TrackAssets('pirateTopDeck_02');
			}
			if(game.CheckAsset('pirateTopDeck_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateTopDeck/CavePirateTopDeck_Sprite_Two.xml'));
				game.TrackAssets('pirateTopDeck_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirateTopDeck","CavePirateTopDeckObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('pirateTopDeck_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			wheel_mc = new MovieClip((stage.getChildAt(0) as Object).PirateTopDeckImages.assets.getTextures('wheel_pos_'),12);
			wheel_mc.smoothing = TextureSmoothing.NONE;
			wheel_mc.x = 391;
			wheel_mc.y = 132;
			wheel_mc.touchable = false;
		//	wheel_mc.loop = true; // default: true
			wheel_mc.stop();
			this.addChildAt(wheel_mc,1);	
			
			
			cabinDoor = new Image(this.assets.getTexture('door'));
			cabinDoor.touchable = false;
			cabinDoor.x = 245.5;
			cabinDoor.y = 11;
					
			cage = new Image(this.assets.getTexture('cage'));
			cage.touchable = false;
			cage.x = 441-40;
			cage.y = -171;

		//	cage_lid = new Image(this.assets.getTexture('cage_lid'));
		//	cage_lid.touchable = false;
		//	cage_lid.x = 460.5;
		//	cage_lid.y = 111;
			
			cannon_lid = new Image(this.assets.getTexture('cannon_lid'));
			cannon_lid.touchable = false;
			cannon_lid.x = 345;
			cannon_lid.y = 231;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck['Cage'] == 'Down'){
					CageDown = true;
					cage.y = 1;
					cage.alpha = 1;
					
				}else{
					cage.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck['DoorUnlocked'] == 'Yes'){
					DoorUnlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck['Door'] == 'Open'){
						DoorOpen = true;
						cabinDoor.alpha = 0;
						CreateOpenDoorHit();
						
					}else{
						cabinDoor.alpha = 1;
					}
					
				}else{
					cabinDoor.alpha = 1;
				}
				
			}else{
				cage.alpha = 0;
				cabinDoor.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon != undefined){			
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateCannon['Lid'] == 'open'){
					cannon_lid.alpha = 1;
				}else{
					cannon_lid.alpha = 0;
				}
			}else{
				cannon_lid.alpha = 0;
			}
			
			
			
			
			
			
			this.addChildAt(cabinDoor,2);
			this.addChildAt(cage,3);
			//this.addChildAt(cage_lid,4);
			this.addChildAt(cannon_lid,4);
			
			CreatRopesHit();
			CreateBackHit();
			CreateWheelHit();
			CreateCageHit();
			CreatePirateCannonHit();
			CreateCabinDoorHit(DoorOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			},1);
		}
		
	//	private var hit_ropes:Shape;
	//	private var hit_back:Shape;
		
		private function CreateBackHit():void{
			hit_back = new Shape();
			hit_back.touchable = false;
			hit_back.graphics.beginFill(0xff0000);
			
			hit_back.graphics.lineTo(366,184);	
			hit_back.graphics.lineTo(417,18);	
			hit_back.graphics.lineTo(538,0);	
			hit_back.graphics.lineTo(671,0);	
			hit_back.graphics.lineTo(642,104);	
			hit_back.graphics.lineTo(493,288);	
			hit_back.graphics.lineTo(386,225);	
			
			hit_back.graphics.endFill(false);
			hit_back.alpha = 0.0;
			
			hit_back.graphics.precisionHitTest = true;	
			this.addChild(hit_back);
		}
		
		private function CreatRopesHit():void{
			hit_ropes = new Shape();
			hit_ropes.touchable = false;
			hit_ropes.graphics.beginFill(0xff0000);
			
			hit_ropes.graphics.lineTo(0,0);	
			hit_ropes.graphics.lineTo(253,0);	
			hit_ropes.graphics.lineTo(240,63);	
			hit_ropes.graphics.lineTo(0,144);	
		
			hit_ropes.graphics.endFill(false);
			hit_ropes.alpha = 0.0;
			
			hit_ropes.graphics.precisionHitTest = true;	
			this.addChild(hit_ropes);
		}
		
		private function CreateOpenDoorHit():void{
			hit_OpenDoor = new Shape();
			hit_OpenDoor.touchable = false;
			hit_OpenDoor.graphics.beginFill(0xff0000);
			
			hit_OpenDoor.graphics.lineTo(237,161);	
			hit_OpenDoor.graphics.lineTo(267,29);	
			hit_OpenDoor.graphics.lineTo(314,8);	
			hit_OpenDoor.graphics.lineTo(331,12);	
			hit_OpenDoor.graphics.lineTo(290,183);	

			hit_OpenDoor.graphics.endFill(false);
			hit_OpenDoor.alpha = 0.0;
			
			hit_OpenDoor.graphics.precisionHitTest = true;	
			this.addChild(hit_OpenDoor);
		}
		private function CreatePirateCannonHit():void{
			hit_PirateCannon = new Shape();
			hit_PirateCannon.touchable = false;
			hit_PirateCannon.graphics.beginFill(0xff0000);
			
			hit_PirateCannon.graphics.lineTo(35,227);	
			hit_PirateCannon.graphics.lineTo(59,156);	
			hit_PirateCannon.graphics.lineTo(249,192);	
			hit_PirateCannon.graphics.lineTo(374,224);	
			hit_PirateCannon.graphics.lineTo(395,271);	
			hit_PirateCannon.graphics.lineTo(379,400);	
			hit_PirateCannon.graphics.lineTo(355,405);	
			hit_PirateCannon.graphics.lineTo(106,359);	
			hit_PirateCannon.graphics.endFill(false);
			hit_PirateCannon.alpha = 0.0;
			
			hit_PirateCannon.graphics.precisionHitTest = true;	
			this.addChild(hit_PirateCannon);
		}

		private function CreateCabinDoorHit(open:Boolean = false):void{
			hit_CabinDoor = new Shape();
			
			if(open === false){
				
				hit_CabinDoor.x = 0;
				hit_CabinDoor.y = 0;
				hit_CabinDoor.graphics.beginFill(0x0000FF);
				
				
				hit_CabinDoor.graphics.lineTo(234,157);	
				hit_CabinDoor.graphics.lineTo(270,21);	
				hit_CabinDoor.graphics.lineTo(320,5);	
				hit_CabinDoor.graphics.lineTo(362,15);	
				hit_CabinDoor.graphics.lineTo(374,56);	
				hit_CabinDoor.graphics.lineTo(340,191);	
				hit_CabinDoor.graphics.lineTo(241,169);	
				hit_CabinDoor.graphics.endFill(false);
				
				hit_CabinDoor.alpha = 0.0;
				
				hit_CabinDoor.graphics.precisionHitTest = true;	
			}else{
				
				hit_CabinDoor.x = 0;
				hit_CabinDoor.y = 0;
				hit_CabinDoor.graphics.beginFill(0x0000FF);		
				hit_CabinDoor.graphics.lineTo(332,32);
				hit_CabinDoor.graphics.lineTo(356,26);
				hit_CabinDoor.graphics.lineTo(361,51);
				hit_CabinDoor.graphics.lineTo(331,184);
				hit_CabinDoor.graphics.lineTo(296,190);
			
				
				hit_CabinDoor.graphics.endFill(false);
				hit_CabinDoor.alpha = 0.0;
				
				hit_CabinDoor.graphics.precisionHitTest = true;				
			}
			hit_CabinDoor.touchable = false;
			this.addChild(hit_CabinDoor);
			
		}	
		
		private function CreateCageHit():void{
			hit_Cage = new Shape();
			hit_Cage.touchable = false;
			hit_Cage.graphics.beginFill(0xff0000);
			
			hit_Cage.graphics.lineTo(431-40,68);	
			hit_Cage.graphics.lineTo(456-40,32);	
			hit_Cage.graphics.lineTo(457-40,33);	
			hit_Cage.graphics.lineTo(499-40,36);	
			hit_Cage.graphics.lineTo(520-40,63);	
			hit_Cage.graphics.lineTo(523-40,157);	
			hit_Cage.graphics.lineTo(510-40,167);	
			hit_Cage.graphics.lineTo(472-40,172);	
			hit_Cage.graphics.lineTo(439-40,169);	
					
			hit_Cage.graphics.endFill(false);
			hit_Cage.alpha = 0.0;
			
			hit_Cage.graphics.precisionHitTest = true;	
			this.addChild(hit_Cage);
		}
		
		private function CreateWheelHit():void{
			hit_Wheel = new Shape();
			hit_Wheel.touchable = false;
			hit_Wheel.graphics.beginFill(0xff0000);
			
			hit_Wheel.graphics.lineTo(488,235);	
			hit_Wheel.graphics.lineTo(526,160);	
			hit_Wheel.graphics.lineTo(596,119);	
			hit_Wheel.graphics.lineTo(673,128);	
			hit_Wheel.graphics.lineTo(736,145);	
			hit_Wheel.graphics.lineTo(770,206);	
			hit_Wheel.graphics.lineTo(775,283);	
			hit_Wheel.graphics.lineTo(750,351);	
			hit_Wheel.graphics.lineTo(695,394);	
			hit_Wheel.graphics.lineTo(613,382);	
			hit_Wheel.graphics.lineTo(513,347);	
		
			hit_Wheel.graphics.endFill(false);
			hit_Wheel.alpha = 0.0;
			
			hit_Wheel.graphics.precisionHitTest = true;	
			this.addChild(hit_Wheel);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(DoorOpen === true){
							if(hit_OpenDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((PirateCaptains as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.PirateCaptainsObj,false
								);
							}
						}
						
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();	
							//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CavePirateDeck as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateDeckObj,true
							);
						}else if(hit_PirateCannon.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((CavePirateCannon as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateCannonObj,true
							);
						}else if(hit_CabinDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							CabinDoorHandler();
							//	private var hit_ropes:Shape;
							//	private var hit_back:Shape;
						}else if(hit_ropes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ropes are old and moldy... The ship could collapse at any moment.");				
						}else if(CageDown === false){
							if(hit_Wheel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								trace("1 YES");
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WheelOne();
								Animating = true;
								cage.alpha = 1; 
								CageDown = true;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck;
								}
								SaveArray['Cage'] = 'Down';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateTopDeck',SaveArray);
	
								wheel_mc.addEventListener(EnterFrameEvent.ENTER_FRAME, onWheelFrame);
							}else if(hit_back.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Ships like this were made hundreds of years ago.");	
							}
						}else{
							if(hit_Wheel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WheelOne();
								Animating = true;
								CageDown = false;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck;
								}
								SaveArray['Cage'] = 'Down';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateTopDeck',SaveArray);
								
								wheel_mc.addEventListener(EnterFrameEvent.ENTER_FRAME, onWheelFrame);
							}else if(hit_Cage.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((CavePirateBirdCage as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateBirdCageObj,true
								);
							}else if(hit_back.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think this vessel is a 17th century galleon.");	
							}
						}
						
						
					}
				}
			}
		}

		private function CabinDoorHandler():void{
			if(DoorUnlocked === false){
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_SlenderKey)
				{
					
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Unlock();
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyDoorThree();
					},0.4);
					DoorUnlocked = true;
					DoorOpen = true;
					
					cabinDoor.alpha = 0;
					
					hit_CabinDoor.graphics.clear()
					CreateCabinDoorHit(true);
					CreateOpenDoorHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck;
					}
					SaveArray['Door'] = 'Open';
					SaveArray['DoorUnlocked'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateTopDeck',SaveArray);
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_SlenderKey,
							"item_SlenderKey"
						);
					
				}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_PirateKey)
				{	
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The key doesn't fit the lock.");				
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The door is locked.");				
				}
			}else{
				if(DoorOpen === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyDoorThree();
					DoorOpen = true;
					cabinDoor.alpha = 0;
					hit_CabinDoor.graphics.clear()
					CreateCabinDoorHit(true);
					CreateOpenDoorHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck;
					}
					SaveArray['Door'] = 'Open';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateTopDeck',SaveArray);
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoorTwo();
					DoorOpen = false;
					cabinDoor.alpha = 1;
					this.removeChild(hit_OpenDoor);
					hit_CabinDoor.graphics.clear()
					CreateCabinDoorHit(false);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck;
					}
					SaveArray['Door'] = 'Closed';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateTopDeck',SaveArray);
					
				}
			}
		}
		
		private function onWheelFrame():void{
			trace("wheelRotCount: "+wheelRotCount);

			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck;
			}
		
			
			if(CageDown === true){
			//	trace("yes 4");
				SaveArray['Cage'] = 'Down';
				if(wheel_mc.currentFrame == 10){
					//trace("yes 5");
					if(wheelRotCount == 4){
						//trace("yes 7");
						Animating = false;
						wheel_mc.removeEventListener(EnterFrameEvent.ENTER_FRAME, onWheelFrame);
						//wheel_mc.currentFrame = 0;
						//cage_lid.alpha = 1;
						cage.alpha = 1;
						cage.y = 1;
						wheelRotCount = 0;
					}else{
						//trace("yes 8");
						cage.y = cage.y+3.1;
						wheel_mc.currentFrame = 0;
						wheelRotCount = wheelRotCount+1;
					}
				}else{
					//trace("yes 6");
					wheel_mc.currentFrame = wheel_mc.currentFrame+1;
					cage.y = cage.y+3.1;
				}
			}else{
				SaveArray['Cage'] = 'Up';
				if(wheel_mc.currentFrame == 0){
				//	trace("yes 5");
					if(wheelRotCount == 4){
						//trace("yes 7");
						Animating = false;
						wheel_mc.removeEventListener(EnterFrameEvent.ENTER_FRAME, onWheelFrame);
						wheel_mc.currentFrame = 0;
					//	cage_lid.alpha = 0;
						cage.alpha = 0;
						cage.y = -171;
						wheelRotCount = 0;
					}else{
						cage.y = cage.y-3.2;
						wheel_mc.currentFrame = 10;
						wheelRotCount = wheelRotCount+1;
					}
				}else{
				//	trace("yes 6");
					wheel_mc.currentFrame = wheel_mc.currentFrame-1;
					cage.y = cage.y-3.1;
				}
			}
			
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirateTopDeck',SaveArray);
			
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
			
			
			this.assets.removeTexture("pirateTopDeck_bg_01",true);
		//	this.assets.removeTexture("CavePirateTopDeck_Sprite",true);
		//	this.assets.removeTextureAtlas("CavePirateTopDeck_Sprite",true);
			this.assets.removeTexture("CavePirateTopDeck_Sprite_Two",true);
			this.assets.removeTextureAtlas("CavePirateTopDeck_Sprite_Two",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateTopDeck_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateTopDeck_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateTopDeck_03");
		//	(stage.getChildAt(0) as Object).falseAsset("pirateTopDeck_04");
		//	(stage.getChildAt(0) as Object).falseAsset("pirateTopDeck_05");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
	}
}