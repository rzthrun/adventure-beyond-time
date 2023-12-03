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
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;

	public class SpaceShipOven extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var lid:Image;
		private var bar:Image;
		
		private var discA:Image;
		private var discB:Image;
		private var discC:Image;
		
		private var anima_laser:Image;
		private var anima_glowing:Image;
		private var anima_red:Image;
		private var anima_teleport:Image;
		
		private var LaserTween:Tween;
		private var GlowTween:Tween;
		private var RedTween:Tween;
		private var TeleportTween:Tween;
		
		private var plasma:Image;
		
		private var hit_lid:Shape;
		private var hit_chamber:Shape;
		
		private var hit_discA:Shape;
		private var hit_discB:Shape;
		private var hit_discC:Shape;
		
		private var hit_left:Shape;
		private var hit_right:Shape;
		private var hit_tube:Shape;
		private var PhraseCounter:int = 0;;
		
		private var LidOpen:Boolean = false;
		private var LightsOn:Boolean = false;
		private var Animating:Boolean = false;
		private var BarAttached:Boolean = false;
		private var BarProcessed:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var DiscAOn:Boolean = false;
		private var DiscBOn:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function SpaceShipOven(_assets:AssetManager,_game:Game)
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
			
			if(game.CheckAsset('spaceShipOven_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipOven/SpaceShipOven_Sprite_01.jpg'));
				game.TrackAssets('spaceShipOven_01');
			}	
			if(game.CheckAsset('spaceShipOven_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipOven/SpaceShipOven_Sprite_01.xml'));
				game.TrackAssets('spaceShipOven_02');
			}
			if(game.CheckAsset('spaceShipOven_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipOven/SpaceShipOven_Sprite_02.atf'));
				game.TrackAssets('spaceShipOven_03');
			}
			if(game.CheckAsset('spaceShipOven_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipOven/SpaceShipOven_Sprite_02.xml'));
				game.TrackAssets('spaceShipOven_04');
			}
			if(game.CheckAsset('spaceShipOven_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipOven/SpaceShipOven_Sprite_03.png'));
				game.TrackAssets('spaceShipOven_05');
			}
			if(game.CheckAsset('spaceShipOven_06') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipOven/SpaceShipOven_Sprite_03.xml'));
				game.TrackAssets('spaceShipOven_06');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SpaceShipOven","SpaceShipOvenObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
		//	if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
		//		SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
		//	}
		//	SaveArray["Plasma"] = "no";
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
			
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipInterior',SaveArray);
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipPuzzle',SaveArray);
			
			
			/*
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
			}
			SaveArray["Bar"] = "no";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
			
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Iridium,
				'item_Iridium',
				'inven_iridium_sm'
			);
			*/
			bg = new Image(this.assets.getTexture('spaceShipOven_bg'));
			bg.touchable = true;
			bg.alpha = 1;
			
			//off_lid_closed 
			lid = new Image(this.assets.getTexture('off_lid_closed'));
			lid.smoothing = TextureSmoothing.NONE;

			lid.touchable = false;
			lid.x = 255;
			lid.y = 128;
			
			bar = new Image(this.assets.getTexture('off_bar'));
			bar.smoothing = TextureSmoothing.NONE;

			bar.touchable = false;
			bar.x = 390;
			bar.y = 254;
			
			discA = new Image(this.assets.getTexture('disc_B01'));
			discA.touchable = false;
			discA.pivotX = 154;
			discA.pivotY = 154;
			discA.x = 133;
			discA.y = 135;
			
			
			discB = new Image(this.assets.getTexture('disc_C01'));
			discB.touchable = false;
			discB.pivotX = 134.5;
			discB.pivotY = 134.5;
			discB.x = 226;
			discB.y = 350;
			
			discC = new Image(this.assets.getTexture('disc_A02'));
			discC.touchable = false;
			discC.pivotX = 145;
			discC.pivotY = 145;
			discC.x = 640;
			discC.y = 259
				
			plasma = new Image(this.assets.getTexture('on_plasma_closed'));
			plasma.smoothing = TextureSmoothing.NONE;

			plasma.touchable = false;
			plasma.x = 398;
			plasma.y = 174;	
			
			anima_laser = new Image(this.assets.getTexture('anima_lasers'));
			anima_laser.smoothing = TextureSmoothing.NONE;

			anima_laser.touchable = false;
			anima_laser.x = 370;
			anima_laser.y = 193;	
			anima_laser.alpha = 0;
			
			anima_glowing = new Image(this.assets.getTexture('anima_glow'));
			anima_glowing.smoothing = TextureSmoothing.NONE;

			anima_glowing.touchable = false;
			anima_glowing.x = 367;
			anima_glowing.y = 193;	
			anima_glowing.alpha = 0;
			
			anima_red = new Image(this.assets.getTexture('anima_red'));
			anima_red.smoothing = TextureSmoothing.NONE;

			anima_red.touchable = false;
			anima_red.x = 277;
			anima_red.y = 83;	
			anima_red.alpha = 0;
			
			anima_teleport = new Image(this.assets.getTexture('anima_teleport'));
			anima_teleport.smoothing = TextureSmoothing.NONE;

			anima_teleport.touchable = false;
			anima_teleport.x = 363;
			anima_teleport.y = 149;	
			anima_teleport.alpha = 0;
			/*
			private var anima_laser:Image;
			private var anima_glowing:Image;
			private var anima_red:Image;
			private var anima_teleport:Image;
			*/
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipPuzzle['Unlocked'] == 'Yes'){
					LightsOn = true;
					bg.texture = this.assets.getTexture('spaceShipOven_bg_lit');
					lid.texture =  this.assets.getTexture('on_lid_closed');
					bar.texture = this.assets.getTexture('on_bar');
					
					discA.alpha = 1;
					discB.alpha = 1;
					discC.alpha = 1;
					
					CreateDiscHits();
					this.addEventListener(EnterFrameEvent.ENTER_FRAME, RotateDiscs);
				}else{
					discA.alpha = 0;
					discB.alpha = 0;
					discC.alpha = 0;
				}
				
			}else{
				discA.alpha = 0;
				discB.alpha = 0;
				discC.alpha = 0;
			}
			
		
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Lid'] == 'Open'){
					LidOpen = true;
					lid.alpha = 0;
					CreateChamberHit();
				}else{
					lid.alpha = 1;
				}
				
				if(LidOpen === true){
					if(LightsOn === true){			
						bar.texture = this.assets.getTexture('on_bar');
						plasma.texture = this.assets.getTexture('on_plasma')

						
					}else{
						bar.texture = this.assets.getTexture('off_bar');
					}
				}else{
					if(LightsOn === true){
						bar.texture = this.assets.getTexture('on_bar_closed');
						plasma.texture = this.assets.getTexture('on_plasma_closed')
					}else{
						bar.texture = this.assets.getTexture('off_bar_closed');
					}
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Bar'] == 'Attached'){
					BarAttached = true;
					bar.alpha = 1;
					plasma.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Bar'] == 'Processed'){
					BarAttached = true;
					BarProcessed = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Plasma'] == 'PickedUp'){
						plasma.alpha = 0;
					}else{
						plasma.alpha = 1;
					}
					
					bar.alpha = 0;
				}else{
					plasma.alpha = 0;
					bar.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['DiscA'] == 'On'){
					DiscAOn = true;
					discA.texture = this.assets.getTexture('disc_B02');
				}else{
					
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['DiscB'] == 'On'){
					DiscBOn = true;
					discB.texture = this.assets.getTexture('disc_C02');
				}else{
					
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Lid'] == 'Closed'){
					if(DiscAOn === true){
						if(DiscBOn === true){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Bar'] == 'Attached'){
								discC.texture = this.assets.getTexture('disc_A01');	
							}
							
						}
					}
				}
				
				
			}else{
				lid.alpha = 1;
				bar.alpha = 0;
				plasma.alpha = 0;
				
			}
			
			
			
			this.addChildAt(bg,0);
			this.addChildAt(lid,1);
			this.addChildAt(bar,2);
			this.addChildAt(plasma,3);
			this.addChildAt(anima_laser,4);
			this.addChildAt(anima_glowing,5);
			this.addChildAt(anima_red,6);
			this.addChildAt(anima_teleport,7);
			
			this.addChildAt(discA,4);
			this.addChildAt(discB,5);
			this.addChildAt(discC,6);
			CreateLeftHit();
			CreateRightHit();
			CreateTubeHit();
			CreateLidHit(LidOpen);
		
			//FadeOutOcean(1);
			CreateDiscHits();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
						
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			
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
		}
		
		
		private function CreateLeftHit():void{
			hit_left = new Shape();
			hit_left.touchable = false;
			hit_left.graphics.beginFill(0xff0000);
			
			hit_left.graphics.lineTo(41,148);	
			hit_left.graphics.lineTo(164,109);	
			hit_left.graphics.lineTo(211,133);	
			hit_left.graphics.lineTo(260,504);	
			hit_left.graphics.lineTo(141,503);	
		
			hit_left.graphics.endFill(false);
			hit_left.alpha = 0.0;
			
			hit_left.graphics.precisionHitTest = true;	
			this.addChild(hit_left);
		}
		private function CreateRightHit():void{
			hit_right = new Shape();
			hit_right.touchable = false;
			hit_right.graphics.beginFill(0xff0000);
			
			hit_right.graphics.lineTo(606,134);	
			hit_right.graphics.lineTo(739,141);	
			hit_right.graphics.lineTo(765,379);	
			hit_right.graphics.lineTo(640,404);	
					
			hit_right.graphics.endFill(false);
			hit_right.alpha = 0.0;
			
			hit_right.graphics.precisionHitTest = true;	
			this.addChild(hit_right);
		}
		
		private function CreateTubeHit():void{
			hit_tube = new Shape();
			hit_tube.touchable = false;
			hit_tube.graphics.beginFill(0xff0000);
			
			hit_tube.graphics.lineTo(229,0);	
			hit_tube.graphics.lineTo(537,0);	
			hit_tube.graphics.lineTo(594,504);	
			hit_tube.graphics.lineTo(288,505);	
			
			hit_tube.graphics.endFill(false);
			hit_tube.alpha = 0.0;
			
			hit_tube.graphics.precisionHitTest = true;	
			this.addChild(hit_tube);
		}
		
		private function CreateDiscHits():void{
			hit_discA = new Shape();
			hit_discA.touchable = false;
			hit_discA.graphics.beginFill(0xff0000);
			
			hit_discA.graphics.lineTo(13,128);	
			hit_discA.graphics.lineTo(43,49);	
			hit_discA.graphics.lineTo(133,14);	
			hit_discA.graphics.lineTo(217,70);	
			hit_discA.graphics.lineTo(238,140);	
			hit_discA.graphics.lineTo(196,215);	
			hit_discA.graphics.lineTo(130,244);	
			hit_discA.graphics.lineTo(49,213);	
			hit_discA.graphics.endFill(false);
			hit_discA.alpha = 0.0;
			
			hit_discA.graphics.precisionHitTest = true;	
			this.addChild(hit_discA);
			
			
			hit_discB = new Shape();
			hit_discB.touchable = false;
			hit_discB.graphics.beginFill(0xff0000);
			
			hit_discB.graphics.lineTo(118,360);	
			hit_discB.graphics.lineTo(144,281);	
			hit_discB.graphics.lineTo(224,240);	
			hit_discB.graphics.lineTo(304,273);	
			hit_discB.graphics.lineTo(333,350);	
			hit_discB.graphics.lineTo(303,425);	
			hit_discB.graphics.lineTo(227,460);	
			hit_discB.graphics.lineTo(158,433);	

			hit_discB.graphics.endFill(false);
			hit_discB.alpha = 0.0;
			
			hit_discB.graphics.precisionHitTest = true;	
			this.addChild(hit_discB);
			
			hit_discC = new Shape();
			hit_discC.touchable = false;
			hit_discC.graphics.beginFill(0xff0000);
			
			hit_discC.graphics.lineTo(521,268);	
			hit_discC.graphics.lineTo(553,173);	
			hit_discC.graphics.lineTo(636,138);	
			hit_discC.graphics.lineTo(728,178);	
			hit_discC.graphics.lineTo(755,261);	
			hit_discC.graphics.lineTo(717,343);	
			hit_discC.graphics.lineTo(645,373);	
			hit_discC.graphics.lineTo(556,343);	
		
			hit_discC.graphics.endFill(false);
			hit_discC.alpha = 0.0;
			
			hit_discC.graphics.precisionHitTest = true;	
			this.addChild(hit_discC);
		}
		
		
		private function CreateChamberHit():void{
			hit_chamber = new Shape();
			hit_chamber.touchable = false;
			hit_chamber.graphics.beginFill(0xff0000);

			hit_chamber.graphics.lineTo(350,160);	
			hit_chamber.graphics.lineTo(468,144);	
			hit_chamber.graphics.lineTo(492,290);	
			hit_chamber.graphics.lineTo(373,309);	
			hit_chamber.graphics.endFill(false);
			hit_chamber.alpha = 0.0;
			
			hit_chamber.graphics.precisionHitTest = true;	
			this.addChild(hit_chamber);
		}
		
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(329,147);	
				hit_lid.graphics.lineTo(482,123);	
				hit_lid.graphics.lineTo(514,302);	
				hit_lid.graphics.lineTo(358,327);	
			
				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(263,154);
				hit_lid.graphics.lineTo(345,164);
				hit_lid.graphics.lineTo(368,310);
				hit_lid.graphics.lineTo(291,330);
				
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			this.addChild(hit_lid);
			
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
							FadeOut((SpaceShipInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SpaceShipInteriorObj,true
							);
							
						}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							LidHandler();
						}else if(LidOpen === true){
							if(hit_chamber.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								ChamberHandler();
							}else if(hit_tube.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(LightsOn === true){
									if(BarProcessed === false){
										if(PhraseCounter == 0){
											PhraseCounter = 1;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The machine emits an unearthly blue glow.");
											
										}else if(PhraseCounter == 1){
											PhraseCounter = 0;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The circuits inside buzz with activity.");
											
										}
									}else{
										if(PhraseCounter == 0){
											PhraseCounter = 1;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This machine must be a teleporter, or some sort of matter converter.");
											
										}else if(PhraseCounter == 1){
											PhraseCounter = 0;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The technology is light years beyond anything I've experienced.");
											
										}
									}
								}else{
									if(hit_tube.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										if(PhraseCounter == 0){
											PhraseCounter = 1;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A thick glass tube encased sophisticated electronics.");
											
										}else if(PhraseCounter == 1){
											PhraseCounter = 0;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can only imagine what this machine does.");
											
										}
									}
								}
							}
						}
						
						 if(LightsOn === true){
							if(hit_discA.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								DiscHandler('A');
							}else if(hit_discB.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								DiscHandler('B');
							}else if(hit_discC.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(BarProcessed === false){
									DoAnimation();
								}else{
							//		(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I t.");
									
								}
							}
						}else{
								if(hit_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									if(PhraseCounter == 0){
										PhraseCounter = 1;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The controls on this panel don't appear to be functioning.");

									}else if(PhraseCounter == 1){
										PhraseCounter = 0;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This panel isn't turned on.");

									}
								}else if(hit_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									if(PhraseCounter == 0){
										PhraseCounter = 1;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The control panel appears to be offline.");

									}else if(PhraseCounter == 1){
										PhraseCounter = 0;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Nothing happens when I press the buttons on this panel.");

									}
								}
							/*
							private var PhraseCounter:Shape;
							private var hit_left:Shape;
							private var hit_right:Shape;
							private var hit_tube:Shape;
							*/
						}
					}
				}
			}
		}
		
		private function DoAnimation():void{
			if(DiscBOn === true){
				if(DiscAOn === true){
					if(LidOpen === false){
						if(BarAttached === true){
							Animating = true;
							BarProcessed = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
							}
							SaveArray["Bar"] = "Processed";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiTwo();

							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
							
							LaserTween = new Tween(anima_laser, 2, Transitions.LINEAR);
							LaserTween.fadeTo(1);
							LaserTween.onComplete = function():void{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicRays();
								//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicProcess();
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
								
								AnimateGlow();
								anima_laser.alpha = 0;
								LaserTween = null
							}
							Starling.juggler.add(LaserTween);
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("hmm... This disc won't engage.");

							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
						}
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("hmm... This disc won't engage.");

						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("hmm... This disc won't engage.");

					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("hmm... This disc won't engage.");

				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ErrorTwo();
			}

		}
		private function AnimateGlow():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicRays();
			GlowTween = new Tween(anima_glowing, 2, Transitions.EASE_OUT);
			GlowTween.fadeTo(1);
			GlowTween.onComplete = function():void{
				
				AnimateRed();
				
				bar.alpha = 0;
				GlowTween = null;
				
			}
			Starling.juggler.add(GlowTween);
		}
		
		private function AnimateRed():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SciFiTransPorter();
			anima_red.alpha = 1;
			RedTween = new Tween(anima_red, 2, Transitions.EASE_OUT_IN_BOUNCE);
			RedTween.fadeTo(0);
			RedTween.onComplete = function():void{
				TeleportFadeIn()
				anima_red.alpha = 0;
				anima_glowing.alpha = 0;
				RedTween = null;
			}
			Starling.juggler.add(RedTween);
		}
		
		private function TeleportFadeIn():void{
			TeleportTween = new Tween(anima_teleport, 3, Transitions.EASE_IN);
			TeleportTween.fadeTo(1);
			TeleportTween.onComplete = function():void{
				TeleportFadeOut();
				
				plasma.alpha = 1;
			}
			Starling.juggler.add(TeleportTween);

		}
		
		private function TeleportFadeOut():void{
			TeleportTween = new Tween(anima_teleport, 3, Transitions.LINEAR);
			TeleportTween.fadeTo(0);
			TeleportTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
				TeleportTween = null;
				Animating = false;
			}
			Starling.juggler.add(TeleportTween);
			
		}
		/*
		private var LaserTween:Tween;
		private var GlowTween:Tween;
		private var RedTween:Tween;
		private var TeleportTween:Tween;
		
		private var LaserTween:Tween;
		private var GlowTween:Tween;
		private var RedTween:Tween;
		private var TeleportTween:Tween;
		
		
		*/
		
		private function RotateDiscs(e:Event):void{
			discA.rotation = discA.rotation+deg2rad(3);
			discB.rotation = discB.rotation+deg2rad(3);
			discC.rotation = discC.rotation-deg2rad(3);
		}
		
		private function DiscHandler(Disc:String):void{
			trace("DiscHANDLER");
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
			}
			
			if(Disc == 'A'){
				if(DiscAOn === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFi();
					SaveArray["DiscA"] = "On";
					DiscAOn = true;
					discA.texture = this.assets.getTexture('disc_B02');
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiTwo();
					SaveArray["DiscA"] = "Off";
					DiscAOn = false;
					discA.texture = this.assets.getTexture('disc_B01');
				}
				
				if(DiscBOn === true){
					if(LidOpen === false){
						if(BarAttached === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiThree();
							discC.texture = this.assets.getTexture('disc_A01');
						}else{
							discC.texture = this.assets.getTexture('disc_A02');
						}
					}else{
						discC.texture = this.assets.getTexture('disc_A02');
					}
				}else{
					discC.texture = this.assets.getTexture('disc_A02');
				}
				
			}else if(Disc == 'B'){
				if(DiscBOn === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFi();
						SaveArray["DiscB"] = "On";
						DiscBOn = true;
						discB.texture = this.assets.getTexture('disc_C02');
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiTwo();
						SaveArray["DiscB"] = "Off";
						DiscBOn = false;
						discB.texture = this.assets.getTexture('disc_C01');
				}
				
				
				if(DiscAOn === true){
					if(LidOpen === false){
						if(BarAttached === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiThree();
							discC.texture = this.assets.getTexture('disc_A01');
						}else{
							discC.texture = this.assets.getTexture('disc_A02');
						}
					}else{
						discC.texture = this.assets.getTexture('disc_A02');
					}
				}else{
					discC.texture = this.assets.getTexture('disc_A02');
				}
			
			}
			
		
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
				
		}
		
		private function ChamberHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Iridium)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				BarAttached = true;
				bar.alpha = 1;
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Iridium,
						"item_Iridium"
					);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
				}
				SaveArray["Bar"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
				
				
			}else{
				if(BarAttached === true){
					if(BarProcessed === false){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						BarAttached = false;
						bar.alpha = 0;
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Iridium,
							'item_Iridium',
							'inven_iridium_sm'
						);	
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
						}
						SaveArray["Bar"] = "PickedUp";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
					}else{
						PlasmaHandler();
					}
				}else{
					if(LightsOn === false){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a platform inside the chamber, with three nozzles pointed at the center.");

					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The interior of the chamber is now illuminated.");

					}
				}
				
				
			}
			
				
				
		}
		
		private function PlasmaHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven['Plasma'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					plasma.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
					}
					SaveArray['Plasma'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Plasma,
						'item_Plasma',
						'inven_plasma_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				plasma.alpha = 0;
				SaveArray['Plasma'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Plasma,
					'item_Plasma',
					'inven_plasma_sm'
				);	
			}
		}
		
		private function LidHandler():void{
			if(LidOpen === false){
				
								LidOpen = true;
				lid.alpha = 0;
				hit_lid._graphics.clear();
				CreateLidHit(true);
				CreateChamberHit();
				
				
				if(LightsOn == true){
					bar.texture = this.assets.getTexture('on_bar');
					plasma.texture = this.assets.getTexture('on_plasma');
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_AirRelease();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicDoor();

				}else{
					bar.texture = this.assets.getTexture('off_bar');
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();

				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
				}
				SaveArray["Lid"] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
				
				
				discC.texture = this.assets.getTexture('disc_A02');
				
				
			}else{
				LidOpen = false;
				lid.alpha = 1;
				hit_lid._graphics.clear();
				this.removeChild(hit_chamber);
				CreateLidHit(false);
				
				if(LightsOn == true){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowerUp();
					bar.texture = this.assets.getTexture('on_bar_closed');
					plasma.texture = this.assets.getTexture('on_plasma_closed')
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyClose();

					bar.texture = this.assets.getTexture('off_bar_closed');
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipOven;
				}
				SaveArray["Lid"] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipOven',SaveArray);
				if(DiscAOn === true){
					if(DiscBOn === true){
						if(LidOpen === false){
							if(BarAttached === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ClickSciFiThree();
								
								discC.texture = this.assets.getTexture('disc_A01');
							}
						}
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
			
			
		//	this.assets.removeTexture("spaceShipOven_bg",true);
			this.assets.removeTexture("SpaceShipOven_Sprite_01",true);
			this.assets.removeTextureAtlas("SpaceShipOven_Sprite_01",true);
			this.assets.removeTexture("SpaceShipOven_Sprite_02",true);
			this.assets.removeTextureAtlas("SpaceShipOven_Sprite_02",true);
			this.assets.removeTexture("SpaceShipOven_Sprite_03",true);
			this.assets.removeTextureAtlas("SpaceShipOven_Sprite_03",true);
			(stage.getChildAt(0) as Object).falseAsset("spaceShipOven_01");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipOven_02");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipOven_03");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipOven_04");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipOven_05");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipOven_06");
		///	(stage.getChildAt(0) as Object).falseAsset("spaceShipOven_05");
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