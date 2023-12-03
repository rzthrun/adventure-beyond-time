package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class SubmarineLowerLevel extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var torpedo_left_door:Image;
		private var torpedo_right_door:Image;
		private var torpedo_left_open_sign:Image;
		private var torpedo_left_closed_sign:Image;
		private var torpedo_right_open_sign:Image;
		private var torpedo_right_closed_sign:Image;
		
		private var hit_SubmarineInterior:Shape;
		private var hit_Torpedos:Shape;
		private var hit_PowerMain:Shape;

		private var hit_roof:Shape;
		private var hit_loader:Shape;
		private var hit_ladder:Shape;
		
		private var Animating:Boolean = false;
		public var delayedcall:DelayedCall;
		private var LightsOn:Boolean = true;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function SubmarineLowerLevel(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineLowerLevel_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineLowerLevel/SubmarineLowerLevel_Sprite_02.jpg'));
				game.TrackAssets('submarineLowerLevel_01');
			}
			if(game.CheckAsset('submarineLowerLevel_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineLowerLevel/SubmarineLowerLevel_Sprite_02.xml'));
				game.TrackAssets('submarineLowerLevel_02');
			}
			if(game.CheckAsset('submarineLowerLevel_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineLowerLevel/SubmarineLowerLevel_Sprite.atf'));
				game.TrackAssets('submarineLowerLevel_03');
			}
			if(game.CheckAsset('submarineLowerLevel_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineLowerLevel/SubmarineLowerLevel_Sprite.xml'));
				game.TrackAssets('submarineLowerLevel_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineLowerLevel","SubmarineLowerLevelObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineLowerLevel_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			/*
			private var torpedo_left_door:Image;
			private var torpedo_right_door:Image;
			private var torpedo_left_open_sign:Image;
			private var torpedo_left_closed_sign:Image;
			private var torpedo_right_open_sign:Image;
			private var torpedo_right_closed_sign:Image;
			
			*/
			torpedo_left_door  = new Image(this.assets.getTexture('torpedo_bay_one_door'));
			torpedo_left_door.smoothing = TextureSmoothing.NONE;

			torpedo_left_door.touchable = false;
			torpedo_left_door.x = 125;
			torpedo_left_door.y = 188;
		
			
			torpedo_right_door  = new Image(this.assets.getTexture('torpedo_bay_two_door'));
			torpedo_right_door.smoothing = TextureSmoothing.NONE;

			torpedo_right_door.touchable = false;
			torpedo_right_door.x = 358;
			torpedo_right_door.y = 141;	
			
			
			torpedo_left_closed_sign = new Image(this.assets.getTexture('torpedo_closed_left'));
			torpedo_left_closed_sign.smoothing = TextureSmoothing.NONE;

			torpedo_left_closed_sign.touchable = false;
			torpedo_left_closed_sign.x = 237;
			torpedo_left_closed_sign.y = 120;	
			
			
			torpedo_left_open_sign = new Image(this.assets.getTexture('torpedo_open_left'));
			torpedo_left_open_sign.smoothing = TextureSmoothing.NONE;

			torpedo_left_open_sign.touchable = false;
			torpedo_left_open_sign.x = 242;
			torpedo_left_open_sign.y = 155;	
			
			
			torpedo_right_closed_sign = new Image(this.assets.getTexture('torpedo_closed_right'));
			torpedo_right_closed_sign.smoothing = TextureSmoothing.NONE;

			torpedo_right_closed_sign.touchable = false;
			torpedo_right_closed_sign.x = 333;
			torpedo_right_closed_sign.y = 105;	
			
			
			torpedo_right_open_sign = new Image(this.assets.getTexture('torpedo_open_right'));
			torpedo_right_open_sign.smoothing = TextureSmoothing.NONE;

			torpedo_right_open_sign.touchable = false;
			torpedo_right_open_sign.x = 338;
			torpedo_right_open_sign.y = 140;	
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				trace("1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					trace("2");
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel != undefined){
						trace("3");
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel['Lights'] == 'On'){
							trace("4");
							LightsOn = true;
							bg.texture = this.assets.getTexture('submarineLowerLevel_lit_bg');
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
								trace("3");
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['DoorLeft'] == 'open'){
									torpedo_left_door.alpha = 0;
									torpedo_left_open_sign.alpha = 1;
									torpedo_left_closed_sign.alpha = 0;
								}else{
									torpedo_left_door.alpha = 1;
									torpedo_left_open_sign.alpha = 0;
									torpedo_left_closed_sign.alpha = 1;
								}
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['DoorRight'] == 'open'){
									torpedo_right_door.alpha = 0;
									torpedo_right_open_sign.alpha = 1;
									torpedo_right_closed_sign.alpha = 0;
								}else{
									torpedo_right_door.alpha = 1;
									torpedo_right_open_sign.alpha = 0;
									torpedo_right_closed_sign.alpha = 1;
								}

							}else{
								torpedo_left_door.alpha = 1;
								torpedo_right_door.alpha = 1;
								torpedo_left_closed_sign.alpha = 1;
								torpedo_left_open_sign.alpha = 0;
								torpedo_right_closed_sign.alpha = 1;
								torpedo_right_open_sign.alpha = 0;
							}
							
						}else{
							trace("5");
							/*JUST ADDED THIS MAY SOLVE "SOLVE" BUG*/
			
							torpedo_left_door.alpha = 0;
							torpedo_right_door.alpha = 0;
							torpedo_left_closed_sign.alpha = 0;
							torpedo_left_open_sign.alpha = 0;
							torpedo_right_closed_sign.alpha = 0;
							torpedo_right_open_sign.alpha = 0;
							
							/*END JUST ADDED*/
							Animating = true;
													
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel;
							}
							SaveArray['Lights'] = 'On'; 
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineLowerLevel',SaveArray);	
							Starling.juggler.delayCall(TurnLightsOn,2);
						}
					}else{
						trace("6");
						/*JUST ADDED THIS MAY SOLVE "SOLVE" BUG*/
						
						torpedo_left_door.alpha = 0;
						torpedo_right_door.alpha = 0;
						torpedo_left_closed_sign.alpha = 0;
						torpedo_left_open_sign.alpha = 0;
						torpedo_right_closed_sign.alpha = 0;
						torpedo_right_open_sign.alpha = 0;
						
						/*END JUST ADDED*/
						Animating = true;
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel;
						}
						SaveArray['Lights'] = 'On'; 
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineLowerLevel',SaveArray);	
						Starling.juggler.delayCall(TurnLightsOn,2);

					}
				}else{
					trace("7");
					torpedo_left_door.alpha = 0;
					torpedo_right_door.alpha = 0;
					torpedo_left_closed_sign.alpha = 0;
					torpedo_left_open_sign.alpha = 0;
					torpedo_right_closed_sign.alpha = 0;
					torpedo_right_open_sign.alpha = 0;
					
				}
			}else{
				torpedo_left_door.alpha = 0;
				torpedo_right_door.alpha = 0;
				torpedo_left_closed_sign.alpha = 0;
				torpedo_left_open_sign.alpha = 0;
				torpedo_right_closed_sign.alpha = 0;
				torpedo_right_open_sign.alpha = 0;
				
			}
					
		
			
			this.addChildAt(torpedo_left_door,1);
			this.addChildAt(torpedo_right_door,2);			
			this.addChildAt(torpedo_left_closed_sign,3);		
			this.addChildAt(torpedo_left_open_sign,4);			
			this.addChildAt(torpedo_right_closed_sign,5);			
			this.addChildAt(torpedo_right_open_sign,6);
			
			CreateHitLadder()
			CreateHitLoader();
			CreateHitRoof();
			
			CreateHitPowerMain();
			CreateHitTorpedos();
			CreateHitSubmarineInterior();
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineLowerLevel;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineLowerLevel',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineLowerLevel',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,2);
					},0.5);
				}
			}
		}
		
		private function TurnLightsOn():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BigLight();
			//PlaySFX_BigLights
			Animating = false;
			LightsOn = true;
			
			bg.texture = this.assets.getTexture('submarineLowerLevel_lit_bg');
			
			torpedo_left_door.alpha = 1;
			torpedo_right_door.alpha = 1;
			torpedo_left_closed_sign.alpha = 1;
			torpedo_right_closed_sign.alpha = 1;
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,2);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadElectricHum(true,0);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'ShipGroansOne';
		//		(stage.getChildAt(0) as Object).MusicObj.LoadBeatDownOne(true,2);
			},1);

			
		}
		
		
		
		private function CreateHitLadder():void{
			hit_ladder = new Shape();
			hit_ladder.touchable = false;
			hit_ladder.graphics.beginFill(0x0000ff);
			
			hit_ladder.graphics.lineTo(8,319);	
			hit_ladder.graphics.lineTo(141,419);	
			hit_ladder.graphics.lineTo(295,412);	
			hit_ladder.graphics.lineTo(335,451);	
			hit_ladder.graphics.lineTo(184,512);	
			hit_ladder.graphics.lineTo(0,512);	
		
			hit_ladder.alpha = 0.0;
			
			hit_ladder.graphics.endFill(false);
			
			hit_ladder.graphics.precisionHitTest = true;	
			this.addChild(hit_ladder);
			
		}
		
		
		private function CreateHitLoader():void{
			hit_loader = new Shape();
			hit_loader.touchable = false;
			hit_loader.graphics.beginFill(0x0000ff);
			
			hit_loader.graphics.lineTo(341,346);	
			hit_loader.graphics.lineTo(500,307);	
			hit_loader.graphics.lineTo(614,358);	
			hit_loader.graphics.lineTo(616,422);	
			hit_loader.graphics.lineTo(409,481);	
			
			hit_loader.alpha = 0.0;
			
			hit_loader.graphics.endFill(false);
			
			hit_loader.graphics.precisionHitTest = true;	
			this.addChild(hit_loader);
			
		}
		
		private function CreateHitRoof():void{
			hit_roof = new Shape();
			hit_roof.touchable = false;
			hit_roof.graphics.beginFill(0x0000ff);
			
			hit_roof.graphics.lineTo(155,0);	
			hit_roof.graphics.lineTo(670,0);	
			hit_roof.graphics.lineTo(661,65);	
			hit_roof.graphics.lineTo(573,91);	
			hit_roof.graphics.lineTo(540,133);	
			hit_roof.graphics.lineTo(370,86);	
			hit_roof.graphics.lineTo(223,110);	
			hit_roof.graphics.lineTo(173,140);				
			
			hit_roof.alpha = 0.0;
			
			hit_roof.graphics.endFill(false);
			
			hit_roof.graphics.precisionHitTest = true;	
			this.addChild(hit_roof);
			
		}
		
		
		private function CreateHitPowerMain():void{
			hit_PowerMain = new Shape();
			hit_PowerMain.touchable = false;
			hit_PowerMain.graphics.beginFill(0x0000ff);
			
			hit_PowerMain.graphics.lineTo(561,142);	
			hit_PowerMain.graphics.lineTo(585,92);	
			hit_PowerMain.graphics.lineTo(671,72);	
			hit_PowerMain.graphics.lineTo(675,88);	
			hit_PowerMain.graphics.lineTo(678,133);	
			hit_PowerMain.graphics.lineTo(695,165);	
			hit_PowerMain.graphics.lineTo(703,174);	
			hit_PowerMain.graphics.lineTo(714,274);	
			hit_PowerMain.graphics.lineTo(596,261);	

			hit_PowerMain.alpha = 0.0;
			
			hit_PowerMain.graphics.endFill(false);
			
			hit_PowerMain.graphics.precisionHitTest = true;	
			this.addChild(hit_PowerMain);
			
		}
		
		private function CreateHitTorpedos():void{
			hit_Torpedos = new Shape();
			hit_Torpedos.touchable = false;
			hit_Torpedos.graphics.beginFill(0x0000ff);
			
			hit_Torpedos.graphics.lineTo(115,216);	
			hit_Torpedos.graphics.lineTo(143,178);	
			hit_Torpedos.graphics.lineTo(233,118);	
			hit_Torpedos.graphics.lineTo(375,97);	
			hit_Torpedos.graphics.lineTo(510,154);	
			hit_Torpedos.graphics.lineTo(525,275);	
			hit_Torpedos.graphics.lineTo(403,326);	
			hit_Torpedos.graphics.lineTo(320,350);	
			hit_Torpedos.graphics.lineTo(158,354);	

			
			hit_Torpedos.alpha = 0.0;
			
			hit_Torpedos.graphics.endFill(false);
			
			hit_Torpedos.graphics.precisionHitTest = true;	
			this.addChild(hit_Torpedos);
			
		}
		
		private function CreateHitSubmarineInterior():void{
			hit_SubmarineInterior = new Shape();
			hit_SubmarineInterior.touchable = false;
			hit_SubmarineInterior.graphics.beginFill(0x0000ff);
			
			hit_SubmarineInterior.graphics.lineTo(0,0);	
			hit_SubmarineInterior.graphics.lineTo(146,0);		
			hit_SubmarineInterior.graphics.lineTo(148,68);	
			hit_SubmarineInterior.graphics.lineTo(92,86);	
			hit_SubmarineInterior.graphics.lineTo(88,254);	
			hit_SubmarineInterior.graphics.lineTo(94,382);	
			hit_SubmarineInterior.graphics.lineTo(58,384);	
			hit_SubmarineInterior.graphics.lineTo(35,257);	
			hit_SubmarineInterior.graphics.lineTo(30,90);	
			hit_SubmarineInterior.graphics.lineTo(0,90);	
			
			hit_SubmarineInterior.alpha = 0.0;
			hit_SubmarineInterior.graphics.endFill(false);
			hit_SubmarineInterior.graphics.precisionHitTest = true;	
			this.addChild(hit_SubmarineInterior);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(hit_SubmarineInterior.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RopeClimb();
						FadeOut((SubmarineInterior as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineInteriorObj,true
						);
					}else if(hit_Torpedos.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((SubmarineTorpedos as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineTorpedosObj,true
						);
					}else if(hit_PowerMain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((SubmarinePowerMain as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarinePowerMainObj,true
						);
					}else if(hit_roof.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Broken pipes and wires cover the ceiling...");
					}else if(hit_loader.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The old torpedo loader.");
					}else if(hit_ladder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The broken ladder to the bridge.");
					}
					
					/*
					private var hit_roof:Shape;
					private var hit_loader:Shape;
					private var hit_ladder:Shape;
					*/
					
					
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
			
			
			
			this.assets.removeTexture("SubmarineLowerLevel_Sprite_02",true);
			this.assets.removeTexture("SubmarineLowerLevel_Sprite",true);
			this.assets.removeTextureAtlas("SubmarineLowerLevel_Sprite_02",true);
			this.assets.removeTextureAtlas("SubmarineLowerLevel_Sprite",true);
			
			(stage.getChildAt(0) as Object).falseAsset("submarineLowerLevel_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineLowerLevel_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineLowerLevel_03");
			(stage.getChildAt(0) as Object).falseAsset("submarineLowerLevel_04");
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