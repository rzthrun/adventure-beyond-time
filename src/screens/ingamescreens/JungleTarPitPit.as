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
	
	public class JungleTarPitPit extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var stick:Image;
		private var plank_front:Image;
		private var plank_back:Image;
		
		private var hit_stick:Shape;
		private var hit_tar:Shape;
		private var hit_rock_close:Shape;
		private var hit_rock_far:Shape;
		private var hit_plankClose:Shape;
		private var hit_plankFar:Shape;
		private var hit_farside:Shape;
		
		private var hit_mammoth:Shape;
		private var hit_bones_one:Shape;
		private var hit_bones_two:Shape;
		private var hit_WallOne:Shape;
		private var hit_WallTwo:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var PlankCloseAttached:Boolean = false;
		private var PlankFarAttached:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function JungleTarPitPit(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleTarPitPit_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleTarPitPit/jungleTarPitPit_bg.jpg'));
				game.TrackAssets('jungleTarPitPit_01');
			}
			if(game.CheckAsset('jungleTarPitPit_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleTarPitPit/JungleTarPitPit_Sprite.atf'));
				game.TrackAssets('jungleTarPitPit_02');
			}
			if(game.CheckAsset('jungleTarPitPit_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleTarPitPit/JungleTarPitPit_Sprite.xml'));
				game.TrackAssets('jungleTarPitPit_03');
			}
			//JungleTarPitPit_Sprite
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleTarPitPit","JungleTarPitPitObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleTarPitPit_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
				
			plank_front = new Image(this.assets.getTexture('front_plank'));
			plank_front.smoothing = TextureSmoothing.NONE;
			plank_front.touchable = false;
			plank_front.x = 206;
			plank_front.y = 173;		
			
			plank_back = new Image(this.assets.getTexture('back_plank'));
			plank_back.smoothing = TextureSmoothing.NONE;
			plank_back.touchable = false;
			plank_back.x = 415;
			plank_back.y = 88;

			stick = new Image(this.assets.getTexture('stick'));
			stick.smoothing = TextureSmoothing.NONE;
			stick.touchable = false;
			stick.x = 415;
			stick.y = 182;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['TorchStick'] == 'PickedUp'){
					stick.alpha = 0;
				}else{
					stick.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['PlankClose'] == 'Attached'){
					CreatePlankCloseHit();
					plank_front.alpha = 1;
					PlankCloseAttached = true;
				}else{
					plank_front.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['PlankFar'] == 'Attached'){
					plank_back.alpha = 1;
					CreatePlankFarHit();
					PlankFarAttached = true;
				}else{
					plank_back.alpha = 0;
				}
				
			}else{
				plank_front.alpha = 0;
				plank_back.alpha = 0;
				stick.alpha = 1;
			}

			
			this.addChildAt(plank_front,1);
			this.addChildAt(plank_back,2);
			this.addChildAt(stick,3);
			
			CreateTarHit();
			CreateStickHit();
			CreateRockCloseHit();
			CreateRockFarHit();
			CreateFarsideHit();
			
			CreateBonesTwoHit();
			CreateBonesOneHit();
			CreateMammothHit();
			CreateWallTwoHit();
			CreateWallOneHit();
			//private var stick:Image;
		//	private var plank_front:Image;
		//	private var plank_back:Image;
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadBeatUpOne(true,3);
						},1.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadBeatUpOne(true,3);
					},1.5);
				}
			}
			
		
		}
		//hit_farside
	//	private var hit_mammoth:Shape;
	//	private var hit_bones_one:Shape;
	//	private var hit_bones_two:Shape;
		
		private function CreateWallOneHit():void{
			hit_WallOne = new Shape();
			hit_WallOne.touchable = false;
			hit_WallOne.graphics.beginFill(0xff0000);
			
			hit_WallOne.graphics.lineTo(0,0);	
			hit_WallOne.graphics.lineTo(203,6);	
			hit_WallOne.graphics.lineTo(156,106);	
			hit_WallOne.graphics.lineTo(0,154);	
			
			
			hit_WallOne.graphics.endFill(false);
			hit_WallOne.alpha = 0.0;
			
			hit_WallOne.graphics.precisionHitTest = true;	
			this.addChild(hit_WallOne);
		}
		private function CreateWallTwoHit():void{
			hit_WallTwo = new Shape();
			hit_WallTwo.touchable = false;
			hit_WallTwo.graphics.beginFill(0xff0000);
			
			hit_WallTwo.graphics.lineTo(495,84);	
			hit_WallTwo.graphics.lineTo(523,3);	
			hit_WallTwo.graphics.lineTo(663,3);	
			hit_WallTwo.graphics.lineTo(673,115);	
			hit_WallTwo.graphics.lineTo(715,145);	
			hit_WallTwo.graphics.lineTo(702,204);	
			hit_WallTwo.graphics.lineTo(566,141);	
			hit_WallTwo.graphics.lineTo(528,112);	
		
			hit_WallTwo.graphics.endFill(false);
			hit_WallTwo.alpha = 0.0;
			
			hit_WallTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_WallTwo);
		}
		
		private function CreateBonesTwoHit():void{
			hit_bones_two = new Shape();
			hit_bones_two.touchable = false;
			hit_bones_two.graphics.beginFill(0x0000ff);
			
			hit_bones_two.graphics.lineTo(566,277);	
			hit_bones_two.graphics.lineTo(637,231);	
			hit_bones_two.graphics.lineTo(725,252);	
			hit_bones_two.graphics.lineTo(792,300);	
			hit_bones_two.graphics.lineTo(791,355);	
			hit_bones_two.graphics.lineTo(670,349);	
			
			hit_bones_two.graphics.endFill(false);
			hit_bones_two.alpha = 0.0;
			
			hit_bones_two.graphics.precisionHitTest = true;	
			this.addChild(hit_bones_two);
		}
		
		private function CreateBonesOneHit():void{
			hit_bones_one = new Shape();
			hit_bones_one.touchable = false;
			hit_bones_one.graphics.beginFill(0x0000ff);
			
			hit_bones_one.graphics.lineTo(0,179);	
			hit_bones_one.graphics.lineTo(65,159);	
			hit_bones_one.graphics.lineTo(182,170);	
			hit_bones_one.graphics.lineTo(177,204);	
			hit_bones_one.graphics.lineTo(53,254);	
			hit_bones_one.graphics.lineTo(0,252);	
			
			hit_bones_one.graphics.endFill(false);
			hit_bones_one.alpha = 0.0;
			
			hit_bones_one.graphics.precisionHitTest = true;	
			this.addChild(hit_bones_one);
		}
		
		private function CreateMammothHit():void{
			hit_mammoth = new Shape();
			hit_mammoth.touchable = false;
			hit_mammoth.graphics.beginFill(0x0000ff);
			
			hit_mammoth.graphics.lineTo(140,153);	
			hit_mammoth.graphics.lineTo(211,36);	
			hit_mammoth.graphics.lineTo(330,75);	
			hit_mammoth.graphics.lineTo(362,99);	
			hit_mammoth.graphics.lineTo(348,141);	
			hit_mammoth.graphics.lineTo(180,158);	
			
			hit_mammoth.graphics.endFill(false);
			hit_mammoth.alpha = 0.0;
			
			hit_mammoth.graphics.precisionHitTest = true;	
			this.addChild(hit_mammoth);
		}
		
		private function CreateFarsideHit():void{
			hit_farside = new Shape();
			hit_farside.touchable = false;
			hit_farside.graphics.beginFill(0x0000ff);
			
			hit_farside.graphics.lineTo(313,0);	
			hit_farside.graphics.lineTo(506,0);	
			hit_farside.graphics.lineTo(461,92);	
			hit_farside.graphics.lineTo(362,96);	
			hit_farside.graphics.lineTo(335,77);	

			hit_farside.graphics.endFill(false);
			hit_farside.alpha = 0.0;
			
			hit_farside.graphics.precisionHitTest = true;	
			this.addChild(hit_farside);
		}
		
		private function CreatePlankFarHit():void{
			hit_plankFar = new Shape();
			hit_plankFar.touchable = false;
			hit_plankFar.graphics.beginFill(0x0000ff);
			
			hit_plankFar.graphics.lineTo(418,82);	
			hit_plankFar.graphics.lineTo(453,85);	
			hit_plankFar.graphics.lineTo(463,184);	
			hit_plankFar.graphics.lineTo(420,167);	
			hit_plankFar.graphics.lineTo(420,167);	
			
			hit_plankFar.graphics.endFill(false);
			hit_plankFar.alpha = 0.0;
			
			hit_plankFar.graphics.precisionHitTest = true;	
			this.addChild(hit_plankFar);
		}
		
		private function CreatePlankCloseHit():void{
			hit_plankClose = new Shape();
			hit_plankClose.touchable = false;
			hit_plankClose.graphics.beginFill(0x0000ff);
			
			hit_plankClose.graphics.lineTo(203,304);	
			hit_plankClose.graphics.lineTo(401,169);	
			hit_plankClose.graphics.lineTo(451,180);	
			hit_plankClose.graphics.lineTo(448,193);	
			hit_plankClose.graphics.lineTo(256,359);	
			
			hit_plankClose.graphics.endFill(false);
			hit_plankClose.alpha = 0.0;
			
			hit_plankClose.graphics.precisionHitTest = true;	
			this.addChild(hit_plankClose);
		}
		
		private function CreateStickHit():void{
			hit_stick = new Shape();
			hit_stick.touchable = false;
			hit_stick.graphics.beginFill(0xff0000);
			
			hit_stick.graphics.lineTo(386,197);	
			hit_stick.graphics.lineTo(400,164);	
			hit_stick.graphics.lineTo(457,154);	
			hit_stick.graphics.lineTo(485,193);	
			hit_stick.graphics.lineTo(522,354);	
			hit_stick.graphics.lineTo(504,381);	
			hit_stick.graphics.lineTo(471,388);	
			hit_stick.graphics.lineTo(428,360);	
			
			hit_stick.graphics.endFill(false);
			hit_stick.alpha = 0.0;
			
			hit_stick.graphics.precisionHitTest = true;	
			this.addChild(hit_stick);
		}
		//hit_rock_close
		private function CreateRockFarHit():void{
			hit_rock_far = new Shape();
			hit_rock_far.touchable = false;
			hit_rock_far.graphics.beginFill(0xff0000);
			
			hit_rock_far.graphics.lineTo(390,113);	
			hit_rock_far.graphics.lineTo(390,110);	
			hit_rock_far.graphics.lineTo(412,84);	
			hit_rock_far.graphics.lineTo(441,82);	
			hit_rock_far.graphics.lineTo(493,115);	
			hit_rock_far.graphics.lineTo(511,142);	
			hit_rock_far.graphics.lineTo(465,153);	
			hit_rock_far.graphics.lineTo(446,147);	
			hit_rock_far.graphics.lineTo(398,133);	
			
			hit_rock_far.graphics.endFill(false);
			hit_rock_far.alpha = 0.0;
			
			hit_rock_far.graphics.precisionHitTest = true;	
			this.addChild(hit_rock_far);
		}

		private function CreateRockCloseHit():void{
			hit_rock_close = new Shape();
			hit_rock_close.touchable = false;
			hit_rock_close.graphics.beginFill(0xff0000);
			
			hit_rock_close.graphics.lineTo(360,211);	
			hit_rock_close.graphics.lineTo(368,181);	
			hit_rock_close.graphics.lineTo(435,156);	
			hit_rock_close.graphics.lineTo(491,188);	
			hit_rock_close.graphics.lineTo(499,204);	
			hit_rock_close.graphics.lineTo(494,215);	
			hit_rock_close.graphics.lineTo(404,254);	
			
			hit_rock_close.graphics.endFill(false);
			hit_rock_close.alpha = 0.0;
			
			hit_rock_close.graphics.precisionHitTest = true;	
			this.addChild(hit_rock_close);
		}
		private function CreateTarHit():void{
			hit_tar = new Shape();
			hit_tar.touchable = false;
			hit_tar.graphics.beginFill(0xff0000);

			hit_tar.graphics.lineTo(0,165);
			hit_tar.graphics.lineTo(211,96);
			hit_tar.graphics.lineTo(496,104);
			hit_tar.graphics.lineTo(575,152);
			hit_tar.graphics.lineTo(703,213);
			hit_tar.graphics.lineTo(795,266);
			hit_tar.graphics.lineTo(797,382);
			
			hit_tar.graphics.lineTo(800,512);	
			hit_tar.graphics.lineTo(685,512);	
			hit_tar.graphics.lineTo(464,487);	
			hit_tar.graphics.lineTo(414,357);	
			hit_tar.graphics.lineTo(345,316);	
			hit_tar.graphics.lineTo(246,296);	
			hit_tar.graphics.lineTo(116,305);	
			hit_tar.graphics.lineTo(0,370);	

			hit_tar.graphics.endFill(false);
			hit_tar.alpha = 0.0;
			
			hit_tar.graphics.precisionHitTest = true;	
			this.addChild(hit_tar);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleTarPit as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleTarPitObj,true
						);
					}else if(PlankCloseAttached === true){
						if(PlankFarAttached === true){
							if(hit_farside.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((Jungle as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleObj,true
								);
							}else if(hit_plankClose.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've laid the two wooden planks across the tar pit. Now I can get to the other side.");
							}else if(hit_plankFar.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've laid the two wooden planks across the tar pit. Now I can get to the other side.");
							}else if(hit_rock_close.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								trace("hit_rock_close");
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['TorchStick'] == 'PickedUp'){
										trace("stick picked up");
										RockCloseHandler();						
									}else{
										trace("TP is  def");
										TorchStickHandler();
									}
								}else{
									trace("TP no def");
									RockCloseHandler();
								}
							}else if(hit_rock_far.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								RockFarHandler();
							}else if(hit_stick.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TorchStickHandler();
							}else if(hit_mammoth.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tusks are enormous.");
							}else if(hit_bones_one.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A predator's skeleton.");
							}else if(hit_bones_two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The bones of a very large animal.");
							}else if(hit_WallOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wall of the pit is slick with tar and decaying leaves.");
							}else if(hit_WallTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The pit wall is steep and slippery.");
							}
							//hit_WallOne
							else if(hit_tar.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TarHandler();
							}
						}else{
							if(hit_farside.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I cannot reach the other side.");
							}else if(hit_plankClose.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can now reach the rock in the middle of the tar pit. But, I still cannot reach the other side.");
							}else if(hit_rock_close.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								trace("hit_rock_close");
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['TorchStick'] == 'PickedUp'){
										trace("stick picked up");
										RockCloseHandler();						
									}else{
										trace("TP is  def");
										TorchStickHandler();
									}
								}else{
									trace("TP no def");
									RockCloseHandler();
								}
							}else if(hit_rock_far.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								RockFarHandler();
							}else if(hit_stick.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TorchStickHandler();
							}else if(hit_mammoth.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tusks are enormous.");
							}else if(hit_bones_one.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A predator's skeleton.");
							}else if(hit_bones_two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The bones of a very large animal.");
							}else if(hit_WallOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wall of the pit is slick with tar and decaying leaves.");
							}else if(hit_WallTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The pit wall is steep and slippery.");
							}

							else if(hit_tar.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TarHandler();
							}
						}
					}else if(hit_farside.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I cannot reach the other side.");
					}else if(hit_rock_close.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						trace("hit_rock_close");
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['TorchStick'] == 'PickedUp'){
								trace("stick picked up");
								RockCloseHandler();						
							}else{
								trace("TP is  def");
								TorchStickHandler();
							}
						}else{
							trace("TP no def");
							TorchStickHandler();
						}
					}else if(hit_rock_far.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						RockFarHandler();
					}else if(hit_stick.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						TorchStickHandler();
					}else if(hit_mammoth.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The tusks are enormous.");
					}else if(hit_bones_one.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A predator's skeleton.");
					}else if(hit_bones_two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The bones of a very large animal.");
					}else if(hit_WallOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wall of the pit is slick with tar and decaying leaves.");
					}else if(hit_WallTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The pit wall is steep and slippery.");
					}

					else if(hit_tar.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						TarHandler();
					}
				
						
				}
			}
		}
		private function RockFarHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['PlankClose'] == 'Attached'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_PlankOne)
						
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_PlankOne,
								"item_PlankOne"
							);
						
						plank_back.alpha = 1;
						CreatePlankFarHit();
						PlankFarAttached = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
						}
						
						SaveArray['PlankFar'] = "Attached";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_PlankTwo)
						
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_PlankTwo,
								"item_PlankTwo"
							);
						
						plank_back.alpha = 1;
						CreatePlankFarHit();
						PlankFarAttached = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
						}
						
						SaveArray['PlankFar'] = "Attached";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						!= 
						false)
						
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't help here.");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a rock sticking out from the tar pit.");
					}
				}else{
					RockCloseHandler();
				}
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PlankOne)
					
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_PlankOne,
							"item_PlankOne"
						);
					plank_front.alpha = 1;
					CreatePlankCloseHit();
					PlankCloseAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
					}
					
					SaveArray['PlankClose'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					
					
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PlankTwo)
					
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_PlankTwo,
							"item_PlankTwo"
						);
					plank_front.alpha = 1;
					CreatePlankCloseHit();
					PlankCloseAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
					}
					
					SaveArray['PlankClose'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					!= 
					false)
					
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't help here.");
				}else{

					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a rock sticking out from the tar pit.");
					
					
				}
			}
		}
		
		private function RockCloseHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				trace("1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['PlankClose'] == 'Attached'){
					trace("2");
					RockFarHandler();
				}else{
					trace("3");
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_PlankOne)
						
					{
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_PlankOne,
								"item_PlankOne"
							);
						plank_front.alpha = 1;
						CreatePlankCloseHit();
						PlankCloseAttached = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
						}
						
						SaveArray['PlankClose'] = "Attached";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
							
									
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_PlankTwo)
						
					{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_PlankTwo,
								"item_PlankTwo"
							);
						plank_front.alpha = 1;
						CreatePlankCloseHit();
						PlankCloseAttached = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
						}
						
						SaveArray['PlankClose'] = "Attached";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
						
						
					}else if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						!= 
						false)
						
					{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't help here.");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a rock sticking out from the tar pit.");
					}
				}
			}else{
				trace("4");
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PlankOne)
					
				{
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_PlankOne,
							"item_PlankOne"
						);
					trace("5");
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					plank_front.alpha = 1;
					CreatePlankCloseHit();
					PlankCloseAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
					}
					
					SaveArray['PlankClose'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					
					
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PlankTwo)
					
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_PlankTwo,
							"item_PlankTwo"
						);
					trace("6");
					plank_front.alpha = 1;
					CreatePlankCloseHit();
					PlankCloseAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
					}
					
					SaveArray['PlankClose'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					!= 
					false)
					
				{
					trace("7");
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't help here.");
				}else{
					trace("8");
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a rock sticking out from the tar pit.");
				}
			}
		}
		
		private function TarHandler():void{
			
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Torch)
					
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_TorchTar,
						'item_TorchTar',
						'inven_torchTar_sm',
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Torch,
						'item_Torch'
					);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
					}
					
					SaveArray['TarTorch'] = "Yes";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PlankOne)
					
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("In need to balance the plank on the rocks in the middle of the pit.");
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_PlankTwo)
					
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("In need to balance the plank on the rocks in the middle of the pit.");
				}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_Bucket)
					
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_BucketTar,
						'item_BucketTar',
						'inven_bucketTar_sm',
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Bucket,
						'item_Bucket'
					);
				
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
					}
					SaveArray['BucketTar'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					
				}else if((stage.getChildAt(0) as Object)		
					.screenGamePlayHandler
					.InventoryObj.armedItem
					!= 
					false)
					
				{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Putting that item into the tar would serve no purpose.");
				}else{
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A primordial tar pit.... If I fall in, I may become stuck and slowly sucked under...");
				}
		}
		private function TorchStickHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit['TorchStick'] == 'PickedUp'){
					TarHandler();
				}else{
					stick.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleTarPitPit;
					SaveArray['TorchStick'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_TorchStick,
						'item_TorchStick',
						'inven_torchStick_sm'
					);
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
				}
			}else{
				stick.alpha = 0;
				SaveArray['TorchStick'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleTarPitPit',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_TorchStick,
					'item_TorchStick',
					'inven_torchStick_sm'
				);
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
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
			
			
			this.assets.removeTexture("jungleTarPitPit_bg",true);
			this.assets.removeTexture("JungleTarPitPit_Sprite",true);
			this.assets.removeTextureAtlas("JungleTarPitPit_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleTarPitPit_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleTarPitPit_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleTarPitPit_03");
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
