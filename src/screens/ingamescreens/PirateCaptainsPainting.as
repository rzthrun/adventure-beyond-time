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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class PirateCaptainsPainting extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var left:Image;
		private var right:Image;
		private var turtle_up:Image;
		private var turtle_down:Image;
		
		
		private var hit_left:Shape;
		private var hit_right:Shape;
		private var hit_center_left:Shape;
		private var hit_center_right:Shape;
		private var hit_turtle_up:Shape
		private var hit_turtle_down:Shape
		
		private var hit_brugle:Shape;
		private var hit_vermeer:Shape;
		private var hit_carravagio:Shape;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var LeftOpen:Boolean = false;
		private var RightOpen:Boolean = false;
		private var TurtleDown:Boolean = false;
		
		private var openLetter:Sprite;
		private var openLetterPages:Image;
		private var hit_openLetter:Shape;
		public var OpenLetterTween:Tween;
		
		private var PhraseCounter:int = 0;
		
		private var openBookbg:Shape;
		
		private var LetterIsOpen:Boolean = false;
		
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function PirateCaptainsPainting(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('pirateCaptainsPainting_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsPainting/pirateCaptainsPainting_bg.jpg'));
				game.TrackAssets('pirateCaptainsPainting_01');
			}
			if(game.CheckAsset('pirateCaptainsPainting_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsPainting/pirateCaptainsPainting_Sprite.atf'));
				game.TrackAssets('pirateCaptainsPainting_02');
			}
			if(game.CheckAsset('pirateCaptainsPainting_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsPainting/pirateCaptainsPainting_Sprite.xml'));
				game.TrackAssets('pirateCaptainsPainting_03');
			}
			
			if(game.CheckAsset('pirateCaptainsPainting_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsPainting/pirateCaptainsPainting_Sprite_02.png'));
				game.TrackAssets('pirateCaptainsPainting_04');
			}
			if(game.CheckAsset('pirateCaptainsPainting_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsPainting/pirateCaptainsPainting_Sprite_02.xml'));
				game.TrackAssets('pirateCaptainsPainting_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("PirateCaptainsPainting","PirateCaptainsPaintingObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
			
			bg = new Image(this.assets.getTexture('pirateCaptainsPainting_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			left = new Image(this.assets.getTexture('left'));
			left.smoothing = TextureSmoothing.NONE;

			left.touchable = false;
			left.x = 0;
			left.y = 11;
			left.alpha = 1;
			this.addChildAt(left,1);
			
			right = new Image(this.assets.getTexture('right'));
			right.smoothing = TextureSmoothing.NONE;

			right.touchable = false;
			right.x = 380;
			right.y = 14;

			turtle_up = new Image(this.assets.getTexture('turtle_up'));
			turtle_up.smoothing = TextureSmoothing.NONE;

			turtle_up.touchable = false;
			turtle_up.x = 398;
			turtle_up.y = 63;
			
			turtle_down = new Image(this.assets.getTexture('turtle_down'));
			turtle_down.smoothing = TextureSmoothing.NONE;

			turtle_down.touchable = false;
			turtle_down.x = 424;
			turtle_down.y = 277;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting['TurtleDown'] == 'Yes'){
					TurtleDown = true;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting['Left'] == 'Open'){
					LeftOpen = true;
					CreateCenterLeftHit();
					left.alpha = 0;
				}else{
					left.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting['Right'] == 'Open'){
					RightOpen = true;
					CreateCenterRightHit();
					right.alpha = 0;
					if(TurtleDown === false){
						turtle_up.alpha = 1;
						turtle_down.alpha = 0;
						CreateTurtleUpHit();
					}else{
						turtle_down.alpha = 1;
						turtle_up.alpha = 0;
						CreateTurtleDownHit();
					}
					
				}else{
					right.alpha = 1;
					turtle_up.alpha = 0;
					turtle_down.alpha = 0;
				}
				
				
			}else{
				left.alpha = 1;
				right.alpha = 1;
				turtle_up.alpha = 0;
				turtle_down.alpha = 0;
			}
			
		
		
			
			this.addChildAt(left,1);
			this.addChildAt(turtle_up,2);
			this.addChildAt(turtle_down,3);
			this.addChildAt(right,4);
			
			//FadeOutOcean(1);
			CreateBrugleHit();
			CreateVermeerHit();
			CreateCarravagioHit();
			CreateRightHit(RightOpen);
			CreateLeftHit(LeftOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting['Letter'] == 'open'){
					LetterIsOpen = true;
					OpenLetter(false);
					this.addChild(goback);
				}
			}
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Waves_02",((stage.getChildAt(0) as Object).MusicObj.globalVol-0.3),1.0);
			},0.7);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("ShipCreaks",((stage.getChildAt(0) as Object).MusicObj.globalVol-0.3),1.0);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,0);
						},0.3);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMountainFluteOne(true,0);
					},0.3);
				}
			}
			
			
		}
		
		
		//turtle_up
	
		private function CreateCarravagioHit():void{
			hit_carravagio = new Shape();
			hit_carravagio.touchable = false;
			hit_carravagio.graphics.beginFill(0x00ff00);
			
			hit_carravagio.graphics.lineTo(24,214);	
			hit_carravagio.graphics.lineTo(90,99);	
			hit_carravagio.graphics.lineTo(182,92);	
			hit_carravagio.graphics.lineTo(190,241);	
			hit_carravagio.graphics.lineTo(72,245);	
			
			
			hit_carravagio.graphics.endFill(false);
			hit_carravagio.alpha = 0.0;
			
			hit_carravagio.graphics.precisionHitTest = true;	
			this.addChild(hit_carravagio);
		}
		
		private function CreateVermeerHit():void{
			hit_vermeer = new Shape();
			hit_vermeer.touchable = false;
			hit_vermeer.graphics.beginFill(0x00ff00);
			
			hit_vermeer.graphics.lineTo(80,259);	
			hit_vermeer.graphics.lineTo(190,252);	
			hit_vermeer.graphics.lineTo(193,402);	
			hit_vermeer.graphics.lineTo(94,412);	
	
			hit_vermeer.graphics.endFill(false);
			hit_vermeer.alpha = 0.0;
			
			hit_vermeer.graphics.precisionHitTest = true;	
			this.addChild(hit_vermeer);
		}
		
		private function CreateBrugleHit():void{
			hit_brugle = new Shape();
			hit_brugle.touchable = false;
			hit_brugle.graphics.beginFill(0x00ff00);
			
			hit_brugle.graphics.lineTo(590,115);	
			hit_brugle.graphics.lineTo(795,126);	
			hit_brugle.graphics.lineTo(795,380);	
			hit_brugle.graphics.lineTo(724,397);	
			hit_brugle.graphics.lineTo(561,341);	
			
			hit_brugle.graphics.endFill(false);
			hit_brugle.alpha = 0.0;
			
			hit_brugle.graphics.precisionHitTest = true;	
			this.addChild(hit_brugle);
		}
		
		private function CreateTurtleUpHit():void{
			hit_turtle_up = new Shape();
			hit_turtle_up.touchable = false;
			hit_turtle_up.graphics.beginFill(0x00ff00);
			
			hit_turtle_up.graphics.lineTo(400,95);	
			hit_turtle_up.graphics.lineTo(488,61);	
			hit_turtle_up.graphics.lineTo(535,181);	
			hit_turtle_up.graphics.lineTo(448,215);	
			
			hit_turtle_up.graphics.endFill(false);
			hit_turtle_up.alpha = 0.0;
			
			hit_turtle_up.graphics.precisionHitTest = true;	
			this.addChild(hit_turtle_up);
		}
		
		private function CreateTurtleDownHit():void{
			hit_turtle_down = new Shape();
			hit_turtle_down.touchable = false;
			hit_turtle_down.graphics.beginFill(0x00ff00);
			
			hit_turtle_down.graphics.lineTo(450,284);	
			hit_turtle_down.graphics.lineTo(539,300);	
			hit_turtle_down.graphics.lineTo(515,419);	
			hit_turtle_down.graphics.lineTo(427,405);	
			
			hit_turtle_down.graphics.endFill(false);
			hit_turtle_down.alpha = 0.0;
			
			hit_turtle_down.graphics.precisionHitTest = true;	
			this.addChild(hit_turtle_down);
		}
		
		private function CreateCenterLeftHit():void{
			hit_center_left = new Shape();
			hit_center_left.touchable = false;
			hit_center_left.graphics.beginFill(0xff0000);
			
			hit_center_left.graphics.lineTo(193,33);	
			hit_center_left.graphics.lineTo(373,36);	
			hit_center_left.graphics.lineTo(374,419);	
			hit_center_left.graphics.lineTo(204,423);	

			hit_center_left.graphics.endFill(false);
			hit_center_left.alpha = 0.0;
			
			hit_center_left.graphics.precisionHitTest = true;	
			this.addChild(hit_center_left);
		}

		private function CreateCenterRightHit():void{
			hit_center_right = new Shape();
			hit_center_right.touchable = false;
			hit_center_right.graphics.beginFill(0xff0000);
			
			hit_center_right.graphics.lineTo(378,36);	
			hit_center_right.graphics.lineTo(555,40);	
			hit_center_right.graphics.lineTo(549,415);	
			hit_center_right.graphics.lineTo(378,418);	

			
			hit_center_right.graphics.endFill(false);
			hit_center_right.alpha = 0.0;
			
			hit_center_right.graphics.precisionHitTest = true;	
			this.addChild(hit_center_right);
		}
		
		private function CreateLeftHit(open:Boolean = false):void{
			hit_left = new Shape();
			
			if(open === false){
				
				hit_left.x = 0;
				hit_left.y = 0;
				hit_left.graphics.beginFill(0x0000FF);
				
				
				hit_left.graphics.lineTo(190,30);	
				hit_left.graphics.lineTo(373,32);	
				hit_left.graphics.lineTo(371,426);	
				hit_left.graphics.lineTo(197,427);	
	
				
				hit_left.graphics.endFill(false);
				
				hit_left.alpha = 0.0;
				
				hit_left.graphics.precisionHitTest = true;	
			}else{
				
				hit_left.x = 0;
				hit_left.y = 0;
				hit_left.graphics.beginFill(0x0000FF);
				
				hit_left.graphics.lineTo(0,12);
				hit_left.graphics.lineTo(185,37);
				hit_left.graphics.lineTo(193,419);
				hit_left.graphics.lineTo(101,440);
				hit_left.graphics.lineTo(0,354);

				hit_left.graphics.endFill(false);
				hit_left.alpha = 0.0;
				
				hit_left.graphics.precisionHitTest = true;				
			}
			hit_left.touchable = false;
			this.addChild(hit_left);
			
		}	
		
		
		private function CreateRightHit(open:Boolean = false):void{
			hit_right = new Shape();
			
			if(open === false){
				
				hit_right.x = 0;
				hit_right.y = 0;
				hit_right.graphics.beginFill(0x0000FF);
				
				
				hit_right.graphics.lineTo(378,32);
				hit_right.graphics.lineTo(564,35);
				hit_right.graphics.lineTo(553,421);
				hit_right.graphics.lineTo(379,426);
				
				
				hit_right.graphics.endFill(false);
				
				hit_right.alpha = 0.0;
				
				hit_right.graphics.precisionHitTest = true;	
			}else{
				
				hit_right.x = 0;
				hit_right.y = 0;
				hit_right.graphics.beginFill(0x0000FF);
				
				hit_right.graphics.lineTo(563,39);
				hit_right.graphics.lineTo(656,30);
				hit_right.graphics.lineTo(739,125);
				hit_right.graphics.lineTo(726,391);
				hit_right.graphics.lineTo(605,429);
				hit_right.graphics.lineTo(552,417);

				
				hit_right.graphics.endFill(false);
				hit_right.alpha = 0.0;
				
				hit_right.graphics.precisionHitTest = true;				
			}
			hit_right.touchable = false;
			this.addChild(hit_right);
			
		}	
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(LetterIsOpen === false){
					
							
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((PirateCaptains as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.PirateCaptainsObj,true
								);
							}else if(hit_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								DoorHandler('LEFT');
							}else if(hit_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								DoorHandler('RIGHT');
							}else if(hit_brugle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The painting shows hunters in the snow.");
							}else if(hit_vermeer.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The small picture is incredibly detailed.");
							}else if(hit_carravagio.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Snakes for hair....");
								
								
							}else if(RightOpen === true){
								if(TurtleDown === false){
									if(hit_turtle_up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										TurtleHandler('Up');
									}else if(hit_center_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										if(PhraseCounter == 0){
											PhraseCounter = 1;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The painting is filled with hundreds of small human figures.");
										}else if(PhraseCounter == 1){
											PhraseCounter = 2;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks like a crazy party in a bizarre landscape.");
										}else if(PhraseCounter == 2){
											PhraseCounter = 3;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The plaque reads 'The Garden of Earthly Delights' by Hieronymus Bosch, c. 1500.");
										}
									}
								}else{
									if(hit_turtle_down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										TurtleHandler('Down');
									}else if(hit_center_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										if(PhraseCounter == 0){
											PhraseCounter = 1;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The painting is filled with hundreds of small human figures.");
										}else if(PhraseCounter == 1){
											PhraseCounter = 2;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks like a crazy party in a bizarre landscape.");
										}else if(PhraseCounter == 2){
											PhraseCounter = 0;
											(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The plaque reads 'The Garden of Earthly Delights' by Hieronymus Bosch, c. 1500.");
										}
									}else if(LeftOpen === true){
										if(hit_center_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
											if(PhraseCounter == 0){
												PhraseCounter = 1;
												(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Small figures dance and revel with each other.");
											}else if(PhraseCounter == 1){
												PhraseCounter = 2;
												(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe it has a moral... or is a depiction of paradise lost.");
											}else if(PhraseCounter == 2){
												PhraseCounter = 0;
												(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What a weird painting...");
											}
										}
									}
								}
							}else if(LeftOpen === true){
								if(hit_center_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									if(PhraseCounter == 0){
										PhraseCounter = 1;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Small figures dance and revel with each other.");
									}else if(PhraseCounter == 1){
										PhraseCounter = 2;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Maybe it has a moral... or is a depiction of paradise lost.");
									}else if(PhraseCounter == 2){
										PhraseCounter = 0;
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What a weird painting...");
									}
								}
							}
						}else{
							if(targ == goback.SourceImage){
								trace("GoBackClick");
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								RemoveLetter();
								LetterIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
								}		
								SaveArray['Letter'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
							}else if(hit_openLetter.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It's an old etching of a turtle skeleton, with a purple watercolor wash applied.");
							}
						}
					}
				}
			}
		}
		private function TurtleHandler(StateStr:String):void{
			if(StateStr == 'Up'){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageUnroll();
				TurtleDown = true;
				turtle_up.alpha = 0;
				turtle_down.alpha = 1;
				CreateTurtleDownHit();
				this.removeChild(hit_turtle_up);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
				}
				SaveArray["TurtleDown"] = "Yes";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
				
				
				
			}else if(StateStr == 'Down'){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
				LetterIsOpen = true;
				OpenLetter(true, 0)
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
				}		
				SaveArray['Letter'] = "open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
			}
		}
		
		
		private function OpenLetter(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openLetter = new Sprite();
			openLetter.alpha = 0;
			CreateOpenBookBg();
			openLetterPages = new Image(this.assets.getTexture('page'));
			this.openLetter.addChildAt(openBookbg,0);
			openLetter.addChild(openLetterPages);
			openLetterPages.touchable = false;
			
			this.addChildAt(openLetter,6);
			this.addChildAt(goback,7);
			
			
			if(Fade === false){
				openLetter.alpha = 1;
				CreateOpenLetterHit();
				Animating = false;
				//	CreateOpenNotePadHit();
			}else{
				
				OpenLetterTween = new Tween(openLetter, 0.5, Transitions.LINEAR);
				OpenLetterTween.fadeTo(1);
				OpenLetterTween.onComplete = function():void{
					//		CreateOpenNotePadHit();
					CreateOpenLetterHit();
					Animating = false; 
				};
				Starling.juggler.add(OpenLetterTween);	
				
			}
			//	CreateOpenBookHit(page);
		}
		private function RemoveLetter():void{
			Animating = true;
			hit_openLetter.graphics.clear();
			//	Starling.juggler.purge();
			OpenLetterTween = new Tween(openLetter, 0.5, Transitions.LINEAR);
			OpenLetterTween.fadeTo(0);
			OpenLetterTween.onComplete = function():void{
				
				CloseLetter();
				Animating = false;
				
			};
			Starling.juggler.add(OpenLetterTween);		
		}
		
		public function CloseLetter():void{
			this.removeChild(openLetter);
			openLetter.dispose();
		}
		private function CreateOpenBookBg():void{
			openBookbg = new Shape();
			openBookbg.graphics.beginFill(0x000000);
			openBookbg.graphics.lineTo(0,0);	
			openBookbg.graphics.lineTo(800,0);	
			openBookbg.graphics.lineTo(800,512);	
			openBookbg.graphics.lineTo(0,512);	
			
			openBookbg.graphics.endFill(false);
			openBookbg.alpha = 0.5;
			//	openBookbg.graphics.precisionHitTest = true;				
			
		}
		private function CreateOpenLetterHit():void{
			hit_openLetter = new Shape();
			this.addChild(hit_openLetter);
			hit_openLetter.graphics.beginFill(0x0000FF);
			hit_openLetter.graphics.lineTo(204,0);	
			hit_openLetter.graphics.lineTo(592,0);	
			hit_openLetter.graphics.lineTo(592,512);	
			hit_openLetter.graphics.lineTo(204,512);
			
			hit_openLetter.graphics.endFill(false);
			hit_openLetter.alpha = 0.0;
			hit_openLetter.touchable = false;
			hit_openLetter.graphics.precisionHitTest = true;	
		}
		
		
		private function DoorHandler(theDoor:String):void{
			if(theDoor == 'LEFT'){
				if(LeftOpen === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
					LeftOpen = true;
					left.alpha = 0;
					
					hit_left.graphics.clear()
					CreateLeftHit(true);
					CreateCenterLeftHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
					}
					SaveArray["Left"] = "Open";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
					LeftOpen = false;
					left.alpha = 1;
					
					hit_left.graphics.clear()
					CreateLeftHit(false);
					
					this.removeChild(hit_center_left);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
					}
					SaveArray["Left"] = "Closed";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
				}
			}else if(theDoor == 'RIGHT'){
				if(RightOpen === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
					RightOpen = true;
					right.alpha = 0;
					
					hit_right.graphics.clear()
					CreateRightHit(true);
					CreateCenterRightHit();
					
					if(TurtleDown === false){
						turtle_up.alpha = 1;
						CreateTurtleUpHit();
					}else{
						turtle_down.alpha = 1;
						CreateTurtleDownHit();
					}
					
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
					}
					SaveArray["Right"] = "Open";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
					RightOpen = false;
					right.alpha = 1;
					
					hit_right.graphics.clear()
					CreateRightHit(false);
					this.removeChild(hit_center_right);
					
					if(TurtleDown === false){
						turtle_up.alpha = 0;
						this.removeChild(hit_turtle_up);
					}else{
						turtle_down.alpha = 0;
						this.removeChild(hit_turtle_down);
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsPainting;
					}
					SaveArray["Right"] = "Closed";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsPainting',SaveArray);
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
			
			
			this.assets.removeTexture("pirateCaptainsPainting_bg",true);
			this.assets.removeTexture("pirateCaptainsPainting_Sprite",true);
			this.assets.removeTexture("pirateCaptainsPainting_Sprite_02",true);
			this.assets.removeTextureAtlas("pirateCaptainsPainting_Sprite",true);
			this.assets.removeTextureAtlas("pirateCaptainsPainting_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsPainting_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsPainting_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsPainting_03");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsPainting_04");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsPainting_05");
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
