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
	
	
	public class JungleEnclaveRock extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var lid_on:Image;
		private var lid_off:Image;
		private var seal:Image;
		
		private var hit_lid:Shape;
		private var hit_seal:Shape;
		
		private var hit_rock:Shape;
		
		private var LidOpen:Boolean = false;
		
		private var Unlocked:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleEnclaveRock(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleEnclaveRock_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclaveRock/jungleEnclaveRock_bg.jpg'));
				game.TrackAssets('jungleEnclaveRock_01');
			}
			if(game.CheckAsset('jungleEnclaveRock_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclaveRock/jungleEnclaveRock_Sprite.atf'));
				game.TrackAssets('jungleEnclaveRock_02');
			}
			if(game.CheckAsset('jungleEnclaveRock_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclaveRock/jungleEnclaveRock_Sprite.xml'));
				game.TrackAssets('jungleEnclaveRock_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleEnclaveRock","JungleEnclaveRockObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
		/*	(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Screwdriver,
				'item_Screwdriver',
				'inven_screwdriver_sm'
			);
			*/
			
			
			
			bg = new Image(this.assets.getTexture('jungleEnclaveRock_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			lid_on = new Image(this.assets.getTexture('lid_on'));
			lid_on.smoothing = TextureSmoothing.NONE;
			lid_on.touchable = false;
			lid_on.x = 224;
			lid_on.y = 34;
		
			lid_off = new Image(this.assets.getTexture('lid_off'));
			lid_off.smoothing = TextureSmoothing.NONE;
			lid_off.touchable = false;
			lid_off.x = 523;
			lid_off.y = 203;

			seal = new Image(this.assets.getTexture('seal'));
			seal.smoothing = TextureSmoothing.NONE;
			seal.touchable = false;
			seal.x = 246;
			seal.y = 196;
			seal.alpha = 0;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Unlocked'] == 'Yes'){
					Unlocked = true;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Lid'] == 'Open'){
					LidOpen = true;
					lid_on.alpha = 0;
					lid_off.alpha = 1;
					CreateHitLid(LidOpen);
					CreateHitSeal();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Seal'] == 'PickedUp'){
						seal.alpha = 0;
					}else{
						seal.alpha = 1;
					}
				}else{
					
					lid_on.alpha = 1;
					lid_off.alpha = 0;
					seal.alpha = 0;
					CreateHitLid(LidOpen);
				}
			}else{
				
				lid_on.alpha = 1;
				lid_off.alpha = 0;
				seal.alpha = 0;
				CreateHitLid(LidOpen);
			}
			
			
			
		
			
			this.addChildAt(lid_on,1);
			this.addChildAt(lid_off,2);
			this.addChildAt(seal,3);
			
			CreateHitRock();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
		}
		//hit_rock
		private function CreateHitRock():void{
			hit_rock = new Shape();
			hit_rock.touchable = false;
			hit_rock.graphics.beginFill(0xff0000);
			
			hit_rock.graphics.lineTo(0,367);																																																																																																																														
			hit_rock.graphics.lineTo(188,0);																																																																																																																														
			hit_rock.graphics.lineTo(458,0);																																																																																																																														
			hit_rock.graphics.lineTo(524,63);																																																																																																																														
			hit_rock.graphics.lineTo(588,435);																																																																																																																														
			hit_rock.graphics.lineTo(499,508);																																																																																																																														
			hit_rock.graphics.lineTo(120,504);																																																																																																																														
																																																																																																																															
			
			hit_rock.graphics.endFill(false);
			hit_rock.alpha = 0.0;
			
			hit_rock.graphics.precisionHitTest = true;	
			this.addChild(hit_rock);
		}
		
		private function CreateHitSeal():void{
			hit_seal = new Shape();
			hit_seal.touchable = false;
			hit_seal.graphics.beginFill(0xff0000);
			
			hit_seal.graphics.lineTo(262,240);																																																																																																																														
			hit_seal.graphics.lineTo(291,203);																																																																																																																														
			hit_seal.graphics.lineTo(337,190);																																																																																																																														
			hit_seal.graphics.lineTo(382,205);																																																																																																																														
			hit_seal.graphics.lineTo(403,247);																																																																																																																														
			hit_seal.graphics.lineTo(404,289);																																																																																																																														
			hit_seal.graphics.lineTo(382,328);																																																																																																																														
			hit_seal.graphics.lineTo(343,341);																																																																																																																														
			hit_seal.graphics.lineTo(296,333);																																																																																																																														
			hit_seal.graphics.lineTo(271,318);																																																																																																																														

			hit_seal.graphics.endFill(false);
			hit_seal.alpha = 0.0;
			
			hit_seal.graphics.precisionHitTest = true;	
			this.addChild(hit_seal);
		}
		
		private function CreateHitLid(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				hit_lid.graphics.lineTo(248,70);
				hit_lid.graphics.lineTo(342,19);
				hit_lid.graphics.lineTo(478,90);
				hit_lid.graphics.lineTo(488,317);
				hit_lid.graphics.lineTo(400,414);
				hit_lid.graphics.lineTo(306,392);
				hit_lid.graphics.lineTo(222,292);

				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(513,261);
				hit_lid.graphics.lineTo(536,199);
				hit_lid.graphics.lineTo(625,213);
				hit_lid.graphics.lineTo(655,235);
				hit_lid.graphics.lineTo(745,505);
				hit_lid.graphics.lineTo(745,392);
				hit_lid.graphics.lineTo(681,505);
				hit_lid.graphics.lineTo(593,451);

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
						FadeOut((JungleEnclave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveObj,true
						);
					}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Screwdriver)
						{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RemoveNail();
							Unlocked = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock;
							}
							SaveArray["Unlocked"] = "Yes";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveRock',SaveArray);
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole['PanelUnlocked'] == 'yes'){
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
										.InventoryObj.removeItemFromInventory(
											(stage.getChildAt(0) as Object)
											.screenGamePlayHandler
											.InventoryObj.item_Screwdriver,
											"item_Screwdriver"
										);
								}
							}
							if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
								
								Starling.juggler.delayCall(function():void{
									(stage.getChildAt(0) as Object).MusicObj.LoadBeatNowOne(true,2);
								},1);
							}
							
							LidHandler();
							
						}else if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Hammer)
						{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The edge of the hammer is too thick to fit in the narrow crease in the edge of the rock.");
							
							
						}else{
							if(Unlocked === true){
								LidHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a narrow crease running around the rock - I think there's a hollow behind it.");
								
							}
						}
						
						
					}else if(LidOpen === true){
						if(hit_seal.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SealHandler();
						}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("How could stone form this way? Someone must have chiseled the recess away");
							
						}
					}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What an unusual rock.");
						
					}
				}
			}
		}
		
		private function SealHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Seal'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is nothing else there.");

				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					seal.alpha = 0;
					SaveArray["Seal"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveRock',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Seal,
						'item_Seal',
						'inven_seal_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				seal.alpha = 0;
				SaveArray["Seal"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveRock',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Seal,
					'item_Seal',
					'inven_seal_sm'
				);
			}
		}
		
		private function LidHandler():void{
			if(LidOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Seal'] == 'PickedUp'){
						seal.alpha = 0;
					}else{
						seal.alpha = 1;
					}
				}else{
					seal.alpha = 1;
				}
				LidOpen = true;
				lid_on.alpha = 0;
				lid_off.alpha = 1;
				SaveArray['Lid'] = 'Open'; 
				
				hit_lid.graphics.clear();
				CreateHitLid(true);
				CreateHitSeal();
			
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock;
				LidOpen = false;
				seal.alpha = 0
				lid_on.alpha = 1;
				lid_off.alpha = 0;
				
				SaveArray['Lid'] = 'Closed'; 
				
				this.removeChild(hit_seal);
				hit_lid.graphics.clear();
				CreateHitLid(false);
				
			}
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleEnclaveRock',SaveArray);
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
			
			
			this.assets.removeTexture("jungleEnclaveRock_bg",true);
			this.assets.removeTexture("jungleEnclaveRock_Sprite",true);
			this.assets.removeTextureAtlas("jungleEnclaveRock_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclaveRock_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclaveRock_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclaveRock_03");
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
