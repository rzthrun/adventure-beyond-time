package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class SpaceShipInterior extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var oven_lid:Image;
		private var oven_bar:Image;
		private var oven_plasma:Image;
		private var ovenUI:Image;
		
		private var consoleBlue:Image;
		private var ovenBlue:Image;
		private var hit_console:Shape;
		private var hit_oven:Shape;
		
		private var hit_pipes:Shape;
		private var hit_bulkhead:Shape;
		private var hit_floor:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var OvenOn:Boolean = false;
		private var Animating:Boolean = false;
		
		private var delayedCall:DelayedCall;
		private var OvenUITween:Tween;
		
		private var goback:GoBackButton;
		
		
		public function SpaceShipInterior(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('spaceShipInterior_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipInterior/spaceShipInterior_bg.jpg'));
				game.TrackAssets('spaceShipInterior_01');
			}
			if(game.CheckAsset('spaceShipInterior_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipInterior/SpaceShipInterior_Sprite_01.atf'));
				game.TrackAssets('spaceShipInterior_02');
			}	
			if(game.CheckAsset('spaceShipInterior_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipInterior/SpaceShipInterior_Sprite_01.xml'));
				game.TrackAssets('spaceShipInterior_03');
			}
			if(game.CheckAsset('spaceShipInterior_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipInterior/SpaceShipInterior_Sprite_02.png'));
				game.TrackAssets('spaceShipInterior_04');
			}
			if(game.CheckAsset('spaceShipInterior_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipInterior/SpaceShipInterior_Sprite_02.xml'));
				game.TrackAssets('spaceShipInterior_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SpaceShipInterior","SpaceShipInteriorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		//	SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior;
			
		//	SaveArray["OvenOn"] = "no";
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
			
		//	SaveArray['FirstTime'] = 'no';
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
			
			bg = new Image(this.assets.getTexture('spaceShipInterior_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			oven_lid  = new Image(this.assets.getTexture('oven_lid_off'));
			oven_lid.smoothing = TextureSmoothing.NONE;

			oven_lid.touchable = false;
			oven_lid.x = 472;
			oven_lid.y = 129;
			
			oven_bar  = new Image(this.assets.getTexture('oven_off_bar'));
			oven_bar.smoothing = TextureSmoothing.NONE;

			oven_bar.touchable = false;
			oven_bar.x = 546;
			oven_bar.y = 174;
			
			oven_plasma = new Image(this.assets.getTexture('oven_on_plasma'));
			oven_plasma.smoothing = TextureSmoothing.NONE;

			oven_plasma.touchable = false;
			oven_plasma.x = 551;
			oven_plasma.y = 149;
			
			consoleBlue = new Image(this.assets.getTexture('console_blue'));
			consoleBlue.smoothing = TextureSmoothing.NONE;

			consoleBlue.touchable = false;
			consoleBlue.x = 1;
			consoleBlue.y = 50;
			
			ovenBlue = new Image(this.assets.getTexture('oven_blue'));
			ovenBlue.smoothing = TextureSmoothing.NONE;

			ovenBlue.touchable = false;
			ovenBlue.x = 378;
			ovenBlue.y = 70;
			
			ovenUI = new Image(this.assets.getTexture('oven_dials'));
		//	ovenUI.smoothing = TextureSmoothing.NONE;

			ovenUI.touchable = false;
			ovenUI.x = 358;
			ovenUI.y = 99;
			
		//	SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior;
			
			//SaveArray["OvenOn"] = "no";
			//(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
		//	SaveArray["Unlocked"] = "no";
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
				trace("x 1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole['Tricorder'] == 'Attached'){
					consoleBlue.alpha = 1;
					trace("x 2");
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior != undefined){
						trace("x 3");
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior['OvenOn'] == 'Yes'){
							trace("x 4");
							ovenUI.alpha = 1;
							ovenBlue.alpha = 1;
							oven_lid.texture = this.assets.getTexture('oven_lid_on');
						}else{
							trace("x 5");
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
								trace("x 6");
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] == 'Yes'){
									trace("x 7");
									Animating = true;
									ovenUI.alpha = 0;
									OvenOn = true;
									ovenBlue.alpha = 1;
									oven_lid.texture = this.assets.getTexture('oven_lid_on');
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior;
									
									SaveArray["OvenOn"] = "Yes";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
									
									
									
									delayedCall = new DelayedCall(function():void{
										TurnOnOvenUI()
									}, 2);
									Starling.juggler.add(delayedCall);
								}else{
									ovenUI.alpha = 0;
									OvenOn = false;
									ovenBlue.alpha = 0;
								}
							}else{
								ovenUI.alpha = 0;
								OvenOn = false;
								ovenBlue.alpha = 0;
							}
							
						}
					}else{
						ovenUI.alpha = 0;
						
						ovenBlue.alpha = 0;
					}
				/*	else{
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] = 'Yes'){
								Animating = true;
								ovenUI.alpha = 0;
								
								SaveArray["OvenOn"] = "Yes";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
								
								delayedCall = new DelayedCall(function():void{
									TurnOnOvenUI()
								}, 2);
								Starling.juggler.add(delayedCall);
							}
						}
					}*/
				}else{
					ovenUI.alpha = 0;
					consoleBlue.alpha = 0;
					ovenBlue.alpha = 0;
				}
			}else{
				ovenUI.alpha = 0;
				consoleBlue.alpha = 0;
				ovenBlue.alpha = 0;
			}
			
			
			
			/*if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] == 'Yes'){
					OvenOn = true;
					ovenBlue.alpha = 1;
					oven_lid.texture = this.assets.getTexture('oven_lid_on');
				}else{
					ovenBlue.alpha = 0;
				}
			}else{
				ovenBlue.alpha = 0;
			}
			*/
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Lid'] == 'Open'){
					oven_lid.alpha = 0;
					
				}else{
					
					
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Bar'] == 'Attached'){
					oven_plasma.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Lid'] == 'Open'){
						if(OvenOn === true){
							oven_bar.texture = this.assets.getTexture('oven_on_bar');
						}else{
							oven_bar.texture = this.assets.getTexture('oven_off_bar');
						}
						oven_bar.alpha = 1;
					}else{
						if(OvenOn === true){
							oven_bar.texture = this.assets.getTexture('oven_on_bar_closed');
						}else{
							oven_bar.texture = this.assets.getTexture('oven_off_bar_closed');
						}
						oven_bar.alpha = 1;
					}
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Bar'] == 'Processed'){
					oven_bar.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Plasma'] == 'PickedUp'){
						oven_plasma.alpha = 0;
						
					}else{
						oven_plasma.alpha = 1;
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Lid'] == 'Open'){
							oven_plasma.texture = this.assets.getTexture('oven_on_plasma');
						}else{
							oven_plasma.texture = this.assets.getTexture('oven_on_plasma_closed');
						}
					}
					
				}else{
					oven_plasma.alpha = 0;
					oven_bar.alpha = 0;
				}
			}else{
				trace("BARK 8");
				oven_plasma.alpha = 0;
				oven_bar.alpha = 0;
				oven_lid.alpha = 1;
			}
			
			
			this.addChildAt(bg,0);
			this.addChildAt(ovenBlue,1);
			this.addChildAt(oven_lid,2);
			this.addChildAt(oven_bar,3);
			this.addChildAt(oven_plasma,4);
			this.addChildAt(consoleBlue,5);
			this.addChildAt(ovenUI,6);
			//FadeOutOcean(1);
			CreateFloorHit();
			CreatePipesHit();
			CreateBulkheadHit();
			CreateConsoleHit();
			CreateOvenHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,0.5,'stop');
			//	(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("WindOne",0,1.0,'stop');
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipConsole['Tricorder'] == 'Attached'){
					(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHumPower(true,999);
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHum(true,999);
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHum(true,999);
			}
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipInterior;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,3);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
					Starling.juggler.delayCall(function():void{
						
						(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,3);
					},0.5);
				}
			}
			/*
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Iridium,
				'item_Iridium',
				'inven_iridium_sm'
			);
			*/
		}
		
		private function TurnOnOvenUI():void{
			game.SoundFXObj.PlaySFX_OhmTwo();
			game.SoundFXObj.PlaySFX_CosmicDoor();
			//game.SoundFXObj.PlaySFX_EnergyPulse();
			OvenUITween = new Tween(ovenUI, 2, Transitions.LINEAR);
			OvenUITween.fadeTo(1);
			OvenUITween.onComplete = function():void{
				game.SoundFXObj.PlaySFX_EnergyPulse();
				Animating = false;
				OvenUITween = null
			}
			Starling.juggler.add(OvenUITween);
		}
		
		/*
		private var hit_pipes:Shape;
		private var hit_bulkhead:Shape;
		private var hit_floor:Shape;
		*/
		private function CreateFloorHit():void{
			hit_floor = new Shape();
			hit_floor.touchable = false;
			hit_floor.graphics.beginFill(0xff0000);
			
			hit_floor.graphics.lineTo(167,357);	
			hit_floor.graphics.lineTo(311,304);	
			hit_floor.graphics.lineTo(772,371);	
			hit_floor.graphics.lineTo(596,512);	
			hit_floor.graphics.lineTo(261,512);	
			
			hit_floor.graphics.endFill(false);
			hit_floor.alpha = 0.0;
			
			hit_floor.graphics.precisionHitTest = true;	
			this.addChild(hit_floor);
		}
		
		private function CreateBulkheadHit():void{
			hit_bulkhead = new Shape();
			hit_bulkhead.touchable = false;
			hit_bulkhead.graphics.beginFill(0xff0000);
						
			hit_bulkhead.graphics.lineTo(290,147);	
			hit_bulkhead.graphics.lineTo(375,124);	
			hit_bulkhead.graphics.lineTo(409,262);	
			hit_bulkhead.graphics.lineTo(310,277);	
			
			hit_bulkhead.graphics.endFill(false);
			hit_bulkhead.alpha = 0.0;
			
			hit_bulkhead.graphics.precisionHitTest = true;	
			this.addChild(hit_bulkhead);
		}
		
		private function CreatePipesHit():void{
			hit_pipes = new Shape();
			hit_pipes.touchable = false;
			hit_pipes.graphics.beginFill(0xff0000);
			
			
			hit_pipes.graphics.lineTo(0,0);	
			hit_pipes.graphics.lineTo(496,0);	
			hit_pipes.graphics.lineTo(230,512);	
			hit_pipes.graphics.lineTo(0,512);	
			
			hit_pipes.graphics.endFill(false);
			hit_pipes.alpha = 0.0;
			
			hit_pipes.graphics.precisionHitTest = true;	
			this.addChild(hit_pipes);
		}
		
		private function CreateConsoleHit():void{
			hit_console = new Shape();
			hit_console.touchable = false;
			hit_console.graphics.beginFill(0xff0000);
			
			
			hit_console.graphics.lineTo(47,154);	
			hit_console.graphics.lineTo(281,114);	
			hit_console.graphics.lineTo(312,301);	
			hit_console.graphics.lineTo(154,357);	
			hit_console.graphics.lineTo(90,314);	
		
			hit_console.graphics.endFill(false);
			hit_console.alpha = 0.0;
			
			hit_console.graphics.precisionHitTest = true;	
			this.addChild(hit_console);
		}
		
		private function CreateOvenHit():void{
			hit_oven = new Shape();
			hit_oven.touchable = false;
			hit_oven.graphics.beginFill(0xff0000);

			hit_oven.graphics.lineTo(366,57);	
			hit_oven.graphics.lineTo(369,55);	
			hit_oven.graphics.lineTo(601,9);	
			hit_oven.graphics.lineTo(603,11);	
			hit_oven.graphics.lineTo(723,168);	
			hit_oven.graphics.lineTo(728,371);	
			hit_oven.graphics.lineTo(439,361);	
		
			hit_oven.graphics.endFill(false);
			hit_oven.alpha = 0.0;
			
			hit_oven.graphics.precisionHitTest = true;	
			this.addChild(hit_oven);
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
							FadeOut((RavineSpaceShipDoor as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipDoorObj,false
							);
						}else if(hit_console.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							FadeOut((SpaceShipConsole as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipConsoleObj,true
							);
						}else if(hit_oven.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((SpaceShipOven as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipOvenObj,true
							);
						}else if(hit_bulkhead.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A metal bulkhead juts out from the walls of the compartment.");

							
						}else if(hit_pipes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PhraseCounter == 0){
								PhraseCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The walls are covered in a menagerie of bizarre looking contraptions.");
								
							}else if(PhraseCounter == 1){
								PhraseCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A powerful hum reverberates through the walls of the galactic vessel.");
								
							}else if(PhraseCounter == 2){
								PhraseCounter = 3;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The function of many parts is not discernible from mere sight.");

							}else if(PhraseCounter == 3){
								PhraseCounter = 4;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal shines under a thin layer of dust.");
								
							}else if(PhraseCounter == 4){
								PhraseCounter = 0;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Wires, pipes, and unnameable gizmos run all over the ship's interior.");
								
							}
						}else if(hit_floor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor is made of corrugated metal.");
								
					
						}
						/*
						private var hit_pipes:Shape;
						private var hit_bulkhead:Shape;
						private var hit_floor:Shape;
						
						private var PhraseCounter:int = 0;
						*/
					}
						
				}
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
			
			
			this.assets.removeTexture("spaceShipInterior_bg",true);
			this.assets.removeTexture("SpaceShipInterior_Sprite_01",true);
			this.assets.removeTextureAtlas("SpaceShipInterior_Sprite_01",true);
			this.assets.removeTexture("SpaceShipInterior_Sprite_02",true);
			this.assets.removeTextureAtlas("SpaceShipInterior_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("spaceShipInterior_01");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipInterior_02");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipInterior_03");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipInterior_04");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipInterior_05");
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
