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
	
	public class SubmarineInterior extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var hatch:Image;
		private var rope:Image;
		
		private var door:Image;
		private var console_on:Image;
		private var console_wires:Image;
		private var console_screens:Image;
		private var periscope:Image;
	
		
		private var hit_SubmarineDoor:Shape;
		private var hit_SubmarineLowerLevel:Shape;
		private var hit_beam:Shape;
		private var hit_hatch:Shape;
		private var hit_console:Shape;
		private var hit_door:Shape;
		private var hit_SubmarineCaptains:Shape;
		
		private var hit_wires:Shape;
		private var hit_periscopeTop:Shape;
		private var hit_gage:Shape;
		private var hit_pipes:Shape;
		private var hit_instrument:Shape;
		private var hit_periscopeDown:Shape;
		
		private var HatchOpen:Boolean = false;
		private var RopeAttached:Boolean = false;
		private var LightsOn:Boolean = false;
		private var WiresSolved:Boolean = false;
		private var ScreensOn:Boolean = false;
		private var DoorOpen:Boolean = false;
		private var PeriscopeDown:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function SubmarineInterior(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineInterior_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineInterior/submarineInterior_Sprite_02.jpg'));
				game.TrackAssets('submarineInterior_01');
			}
			if(game.CheckAsset('submarineInterior_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineInterior/submarineInterior_Sprite_02.xml'));
				game.TrackAssets('submarineInterior_02');
			}
			if(game.CheckAsset('submarineInterior_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineInterior/submarineInterior_Sprite.png'));
				game.TrackAssets('submarineInterior_03');
			}
			if(game.CheckAsset('submarineInterior_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineInterior/submarineInterior_Sprite.xml'));
				game.TrackAssets('submarineInterior_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineInterior","SubmarineInteriorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineInterior_bg_red'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			
			hatch = new Image(this.assets.getTexture('hatch_open_red'));
			//hatch.smoothing = TextureSmoothing.NONE;

			hatch.touchable = false;
			hatch.x = 164;
			hatch.y = 223;
			
			/*
			private var door:Image;
			private var console_on:Image;
			private var console_wires:Image;
			private var periscope:Image;
			*/
			door = new Image(this.assets.getTexture('door'));
	//		door.smoothing = TextureSmoothing.NONE;

			door.touchable = true;
			door.x = 67;
			door.y = 69;
			
			rope = new Image(this.assets.getTexture('rope_red_lidOpen'));
	//		rope.smoothing = TextureSmoothing.NONE;

			rope.touchable = false;
			rope.x = 46;
			rope.y = 315;
			
			console_on = new Image(this.assets.getTexture('console_lit'));
	//		console_on.smoothing = TextureSmoothing.NONE;

			console_on.touchable = false;
			console_on.x = 337;
			console_on.y = 84;
			
			console_screens = new Image(this.assets.getTexture('console_screen'));
		//	console_screens.smoothing = TextureSmoothing.NONE;

			console_screens.touchable = false;
			console_screens.x = 487;
			console_screens.y = 112;
			
			console_wires = new Image(this.assets.getTexture('wires_red'));
		//	console_wires.smoothing = TextureSmoothing.NONE;

			console_wires.touchable = false;
			console_wires.x = 565;
			console_wires.y = 233;
			
			periscope = new Image(this.assets.getTexture('periscope'));
	//		periscope.smoothing = TextureSmoothing.NONE;

			periscope.touchable = false;
			periscope.x = 290;
			periscope.y = 41;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					bg.texture = this.assets.getTexture('submarineInterior_bg_lit');
					hatch.texture = this.assets.getTexture('hatch_open_lit');
					console_wires.texture = this.assets.getTexture('wires_lit_off');
					door.alpha = 1;
					periscope.alpha = 0;
					LightsOn = true;
				}else{
					door.alpha = 0;
					periscope.alpha = 0;
				}
			}else{
				door.alpha = 0;
				periscope.alpha = 0;
			}
			
			//door.alpha = 0;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['Solved'] == 'Yes'){
					trace("The console is solved");
					console_wires.texture = this.assets.getTexture('wires_lit_on');
					console_on.alpha = 1;
					
					WiresSolved = true;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole['ScreensOn'] == 'yes'){
						ScreensOn = true;
						console_screens.alpha = 0;
					}else{
						console_screens.alpha = 1;
					}
					
				}else{
					console_on.alpha = 0;
					console_screens.alpha = 0;
				}
			}else{
				console_on.alpha = 0;
				console_screens.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineConsole['Panel'] == 'open'){
					console_wires.alpha = 1;
				}else{
					console_wires.alpha = 0;
				}
			}else{
				console_wires.alpha = 0;
			}
				
			//submarineInterior_bg_lit
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior['Hatch'] == 'Open'){
					HatchOpen = true;
					hatch.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior['Rope'] == 'Attached'){
						RopeAttached = true;
						if(LightsOn === true){
							rope.alpha = 0;
						}else{
							rope.alpha = 1;
						}
					}else{
						RopeAttached = false;
						rope.alpha = 0;
					}
				}else{
					HatchOpen = false;
					hatch.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior['Rope'] == 'Attached'){
						RopeAttached = true;
						rope.texture = this.assets.getTexture('rope_red_lidClose')
						if(LightsOn === true){
							rope.alpha = 0;
						}else{
							rope.alpha = 1;
						}
					}else{
						RopeAttached = false;
						rope.alpha = 0;
					}
				}
				if(WiresSolved === true){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior['Periscope'] == 'Down'){
						periscope.alpha = 1;
					}else{
						periscope.alpha = 0;
					}
				}else{
					periscope.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior['Door'] == 'open'){
					DoorOpen = true;
					door.alpha = 0;
					
					CreateHitSubmarineCaptains();
				}else{
					DoorOpen = false;
					if(LightsOn === true){
						door.alpha = 1;
					}else{
						door.alpha = 0;
					}
				}
				
			}else{
				
				hatch.alpha = 0;
				rope.alpha = 0;
				periscope.alpha = 0;
			}
			
			this.addChildAt(console_on,1);
			this.addChildAt(hatch,2);		
			this.addChildAt(door,3);		
			this.addChildAt(rope,4);
			
			this.addChildAt(console_screens,5);
			this.addChildAt(console_wires,6);
			this.addChildAt(periscope,7);
			//rope_red_lidOpen
			
			//FadeOutOcean(1);
			CreateHitPipes();
			CreateHitInstruments();
			CreateHitWires();
			CreateHitPeriscopeTop();
			CreateHitPeriscopeDown();
			CreateHitGage();
			
			
			CreateHitSubmarineDoor();
			CreateHitConsole();
			CreateHatchHit(HatchOpen);
			CreateHitBeam();
			CreateDoorHit(DoorOpen);
			if(HatchOpen === true){
				CreateHitSubmarineLowerLevel();
			}
			
		//	goback = new GoBackButton(this.assets);
		//	this.addChild(goback);
			
			
		//	CreateHitSubmarineLowerLevel();
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Sonar",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("WindOne",0,0.5,'stop');
		//	(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("WindOne",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDrips(true,999);
			
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,2);
						},0.4);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,2);
					},0.4);
				}
			}
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,2);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'CaveDrips';
			},0.7);
	
			
		}
		//hit_console
		//hit_periscopeDown
		private function CreateHitPeriscopeDown():void{
			hit_periscopeDown = new Shape();
			hit_periscopeDown.touchable = false;
			hit_periscopeDown.graphics.beginFill(0x00ff00);
			
			hit_periscopeDown.graphics.lineTo(284,168);	
			hit_periscopeDown.graphics.lineTo(291,142);	
			hit_periscopeDown.graphics.lineTo(331,106);	
			hit_periscopeDown.graphics.lineTo(420,128);	
			hit_periscopeDown.graphics.lineTo(437,196);	
			hit_periscopeDown.graphics.lineTo(380,219);	
			hit_periscopeDown.graphics.lineTo(339,209);	
			
			
			hit_periscopeDown.alpha = 0.0;
			hit_periscopeDown.graphics.endFill(false);
			hit_periscopeDown.graphics.precisionHitTest = true;	
			this.addChild(hit_periscopeDown);
			
		}	
		
		private function CreateHitPipes():void{
			hit_pipes = new Shape();
			hit_pipes.touchable = false;
			hit_pipes.graphics.beginFill(0x00ff00);
			
			hit_pipes.graphics.lineTo(149,0);	
			hit_pipes.graphics.lineTo(648,0);	
			hit_pipes.graphics.lineTo(645,86);	
			hit_pipes.graphics.lineTo(420,119);	
			hit_pipes.graphics.lineTo(160,34);	
			
			hit_pipes.alpha = 0.0;
			hit_pipes.graphics.endFill(false);
			hit_pipes.graphics.precisionHitTest = true;	
			this.addChild(hit_pipes);
			
		}	
		
		private function CreateHitInstruments():void{
			hit_instrument = new Shape();
			hit_instrument.touchable = false;
			hit_instrument.graphics.beginFill(0x00ff00);
			
			hit_instrument.graphics.lineTo(181,286);	
			hit_instrument.graphics.lineTo(195,243);	
			hit_instrument.graphics.lineTo(315,212);	
			hit_instrument.graphics.lineTo(419,237);	
			hit_instrument.graphics.lineTo(408,291);	
			hit_instrument.graphics.lineTo(337,273);	
			hit_instrument.graphics.lineTo(322,325);				
			
			hit_instrument.alpha = 0.0;
			hit_instrument.graphics.endFill(false);
			hit_instrument.graphics.precisionHitTest = true;	
			this.addChild(hit_instrument);
			
		}	
		
		private function CreateHitGage():void{
			hit_gage = new Shape();
			hit_gage.touchable = false;
			hit_gage.graphics.beginFill(0x00ff00);
			
			hit_gage.graphics.lineTo(46,0);	
			hit_gage.graphics.lineTo(125,8);	
			hit_gage.graphics.lineTo(58,211);	
			hit_gage.graphics.lineTo(8,197);	
			
			hit_gage.alpha = 0.0;
			hit_gage.graphics.endFill(false);
			hit_gage.graphics.precisionHitTest = true;	
			this.addChild(hit_gage);
			
		}	
		
		private function CreateHitPeriscopeTop():void{
			hit_periscopeTop = new Shape();
			hit_periscopeTop.touchable = false;
			hit_periscopeTop.graphics.beginFill(0x00ff00);
			
			hit_periscopeTop.graphics.lineTo(345,51);	
			hit_periscopeTop.graphics.lineTo(378,40);	
			hit_periscopeTop.graphics.lineTo(443,56);	
			hit_periscopeTop.graphics.lineTo(416,124);	
			hit_periscopeTop.graphics.lineTo(340,110);	
			
			hit_periscopeTop.alpha = 0.0;
			hit_periscopeTop.graphics.endFill(false);
			hit_periscopeTop.graphics.precisionHitTest = true;	
			this.addChild(hit_periscopeTop);
			
		}		
		
		private function CreateHitWires():void{
			hit_wires = new Shape();
			hit_wires.touchable = false;
			hit_wires.graphics.beginFill(0x00ff00);
			
			hit_wires.graphics.lineTo(509,139);	
			hit_wires.graphics.lineTo(539,0);	
			hit_wires.graphics.lineTo(585,0);	
			hit_wires.graphics.lineTo(613,135);	
			
			hit_wires.alpha = 0.0;
			hit_wires.graphics.endFill(false);
			hit_wires.graphics.precisionHitTest = true;	
			this.addChild(hit_wires);
			
		}		

		private function CreateDoorHit(open:Boolean = false):void{
			hit_door = new Shape();
			
			if(open === false){
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x0000FF);
				
				hit_door.graphics.lineTo(116,85);
				hit_door.graphics.lineTo(168,55);
				hit_door.graphics.lineTo(243,81);
				hit_door.graphics.lineTo(260,120);
				hit_door.graphics.lineTo(236,240);
				hit_door.graphics.lineTo(190,237);
				hit_door.graphics.lineTo(173,287);
				hit_door.graphics.lineTo(115,277);
				hit_door.graphics.lineTo(87,206);
				
				hit_door.graphics.endFill(false);
				
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;	
			}else{
				
				hit_door.x = 0;
				hit_door.y = 0;
				hit_door.graphics.beginFill(0x0000FF);		
				
				hit_door.graphics.lineTo(123,76);	
				hit_door.graphics.lineTo(158,67);	
				hit_door.graphics.lineTo(170,78);	
				hit_door.graphics.lineTo(133,260);	
				hit_door.graphics.lineTo(116,257);	
				hit_door.graphics.lineTo(91,221);	

				hit_door.graphics.endFill(false);
				hit_door.alpha = 0.0;
				
				hit_door.graphics.precisionHitTest = true;				
			}
			hit_door.touchable = false;
			this.addChild(hit_door);
			
		}	
		
		
		private function CreateHitConsole():void{
			hit_console = new Shape();
			hit_console.touchable = false;
			hit_console.graphics.beginFill(0x00ff00);
			
			hit_console.graphics.lineTo(505,151);	
			hit_console.graphics.lineTo(632,142);	
			hit_console.graphics.lineTo(671,165);	
			hit_console.graphics.lineTo(670,204);	
			hit_console.graphics.lineTo(619,394);	
			hit_console.graphics.lineTo(561,452);	
			hit_console.graphics.lineTo(455,426);	

			hit_console.alpha = 0.0;
			hit_console.graphics.endFill(false);
			hit_console.graphics.precisionHitTest = true;	
			this.addChild(hit_console);
			
		}
		
		private function CreateHitSubmarineLowerLevel():void{
			hit_SubmarineLowerLevel = new Shape();
			hit_SubmarineLowerLevel.touchable = false;
			hit_SubmarineLowerLevel.graphics.beginFill(0x00ff00);
			
			hit_SubmarineLowerLevel.graphics.lineTo(151,388);	
			hit_SubmarineLowerLevel.graphics.lineTo(158,357);	
			hit_SubmarineLowerLevel.graphics.lineTo(191,346);	
			hit_SubmarineLowerLevel.graphics.lineTo(261,348);	
			hit_SubmarineLowerLevel.graphics.lineTo(340,373);	
			hit_SubmarineLowerLevel.graphics.lineTo(355,389);	
			hit_SubmarineLowerLevel.graphics.lineTo(350,430);	
			hit_SubmarineLowerLevel.graphics.lineTo(256,435);	
			hit_SubmarineLowerLevel.graphics.lineTo(178,412);	

			hit_SubmarineLowerLevel.alpha = 0.0;
			hit_SubmarineLowerLevel.graphics.endFill(false);
			hit_SubmarineLowerLevel.graphics.precisionHitTest = true;	
			this.addChild(hit_SubmarineLowerLevel);
			
		}
		//hit_beam
		//hit_SubmarineCaptains
		
		private function CreateHitSubmarineCaptains():void{
			hit_SubmarineCaptains = new Shape();
			hit_SubmarineCaptains.touchable = false;
			hit_SubmarineCaptains.graphics.beginFill(0x00ff00);
			
			hit_SubmarineCaptains.graphics.lineTo(172,78);	
			hit_SubmarineCaptains.graphics.lineTo(223,94);	
			hit_SubmarineCaptains.graphics.lineTo(242,133);	
			hit_SubmarineCaptains.graphics.lineTo(216,239);	
			hit_SubmarineCaptains.graphics.lineTo(182,266);	
			hit_SubmarineCaptains.graphics.lineTo(138,254);	

			hit_SubmarineCaptains.alpha = 0.0
			hit_SubmarineCaptains.graphics.endFill(false);
			hit_SubmarineCaptains.graphics.precisionHitTest = true;	
			this.addChild(hit_SubmarineCaptains);
			
		}
		
		private function CreateHitBeam():void{
			hit_beam = new Shape();
			hit_beam.touchable = false;
			hit_beam.graphics.beginFill(0x00ff00);
			
			hit_beam.graphics.lineTo(0,227);	
			hit_beam.graphics.lineTo(36,219);	
			hit_beam.graphics.lineTo(103,337);	
			hit_beam.graphics.lineTo(89,396);	
			hit_beam.graphics.lineTo(0,385);	

			hit_beam.alpha = 0.0;
			hit_beam.graphics.endFill(false);
			hit_beam.graphics.precisionHitTest = true;	
			this.addChild(hit_beam);
			
		}
		private function CreateHitSubmarineDoor():void{
			hit_SubmarineDoor = new Shape();
			hit_SubmarineDoor.touchable = false;
			hit_SubmarineDoor.graphics.beginFill(0xff0000);
			
			hit_SubmarineDoor.graphics.lineTo(658,0);	
			hit_SubmarineDoor.graphics.lineTo(800,0);	
			hit_SubmarineDoor.graphics.lineTo(800,512);	
			hit_SubmarineDoor.graphics.lineTo(603,512);	
			hit_SubmarineDoor.graphics.lineTo(697,113);	
			hit_SubmarineDoor.graphics.lineTo(641,71);	
			
			hit_SubmarineDoor.alpha = 0.0;
			hit_SubmarineDoor.graphics.endFill(false);
			hit_SubmarineDoor.graphics.precisionHitTest = true;	
			this.addChild(hit_SubmarineDoor);
					
		}
		
		private function CreateHatchHit(open:Boolean = false):void{
			hit_hatch = new Shape();
			
			if(open === false){
				
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);
				
				hit_hatch.graphics.lineTo(155,331);	
				hit_hatch.graphics.lineTo(196,315);	
				hit_hatch.graphics.lineTo(263,325);	
				hit_hatch.graphics.lineTo(363,350);	
				hit_hatch.graphics.lineTo(393,386);	
				hit_hatch.graphics.lineTo(376,456);	
				hit_hatch.graphics.lineTo(266,475);	
				hit_hatch.graphics.lineTo(121,432);	

				hit_hatch.graphics.endFill(false);
				
				hit_hatch.alpha = 0.0;
				
				hit_hatch.graphics.precisionHitTest = true;	
			}else{
				
				hit_hatch.x = 0;
				hit_hatch.y = 0;
				hit_hatch.graphics.beginFill(0x0000FF);		
				hit_hatch.graphics.lineTo(332,264);
				hit_hatch.graphics.lineTo(385,217);
				hit_hatch.graphics.lineTo(407,217);
				hit_hatch.graphics.lineTo(424,238);
				hit_hatch.graphics.lineTo(409,312);
				hit_hatch.graphics.lineTo(362,368);
				hit_hatch.graphics.lineTo(330,360);

				hit_hatch.graphics.endFill(false);
				hit_hatch.alpha = 0.0;
				
				hit_hatch.graphics.precisionHitTest = true;				
			}
			hit_hatch.touchable = false;
			this.addChild(hit_hatch);
			
		}	
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(hit_SubmarineDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalSteps();
						FadeOut((JungleSubmarineDoor as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleSubmarineDoorObj,false
						);
					}else if(hit_console.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((SubmarineConsole as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineConsoleObj,true
						);

					}else if(hit_hatch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						HatchHandler();
					}else if(hit_beam.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
						BeamHandler();
					}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){			
						DoorHandler();
					}else if(hit_periscopeTop.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
						if(LightsOn === true){
							if(ScreensOn === true){
								PeriscopeHandler();
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The periscope is still locked in place.");	
							}
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The periscope is locked in place.");	
						}
					//	private var LightsOn:Boolean = false;
					//	private var WiresSolved:Boolean = false;
					//	private var ScreensOn:Boolean = false;
						
					//	(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are several sturdy pipes running along the length of the room close to the floor.");	
					}else if(hit_wires.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Electrical wiring dangles from the ceiling.");					
					}else if(hit_gage.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Valves and nozzles line the wall.");
					}else if(hit_pipes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pipes drip with condensation.");
					}else if(hit_instrument.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Various instruments and gauges... I don't know what they do.");
					}else if(HatchOpen === true){
						if(hit_SubmarineLowerLevel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							LowerLevelHandler();
						}else{
							if(DoorOpen === true){
								if(hit_SubmarineCaptains.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									FadeOut((SubmarineCaptains as Class), 
										(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsObj,true
									);
								}
							}
							if(PeriscopeDown === true){
								if(hit_periscopeDown.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The periscope is no longer functional, only darkness shows.");
								}
							}
						}
					}else{
						if(DoorOpen === true){
							if(hit_SubmarineCaptains.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((SubmarineCaptains as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsObj,true
								);
							}
						}
						if(PeriscopeDown === true){
							if(hit_periscopeDown.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The periscope is no longer functional, only darkness shows.");
							}
						}
					}
					
					
				}
			}
		}
		private function PeriscopeHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Machine();
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior;
			}
			if(PeriscopeDown === false){
				PeriscopeDown = true;
				periscope.alpha = 1;
				SaveArray['Periscope'] = "Down";
			}else{
				PeriscopeDown = false;
				periscope.alpha = 0;
				SaveArray['Periscope'] = "Up";
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
		}
		
		private function DoorHandler():void{
			if(ScreensOn === true){
				if(DoorOpen === false){
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
					DoorOpen = true;
					door.alpha = 0;
					hit_door._graphics.clear();
					CreateDoorHit(true);
					CreateHitSubmarineCaptains();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior;
					}
					SaveArray['Door'] = "open";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyCloseTwo();
					trace("Door Unlocked");
					DoorOpen = false;
					door.alpha = 1;
					hit_door._graphics.clear();
					CreateDoorHit(false);
					
					this.removeChild(hit_SubmarineCaptains);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior;
					}
					SaveArray['Door'] = "closed";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
					
				}
				
			}else{
				if(LightsOn === true){
					if(WiresSolved === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've got to find a way to restore all the power to this section of the submarine if I'm going to open this door.");
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("hmm.. The door still won't open. It must be on the same circuit as the other electronics here.");
					}
				}else{
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The door is controlled by hydraulics. It's sealed and I won't be able to open it until I restore electrical power.");
				}
			}
		
		}
		
		//private var HatchOpen:Boolean = false;
		//private var RopeAttached:Boolean = false;
		private function LowerLevelHandler():void{
			if(RopeAttached === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RopeClimb();
				FadeOut((SubmarineLowerLevel as Class), 
					(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineLowerLevelObj,true
				);
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Rope)
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That's a great idea! But I have to find something to tie the rope to.");
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_CannonTorchBurning)
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Dropping the flaming torch down the hatch could be dangerous - I don't know what's down there!");
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					!= 
					false)
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Throwing that item down there won't accomplish anything.");
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ladder to next level appears broken. It's dark, and even if I don't get hurt jumping, I might not be able climb back up.");
				}
			}
		}
		//item_CannonTorchBurning
		private function BeamHandler():void{
			if(RopeAttached === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rope is tied securely around the pipe.");
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Rope)
				{
					if(HatchOpen === false){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I should open the hatch to the lower level first.");
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Knot();
						rope.alpha = 1;
						RopeAttached = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior;
						}
						SaveArray['Rope'] = "Attached";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
						
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_Rope,
								"item_Rope"
							);
					}
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are several sturdy pipes running along the length of the room close to the floor.");
				}
				/*
				
				*/
			}
		}
		
		private function HatchHandler():void{
			if(HatchOpen === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxClose();
				HatchOpen = false;
				hatch.alpha = 0;
				
				rope.texture = this.assets.getTexture('rope_red_lidClose')
				
				this.removeChild(hit_SubmarineLowerLevel);
				
				hit_hatch.graphics.clear();
				CreateHatchHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior;
				}
				SaveArray['Hatch'] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
				
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalBoxOpen();
				HatchOpen = true;
				hatch.alpha = 1;
				
				rope.texture = this.assets.getTexture('rope_red_lidOpen')
				
				CreateHitSubmarineLowerLevel();
				
				hit_hatch.graphics.clear();
				CreateHatchHit(true);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineInterior;
				}
				SaveArray['Hatch'] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineInterior',SaveArray);
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
			
			this.assets.removeTexture("submarineInterior_Sprite_02",true);
			this.assets.removeTextureAtlas("submarineInterior_Sprite_02",true);		
			this.assets.removeTexture("submarineInterior_Sprite",true);
			this.assets.removeTextureAtlas("submarineInterior_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineInterior_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineInterior_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineInterior_03");
			(stage.getChildAt(0) as Object).falseAsset("submarineInterior_04");
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
