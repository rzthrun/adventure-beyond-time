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
	
	public class FreighterSafe extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var door:Image;
		private var PirateTube:Image;
		
		private var hit_book:Shape;
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		
		private var hit_OpenBook:Shape;
		private var hit_safe:Shape;
		private var hit_pirateTube:Shape;
		
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		
		private var WheelSolved:Boolean = false;
		private var DoorIsOpen:Boolean = false;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function FreighterSafe(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterSafe_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterSafe/freighterSafe_bg.jpg'));
				game.TrackAssets('freighterSafe_01');
			}
			if(game.CheckAsset('freighterSafe_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterSafe/FreighterSafe_Sprite.atf'));
				game.TrackAssets('freighterSafe_02');
			}
			if(game.CheckAsset('freighterSafe_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterSafe/FreighterSafe_Sprite.xml'));
				game.TrackAssets('freighterSafe_03');
			}
			if(game.CheckAsset('freighterSafe_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterSafe/FirstMatesLetter_Sprite.png'));
				game.TrackAssets('freighterSafe_04');
			}
			if(game.CheckAsset('freighterSafe_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterSafe/FirstMatesLetter_Sprite.xml'));
				game.TrackAssets('freighterSafe_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterSafe","FreighterSafeObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('freighterSafe_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			door = new Image(this.assets.getTexture('door'));
			door.smoothing = TextureSmoothing.NONE;
			door.touchable = false;
			door.x = 0;
			door.y = 69;
			door.alpha = 0;
			
			PirateTube = new Image(this.assets.getTexture('pirateTube'));
			PirateTube.smoothing = TextureSmoothing.NONE;
			PirateTube.touchable = false;
			PirateTube.x = 291;
			PirateTube.y = 179;
			PirateTube.alpha = 0;
			
		
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel != undefined){
					//trace("1");
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWheel['Solved'] == 'Yes'){
						//trace("2");
						WheelSolved = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe['Door'] == 'open'){
							//trace("3");
							DoorIsOpen = true;
							door.alpha = 1;
							CreatePirateTubeHit();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe['PirateTube'] == 'PickedUp'){
								//trace("4");
								PirateTube.alpha = 0;
							}else{
								//trace("5");
								//CreatePirateTubeHit();
								PirateTube.alpha = 1;
							}
						}else{
							door.alpha = 0;
						}
					}
				}else{
					door.alpha = 0;
				}
						
			}			
			
			this.addChildAt(door,1);
			this.addChildAt(PirateTube,2);
			
			CreateBookHit();
			CreateSafeHit(DoorIsOpen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe["Book"] == "open"){
					trace("Book is Open");
					BookIsOpen = true;
					//	OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe["BookCurrentPage"] == 2){
						openBookcurrentPage = 2;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe["BookCurrentPage"] == 3){
						openBookcurrentPage = 2;
					}else{
						openBookcurrentPage = 0;
					}
					OpenBook();
					this.addChild(goback);
				}
			}else{
				
			}
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
		//	(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,999);
		}
		

		//hit_pirateTube
		
		private function CreatePirateTubeHit():void{
			hit_pirateTube = new Shape();
			hit_pirateTube.touchable = false;
			hit_pirateTube.graphics.beginFill(0xff0000);
			
			hit_pirateTube.graphics.lineTo(274,208);	
			hit_pirateTube.graphics.lineTo(360,173);	
			hit_pirateTube.graphics.lineTo(396,181);	
			hit_pirateTube.graphics.lineTo(492,305);	
			hit_pirateTube.graphics.lineTo(484,362);	
			hit_pirateTube.graphics.lineTo(423,403);	
			hit_pirateTube.graphics.lineTo(362,400);	
			hit_pirateTube.graphics.lineTo(278,278);	

			hit_pirateTube.graphics.endFill(false);
			hit_pirateTube.alpha = 0.0;
			
			hit_pirateTube.graphics.precisionHitTest = true;	
			this.addChild(hit_pirateTube);
		}
		
		private function CreateBookHit():void{
			hit_book = new Shape();
			hit_book.touchable = false;
			hit_book.graphics.beginFill(0xff0000);
			
			hit_book.graphics.lineTo(241,101);	
			hit_book.graphics.lineTo(317,32);	
			hit_book.graphics.lineTo(518,44);	
			hit_book.graphics.lineTo(593,78);	
			hit_book.graphics.lineTo(590,107);	
			hit_book.graphics.lineTo(506,144);	
			hit_book.graphics.lineTo(254,127);	

			hit_book.graphics.endFill(false);
			hit_book.alpha = 0.0;
			
			hit_book.graphics.precisionHitTest = true;	
			this.addChild(hit_book);
		}
		
		private function CreateOpenBookHit():void{
			hit_OpenBook = new Shape();
			hit_OpenBook.touchable = false;
			hit_OpenBook.graphics.beginFill(0xff0000);
			
			hit_OpenBook.graphics.lineTo(211,0);	
			hit_OpenBook.graphics.lineTo(585,0);	
			hit_OpenBook.graphics.lineTo(585,512);	
			hit_OpenBook.graphics.lineTo(211,512);	

			
			hit_OpenBook.graphics.endFill(false);
			hit_OpenBook.alpha = 0.0;
			
			hit_OpenBook.graphics.precisionHitTest = true;	
			this.addChild(hit_OpenBook);
		}
		
		private function CreateSafeHit(open:Boolean = false):void{
			hit_safe = new Shape();
			this.addChild(hit_safe);
			if(open === false){
				
				hit_safe.x = 0;
				hit_safe.y = 0;
				hit_safe.graphics.beginFill(0x0000FF);
				hit_safe.graphics.lineTo(220,149);	
				hit_safe.graphics.lineTo(575,181);	
				hit_safe.graphics.lineTo(545,464);	
				hit_safe.graphics.lineTo(249,423);	
				
				hit_safe.graphics.endFill(false);
				
				hit_safe.alpha = 0.0;
				
				hit_safe.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_safe.x = 0;
				hit_safe.y = 0;
				hit_safe.graphics.beginFill(0x0000FF);		
				hit_safe.graphics.lineTo(0,312);	
				hit_safe.graphics.lineTo(222,151);	
				hit_safe.graphics.lineTo(255,160);	
				hit_safe.graphics.lineTo(287,408);	
				hit_safe.graphics.lineTo(220,512);	
				hit_safe.graphics.lineTo(0,512);	
	
				hit_safe.graphics.endFill(false);
				hit_safe.alpha = 0.0;
				
				hit_safe.graphics.precisionHitTest = true;				
			}
			hit_safe.touchable = false;
			
		}		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(BookIsOpen === false){
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((FreighterUpper as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterUpperObj,true
								);
							}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								BookIsOpen = true;
								OpenBook(true, 0);
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe;
								}		
								SaveArray['Book'] = "open";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterSafe',SaveArray);
								
							}else if(hit_safe.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(WheelSolved === true){	
									if(DoorIsOpen === false){
										DoorHandler(true);
									}else{
										DoorHandler(false)
									}
								}else{
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The safe is locked. There is no key-hole, or anywhere to enter a combination.");
								}
							}else if(WheelSolved === true){
								if(DoorIsOpen === true){
									if(hit_pirateTube.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										PirateTubeHandler();
									}
								}
							}
						}else{
							
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								trace("GoBackClick");
								RemoveBook();
								BookIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe;
								}		
								SaveArray['Book'] = "closed";
							}else if(hit_OpenBook.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe;
								}
								if(openBookcurrentPage == 0){
									SaveArray['BookCurrentPage'] = 1;
									openBookcurrentPage = 1;
									openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageTwo');
								}else if(openBookcurrentPage == 1){
									SaveArray['BookCurrentPage'] = 2;
									openBookcurrentPage = 2;
									openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageThree');
								}else if(openBookcurrentPage == 2){
									SaveArray['BookCurrentPage'] = 3;
									openBookcurrentPage = 3;
									openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageFour');
								}
								else if(openBookcurrentPage == 3){
									SaveArray['BookCurrentPage'] = 0;
									openBookcurrentPage = 0;
									openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageOne');
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterSafe',SaveArray);
								
							}
						}

					}
				}
			}
		}
		
		
		
		
		
		private function DoorHandler(OpenIt:Boolean = true):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe;
			}
			if(OpenIt === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeOpen();
				SaveArray['Door'] = 'open';
				door.alpha = 1;
				hit_safe.graphics.clear();
				CreateSafeHit(true);
				DoorIsOpen = true;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe['PirateTube'] == 'PickedUp'){
					PirateTube.alpha = 0;
				}else{
					PirateTube.alpha = 1;
				}
				CreatePirateTubeHit();

			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FridgeClose();
				SaveArray['Door'] = 'closed';
				door.alpha = 0;
				hit_safe.graphics.clear();
				hit_pirateTube.graphics.clear();
				PirateTube.alpha = 0;
				CreateSafeHit(false);
				DoorIsOpen = false;
				
				
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterSafe',SaveArray);	
		}
		
		private function PirateTubeHandler():void{
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe["PirateTube"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's nothing else in the safe.");

				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					PirateTube.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterSafe;
					SaveArray["PirateTube"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterSafe',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTubeEmpty,
						'item_PirateTubeEmpty',
						'inven_pirateTubeEmpty_sm'
					);
					
					
				}
			}else{
				PirateTube.alpha = 0;
				SaveArray["PirateTube"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterSafe',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateTubeEmpty,
					'item_PirateTubeEmpty',
					'inven_pirateTubeEmpty_sm'
				);
			}
		}
		
		
		
		private function OpenBook(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openBook = new Sprite();
			openBook.alpha = 0;
			CreateOpenBookBg();
			openBookPages = new Image(this.assets.getTexture('FirstMatesLetter_pageOne'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChild(openBook);
			this.addChild(goback);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageOne');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageTwo');
			}else if(openBookcurrentPage == 2){
				openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageThree');
			}else if(openBookcurrentPage == 3){
				openBookPages.texture = this.assets.getTexture('FirstMatesLetter_pageFour');
			}
			
			CreateOpenBookHit();
			//CreateOpenBookHit(openBookcurrentPage);
			
			if(Fade === false){
				Animating = false;
				openBook.alpha = 1;
			//	CreateOpenBookHit();
			}else{
				
				OpenBookTween = new Tween(openBook, 0.5, Transitions.LINEAR);
				OpenBookTween.fadeTo(1);
				OpenBookTween.onComplete = function():void{
					Animating = false;
					//	CreateOpenNotePadHit();
				};
				Starling.juggler.add(OpenBookTween);	
				
			}
			//	CreateOpenBookHit(page);
		}
		private function RemoveBook():void{
			Animating = true;
			Starling.juggler.purge();
			OpenBookTween = new Tween(openBook, 0.5, Transitions.LINEAR);
			OpenBookTween.fadeTo(0);
			OpenBookTween.onComplete = function():void{
				hit_OpenBook.graphics.clear();
				Animating = false;
				CloseBook();
				
			};
			Starling.juggler.add(OpenBookTween);		
		}
		
		public function CloseBook():void{
			this.removeChild(openBook);
			openBook.dispose();
		}
		
		private function CreateOpenBookBg():void{
			openBookbg = new Shape();
			openBookbg.graphics.beginFill(0x000000);
			openBookbg.graphics.lineTo(0,0);	
			openBookbg.graphics.lineTo(800,0);	
			openBookbg.graphics.lineTo(800,512);	
			openBookbg.graphics.lineTo(0,512);	
			openBookbg.touchable = false;
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
			
			
			this.assets.removeTexture("freighterSafe_bg",true);
			this.assets.removeTexture("FreighterSafe_Sprite",true);
			this.assets.removeTextureAtlas("FreighterSafe_Sprite",true);
			this.assets.removeTexture("FirstMatesLetter_Sprite",true);
			this.assets.removeTextureAtlas("FirstMatesLetter_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterSafe_01");
			(stage.getChildAt(0) as Object).falseAsset("freighterSafe_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterSafe_03");
			(stage.getChildAt(0) as Object).falseAsset("freighterSafe_04");
			(stage.getChildAt(0) as Object).falseAsset("freighterSafe_05");
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