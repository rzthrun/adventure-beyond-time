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
	
	public class JungleJunk extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var hit_JungleOracle:Shape;
		private var hit_JungleJunkDeck:Shape;
		private var hit_JungleEnclave:Shape;
		
		private var hit_front:Shape;
		private var hit_logs:Shape;
		private var hit_sail:Shape;
		private var hit_ground:Shape;
		private var hit_hull:Shape;
		
		private var hatch:Image;
		private var enclaveRock:Image;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleJunk(_assets:AssetManager,_game:Game)
		{
			super();
			//	this.assets = new AssetManager();
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		public function onAddedToStage(event:starling.events.Event):void
		{
			
			if(game.CheckAsset('jungleJunk_01') === false){
//				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleJunk/jungleJunk_spriteSheet.jpg'));
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleJunk/jungleJunk_bg.jpg'));
				game.TrackAssets('jungleJunk_01');
			}
	
			if(game.CheckAsset('jungleJunk_02') === false){
					this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleJunk/jungleJunk_spriteSheet.xml'));
					game.TrackAssets('jungleJunk_02');
			 }
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleJunk_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleJunk/jungleJunk_spriteSheet.png'));
				game.TrackAssets('jungleJunk_03');
			}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleJunk","JungleJunkObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleJunk_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			
			hatch = new Image(this.assets.getTexture('junk_hatch_open'));
			hatch.touchable = false;
			hatch.x = 299;
			hatch.y = 175;
			
			enclaveRock = new Image(this.assets.getTexture('enclave_rock'));
			enclaveRock.touchable = false;
			enclaveRock.x = 586;
			enclaveRock.y = 165;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkDeck['Hatch'] == 'open'){
					
					hatch.alpha = 1;								
				}else{
					hatch.alpha = 0;								
				}			
			}else{
				
				hatch.alpha = 0;				
			}
			
		
			
			enclaveRock.alpha = 0;
			this.addChildAt(hatch,1);
			this.addChildAt(enclaveRock,2);

			CreateHitHull();
			CreateHitGround();
			CreateHitLogs();
			CreateHitFront();
			CreateHitSail();
			CreateHitJungleOracle();
			CreateHitJungleJunk();
			CreateHitJungleEnclave();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipCreaks",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleJunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleJunk['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirate;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleJunk',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,1);
						},1.5);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleJunk',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,1);
					},1.5);
				}
			}
			
		}
		//hit_hull
		private function CreateHitHull():void{
			hit_hull = new Shape();
			hit_hull.touchable = false;
			hit_hull.graphics.beginFill(0xff0000);
			
			hit_hull.graphics.lineTo(59,291);									
			hit_hull.graphics.lineTo(518,161);									
			hit_hull.graphics.lineTo(467,244);									
			hit_hull.graphics.lineTo(159,378);									
			hit_hull.graphics.lineTo(59,348);									
																		
			
			hit_hull.graphics.endFill(false);
			hit_hull.alpha = 0.0;
			
			hit_hull.graphics.precisionHitTest = true;	
			this.addChild(hit_hull);
		}
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(480,389);									
			hit_ground.graphics.lineTo(578,256);									
			hit_ground.graphics.lineTo(752,257);									
			hit_ground.graphics.lineTo(796,376);									
			hit_ground.graphics.lineTo(589,471);																		
			
			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}

		
	
		private function CreateHitLogs():void{
			hit_logs = new Shape();
			hit_logs.touchable = false;
			hit_logs.graphics.beginFill(0xff0000);
			
			hit_logs.graphics.lineTo(201,392);									
			hit_logs.graphics.lineTo(413,244);									
			hit_logs.graphics.lineTo(543,493);									
			hit_logs.graphics.lineTo(379,481);									
			
			hit_logs.graphics.endFill(false);
			hit_logs.alpha = 0.0;
			
			hit_logs.graphics.precisionHitTest = true;	
			this.addChild(hit_logs);
		}
		
		private function CreateHitSail():void{
			hit_sail = new Shape();
			hit_sail.touchable = false;
			hit_sail.graphics.beginFill(0xff0000);
			
			hit_sail.graphics.lineTo(0,44);									
			hit_sail.graphics.lineTo(81,0);									
			hit_sail.graphics.lineTo(426,0);									
			hit_sail.graphics.lineTo(468,88);									
			hit_sail.graphics.lineTo(86,190);									
			hit_sail.graphics.lineTo(86,190);									
			
			hit_sail.graphics.endFill(false);
			hit_sail.alpha = 0.0;
			
			hit_sail.graphics.precisionHitTest = true;	
			this.addChild(hit_sail);
		}
		
		private function CreateHitFront():void{
			hit_front = new Shape();
			hit_front.touchable = false;
			hit_front.graphics.beginFill(0xff0000);
			
			hit_front.graphics.lineTo(0,236);									
			hit_front.graphics.lineTo(151,156);									
			hit_front.graphics.lineTo(193,160);									
			hit_front.graphics.lineTo(227,325);									
			hit_front.graphics.lineTo(0,326);									
									
			hit_front.graphics.endFill(false);
			hit_front.alpha = 0.0;
			
			hit_front.graphics.precisionHitTest = true;	
			this.addChild(hit_front);
		}
		
		
		private function CreateHitJungleEnclave():void{
			hit_JungleEnclave = new Shape();
			hit_JungleEnclave.touchable = false;
			hit_JungleEnclave.graphics.beginFill(0xff0000);
			
			hit_JungleEnclave.graphics.lineTo(567,96);									
			hit_JungleEnclave.graphics.lineTo(614,78);									
			hit_JungleEnclave.graphics.lineTo(678,81);									
			hit_JungleEnclave.graphics.lineTo(729,112);									
			hit_JungleEnclave.graphics.lineTo(743,246);									
			hit_JungleEnclave.graphics.lineTo(701,282);									
			hit_JungleEnclave.graphics.lineTo(623,276);									
			hit_JungleEnclave.graphics.lineTo(581,256);									
			hit_JungleEnclave.graphics.endFill(false);
			hit_JungleEnclave.alpha = 0.0;
			
			hit_JungleEnclave.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleEnclave);
		}
		
		private function CreateHitJungleOracle():void{
			hit_JungleOracle = new Shape();
			hit_JungleOracle.touchable = false;
			hit_JungleOracle.graphics.beginFill(0xff0000);
			
			hit_JungleOracle.graphics.lineTo(409,273);									
			hit_JungleOracle.graphics.lineTo(486,245);									
			hit_JungleOracle.graphics.lineTo(566,324);									
			hit_JungleOracle.graphics.lineTo(535,384);									
			hit_JungleOracle.graphics.lineTo(438,381);																	
			hit_JungleOracle.graphics.lineTo(406,335);									
			hit_JungleOracle.graphics.endFill(false);			
			
			hit_JungleOracle.alpha = 0.0;
			
			hit_JungleOracle.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleOracle);
		}
		
		//hit_JungleJunkDeck
		
		private function CreateHitJungleJunk():void{
			hit_JungleJunkDeck = new Shape();
			hit_JungleJunkDeck.touchable = false;
			hit_JungleJunkDeck.graphics.beginFill(0xff0000);
			
			hit_JungleJunkDeck.graphics.lineTo(199,162);									
			hit_JungleJunkDeck.graphics.lineTo(325,117);									
			hit_JungleJunkDeck.graphics.lineTo(485,96);									
			hit_JungleJunkDeck.graphics.lineTo(525,119);									
			hit_JungleJunkDeck.graphics.lineTo(521,156);									
			hit_JungleJunkDeck.graphics.lineTo(455,191);									
			hit_JungleJunkDeck.graphics.lineTo(428,231);									
			hit_JungleJunkDeck.graphics.lineTo(288,270);	
			hit_JungleJunkDeck.graphics.lineTo(224,270);	
			hit_JungleJunkDeck.graphics.lineTo(214,231);									
			hit_JungleJunkDeck.graphics.endFill(false);	
			
			hit_JungleJunkDeck.alpha = 0.0;
			
			hit_JungleJunkDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleJunkDeck);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleDeep as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleDeepObj,true
						);
					}else if(hit_JungleOracle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleOracle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleOracleObj,true
						);	
					}else if(hit_JungleJunkDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JunkDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkDeckObj,true
						);	
					}else if(hit_JungleEnclave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleEnclave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveObj,true
						);	
					}else if(hit_front.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("How did the ship get all the way up here?");
						
					}else if(hit_logs.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Large logs used for ballast have become untethered from the ship.");
						
					}else if(hit_sail.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sails are tattered and ripped");
					}else if(hit_hull.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship is resting amongst the boulders... it could come loose and slide downhill.");				
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ground is steep and precarious.");						
					}
					
					/*		
					private var hit_front:Shape;
					private var hit_logs:Shape;
					private var hit_sail:Shape;
					private var hit_ground:Shape;
					
					*/
					//JungleEnclave
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
			
			this.assets.removeTexture("jungleJunk_spriteSheet",true);
			this.assets.removeTextureAtlas("jungleJunk_spriteSheet",true);
			this.assets.removeTexture("jungleJunk_bg",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleJunk_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleJunk_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleJunk_03");
			
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