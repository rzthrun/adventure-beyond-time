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
	
	public class FreighterUpper extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		public var SaveArraySafe:Array = new Array();
		
		private var bg:Image;
		private var wheel_puller:Image;
		private var safe_door:Image;
		private var safe_tube:Image;
		private var glass:Image;
		
		private var hit_safe:Shape;
		private var hit_wheel:Shape;
		private var hit_glass:Shape;
		private var hit_lower:Shape;
		private var hit_window:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		private var Animating:Boolean = false;
		
		public function FreighterUpper(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterUpper_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterUpper/freighterUpper_bg.jpg'));
				game.TrackAssets('freighterUpper_01');
			}
			if(game.CheckAsset('freighterUpper_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterUpper/FreighterUpper_Sprite.png'));
				game.TrackAssets('freighterUpper_02');
			}
			if(game.CheckAsset('freighterUpper_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterUpper/FreighterUpper_Sprite.xml'));
				game.TrackAssets('freighterUpper_03');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterUpper","FreighterUpperObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('freighterUpper_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			wheel_puller = new Image(this.assets.getTexture('FreighterWheel_pull_rev'));
			wheel_puller.touchable = false;
			wheel_puller.x = 432;
			wheel_puller.y = 89;
			
			safe_door = new Image(this.assets.getTexture('safe_door'));
			safe_door.touchable = false;
			safe_door.x = 561;
			safe_door.y = 182;
			safe_door.alpha = 0;
			
			safe_tube  = new Image(this.assets.getTexture('safe_pirateTube'));
			safe_tube.touchable = false;
			safe_tube.x = 674;
			safe_tube.y = 198;
			safe_tube.alpha = 0;
			
			glass = new Image(this.assets.getTexture('glass'));
			glass.touchable = false;
			glass.x = 125;
			glass.y = 342;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterUpper != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterUpper["Glass"] == "PickedUp"){
					glass.alpha = 0;
				}
				else{
					glass.alpha = 1;
				}
			}else{
				glass.alpha = 1;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Puller'] == 'Attached'){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerPos'] != null){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerPos'] == 0){
							
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerPos'] == 1){
							wheel_puller.texture = this.assets.getTexture('FreighterWheel_pull_mid');
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerPos'] == 2){
							wheel_puller.texture = this.assets.getTexture('FreighterWheel_pull_fwd');
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerPos'] == 3){
							wheel_puller.texture = this.assets.getTexture('FreighterWheel_pull_mid');
						}
					}else{
						wheel_puller.alpha = 1;
					}
				}else{
					wheel_puller.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Solved'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe['SafePopped'] == 'Yes'){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe['Door'] == 'open'){
								safe_door.alpha = 1;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe['PirateTube'] == 'PickedUp'){
									safe_tube.alpha = 0;
								}else{
									safe_tube.alpha = 1;
								}
							}else{
								safe_door.alpha = 0;
							}
						}else{
							Animating = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
								SaveArraySafe = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe;
							}
							SaveArraySafe['Door'] = 'open'; 
							SaveArraySafe['SafePopped'] = 'Yes'; 
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterSafe',SaveArraySafe);	
							Starling.juggler.delayCall(OpenSafe,2);
						}
					}else{
						Animating = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
							SaveArraySafe = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe;
						}
						SaveArraySafe['Door'] = 'open'; 
						SaveArraySafe['SafePopped'] = 'Yes'; 
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterSafe',SaveArraySafe);	
						Starling.juggler.delayCall(OpenSafe,2);
					}
				}
				
			}else{
				wheel_puller.alpha = 0;
				
			}
			
			
			this.addChildAt(wheel_puller,1);
			this.addChildAt(safe_door,2);
			this.addChildAt(safe_tube,3);
			this.addChildAt(glass,4);
			
			CreateSafeHit();
			CreateWheelHit();
			CreateGlassHit();
			CreateLowerHit();
			CreateWindowHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			//(stage.getChildAt(0) as Object).MusicObj.LoadShipGroansOne(true,999);
		}

		private function OpenSafe():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeOpen();
			safe_door.alpha = 1;
			safe_tube.alpha = 1;
			Animating = false;
			if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
				(stage.getChildAt(0) as Object).MusicObj.LoadMoonBeams(true,2);
			}
			
			
			
		}
		//hit_window
		private function CreateWindowHit():void{
			hit_window = new Shape();
			hit_window.touchable = false;
			hit_window.graphics.beginFill(0xff0000);
			
			hit_window.graphics.lineTo(8,103);	
			hit_window.graphics.lineTo(146,90);	
			hit_window.graphics.lineTo(165,209);	
			hit_window.graphics.lineTo(30,238);	
		
			hit_window.graphics.endFill(false);
			hit_window.alpha = 0.0;
			
			hit_window.graphics.precisionHitTest = true;	
			this.addChild(hit_window);
		}
		
		private function CreateLowerHit():void{
			hit_lower = new Shape();
			hit_lower.touchable = false;
			hit_lower.graphics.beginFill(0xff0000);
			
			hit_lower.graphics.lineTo(317,430);	
			hit_lower.graphics.lineTo(517,352);	
			hit_lower.graphics.lineTo(684,391);	
			hit_lower.graphics.lineTo(633,507);	
			hit_lower.graphics.lineTo(356,506);	
			
			hit_lower.graphics.endFill(false);
			hit_lower.alpha = 0.0;
			
			hit_lower.graphics.precisionHitTest = true;	
			this.addChild(hit_lower);
		}
		
		
		private function CreateGlassHit():void{
			hit_glass = new Shape();
			hit_glass.touchable = false;
			hit_glass.graphics.beginFill(0xff0000);
			
			hit_glass.graphics.lineTo(118,335);	
			hit_glass.graphics.lineTo(216,305);	
			hit_glass.graphics.lineTo(261,352);	
			hit_glass.graphics.lineTo(254,385);	
			hit_glass.graphics.lineTo(158,417);	
			hit_glass.graphics.lineTo(108,389);	

			hit_glass.graphics.endFill(false);
			hit_glass.alpha = 0.0;
			
			hit_glass.graphics.precisionHitTest = true;	
			this.addChild(hit_glass);
		}
		
		private function CreateWheelHit():void{
			hit_wheel = new Shape();
			hit_wheel.touchable = false;
			hit_wheel.graphics.beginFill(0xff0000);
			
			hit_wheel.graphics.lineTo(241,180);	
			hit_wheel.graphics.lineTo(270,114);	
			hit_wheel.graphics.lineTo(331,85);	
			hit_wheel.graphics.lineTo(532,120);	
			hit_wheel.graphics.lineTo(546,267);	
			hit_wheel.graphics.lineTo(486,282);	
			hit_wheel.graphics.lineTo(318,343);	
			hit_wheel.graphics.lineTo(271,331);	
			
			
			hit_wheel.graphics.endFill(false);
			hit_wheel.alpha = 0.0;
			
			hit_wheel.graphics.precisionHitTest = true;	
			this.addChild(hit_wheel);
		}
		
		private function CreateSafeHit():void{
			hit_safe = new Shape();
			hit_safe.touchable = false;
			hit_safe.graphics.beginFill(0xff0000);
			
			hit_safe.graphics.lineTo(586,200);	
			//hit_safe.graphics.lineTo(619,263);	
			hit_safe.graphics.lineTo(621,163);	
			hit_safe.graphics.lineTo(790,143);	
			hit_safe.graphics.lineTo(793,271);	
			hit_safe.graphics.lineTo(750,298);	
			hit_safe.graphics.lineTo(730,296);	
			hit_safe.graphics.lineTo(705,275);	
			hit_safe.graphics.lineTo(688,266);	
			hit_safe.graphics.lineTo(671,263);	
			hit_safe.graphics.lineTo(666,280);	
			hit_safe.graphics.lineTo(598,282);	
			hit_safe.graphics.endFill(false);
			hit_safe.alpha = 0.0;
			
			hit_safe.graphics.precisionHitTest = true;	
			this.addChild(hit_safe);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							FadeOut((FreighterInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterInteriorObj,true
							);
						}
						else if(hit_safe.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((FreighterSafe as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterSafeObj,true
							);
						}
						else if(hit_wheel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((FreighterWheel as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterWheelObj,true
							);
						}
						else if(hit_glass.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							GlassHandler();
						}
						else if(hit_lower.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							FadeOut((FreighterInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterInteriorObj,true
							);
						}else if(hit_window.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A broken window... the glass is scattered over the floor.");
						}
					}
						//hit_window
				}
			}
		}
		
		private function GlassHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterUpper != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterUpper["Glass"] == "PickedUp"){
					
				}else{
					glass.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
					SaveArray['Glass'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterUpper',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Glass,
						'item_Glass',
						'inven_glass_sm'
					);
					
					
				}
			}else{
				glass.alpha = 0;
				SaveArray['Glass'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterUpper',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Glass,
					'item_Glass',
					'inven_glass_sm'
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
			
			
			this.assets.removeTexture("freighterUpper_bg",true);
			this.assets.removeTexture("FreighterUpper_Sprite",true);
			this.assets.removeTextureAtlas("FreighterUpper_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterUpper_01");
			(stage.getChildAt(0) as Object).falseAsset("freighterUpper_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterUpper_03");
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