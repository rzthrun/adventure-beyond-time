package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class SubmarineConsole extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var panel:Image;
		private var lever:Image;
		private var screens:Image;
		
		private var hit_panel:Shape;
		private var hit_screens:Shape;
		private var hit_lever:Shape;
		private var hit_wires:Shape;
		
		private var hit_buttons:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var PanelUnlocked:Boolean = false;
		private var PanelOpen:Boolean = false;
		private var LightsOn:Boolean = false;
		private var PowerOn:Boolean = false;
		private var ScreensOn:Boolean = false;
		private var Animating:Boolean = false;
		
		private var ScreensTween:Tween;
		
		private var goback:GoBackButton;
		
		public function SubmarineConsole(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineConsole_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineConsole/SubmarineConsole_Sprite.jpg'));
				game.TrackAssets('submarineConsole_01');
			}
			if(game.CheckAsset('submarineConsole_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineConsole/SubmarineConsole_Sprite.xml'));
				game.TrackAssets('submarineConsole_02');
			}
			if(game.CheckAsset('submarineConsole_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineConsole/SubmarineConsole_Sprite_02.png'));
				game.TrackAssets('submarineConsole_03');
			}
			if(game.CheckAsset('submarineConsole_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineConsole/SubmarineConsole_Sprite_02.xml'));
				game.TrackAssets('submarineConsole_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineConsole","SubmarineConsoleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			//(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineConsole',SaveArray);	
			bg = new Image(this.assets.getTexture('SubmarineConsole_red_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			panel = new Image(this.assets.getTexture('panel_red'));
			panel.touchable = true;
			panel.x = 330;
			panel.y = 186;
		
			lever = new Image(this.assets.getTexture('lever'));
			lever.touchable = true;
			lever.x = 549;
			lever.y = 56;

			screens = new Image(this.assets.getTexture('screens'));
			screens.touchable = true;
			screens.x = 21;
			screens.y = 42;
			
			//SaveArray['PanelUnlocked'] = 'yes';
			//SaveArray['Panel'] = 'open';
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					bg.texture = this.assets.getTexture('SubmarineConsole_lit_bg');
					panel.texture = this.assets.getTexture('panel_lit');
					LightsOn = true;
				}else{
					
				}
			}else{
				
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole['PanelUnlocked'] == 'yes'){
					PanelUnlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole['Panel'] == 'open'){
						panel.alpha = 0;
						PanelOpen = true;
						CreateHitWires();
					}else{
						panel.alpha = 1;
						
					}
				}else{
					panel.alpha = 1;
					
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole['ScreensOn'] == 'yes'){
					(stage.getChildAt(0) as Object).AmbientObj.LoadSonar(true,999);
					ScreensOn = true;
					screens.alpha = 1;
					lever.alpha = 1;
				}else{
					screens.alpha = 0;
					lever.alpha = 0;
				}
			}else{
				panel.alpha = 1;
				screens.alpha = 0;
				lever.alpha = 0;
				
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['Solved'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole['Power'] == 'On'){
							
							PowerOn = true;
							bg.texture = this.assets.getTexture('SubmarineConsole_power_bg');
							panel.texture = this.assets.getTexture('panel_power');
						}else{
							PowerOn = true;
							Animating = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole;
							}
							SaveArray['Power'] = 'On'; 
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineConsole',SaveArray);	
							Starling.juggler.delayCall(TurnOnPower,2)
							
						}	
					}else{
						PowerOn = true;
						Animating = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole;
						}
						SaveArray['Power'] = 'On'; 
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineConsole',SaveArray);	
						Starling.juggler.delayCall(TurnOnPower,2)
					}
				}else{
				
				}
			}else{
				
			}
			
			CreateHitButtons();
			CreatePanelHit(PanelOpen);
			CreateHitLever();
			CreateHitScreens();
			
			this.addChildAt(panel,1);
			this.addChildAt(lever,2);			
			this.addChildAt(screens,3);
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDrips(true,999);
			},1.5);
			
		}
		
		
		private function TurnOnPower():void{
//SubmarineConsole_power_bg
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BigLights();
			//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowerUp();
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,999);
			
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'CaveDrips';
			bg.texture = this.assets.getTexture('SubmarineConsole_power_bg');
			panel.texture = this.assets.getTexture('panel_power');
			Animating = false;
			Starling.juggler.delayCall(function():void{
				
				(stage.getChildAt(0) as Object).AmbientObj.LoadElectricHum(true,0);
				
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'CaveDrips';
				//		(stage.getChildAt(0) as Object).MusicObj.LoadBeatDownOne(true,2);
			},1);
			
			
		}
		
		private function CreatePanelHit(open:Boolean = false):void{
			hit_panel = new Shape();
			
			if(open === false){
				
				hit_panel.x = 0;
				hit_panel.y = 0;
				hit_panel.graphics.beginFill(0x0000FF);
				
				hit_panel.graphics.lineTo(378,191);	
				hit_panel.graphics.lineTo(599,227);	
				hit_panel.graphics.lineTo(551,403);	
				hit_panel.graphics.lineTo(332,336);	

				hit_panel.graphics.endFill(false);
				
				hit_panel.alpha = 0.0;
				
				hit_panel.graphics.precisionHitTest = true;	
			}else{
				
				hit_panel.x = 0;
				hit_panel.y = 0;
				hit_panel.graphics.beginFill(0x0000FF);		
				hit_panel.graphics.lineTo(569,235);
				hit_panel.graphics.lineTo(734,190);
				hit_panel.graphics.lineTo(747,387);
				hit_panel.graphics.lineTo(643,467);
				hit_panel.graphics.lineTo(547,464);

				hit_panel.graphics.endFill(false);
				hit_panel.alpha = 0.0;
				
				hit_panel.graphics.precisionHitTest = true;				
			}
			hit_panel.touchable = false;
			this.addChild(hit_panel);
			
		}	
		//hit_buttons
		private function CreateHitButtons():void{
			hit_buttons = new Shape();
			hit_buttons.touchable = false;
			hit_buttons.graphics.beginFill(0x00ff00);
			
			hit_buttons.graphics.lineTo(0,0);	
			hit_buttons.graphics.lineTo(533,50);	
			hit_buttons.graphics.lineTo(430,427);	
			hit_buttons.graphics.lineTo(0,284);	
			
		
			hit_buttons.graphics.endFill(false);
			hit_buttons.alpha = 0.0;
			hit_buttons.graphics.precisionHitTest = true;	
			this.addChild(hit_buttons);
			
		}
		
		private function CreateHitWires():void{
			hit_wires = new Shape();
			hit_wires.touchable = false;
			hit_wires.graphics.beginFill(0x00ff00);
			
			hit_wires.graphics.lineTo(385,202);	
			hit_wires.graphics.lineTo(560,236);	
			hit_wires.graphics.lineTo(553,337);	
			hit_wires.graphics.lineTo(541,387);	
			hit_wires.graphics.lineTo(348,328);	
			//hit_screens.graphics.lineTo(194,35);	
			
			
			hit_wires.graphics.endFill(false);
			hit_wires.alpha = 0.0;
			hit_wires.graphics.precisionHitTest = true;	
			this.addChild(hit_wires);
			
		}
		
		private function CreateHitScreens():void{
			hit_screens = new Shape();
			hit_screens.touchable = false;
			hit_screens.graphics.beginFill(0x00ff00);
			
			hit_screens.graphics.lineTo(27,10);	
			//hit_screens.graphics.lineTo(194,35);	
			hit_screens.graphics.lineTo(265,48);	
			hit_screens.graphics.lineTo(300,144);	
			hit_screens.graphics.lineTo(255,277);	
			hit_screens.graphics.lineTo(16,217);	
			//hit_screens.graphics.lineTo(14,144);	
			
			hit_screens.graphics.endFill(false);
			hit_screens.alpha = 0.0;
			hit_screens.graphics.precisionHitTest = true;	
			this.addChild(hit_screens);
			
		}
		
		private function CreateHitLever():void{
			hit_lever = new Shape();
			hit_lever.touchable = false;
			hit_lever.graphics.beginFill(0x00ff00);
			
			hit_lever.graphics.lineTo(536,71);	
			hit_lever.graphics.lineTo(553,53);	
			hit_lever.graphics.lineTo(670,50);	
			
			hit_lever.graphics.lineTo(706,180);	
			
			hit_lever.graphics.lineTo(688,193);	
			hit_lever.graphics.lineTo(536,190);	
		
			hit_lever.graphics.endFill(false);
			hit_lever.alpha = 0.0;
			hit_lever.graphics.precisionHitTest = true;	
			this.addChild(hit_lever);
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
							FadeOut((SubmarineInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineInteriorObj,true
							);
						}else if(hit_panel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PanelHandler();
						}else if(hit_lever.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PowerOn === true){
								if(ScreensOn === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'll leave the lever alone. If I turn anything off, I might not be able to turn it back on again.");
								}else{
									LeverHandler();
									
								}
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The lever won't budge. It's locked in place.");
							}
						}else if(hit_screens.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PowerOn === true){
								if(ScreensOn === true){
									FadeOut((SubmarineSonar as Class), 
										(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineSonarObj,true
									);
								}else{
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The screen still has no power.");
								}
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("None of the electronics on this console are working.");
							}
						}else if(PanelOpen === true){
							if(hit_wires.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(LightsOn === false){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some of the wires seem disconnected. I'll have to turn the lights on before I can look closer.");
								}else{
									if(PowerOn === true){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've repaired the console's wiring. There's nothing more to do with it.");
									}else{
										FadeOut((SubmarineWirePuzzle as Class), 
											(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineWirePuzzleObj,true
										);
									}
								}
								
							}else if(hit_buttons.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(LightsOn === false){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pressing random buttons won't solve anything.");
								}else{
									if(PowerOn === true){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I must be careful.. don't want to press the wrong button.");
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The console is covered with hundreds of buttons and switches for control of the submarine.");
									}
								}
									
									
							}
							
						}else if(hit_buttons.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pressing random buttons won't solve anything.");
						}
					}
				}
			}
		}
		private function LeverHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxOpen();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowerUp();
			
			Animating = true;
			ScreensOn = true;
	//		screens.alpha = 1;			
			lever.alpha = 1;
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole;
			}
			SaveArray['ScreensOn'] = 'yes';
		
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineConsole',SaveArray);
			
			ScreensTween = new Tween(screens, 2.5, Transitions.LINEAR);
			ScreensTween.fadeTo(1);
			ScreensTween.onComplete = function():void{	
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BootUp();
				//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Sonar();
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMoonBeams(true,1);
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).AmbientObj.LoadSonar(true,999);
						},2);
					},1);
					
				}
				
				Animating = false;
				ScreensTween = null;
			}
			Starling.juggler.add(ScreensTween);
			
			
		}
		
		private function PanelHandler():void{
			if(PanelOpen === false){
				if(PanelUnlocked == false){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Screwdriver)
					{
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeOpen();
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock != undefined){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Unlocked'] == 'Yes'){
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
						panel.alpha = 0;
						PanelOpen = true;
						PanelUnlocked = true;
						
						hit_panel.graphics.clear();
						CreatePanelHit(true);
						CreateHitWires();
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole;
						}
						SaveArray['PanelUnlocked'] = 'yes';
						SaveArray['Panel'] = 'open';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineConsole',SaveArray);
						
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks like this instrument panel is removable, but it's tightly screwed in place.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeOpen()
					
					panel.alpha = 0;
					PanelOpen = true;
					
					hit_panel.graphics.clear();
					CreatePanelHit(true);
					CreateHitWires();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole;
					}
					SaveArray['Panel'] = 'open';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineConsole',SaveArray);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeClose();
				panel.alpha = 1;
				PanelOpen = false;
				this.removeChild(hit_wires)
				hit_panel.graphics.clear();
				CreatePanelHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole;
				}
				SaveArray['Panel'] = 'closed';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineConsole',SaveArray);
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
			
			
			this.assets.removeTexture("SubmarineConsole_Sprite",true);
			this.assets.removeTexture("SubmarineConsole_Sprite_02",true);
			this.assets.removeTextureAtlas("SubmarineConsole_Sprite",true);
			this.assets.removeTextureAtlas("SubmarineConsole_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineConsole_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineConsole_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineConsole_03");
			(stage.getChildAt(0) as Object).falseAsset("submarineConsole_04");
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
