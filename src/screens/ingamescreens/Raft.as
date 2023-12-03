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
	import starling.textures.TextureSmoothing;
	
	public class Raft extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var doorOpen:Image;
		private var Handle:Image;
		private var box_lid:Image;
		private var handle_up:Image;
		
		private var hit_box:Shape;
		private var hit_latch:Shape;
		private var hit_door:Shape;
		private var hit_letter:Shape;
		
		private var doorIsOpen:Boolean = false;
		private var handleAttached:Boolean = false;
		private var LetterIsOpen:Boolean = false;
	//	private var LatchState:int = 1;
		
		private var openLetter:Sprite;
		private var openLetterPages:Image;
		private var hit_openLetter:Shape;
		public var OpenLetterTween:Tween;
		
		private var openBookbg:Shape;
		private var GoBackTween:Tween;
		
		private var Animating:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function Raft(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('raft_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Raft/raft_bg.jpg'));
				game.TrackAssets('raft_01');
			}
			if(game.CheckAsset('raft_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Raft/Raft_Sprite.atf'));
				game.TrackAssets('raft_02');
			}
			if(game.CheckAsset('raft_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Raft/Raft_Sprite.xml'));
				game.TrackAssets('raft_03');
			}
			if(game.CheckAsset('raft_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Raft/PrintOut_Sprite.atf'));
				game.TrackAssets('raft_04');
			}
			if(game.CheckAsset('raft_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Raft/PrintOut_Sprite.xml'));
				game.TrackAssets('raft_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Raft","RaftObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			goback = new GoBackButton(this.assets);
			goback.alpha = 0;
			
			bg = new Image(this.assets.getTexture('raft_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			//box_lid
			doorOpen = new Image(this.assets.getTexture('doorOpen'));
			doorOpen.smoothing = TextureSmoothing.NONE;
			doorOpen.touchable = false;
			doorOpen.x = 115;
			doorOpen.y = 0;
			doorOpen.alpha = 0;			
			
			
			handle_up = new Image(this.assets.getTexture('handle_up'));
			handle_up.smoothing = TextureSmoothing.NONE;
			handle_up.touchable = false;
			handle_up.x = 118;
			handle_up.y = 95;
			handle_up.alpha = 0;			
			
			
			Handle = new Image(this.assets.getTexture('box_handle'));
			Handle.smoothing = TextureSmoothing.NONE;
			Handle.touchable = false;
			Handle.x = 582;
			Handle.y = 251;
						
			
			
			box_lid = new Image(this.assets.getTexture('box_dark'));
			box_lid.smoothing = TextureSmoothing.NONE;
			box_lid.touchable = false;
			box_lid.x = 425;
			box_lid.y = 193;
				
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox != undefined){
			//	SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox['Lid'] == 'open'){
					box_lid.alpha = 0;
					CreateBoxHit(true);
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox['Handle'] == 'PickedUp'){
						Handle.alpha = 0;
						
					}else{
						Handle.alpha = 1;
					}
				}else{
					box_lid.alpha = 1;		
					Handle.alpha = 0
					CreateBoxHit(false);
				}
			}else{
				box_lid.alpha = 1;		
				Handle.alpha = 0;
				CreateBoxHit(false);
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft['Handle'] == 'Attached'){
					handleAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft['Door'] == 'open'){
						//hit_latch.graphics.clear();
						CreateLatchHit(3);
						doorOpen.alpha = 1;
						handle_up.alpha = 0;
						doorIsOpen = true;
						box_lid.texture = this.assets.getTexture('box_lift');
						
					}else{
					//	hit_latch.graphics.clear();
						CreateLatchHit(2);
						doorOpen.alpha = 0;
						handle_up.alpha = 1;
						doorIsOpen = false;
						
					//	box_lid.texture = this.assets.getTexture('box_lift');
					}
				}else{
				//	hit_latch.graphics.clear();
					CreateLatchHit(1);
					doorOpen.alpha = 0;
					handle_up.alpha = 0;
					doorIsOpen = false;
				}
	
			}else{
			//	hit_latch.graphics.clear();
				CreateLatchHit(1);
				doorOpen.alpha = 0;
				handle_up.alpha = 0;
				doorIsOpen = false;
			}
			
			this.addChildAt(doorOpen,1);
			this.addChildAt(handle_up,2);
			this.addChildAt(Handle,3);
			this.addChildAt(box_lid,4);
			
			CreateDoorHit();
			CreateLetterHit();

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft['Letter'] == 'open'){
					LetterIsOpen = true;
					OpenLetter(false);
					this.addChild(goback);
				}
			}
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
		
		}
		
		private function CreateDoorHit():void{
			hit_door = new Shape();
			hit_door.touchable = false;
			hit_door.graphics.beginFill(0x0000ff);
			
			hit_door.graphics.lineTo(246,51);	
			hit_door.graphics.lineTo(507,39);	
			hit_door.graphics.lineTo(475,178);	
			hit_door.graphics.lineTo(421,203);	
			hit_door.graphics.lineTo(361,222);	
			hit_door.graphics.lineTo(300,215);	
			hit_door.graphics.lineTo(251,196);	
			
			hit_door.graphics.endFill(false);
			hit_door.alpha = 0.0;
			
			hit_door.graphics.precisionHitTest = true;	
			this.addChild(hit_door);
		}
		
		private function CreateBoxHit(open:Boolean = false):void{
			hit_box = new Shape();
			this.addChild(hit_box);
			if(open === false){
				
				hit_box.x = 0;
				hit_box.y = 0;
				hit_box.graphics.beginFill(0x0000FF);
				hit_box.graphics.lineTo(503,312);	
				hit_box.graphics.lineTo(545,193);	
				hit_box.graphics.lineTo(767,197);	
				hit_box.graphics.lineTo(736,350);	
				
				hit_box.graphics.endFill(false);
				
				hit_box.alpha = 0.0;
				
				hit_box.graphics.precisionHitTest = true;	
			}else{

				hit_box.x = 0;
				hit_box.y = 0;
				hit_box.graphics.beginFill(0x0000FF);		
				hit_box.graphics.lineTo(431,341);
				hit_box.graphics.lineTo(546,202);
				hit_box.graphics.lineTo(771,199);
				hit_box.graphics.lineTo(756,359);
				hit_box.graphics.lineTo(683,423);
				hit_box.graphics.lineTo(437,388);

				
				hit_box.graphics.endFill(false);
				hit_box.alpha = 0.0;
				
				hit_box.graphics.precisionHitTest = true;				
			}
			hit_box.touchable = false;
			
		}		
		
		private function CreateLatchHit(state:int = 1):void{
			hit_latch = new Shape();
			this.addChild(hit_latch);
			if(state == 1){
				
				hit_latch.x = 0;
				hit_latch.y = 0;
				hit_latch.graphics.beginFill(0x0000FF);
				hit_latch.graphics.lineTo(164,132);	
				hit_latch.graphics.lineTo(186,88);	
				hit_latch.graphics.lineTo(255,84);	
				hit_latch.graphics.lineTo(273,127);	
				hit_latch.graphics.lineTo(261,179);	
				hit_latch.graphics.lineTo(201,185);	

				
				hit_latch.graphics.endFill(false);
				
				hit_latch.alpha = 0.0;
				
				hit_latch.graphics.precisionHitTest = true;	
			}else if(state == 2){
				
				hit_latch.x = 0;
				hit_latch.y = 0;
				hit_latch.graphics.beginFill(0x0000FF);		
				hit_latch.graphics.lineTo(164,132);	
				hit_latch.graphics.lineTo(186,88);	
				hit_latch.graphics.lineTo(255,84);	
				hit_latch.graphics.lineTo(273,127);	
				hit_latch.graphics.lineTo(331,136);	
				hit_latch.graphics.lineTo(333,181);	
				hit_latch.graphics.lineTo(228,195);	
				

				hit_latch.graphics.endFill(false);
				hit_latch.alpha = 0.0;
				
				hit_latch.graphics.precisionHitTest = true;				
			}else if(state == 3){
				hit_latch.x = 0;
				hit_latch.y = 0;
				hit_latch.graphics.beginFill(0x0000FF);		
				hit_latch.graphics.lineTo(164,132);	
				hit_latch.graphics.lineTo(186,88);	
				hit_latch.graphics.lineTo(255,84);	
				hit_latch.graphics.lineTo(273,127);	
				hit_latch.graphics.lineTo(261,179);	
				hit_latch.graphics.lineTo(255,241);	
				hit_latch.graphics.lineTo(205,246);	
				
				
				hit_latch.graphics.endFill(false);
				hit_latch.alpha = 0.0;
				
				hit_latch.graphics.precisionHitTest = true;		
			}
			hit_latch.touchable = false;
			
		}		
		//hit_letter
		private function CreateLetterHit():void{
			hit_letter = new Shape();
			hit_letter.touchable = false;
			hit_letter.graphics.beginFill(0x0000ff);
			
			hit_letter.graphics.lineTo(41,291);	
			hit_letter.graphics.lineTo(50,268);	
			hit_letter.graphics.lineTo(160,231);	
			hit_letter.graphics.lineTo(186,245);	
			hit_letter.graphics.lineTo(215,334);	
			hit_letter.graphics.lineTo(284,352);	
			hit_letter.graphics.lineTo(317,380);	
			hit_letter.graphics.lineTo(236,446);	
			hit_letter.graphics.lineTo(99,410);	

			hit_letter.graphics.endFill(false);
			hit_letter.alpha = 0.0;
			
			hit_letter.graphics.precisionHitTest = true;	
			this.addChild(hit_letter);
		}
		
		
		private function CreateOpenLetterHit():void{
			hit_openLetter = new Shape();
			addChild(hit_openLetter);
			hit_openLetter.graphics.beginFill(0x0000FF);
			hit_openLetter.graphics.lineTo(100,0);	
			hit_openLetter.graphics.lineTo(532,0);	
			hit_openLetter.graphics.lineTo(583,120);	
			hit_openLetter.graphics.lineTo(617,225);	
			hit_openLetter.graphics.lineTo(638,316);	
			hit_openLetter.graphics.lineTo(670,504);	
			hit_openLetter.graphics.lineTo(188,507);	
			hit_openLetter.graphics.lineTo(165,302);	
			hit_openLetter.graphics.lineTo(139,166);	
			hit_openLetter.graphics.lineTo(116,67);	

			hit_openLetter.graphics.endFill(false);
			hit_openLetter.touchable = false;
			hit_openLetter.alpha = 0.0;
			hit_openLetter.graphics.precisionHitTest = true;				
		}

		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						if(LetterIsOpen === false){
							trace(touches[0].globalX+" ,"+touches[0].globalY);
		
							if(hit_box.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								FadeOut((RaftBox as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.RaftBoxObj,true
								);
							}else if(hit_letter.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft;
								}		
								SaveArray['Letter'] = "open";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Raft',SaveArray);
								
								
								LetterIsOpen = true;
								OpenLetter(true);
								this.addChild(goback);
							}else if(handleAttached === false){
								if(hit_latch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									//LatchHandler();
									if((stage.getChildAt(0) as Object)
										.screenGamePlayHandler
										.InventoryObj.armedItem
										== 
										(stage.getChildAt(0) as Object)
										.screenGamePlayHandler
										.InventoryObj.inventoryBarObj
										.item_Handle)
									{
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();

										(stage.getChildAt(0) as Object)
										.screenGamePlayHandler
											.InventoryObj.removeItemFromInventory(
												(stage.getChildAt(0) as Object)
												.screenGamePlayHandler
												.InventoryObj.item_Handle,
												"item_Handle"
											);
										handleAttached = true;
										hit_latch.graphics.clear();
										CreateLatchHit(2);
										if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
											SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft;			
										}
										SaveArray['Handle'] = 'Attached';
										handle_up.alpha = 1;
										(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Raft',SaveArray);
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is a plastic semi-circular device attached to the door.");
									}
									
								}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The door is sealed - it's water tight.");
								}
							}else{
								if(doorIsOpen === true){
									if(hit_latch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
										hit_latch.graphics.clear();
										CreateLatchHit(2);
										doorOpen.alpha = 0;
										handle_up.alpha = 1;
										doorIsOpen = false;
										box_lid.texture = this.assets.getTexture('box_dark');
										
										if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
											SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft;			
										}
										SaveArray['Door'] = 'close';
										(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Raft',SaveArray);
										
									}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										FadeOut((Coast as Class), 
											(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastObj,true
										);
									}
								}else{
									if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
										hit_latch.graphics.clear();
										CreateLatchHit(3);
										doorOpen.alpha = 1;
										handle_up.alpha = 0;
										doorIsOpen = true;
										box_lid.texture = this.assets.getTexture('box_lift');
										
										if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
											SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft;			
										}
										SaveArray['Door'] = 'open';
										(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Raft',SaveArray);
										
									}else if(hit_latch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();

										hit_latch.graphics.clear();
										CreateLatchHit(3);
										doorOpen.alpha = 1;
										handle_up.alpha = 0;
										doorIsOpen = true;
										box_lid.texture = this.assets.getTexture('box_lift');
										
										if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
											SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft;			
										}
										SaveArray['Door'] = 'open';
										(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Raft',SaveArray);
									}
								}
									
							}
							
						}else{
							trace(touches[0].globalX+" ,"+touches[0].globalY);
							if(hit_openLetter.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I hope someone is as concerned about me as they are about the missing scientist, Dr. Von Awesome.");
							}
								
							else if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();	
								trace("GoBackClick");
								RemoveLetter();
								LetterIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Raft;
								}		
								SaveArray['Letter'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Raft',SaveArray);
								
								
							}
							
						}
					}
				}
			}
		}
		
	//	private 
		
		
		
		private function OpenLetter(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openLetter = new Sprite();
			openLetter.alpha = 0;
			openLetter.x = 0;
			openLetter.y = 0;
			CreateOpenBookBg();
			
			openBookbg.x = 0;
			openBookbg.y = 0;
			openLetterPages = new Image(this.assets.getTexture('printOut'));
			openLetterPages.x = 100;
			this.openLetter.addChildAt(openBookbg,0);
			openLetter.addChild(openLetterPages);
			openLetterPages.touchable = false;
			
			this.addChildAt(openLetter,7);
			this.addChildAt(goback,8);
			
			
			if(Fade === false){
				Animating = false;
				openLetter.alpha = 1;
				goback.alpha = 1;
				CreateOpenLetterHit();
				//	CreateOpenNotePadHit();
			}else{
				GoBackTween = new Tween(goback,0.5,Transitions.LINEAR);
				GoBackTween.fadeTo(1);
				GoBackTween.onComplete = function():void{};
				Starling.juggler.add(GoBackTween);	
				
				OpenLetterTween = new Tween(openLetter, 0.5, Transitions.LINEAR);
				OpenLetterTween.fadeTo(1);
				OpenLetterTween.onComplete = function():void{
					//		CreateOpenNotePadHit();
					Animating = false;
					CreateOpenLetterHit();
				};
				Starling.juggler.add(OpenLetterTween);	
				Starling.juggler.add(GoBackTween);	
				
			}
			//	CreateOpenBookHit(page);
		}
		private function RemoveLetter():void{
			Animating = true;
			hit_openLetter.graphics.clear();
			//	Starling.juggler.purge();
			GoBackTween = new Tween(goback, 0.5, Transitions.LINEAR);
			OpenLetterTween = new Tween(openLetter, 0.5, Transitions.LINEAR);
			OpenLetterTween.fadeTo(0);
			GoBackTween.fadeTo(0);
			GoBackTween.onComplete = function():void{};
			OpenLetterTween.onComplete = function():void{
				Animating = false;
				CloseLetter();
				
			};
			Starling.juggler.add(GoBackTween);
			Starling.juggler.add(OpenLetterTween);		
		}
		
		public function CloseLetter():void{
			this.removeChild(goback);
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
			
			
			this.assets.removeTexture("raft_bg",true);
			this.assets.removeTexture("Raft_Sprite",true);
			this.assets.removeTextureAtlas("Raft_Sprite",true);
			this.assets.removeTexture("PrintOut_Sprite",true);
			this.assets.removeTextureAtlas("PrintOut_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("raft_01");
			(stage.getChildAt(0) as Object).falseAsset("raft_02");
			(stage.getChildAt(0) as Object).falseAsset("raft_03");
			(stage.getChildAt(0) as Object).falseAsset("raft_04");
			(stage.getChildAt(0) as Object).falseAsset("raft_05");
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