package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class FreighterWheel extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		public var delayedcall:DelayedCall;
		
		private var bg:Image;
		private var wheel_mc:MovieClip;
		private var puller_mc:MovieClip;
		
		private var hit_puller:Shape;
		private var hit_wheelLeft:Shape;
		private var hit_wheelRight:Shape;
		
		private var Animating:Boolean = false;
		private var PullerReverseDirection:Boolean = false;
		private var WheelReverseDirection:Boolean = false;
		
		private var PullerPos:int = 0;
		
		private var Pos_0_Dir_LEFT:int = 0;
		private var Pos_1_Dir_RIGHT:int = 0;
		private var Pos_2_Dir_LEFT:int = 0;
		private var Pos_3_Dir_RIGHT:int = 0;
		
		private var Pos_0_Valid:Boolean = true;
		private var Pos_1_Valid:Boolean = true;
		private var Pos_2_Valid:Boolean = true;
		private var Pos_3_Valid:Boolean = true;
		
		private var touches:Vector.<Touch>;
		
		private var Solved:Boolean = false;
		
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		
		public function FreighterWheel(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterWheel_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWheel/freighterWheel_bg.jpg'));
				game.TrackAssets('freighterWheel_01');
			}
			
		//	if(game.CheckAsset('freighterWheel_02') === false){
		//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWheel/FreighterSteeringWheel_Sprite.png'));
		//		game.TrackAssets('freighterWheel_02');
		//	}
		//	if(game.CheckAsset('freighterWheel_03') === false){
		//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWheel/FreighterSteeringWheel_Sprite.xml'));
		//		game.TrackAssets('freighterWheel_03');
		//	}
		//	if(game.CheckAsset('freighterWheel_04') === false){
		//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWheel/FreighterPuller_Sprite.png'));
		//		game.TrackAssets('freighterWheel_04');
		//	}
		//	if(game.CheckAsset('freighterWheel_05') === false){
		//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWheel/FreighterPuller_Sprite.xml'));
		//		game.TrackAssets('freighterWheel_05');
		//	}
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterWheel","FreighterWheelObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{

			bg = new Image(this.assets.getTexture('freighterWheel_bg'));
			bg.touchable = true;
			this.addChild(bg);
				

			//if((stage.getChildAt(0) as Object).FreighterSteeringWheelImages.Loaded === true){
			//	wheel_mc = new MovieClip((stage.getChildAt(0) as Object).WheelLockImages.assets.getTextures("wheel_01"),12);
			      // (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_four")
				wheel_mc = new MovieClip((stage.getChildAt(0) as Object).FreighterWheelImages.assets.getTextures('swheel_'),12);
					//		LargeWheel_mc.smoothing = TextureSmoothing.NONE;
				wheel_mc.x = 0;
				wheel_mc.y = 0;
				wheel_mc.width = 478;
				wheel_mc.height = 512;
				wheel_mc.touchable = false;
				wheel_mc.loop = true; // default: true
				wheel_mc.stop();
				this.addChild(wheel_mc);	
				
				puller_mc = new MovieClip((stage.getChildAt(0) as Object).FreighterWheelImages.assets.getTextures('puller_'),12);
				//puller_mc.smoothing = TextureSmoothing.NONE;
				puller_mc.x = 468;
				puller_mc.y = 36;
				puller_mc.width = 290;
				puller_mc.height = 280;
				puller_mc.touchable = false;
				puller_mc.loop = true; // default: true
				puller_mc.stop();
				this.addChild(puller_mc);
				/*
				SaveArray['Pos_0_Dir_LEFT'] = Pos_0_Dir_LEFT;
				SaveArray['Pos_1_Dir_RIGHT'] = Pos_1_Dir_RIGHT;
				SaveArray['Pos_2_Dir_LEFT'] = Pos_2_Dir_LEFT;
				SaveArray['Pos_3_Dir_RIGHT'] = Pos_3_Dir_RIGHT;
				SaveArray['Pos_0_Valid'] = Pos_0_Valid;
				SaveArray['Pos_1_Valid'] = Pos_1_Valid;
				SaveArray['Pos_2_Valid'] = Pos_2_Valid;
				SaveArray['Pos_3_Valid'] = Pos_3_Valid;
				SaveArray['PullerPos'] = PullerPos;
				SaveArray['PullerFrame'] = puller_mc.currentFrame;
				SaveArray['PullerReverseDirection'] = PullerReverseDirection;
				*/
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Solved'] == 'Yes'){
						Solved = true;
					}else{
						Solved = false;
					}
					
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Puller'] == 'Attached'){
						puller_mc.alpha = 1;
						trace("YES");
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerPos'] != null){
							trace("YES2");
							PullerPos = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerPos'];
							puller_mc.currentFrame = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerFrame'];
						}else{
							PullerPos = 0;
							puller_mc.currentFrame =0;
						}
						//PullerReverseDirection
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['PullerReverseDirection'] === false){
							PullerReverseDirection = false;
						}else{
							PullerReverseDirection = true;
						}
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_0_Dir_LEFT'] != undefined){
							Pos_0_Dir_LEFT = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_0_Dir_LEFT'];
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_1_Dir_RIGHT'] != undefined){
							Pos_1_Dir_RIGHT = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_1_Dir_RIGHT'];
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_2_Dir_LEFT'] != undefined){
							Pos_2_Dir_LEFT = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_2_Dir_LEFT'];
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_3_Dir_RIGHT'] != undefined){
							Pos_3_Dir_RIGHT = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_3_Dir_RIGHT'];
						}
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_0_Valid'] === true){
							Pos_0_Valid = true;
						}else{
							Pos_0_Valid = false;
						}
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_1_Valid'] === true){
							Pos_1_Valid = true;
						}else{
							Pos_1_Valid = false;
						}
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_2_Valid'] === true){
							Pos_2_Valid = true;
						}else{
							Pos_2_Valid = false;
						}
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Pos_3_Valid'] === true){
							Pos_3_Valid = true;
						}else{
							Pos_3_Valid = false;
						}
						
					}else{
						puller_mc.alpha = 0;
						//(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's throttle.");

					}
					
					
				}else{
					puller_mc.alpha = 0;
					puller_mc.currentFrame = 0;
				}
				
			//}
			
			CreatePullerHit();
			CreateWheelHit();	
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
		private function CreatePullerHit():void{
			hit_puller = new Shape();
			hit_puller.touchable = false;
			hit_puller.graphics.beginFill(0xff0000);
			
			hit_puller.graphics.lineTo(470,197);	
			hit_puller.graphics.lineTo(592,48);	
			hit_puller.graphics.lineTo(653,48);	
			hit_puller.graphics.lineTo(696,119);	
			hit_puller.graphics.lineTo(770,170);	
			hit_puller.graphics.lineTo(768,326);	
			hit_puller.graphics.lineTo(470,307);	
			
			hit_puller.graphics.endFill(false);
			hit_puller.alpha = 0.0;
			
			hit_puller.graphics.precisionHitTest = true;	
			this.addChild(hit_puller);
		}
		
		private function CreateWheelHit():void{
			hit_wheelLeft = new Shape();
			hit_wheelLeft.touchable = false;
			hit_wheelLeft.graphics.beginFill(0xff0000);
			
			hit_wheelLeft.graphics.lineTo(0,164);	
			hit_wheelLeft.graphics.lineTo(107,32);	
			hit_wheelLeft.graphics.lineTo(265,0);	
			hit_wheelLeft.graphics.lineTo(273,512);	
			hit_wheelLeft.graphics.lineTo(128,512);	
			hit_wheelLeft.graphics.lineTo(0,368);		
	
			hit_wheelLeft.graphics.endFill(false);
			hit_wheelLeft.alpha = 0.0;
			
			hit_wheelLeft.graphics.precisionHitTest = true;	
			this.addChild(hit_wheelLeft);
			
			hit_wheelRight = new Shape();
			hit_wheelRight.touchable = false;
			hit_wheelRight.graphics.beginFill(0xff0000);
			
			hit_wheelRight.graphics.lineTo(266,0);	
			hit_wheelRight.graphics.lineTo(399,55);	
			hit_wheelRight.graphics.lineTo(468,176);	
			hit_wheelRight.graphics.lineTo(464,320);	
			hit_wheelRight.graphics.lineTo(398,434);	
			hit_wheelRight.graphics.lineTo(274,512);	
			
			
			hit_wheelRight.graphics.endFill(false);
			hit_wheelRight.alpha = 0.0;
			
			hit_wheelRight.graphics.precisionHitTest = true;	
			this.addChild(hit_wheelRight);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					
					trace("wheel_mc.numFrames: "+ wheel_mc.numFrames);
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((FreighterUpper as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterUpperObj,true
							);
						}else if(hit_wheelLeft.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){

							Animating = true;
							WheelReverseDirection = false;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
							wheel_mc.currentFrame =wheel_mc.currentFrame+1;
							wheel_mc.addEventListener(EnterFrameEvent.ENTER_FRAME, onWheelFrame);

						}else if(hit_wheelRight.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
							Animating = true;
							WheelReverseDirection = true;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
							wheel_mc.currentFrame = wheel_mc.numFrames-1
							wheel_mc.addEventListener(EnterFrameEvent.ENTER_FRAME, onWheelFrame);
							
						}else if(hit_puller.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Solved'] == 'yes'){
									
									trace("Something");
								}else{
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Puller'] == 'Attached'){
										Animating = true;
										if(puller_mc.currentFrame == puller_mc.numFrames-1){
											puller_mc.currentFrame = puller_mc.currentFrame-1;
										}else if(puller_mc.currentFrame == 11){
											if(PullerReverseDirection === true){
												puller_mc.currentFrame = puller_mc.currentFrame-1;
											}else{
												puller_mc.currentFrame = puller_mc.currentFrame+1;
											}
										}else{
											puller_mc.currentFrame = puller_mc.currentFrame+1;
										}
										puller_mc.addEventListener(EnterFrameEvent.ENTER_FRAME, AnimatePuller);
										
									}else{
										AttachPuller();
									}
								}
							}else{
								AttachPuller();
							}
								
							
						}
					}else{
						
					}
				}
			}
		}
		private function AnimatePuller(e:Event):void{
			if(puller_mc.currentFrame == 11){
				Animating = false;
				puller_mc.pause();
				puller_mc.removeEventListener(EnterFrameEvent.ENTER_FRAME, AnimatePuller);
				
				if(PullerReverseDirection === false){
					PullerPos = 1;
				}else{
					PullerPos = 3;
				}
				
				SavePullerInfo();
			}else if(puller_mc.currentFrame == 23){
				PullerReverseDirection = true;
				Animating = false;
				puller_mc.pause();
				puller_mc.removeEventListener(EnterFrameEvent.ENTER_FRAME, AnimatePuller);
				
				PullerPos = 2;
				
				SavePullerInfo();
			}else if(puller_mc.currentFrame == 0){
				PullerReverseDirection = false;
				Animating = false;
				puller_mc.pause();
				puller_mc.removeEventListener(EnterFrameEvent.ENTER_FRAME, AnimatePuller);
				
				PullerPos = 0;
				
				SavePullerInfo();
				Solve();
			}else{
				if(PullerReverseDirection === false){
					puller_mc.currentFrame = puller_mc.currentFrame+1;
				}else{
					puller_mc.currentFrame = puller_mc.currentFrame-1;
				}
			}
			
		}
		
		private function SavePullerInfo():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel;
			}
			
			trace('PullerPos: '+PullerPos);
			SaveArray['PullerPos'] = PullerPos;
			SaveArray['PullerFrame'] = puller_mc.currentFrame;
			SaveArray['PullerReverseDirection'] = PullerReverseDirection;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterWheel',SaveArray);
		}
		
		private function AttachPuller():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Puller)
			{
				trace("The Puller is Armed");
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Puller,
						"item_Puller"
					);
				
				puller_mc.alpha = 1;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel;			
				}
				SaveArray['Pos_0_Dir_LEFT'] = 0;
				SaveArray['Pos_1_Dir_RIGHT'] = 0;
				SaveArray['Pos_2_Dir_LEFT'] = 0;
				SaveArray['Pos_3_Dir_RIGHT'] = 0;
				SaveArray['Pos_0_Valid'] = true;
				SaveArray['Pos_1_Valid'] = true;
				SaveArray['Pos_2_Valid'] = true;
				SaveArray['Pos_3_Valid'] = true;
				
				
				SaveArray['Puller'] = 'Attached';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterWheel',SaveArray);
				
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's throttle. Looks like it's missing a part.");
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(false,0);			
			}
		}
		
		private function onWheelFrame(e:Event):void{
			trace("wheel_mc.currentFrame="+wheel_mc.currentFrame);
			if(wheel_mc.currentFrame == 0 ){

				Animating = false;
				wheel_mc.pause();
				wheel_mc.removeEventListener(EnterFrameEvent.ENTER_FRAME, onWheelFrame);
				
				if(WheelReverseDirection === false){
					if(PullerPos == 0){
						Pos_0_Dir_LEFT += 1;
					}else if(PullerPos == 1){
						Pos_1_Dir_RIGHT = 0;
						Pos_1_Valid = false;
					}else if(PullerPos == 2){
						Pos_2_Dir_LEFT =+ 1;
					}else if(PullerPos == 3){
						Pos_3_Dir_RIGHT = 0;
						Pos_3_Valid = false;
					}

				}else{
					if(PullerPos == 0){
						Pos_0_Dir_LEFT = 0;
						Pos_0_Valid = false;
					}else if(PullerPos == 1){
						Pos_1_Dir_RIGHT += 1;
					}else if(PullerPos == 2){
						Pos_2_Dir_LEFT =0;
						Pos_2_Valid = false;
					}else if(PullerPos == 3){
						Pos_3_Dir_RIGHT += 1;
					}

				}
				
				
				SaveWheelInfo();
	
			}else{
				trace("WheelReverseDirection: "+WheelReverseDirection);
				if(WheelReverseDirection === false){
					if(wheel_mc.currentFrame == wheel_mc.numFrames-1){
						wheel_mc.currentFrame =0;
					}else{
						wheel_mc.currentFrame += 1;
					}
				}else{
					wheel_mc.currentFrame -= 1;
				}
			}
			
		}

		private function SaveWheelInfo():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel;
			}
			SaveArray['Pos_0_Dir_LEFT'] = Pos_0_Dir_LEFT;
			SaveArray['Pos_1_Dir_RIGHT'] = Pos_1_Dir_RIGHT;
			SaveArray['Pos_2_Dir_LEFT'] = Pos_2_Dir_LEFT;
			SaveArray['Pos_3_Dir_RIGHT'] = Pos_3_Dir_RIGHT;
			SaveArray['Pos_0_Valid'] = Pos_0_Valid;
			SaveArray['Pos_1_Valid'] = Pos_1_Valid;
			SaveArray['Pos_2_Valid'] = Pos_2_Valid;
			SaveArray['Pos_3_Valid'] = Pos_3_Valid;
			
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterWheel',SaveArray);
		}
		
		private function Solve():void{
			trace("Solving");
			trace(Pos_0_Valid+" "+ Pos_0_Dir_LEFT);
			trace(Pos_1_Valid+" "+ Pos_1_Dir_RIGHT);
			trace(Pos_2_Valid+" "+ Pos_2_Dir_LEFT);
			trace(Pos_3_Valid+" "+ Pos_3_Dir_RIGHT);	
			if(Solved === false){
				if(Pos_0_Valid === true && Pos_0_Dir_LEFT == 2){
					trace("0: "+Pos_0_Valid+" "+ Pos_0_Dir_LEFT);
					if(Pos_1_Valid === true && Pos_1_Dir_RIGHT == 3){
						trace("1: "+Pos_1_Valid+" "+ Pos_1_Dir_RIGHT);
						if(Pos_2_Valid === true && Pos_2_Dir_LEFT == 1){
							trace("2: "+Pos_2_Valid+" "+ Pos_2_Dir_LEFT);
							if(Pos_3_Valid === true && Pos_3_Dir_RIGHT == 2){
								Solved = true;
								trace("3: "+Pos_3_Valid+" "+ Pos_3_Dir_RIGHT);
								Animating = true;
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
								trace("Solved");
								delayedcall = new DelayedCall(function():void{
									Animating = false;
									FadeOut(FreighterUpper,(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterUpperObj,true)
								},2);
								
								
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel;
								}
								SaveArray['Solved'] = 'Yes'; 
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterWheel',SaveArray);	
								
								
								Starling.juggler.add(delayedcall);
							}else{
								trace("FAIL ON 3");
								Pos_0_Dir_LEFT = 0;
								Pos_1_Dir_RIGHT = 0;
								Pos_2_Dir_LEFT = 0;
								Pos_3_Dir_RIGHT = 0;
								Pos_0_Valid = true;
								Pos_1_Valid = true;
								Pos_2_Valid = true;
								Pos_3_Valid = true;
	
							}
						}else{
							trace("FAIL ON 2");
							Pos_0_Dir_LEFT = 0;
							Pos_1_Dir_RIGHT = 0;
							Pos_2_Dir_LEFT = 0;
							Pos_3_Dir_RIGHT = 0;
							Pos_0_Valid = true;
							Pos_1_Valid = true;
							Pos_2_Valid = true;
							Pos_3_Valid = true;
						}
					}else{
						trace("FAIL ON 1");
						Pos_0_Dir_LEFT = 0;
						Pos_1_Dir_RIGHT = 0;
						Pos_2_Dir_LEFT = 0;
						Pos_3_Dir_RIGHT = 0;
						Pos_0_Valid = true;
						Pos_1_Valid = true;
						Pos_2_Valid = true;
						Pos_3_Valid = true;
					}
				}else{
					trace("FAIL ON 0");
					Pos_0_Dir_LEFT = 0;
					Pos_1_Dir_RIGHT = 0;
					Pos_2_Dir_LEFT = 0;
					Pos_3_Dir_RIGHT = 0;
					Pos_0_Valid = true;
					Pos_1_Valid = true;
					Pos_2_Valid = true;
					Pos_3_Valid = true;
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
			
			
			this.assets.removeTexture("freighterWheel_bg",true);
		//	this.assets.removeTexture("FreighterSteeringWheel_Sprite",true);
		//	this.assets.removeTextureAtlas("FreighterSteeringWheel_Sprite",true);
		//	this.assets.removeTexture("FreighterPuller_Sprite",true);
	//		this.assets.removeTextureAtlas("FreighterPuller_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterWheel_01");
	//		(stage.getChildAt(0) as Object).falseAsset("freighterWheel_02");
	//		(stage.getChildAt(0) as Object).falseAsset("freighterWheel_03");
	//		(stage.getChildAt(0) as Object).falseAsset("freighterWheel_04");
	//		(stage.getChildAt(0) as Object).falseAsset("freighterWheel_05");
	
			
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