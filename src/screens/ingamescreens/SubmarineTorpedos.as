package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class SubmarineTorpedos extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var wrench:Image;
		private var doorLeft:Image;
		private var doorRight:Image;
		private var left_sign_closed:Image;
		private var left_sign_open:Image;
		private var right_sign_closed:Image;
		private var right_sign_open:Image;
		private var blowtorch:Image;
		
		private var hit_wrench:Shape;
		private var hit_door_left:Shape;
		private var hit_door_right:Shape;
		
		private var hit_intercom:Shape;
		private var hit_floor:Shape;
		private var hit_wall:Shape;
		private var hit_sign_left:Shape;
		private var hit_sign_right:Shape;
		
		private var hit_blowtorch:Shape;
		private var hit_tunnel_left:Shape;
		private var hit_tunnel_right:Shape;
		
		private var PowerOn:Boolean = false;
		
		private var DoorLeftOpen:Boolean = false;
		private var DoorRightOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function SubmarineTorpedos(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineTorpedos_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineTorpedos/SubmarineTorpedos_Sprite_02.jpg'));
				game.TrackAssets('submarineTorpedos_01');
			}
			if(game.CheckAsset('submarineTorpedos_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineTorpedos/SubmarineTorpedos_Sprite_02.xml'));
				game.TrackAssets('submarineTorpedos_02');
			}
			if(game.CheckAsset('submarineTorpedos_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineTorpedos/SubmarineTorpedos_Sprite.png'));
				game.TrackAssets('submarineTorpedos_03');
			}
			if(game.CheckAsset('submarineTorpedos_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineTorpedos/SubmarineTorpedos_Sprite.xml'));
				game.TrackAssets('submarineTorpedos_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineTorpedos","SubmarineTorpedosObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineTorpedos_red_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			wrench = new Image(this.assets.getTexture('wrench_red'));
			//wrench.smoothing = TextureSmoothing.NONE;

			wrench.touchable = false;
			wrench.x = 346;
			wrench.y = 297;
			
			blowtorch = new Image(this.assets.getTexture('blowtorch'));
			//blowtorch.smoothing = TextureSmoothing.NONE;

			blowtorch.touchable = false;
			blowtorch.x = 103;
			blowtorch.y = 267;

			
			doorLeft = new Image(this.assets.getTexture('door_left'));
		//	doorLeft.smoothing = TextureSmoothing.NONE;

			doorLeft.touchable = false;
			doorLeft.x = 1;
			doorLeft.y = 138;

			
			
			doorRight = new Image(this.assets.getTexture('door_right'));
		//	doorRight.smoothing = TextureSmoothing.NONE;

			doorRight.touchable = false;
			doorRight.x = 447;
			doorRight.y = 97;
			
			left_sign_closed = new Image(this.assets.getTexture('closed_left'));
		//	left_sign_closed.smoothing = TextureSmoothing.NONE;

			left_sign_closed.touchable = false;
			left_sign_closed.x = 251;
			left_sign_closed.y = 36;
			
			left_sign_open = new Image(this.assets.getTexture('open_left'));
		//	left_sign_open.smoothing = TextureSmoothing.NONE;

			left_sign_open.touchable = false;
			left_sign_open.x = 260;
			left_sign_open.y = 99;
			
			right_sign_closed = new Image(this.assets.getTexture('closed_right'));
		//	right_sign_closed.smoothing = TextureSmoothing.NONE;

			right_sign_closed.touchable = false;
			right_sign_closed.x = 416;
			right_sign_closed.y = 17;
			
			right_sign_open = new Image(this.assets.getTexture('open_right'));
		//	right_sign_open.smoothing = TextureSmoothing.NONE;

			right_sign_open.touchable = false;
			right_sign_open.x = 425;
			right_sign_open.y = 79;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['Wrench'] == 'PickedUp'){
					wrench.alpha = 0;
				}else{
					wrench.alpha = 1;
				}
			}else{
				wrench.alpha = 1;
			}
		
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				trace("1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					PowerOn = true;
					bg.texture = this.assets.getTexture('submarineTorpedos_lit_bg');
					wrench.texture = this.assets.getTexture('wrench_lit');
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['DoorLeft'] == 'open'){
							DoorLeftOpen = true;
							doorLeft.alpha = 0;
							left_sign_closed.alpha = 0;
							left_sign_open.alpha = 1;
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['Blowtorch'] == 'PickedUp'){
								trace("BLOW TORCH PICKED UP");
								blowtorch.alpha = 0;
							}else{
								trace("BLOW TORCH NOT PICKED UP");
								blowtorch.alpha = 1;
							}
							CreateHitTunnelLeft();
							CreateHitBlowtorch();
						}else{
							blowtorch.alpha = 0;
							doorLeft.alpha = 1;
							left_sign_closed.alpha = 1;
							left_sign_open.alpha = 0;
						}
					}else{
						blowtorch.alpha = 0;
						doorLeft.alpha = 1;
						left_sign_closed.alpha = 1;
						left_sign_open.alpha = 0;
					}

					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['DoorRight'] == 'open'){
							DoorRightOpen = true;
							doorRight.alpha = 0;
							right_sign_closed.alpha = 0;
							right_sign_open.alpha = 1;
							
							CreateHitTunnelRight();
						}else{
							
							doorRight.alpha = 1;
							right_sign_closed.alpha = 1;
							right_sign_open.alpha = 0;
						}
					}else{
						
						doorRight.alpha = 1;
						right_sign_closed.alpha = 1;
						right_sign_open.alpha = 0;
					}
					
					
				}else{
					blowtorch.alpha = 0;
					doorLeft.alpha = 0;
					
					doorRight.alpha = 0;
					
					left_sign_closed.alpha = 0;
					left_sign_open.alpha = 0;
					right_sign_closed.alpha = 0;
					right_sign_open.alpha = 0;
				}
			}else{

				blowtorch.alpha = 0;
				doorLeft.alpha = 0;
				doorRight.alpha = 0;
				
				left_sign_closed.alpha = 0;
				left_sign_open.alpha = 0;
				right_sign_closed.alpha = 0;
				right_sign_open.alpha = 0;
				
			}

			this.addChildAt(wrench,1);
			this.addChildAt(blowtorch,2);
			this.addChildAt(doorLeft,3);
			this.addChildAt(doorRight,4);
			this.addChildAt(left_sign_closed,5);
			this.addChildAt(left_sign_open,6);
			this.addChildAt(right_sign_closed,7);
			this.addChildAt(right_sign_open,8);
			
			
			CreateHitIntercom();
			CreateHitSignRight();
			CreateHitSignLeft()
			CreateHitWall();
			CreateHitFloor();
			
			CreateHitWrench();

			CreateDoorRightHit(DoorRightOpen);
			CreateDoorLeftHit(DoorLeftOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDrips(true,999);
		}
		
		private function CreateHitFloor():void{
			hit_floor = new Shape();
			hit_floor.touchable = false;
			hit_floor.graphics.beginFill(0x0000ff);
			
			hit_floor.graphics.lineTo(92,424);	
			hit_floor.graphics.lineTo(720,355);	
			hit_floor.graphics.lineTo(673,512);	
			hit_floor.graphics.lineTo(82,512);	
			
			hit_floor.alpha = 0.0;
			
			hit_floor.graphics.endFill(false);
			
			hit_floor.graphics.precisionHitTest = true;	
			this.addChild(hit_floor);
			
		}
		
		
		private function CreateHitWall():void{
			hit_wall = new Shape();
			hit_wall.touchable = false;
			hit_wall.graphics.beginFill(0x0000ff);
			
			hit_wall.graphics.lineTo(0,0);	
			hit_wall.graphics.lineTo(650,0);	
			hit_wall.graphics.lineTo(684,113);	
			hit_wall.graphics.lineTo(0,188);	
		
			hit_wall.alpha = 0.0;
			
			hit_wall.graphics.endFill(false);
			
			hit_wall.graphics.precisionHitTest = true;	
			this.addChild(hit_wall);
			
		}
		
		
		private function CreateHitSignLeft():void{
			hit_sign_left = new Shape();
			hit_sign_left.touchable = false;
			hit_sign_left.graphics.beginFill(0x0000ff);
			
			hit_sign_left.graphics.lineTo(243,32);	
			hit_sign_left.graphics.lineTo(313,27);	
			hit_sign_left.graphics.lineTo(326,142);	
			hit_sign_left.graphics.lineTo(258,148);	
			
			hit_sign_left.alpha = 0.0;
			
			hit_sign_left.graphics.endFill(false);
			
			hit_sign_left.graphics.precisionHitTest = true;	
			this.addChild(hit_sign_left);
			
		}
		
		private function CreateHitSignRight():void{
			hit_sign_right = new Shape();
			hit_sign_right.touchable = false;
			hit_sign_right.graphics.beginFill(0x0000ff);
			
			hit_sign_right.graphics.lineTo(411,12);	
			hit_sign_right.graphics.lineTo(479,8);	
			hit_sign_right.graphics.lineTo(490,119);	
			hit_sign_right.graphics.lineTo(425,130);	
			
			hit_sign_right.alpha = 0.0;
			
			hit_sign_right.graphics.endFill(false);
			
			hit_sign_right.graphics.precisionHitTest = true;	
			this.addChild(hit_sign_right);
			
		}
		
		
		private function CreateHitIntercom():void{
			hit_intercom = new Shape();
			hit_intercom.touchable = false;
			hit_intercom.graphics.beginFill(0x0000ff);
			
			hit_intercom.graphics.lineTo(309,0);	
			hit_intercom.graphics.lineTo(410,0);	
			hit_intercom.graphics.lineTo(440,206);	
			hit_intercom.graphics.lineTo(335,218);	
		
			hit_intercom.alpha = 0.0
			
			hit_intercom.graphics.endFill(false);
			
			hit_intercom.graphics.precisionHitTest = true;	
			this.addChild(hit_intercom);
			
		}
		
		
		
		private function CreateHitBlowtorch():void{
			hit_blowtorch = new Shape();
			hit_blowtorch.touchable = false;
			hit_blowtorch.graphics.beginFill(0x0000ff);
			
			hit_blowtorch.graphics.lineTo(147,268);	
			hit_blowtorch.graphics.lineTo(268,257);	
			hit_blowtorch.graphics.lineTo(264,382);	
			hit_blowtorch.graphics.lineTo(167,397);	

			
			hit_blowtorch.alpha = 0.0;
			
			hit_blowtorch.graphics.endFill(false);
			
			hit_blowtorch.graphics.precisionHitTest = true;	
			this.addChild(hit_blowtorch);
			
		}
		
		private function CreateHitTunnelLeft():void{
			hit_tunnel_left = new Shape();
			hit_tunnel_left.touchable = false;
			hit_tunnel_left.graphics.beginFill(0x0000ff);
			
			hit_tunnel_left.graphics.lineTo(98,288);	
			hit_tunnel_left.graphics.lineTo(126,202);	
			hit_tunnel_left.graphics.lineTo(201,172);	
			hit_tunnel_left.graphics.lineTo(279,202);	
			hit_tunnel_left.graphics.lineTo(311,308);	
			hit_tunnel_left.graphics.lineTo(252,381);	
			hit_tunnel_left.graphics.lineTo(160,388);	

			hit_tunnel_left.alpha = 0.0;
			
			hit_tunnel_left.graphics.endFill(false);
			
			hit_tunnel_left.graphics.precisionHitTest = true;	
			this.addChild(hit_tunnel_left);
			
		}
		
		private function CreateHitTunnelRight():void{
			hit_tunnel_right = new Shape();
			hit_tunnel_right.touchable = false;
			hit_tunnel_right.graphics.beginFill(0x0000ff);
			
			hit_tunnel_right.graphics.lineTo(475,242);	
			hit_tunnel_right.graphics.lineTo(500,163);	
			hit_tunnel_right.graphics.lineTo(570,124);	
			hit_tunnel_right.graphics.lineTo(674,174);	
			hit_tunnel_right.graphics.lineTo(678,261);	
			hit_tunnel_right.graphics.lineTo(643,314);	
			hit_tunnel_right.graphics.lineTo(559,332);	
			hit_tunnel_right.graphics.lineTo(490,288);	
			
			hit_tunnel_right.alpha = 0.0;
			
			hit_tunnel_right.graphics.endFill(false);
			
			hit_tunnel_right.graphics.precisionHitTest = true;	
			this.addChild(hit_tunnel_right);
			
		}
		
		private function CreateHitWrench():void{
			hit_wrench = new Shape();
			hit_wrench.touchable = false;
			hit_wrench.graphics.beginFill(0x0000ff);
			
			hit_wrench.graphics.lineTo(331,321);	
			hit_wrench.graphics.lineTo(338,285);	
			hit_wrench.graphics.lineTo(376,280);	
			hit_wrench.graphics.lineTo(462,366);	
			hit_wrench.graphics.lineTo(466,394);	
			hit_wrench.graphics.lineTo(448,418);	
			hit_wrench.graphics.lineTo(416,414);	

			hit_wrench.alpha = 0.0;
			
			hit_wrench.graphics.endFill(false);
			
			hit_wrench.graphics.precisionHitTest = true;	
			this.addChild(hit_wrench);
			
		}
		
		private function CreateDoorLeftHit(open:Boolean = false):void{
			hit_door_left = new Shape();
			this.addChild(hit_door_left);
			if(open === false){
				
				hit_door_left.x = 0;
				hit_door_left.y = 0;
				hit_door_left.graphics.beginFill(0x0000FF);
				hit_door_left.graphics.lineTo(42,297);	
				hit_door_left.graphics.lineTo(54,217);	
				hit_door_left.graphics.lineTo(123,150);	
				hit_door_left.graphics.lineTo(216,138);	
				hit_door_left.graphics.lineTo(310,186);	
				hit_door_left.graphics.lineTo(342,255);	
				hit_door_left.graphics.lineTo(315,366);	
				hit_door_left.graphics.lineTo(230,422);	
				hit_door_left.graphics.lineTo(121,409);	
				hit_door_left.graphics.lineTo(66,363);	
				
				hit_door_left.graphics.endFill(false);
				
				hit_door_left.alpha = 0.0;
				
				hit_door_left.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_door_left.x = 0;
				hit_door_left.y = 0;
				hit_door_left.graphics.beginFill(0x0000FF);		
				hit_door_left.graphics.lineTo(0,122);	
				hit_door_left.graphics.lineTo(72,122);	
				hit_door_left.graphics.lineTo(126,512);	
				hit_door_left.graphics.lineTo(0,512);	

				hit_door_left.graphics.endFill(false);
				hit_door_left.alpha = 0.0;
				
				hit_door_left.graphics.precisionHitTest = true;				
			}
			hit_door_left.touchable = false;
			
		}		
		
		private function CreateDoorRightHit(open:Boolean = false):void{
			hit_door_right = new Shape();
			this.addChild(hit_door_right);
			if(open === false){
				
				hit_door_right.x = 0;
				hit_door_right.y = 0;
				hit_door_right.graphics.beginFill(0x0000FF);
				hit_door_right.graphics.lineTo(443,243);	
				hit_door_right.graphics.lineTo(463,157);	
				hit_door_right.graphics.lineTo(522,104);	
				hit_door_right.graphics.lineTo(624,94);	
				hit_door_right.graphics.lineTo(700,138);	
				hit_door_right.graphics.lineTo(731,208);	
				hit_door_right.graphics.lineTo(718,300);	
				hit_door_right.graphics.lineTo(657,355);	
				hit_door_right.graphics.lineTo(561,366);	
				hit_door_right.graphics.lineTo(464,304);	

				hit_door_right.graphics.endFill(false);
				
				hit_door_right.alpha = 0.0;
				
				hit_door_right.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_door_right.x = 0;
				hit_door_right.y = 0;
				hit_door_right.graphics.beginFill(0x0000FF);		
				hit_door_right.graphics.lineTo(698,114);	
				hit_door_right.graphics.lineTo(796,113);	
				hit_door_right.graphics.lineTo(797,381);	
				hit_door_right.graphics.lineTo(734,385);	
				hit_door_right.graphics.lineTo(703,225);	
				
				hit_door_right.graphics.endFill(false);
				hit_door_right.alpha = 0.0;
				
				hit_door_right.graphics.precisionHitTest = true;				
			}
			hit_door_right.touchable = false;
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((SubmarineLowerLevel as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineLowerLevelObj,true
						);
					}else if(hit_wrench.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						WrenchHandler();
					}else if(hit_door_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PowerOn === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't open it.");
						}else{
							if(DoorLeftOpen === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
								LeftDoorHandler(true);
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyCloseTwo();
								LeftDoorHandler(false);
							}
						}
					}else if(hit_door_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PowerOn === false){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_LockedDoor();
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The door won't budge. It must be linked to the main power supply.");
						}else{
							if(DoorRightOpen === false){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpenTwo();
								RightDoorHandler(true);
							}else{
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyCloseTwo();
								RightDoorHandler(false);
							}
						}
					}else if(DoorLeftOpen === true){
						if(hit_blowtorch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							BlowtorchHandler();
						}else if(hit_tunnel_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I believe this is a torpedo bay. It's dark and murky inside.");
						}else if(DoorRightOpen === true){
							if(hit_tunnel_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A torpedo tube loading bay.");
							}else{
								OtherHitHandler(e);
							}
						}else{
							OtherHitHandler(e);
						}
					}
					else if(DoorRightOpen === true){
						if(hit_tunnel_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A torpedo tube loading bay.");
						}else{
							OtherHitHandler(e);
						}
					}else{
						OtherHitHandler(e);
					}
					
					/*
					
					private var hit_intercom:Shape;
					private var hit_floor:Shape;
					private var hit_wall:Shape;
					private var hit_sign_left:Shape;
					private var hit_sign_right:Shape;
					
					*/
					
				}
			}
		}
		private function OtherHitHandler(e:Event):void{
			if(hit_intercom.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sub's intercom system... too bad there's no one to talk to.");
			}else if(hit_floor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor has a set of tracks leading to each tube.");
			}else if(hit_sign_left.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				if(PowerOn === true){
					if(DoorLeftOpen === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sign says 'open.'");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sign says the torpedo tube is closed.");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An indicator sign for the torpedo tube.");
				}
			}else if(hit_sign_right.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				if(PowerOn === true){
					if(DoorRightOpen === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sign says 'open.'");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sign says the torpedo tube is closed.");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A sign to let the crew know if the tube is open or not.");
				}
			}else if(hit_wall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Pipes and ventilation shafts cover the walls.");
			}
		}
			
		private function BlowtorchHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['Blowtorch'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I hope this submarine never had to launch a torpedo from here. Seems like it never will again at least.");
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					blowtorch.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos;
					}
					SaveArray["Blowtorch"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineTorpedos',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_BlowTorch,
						'item_BlowTorch',
						'inven_blowtorch_sm'
					);
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						Starling.juggler.delayCall(function():void{					
							(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,1);
						},1);
					}
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				blowtorch.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos;
				}
				SaveArray["Blowtorch"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineTorpedos',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_BlowTorch,
					'item_BlowTorch',
					'inven_blowtorch_sm'
				);
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					Starling.juggler.delayCall(function():void{					
						(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,1);
					},1);
				}
			}
		}
		
		private function LeftDoorHandler(openClose:Boolean):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos;
			}
			if(openClose === true){
				DoorLeftOpen = true;
				SaveArray["DoorLeft"] = "open";
				doorLeft.alpha = 0;
				
				left_sign_closed.alpha = 0;
				left_sign_open.alpha = 1;
				
				hit_door_left.graphics.clear();
				CreateDoorLeftHit(true);
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['Blowtorch'] == 'PickedUp'){
						trace("BLOW TORCH PICKED UP");
						blowtorch.alpha = 0;
					}else{
						trace("BLOW TORCH NOT PICKED UP");
						blowtorch.alpha = 1;
					}
				}else{
					blowtorch.alpha = 1;
				}
				
				CreateHitTunnelLeft();
				CreateHitBlowtorch();
				
			}else{
				DoorLeftOpen = false;
				SaveArray["DoorLeft"] = "closed";
				doorLeft.alpha = 1;
				
				left_sign_closed.alpha = 1;
				left_sign_open.alpha = 0;
				
				this.removeChild(hit_blowtorch);
				this.removeChild(hit_tunnel_left);
				hit_door_left.graphics.clear();
				CreateDoorLeftHit(false);
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineTorpedos',SaveArray);
		}
		
		private function RightDoorHandler(openClose:Boolean):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos;
			}
			if(openClose === true){
				DoorRightOpen = true;
				SaveArray["DoorRight"] = "open";
				doorRight.alpha = 0;
				
				right_sign_closed.alpha = 0;
				right_sign_open.alpha = 1;
				
				hit_door_right.graphics.clear();
				CreateDoorRightHit(true);
				CreateHitTunnelRight();
			}else{
				DoorRightOpen = false;
				SaveArray["DoorRight"] = "closed";
				
				doorRight.alpha = 1;
				right_sign_closed.alpha = 1;
				right_sign_open.alpha = 0;
				
				this.removeChild(hit_tunnel_right);
				
				hit_door_right.graphics.clear();
				CreateDoorRightHit(false);
	
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineTorpedos',SaveArray);
		}
		
		
		private function WrenchHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos['Wrench'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					wrench.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos;
					}
					SaveArray["Wrench"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineTorpedos',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Wrench,
						'item_Wrench',
						'inven_wrench_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				wrench.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineTorpedos;
				}
				SaveArray["Wrench"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineTorpedos',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Wrench,
					'item_Wrench',
					'inven_wrench_sm'
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
			
			
			
			this.assets.removeTexture("SubmarineTorpedos_Sprite_02",true);
			this.assets.removeTexture("SubmarineTorpedos_Sprite",true);
			this.assets.removeTextureAtlas("SubmarineTorpedos_Sprite_02",true);
			this.assets.removeTextureAtlas("SubmarineTorpedos_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineTorpedos_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineTorpedos_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineTorpedos_03");
			(stage.getChildAt(0) as Object).falseAsset("submarineTorpedos_04");
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
