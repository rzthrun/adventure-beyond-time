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
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class FreighterLocker extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var doorOne:Image;
		private var doorTwo:Image;
		private var doorThree:Image;
		private var CelticTriangle:Image;
	//	private var Piggy:Image;
		
		private var hit_doorOne:Shape;
		private var hit_doorTwo:Shape;
		private var hit_doorThree:Shape;
		private var hit_book:Shape;
		private var hit_celticTriangle:Shape;
		private var hit_piggy:Shape;

		
		private var doorOneOpen:Boolean = false;
		private var doorTwoOpen:Boolean = false;
		private var doorThreeOpen:Boolean = false;
	
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		private var Animating:Boolean = false;
		
		//private var openBookbg:Shape;
		private var LetterIsOpen:Boolean = false;
		private var openLetter:Sprite;
		private var openLetterPages:Image;
		private var hit_openLetter:Shape;
		public var OpenLetterTween:Tween;
		
		
		public function FreighterLocker(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterLocker_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLocker/freighterLocker_bg.jpg'));
				game.TrackAssets('freighterLocker_01');
			}
			if(game.CheckAsset('freighterLocker_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLocker/FreighterLocker_Sprite.atf'));
				game.TrackAssets('freighterLocker_02');
			}
			if(game.CheckAsset('freighterLocker_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLocker/FreighterLocker_Sprite.xml'));
				game.TrackAssets('freighterLocker_03');
			}
			if(game.CheckAsset('freighterLocker_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLocker/FreighterLocker_Sprite_02.png'));
				game.TrackAssets('freighterLocker_04');
			}
			if(game.CheckAsset('freighterLocker_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLocker/FreighterLocker_Sprite_02.xml'));
				game.TrackAssets('freighterLocker_05');
			}
			/*
			if(game.CheckAsset('freighterLocker_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLocker/FreighterLocker_Sprite.png'));
				game.TrackAssets('freighterLocker_04');
			}
			if(game.CheckAsset('freighterLocker_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterLocker/FreighterLocker_Sprite.xml'));
				game.TrackAssets('freighterLocker_05');
			}
			*/
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterLocker","FreighterLockerObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('freighterLocker_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			
			doorOne = new Image(this.assets.getTexture('door_one'));
	//		doorOne.smoothing = TextureSmoothing.NONE;
			doorOne.touchable = false;
			doorOne.x = 0;
			doorOne.y = 0;
			
			CelticTriangle = new Image(this.assets.getTexture('celtic'));
			CelticTriangle.smoothing = TextureSmoothing.NONE;
			CelticTriangle.touchable = false;
			CelticTriangle.x = 71;
			CelticTriangle.y = 226;
			
			
			doorTwo = new Image(this.assets.getTexture('door_two'));
	//		doorTwo.smoothing = TextureSmoothing.NONE;
			doorTwo.touchable = false;
			doorTwo.x = 143;
			doorTwo.y = 0;
			
			doorThree = new Image(this.assets.getTexture('door_three'));
	//		doorThree.smoothing = TextureSmoothing.NONE;
			doorThree.touchable = false;
			doorThree.x = 256;
			doorThree.y = 0;

//			Piggy = new Image(this.assets.getTexture('piggy'));
//			Piggy.smoothing = TextureSmoothing.NONE;
//			Piggy.touchable = false;
//			Piggy.x = 508;
//			Piggy.y = 201;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorOne'] == 'open'){
					doorOne.alpha = 1;
					doorOneOpen = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['CelticTriangle'] == 'PickedUp'){
						CelticTriangle.alpha = 0;
					}else{
						CelticTriangle.alpha = 1;
					}
					CreateCelticHit();
				}else{
					doorOne.alpha = 0;
					CelticTriangle.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorTwo'] == 'open'){
					doorTwo.alpha = 1;
					doorTwoOpen = true;
					CreateBookHit();
				}else{
					doorTwo.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorThree'] == 'open'){
					doorThree.alpha = 1;
					doorThreeOpen = true;
				}else{
					doorThree.alpha = 0;
				}
				
		//		if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["Piggy"] == "PickedUp"){
		//			Piggy.alpha = 0;
		//		}
		//		else{
		//			Piggy.alpha = 1;
		//		}
			}else{
				doorOne.alpha = 0;
				doorTwo.alpha = 0;
				doorThree.alpha = 0;
		//		Piggy.alpha = 1;
				CelticTriangle.alpha = 0;
			}
			
			
			this.addChildAt(doorOne,1);
			this.addChildAt(CelticTriangle,2);
			

			this.addChildAt(doorTwo,3);
			
			this.addChildAt(doorThree,4);
			
			
		//	this.addChildAt(Piggy,5);
			
			CreatePiggyHit();
			
			CreateDoorThreeHit(doorThreeOpen);
			CreateDoorTwoHit(doorTwoOpen);
			CreateDoorOneHit(doorOneOpen);
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["Book"] == "open"){
					BookIsOpen = true;
					OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
						//openBookPages.texture = this.assets.getTexture('queens_page_one');
						openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_one");
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
					//	openBookPages.texture = this.assets.getTexture('queens_page_two');
						openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_two");
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["BookCurrentPage"] == 2){
						openBookcurrentPage = 2;
					//	openBookPages.texture = this.assets.getTexture('queens_page_three');
						openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_three");
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["BookCurrentPage"] == 3){
						openBookcurrentPage = 3;
					//	openBookPages.texture = this.assets.getTexture('queens_page_four');
						openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_four");
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["BookCurrentPage"] == 4){
						openBookcurrentPage = 4;
						openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_five");
					}else{
						openBookcurrentPage = 0;
						openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_one");
						//openBookPages.texture = this.assets.getTexture('queens_page_one');
					}
					
					this.addChild(goback);
				}
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["NewsPaper"] == "open"){
					LetterIsOpen = true;
					OpenLetter();
					
					this.addChild(goback);
				}
			}
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			//(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,999);
		}

		/*
		
		private var hit_doorOne:Shape;
		private var hit_doorTwo:Shape;
		private var hit_doorThree:Shape;
		private var hit_book:Shape;
		private var hit_celticTriangle:Shape;
		*/
		
		
		private function CreatePiggyHit():void{
			hit_piggy = new Shape();
			hit_piggy.touchable = false;
			hit_piggy.graphics.beginFill(0xff0000);
			
			hit_piggy.graphics.lineTo(470,187);	
			hit_piggy.graphics.lineTo(600,187);	
			hit_piggy.graphics.lineTo(600,310);	
			hit_piggy.graphics.lineTo(470,310);	

			hit_piggy.graphics.endFill(false);
			hit_piggy.alpha = 0.0;
			
			hit_piggy.graphics.precisionHitTest = true;	
			this.addChild(hit_piggy);
		}
		
		
		private function CreateCelticHit():void{
			hit_celticTriangle = new Shape();
			hit_celticTriangle.touchable = false;
			hit_celticTriangle.graphics.beginFill(0xff0000);
			
			hit_celticTriangle.graphics.lineTo(74,212);	
			hit_celticTriangle.graphics.lineTo(147,215);	
			hit_celticTriangle.graphics.lineTo(147,325);	
			hit_celticTriangle.graphics.lineTo(71,326);	
			hit_celticTriangle.graphics.lineTo(71,268);	
			hit_celticTriangle.graphics.endFill(false);
			hit_celticTriangle.alpha = 0.0;
			
			hit_celticTriangle.graphics.precisionHitTest = true;	
			this.addChild(hit_celticTriangle);
		}
		
		private function CreateBookHit():void{
			hit_book = new Shape();
			hit_book.touchable = false;
			hit_book.graphics.beginFill(0xff0000);
			
			hit_book.graphics.lineTo(191,17);	
			hit_book.graphics.lineTo(268,22);	
			hit_book.graphics.lineTo(261,145);	
			hit_book.graphics.lineTo(178,140);	
			hit_book.graphics.endFill(false);
			hit_book.alpha = 0.0;
			
			hit_book.graphics.precisionHitTest = true;	
			this.addChild(hit_book);
		}
		
		private function CreateDoorOneHit(open:Boolean = false):void{
			hit_doorOne = new Shape();
			this.addChild(hit_doorOne);
			if(open === false){
				
				hit_doorOne.x = 0;
				hit_doorOne.y = 0;
				hit_doorOne.graphics.beginFill(0x0000FF);
				hit_doorOne.graphics.lineTo(45,9);	
				hit_doorOne.graphics.lineTo(146,14);	
				hit_doorOne.graphics.lineTo(146,266);	
				hit_doorOne.graphics.lineTo(133,289);	
				hit_doorOne.graphics.lineTo(131,352);	
				hit_doorOne.graphics.lineTo(141,362);	
				hit_doorOne.graphics.lineTo(141,512);	
				hit_doorOne.graphics.lineTo(48,512);	
				
				
				hit_doorOne.graphics.endFill(false);
				
				hit_doorOne.alpha = 0.0;
				
				hit_doorOne.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_doorOne.x = 0;
				hit_doorOne.y = 0;
				hit_doorOne.graphics.beginFill(0x0000FF);		
				hit_doorOne.graphics.lineTo(0,0);
				hit_doorOne.graphics.lineTo(66,14);
				hit_doorOne.graphics.lineTo(71,512);
				hit_doorOne.graphics.lineTo(0,512);
				
				
				hit_doorOne.graphics.endFill(false);
				hit_doorOne.alpha = 0.0;
				
				hit_doorOne.graphics.precisionHitTest = true;				
			}
			hit_doorOne.touchable = false;
			
		}		
		
		private function CreateDoorTwoHit(open:Boolean = false):void{
			hit_doorTwo = new Shape();
			this.addChild(hit_doorTwo);
			if(open === false){
				
				hit_doorTwo.x = 0;
				hit_doorTwo.y = 0;
				hit_doorTwo.graphics.beginFill(0x0000FF);
				hit_doorTwo.graphics.lineTo(160,10);
				hit_doorTwo.graphics.lineTo(267,15);
				hit_doorTwo.graphics.lineTo(249,508);
				hit_doorTwo.graphics.lineTo(148,509);
				
				hit_doorTwo.graphics.endFill(false);
				
				hit_doorTwo.alpha = 0.0;
				
				hit_doorTwo.graphics.precisionHitTest = true;	
			}else{

				hit_doorTwo.x = 0;
				hit_doorTwo.y = 0;
				hit_doorTwo.graphics.beginFill(0x0000FF);		
				hit_doorTwo.graphics.lineTo(156,0);
				hit_doorTwo.graphics.lineTo(190,0);
				hit_doorTwo.graphics.lineTo(177,119);
				hit_doorTwo.graphics.lineTo(177,147);
				hit_doorTwo.graphics.lineTo(188,160);
				hit_doorTwo.graphics.lineTo(185,506);
				hit_doorTwo.graphics.lineTo(141,509);
				
				hit_doorTwo.graphics.endFill(false);
				hit_doorTwo.alpha = 0.0;
				
				hit_doorTwo.graphics.precisionHitTest = true;				
			}
			hit_doorTwo.touchable = false;
			
		}		
		private function CreateDoorThreeHit(open:Boolean = false):void{
			hit_doorThree = new Shape();
			this.addChild(hit_doorThree);
			if(open === false){
				
				hit_doorThree.x = 0;
				hit_doorThree.y = 0;
				hit_doorThree.graphics.beginFill(0x0000FF);
				hit_doorThree.graphics.lineTo(275,14);
				hit_doorThree.graphics.lineTo(399,19);
				hit_doorThree.graphics.lineTo(366,507);
				hit_doorThree.graphics.lineTo(253,509);
				
				hit_doorThree.graphics.endFill(false);
				
				hit_doorThree.alpha = 0.0;
				
				hit_doorThree.graphics.precisionHitTest = true;	
			}else{
				
				hit_doorThree.x = 0;
				hit_doorThree.y = 0;
				hit_doorThree.graphics.beginFill(0x0000FF);		
				hit_doorThree.graphics.lineTo(278,0);
				hit_doorThree.graphics.lineTo(323,0);
				hit_doorThree.graphics.lineTo(304,391);
				hit_doorThree.graphics.lineTo(285,426);
				hit_doorThree.graphics.lineTo(281,506);
				hit_doorThree.graphics.lineTo(255,504);
				hit_doorThree.graphics.lineTo(261,374);
				hit_doorThree.graphics.lineTo(253,360);
				hit_doorThree.graphics.lineTo(265,288);
			
				hit_doorThree.graphics.endFill(false);
				hit_doorThree.alpha = 0.0;
				
				hit_doorThree.graphics.precisionHitTest = true;				
			}
			hit_doorThree.touchable = false;
			
		}		
		
		/*
		private var doorOneOpen:Boolean = false;
		private var doorTwoOpen:Boolean = false;
		private var doorThreeOpen:Boolean = false;
		*/
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(BookIsOpen === false){
							if(LetterIsOpen === false){
								if(targ == goback.SourceImage){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
									FadeOut((FreighterInterior as Class), 
										(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterInteriorObj,true
									);
								}
								if(doorOneOpen === true){
									if(hit_doorOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										DoorOneTouch();
									}else if(hit_celticTriangle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										CelticHandler();
									}
								}else{
									if(hit_doorOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										DoorOneTouch();
										
									}
								}
								if(doorTwoOpen === true){
									if(hit_doorTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										DoorTwoTouch();
									}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
										BookIsOpen = true;
										OpenBook(true, openBookcurrentPage)
										if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
											SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
										}		
										SaveArray['Book'] = "open";
										(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
									}
								}else{
									if(hit_doorTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										DoorTwoTouch();
										
									}
								}
								if(doorThreeOpen === true){
									if(hit_doorThree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										DoorThreeTouch();
									}
								}else{
									if(hit_doorThree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
										DoorThreeTouch();
										
									}
								}
								
								if(hit_piggy.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
									LetterIsOpen = true;
									OpenLetter(true, 0)
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
									}		
									SaveArray['NewsPaper'] = "open";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);		
								}
							}else{
								if(targ == goback.SourceImage){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
									trace("GoBackClick");
									RemoveLetter();
									LetterIsOpen = false;	
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
									}		
									SaveArray['NewsPaper'] = "closed";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
								}else if(hit_openLetter.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old newspaper article on using potatoes as batteries...");	

								}
							}
						}else{
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								trace("GoBackClick");
								RemoveBook();
								BookIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
								}		
								SaveArray['Book'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
							}
							else if(hit_openBookNext.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
								}
								
								if(openBookcurrentPage == 0){
									SaveArray['BookCurrentPage'] = 1;
									openBookcurrentPage = 1;
									openBookPages.texture = this.assets.getTexture('queens_page_two');
								}else if(openBookcurrentPage == 1){
									SaveArray['BookCurrentPage'] = 2;
									openBookcurrentPage = 2;
									openBookPages.texture = this.assets.getTexture('queens_page_three');
								}else if(openBookcurrentPage == 2){
									SaveArray['BookCurrentPage'] = 3;
									openBookcurrentPage = 3;
									openBookPages.texture = this.assets.getTexture('queens_page_four');
								}else if(openBookcurrentPage == 3){
									SaveArray['BookCurrentPage'] = 4;
									openBookcurrentPage = 4;
									openBookPages.texture = this.assets.getTexture('queens_page_five');
								}else if(openBookcurrentPage == 4){
									SaveArray['BookCurrentPage'] = 0;
									openBookcurrentPage = 0;
									openBookPages.texture = this.assets.getTexture('queens_page_one');
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
							}
							else if(hit_openBookBack.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
								}
								if(openBookcurrentPage == 0){
									SaveArray['BookCurrentPage'] = 4;
									openBookcurrentPage = 4;
									openBookPages.texture = this.assets.getTexture('queens_page_five');
								}else if(openBookcurrentPage == 1){
									SaveArray['BookCurrentPage'] = 0;
									openBookcurrentPage = 0;
									openBookPages.texture = this.assets.getTexture('queens_page_one');
								}else if(openBookcurrentPage == 2){
									SaveArray['BookCurrentPage'] = 1;
									openBookcurrentPage = 1;
									openBookPages.texture = this.assets.getTexture('queens_page_two');
								}else if(openBookcurrentPage == 3){
									SaveArray['BookCurrentPage'] = 2;
									openBookcurrentPage = 2;
									openBookPages.texture = this.assets.getTexture('queens_page_three');
								}else if(openBookcurrentPage == 4){
									SaveArray['BookCurrentPage'] = 3;
									openBookcurrentPage = 3;
									openBookPages.texture = this.assets.getTexture('queens_page_four');
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
							}
	
						}
					}
				}
			}
		}
		
		private function OpenLetter(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openLetter = new Sprite();
			openLetter.alpha = 0;
			CreateOpenBookBg();
			openLetterPages = new Image(this.assets.getTexture('potatoPower'));
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
		private function CreateOpenLetterHit():void{
			hit_openLetter = new Shape();
			this.addChild(hit_openLetter);
			hit_openLetter.graphics.beginFill(0x0000FF);
			hit_openLetter.graphics.lineTo(115,14);	
			hit_openLetter.graphics.lineTo(244,0);	
			hit_openLetter.graphics.lineTo(546,0);	
			hit_openLetter.graphics.lineTo(677,476);	
			hit_openLetter.graphics.lineTo(160,476);	
			
			hit_openLetter.graphics.endFill(false);
			hit_openLetter.alpha = 0.0;
			hit_openLetter.touchable = false;
			hit_openLetter.graphics.precisionHitTest = true;	
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
		
		
		private function OpenBook(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openBook = new Sprite();
			openBook.alpha = 0;
			CreateOpenBookBg();
			openBookPages = new Image((stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_one"));
		//	openBookPages = new Image(this.assets.getTexture('queens_page_one'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChildAt(openBook,6);
			this.addChildAt(goback,7);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_one");
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_two");
			//	openBookPages.texture = this.assets.getTexture('queens_page_two');
			}else if(openBookcurrentPage == 2){
				openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_three");
			//	openBookPages.texture = this.assets.getTexture('queens_page_three');
			}else if(openBookcurrentPage == 3){
				openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_four");
			//	openBookPages.texture = this.assets.getTexture('queens_page_four');
			}else if(openBookcurrentPage == 4){
				openBookPages.texture = (stage.getChildAt(0) as Object).QueensBookImages.assets.getTexture("queens_page_five");
			//	openBookPages.texture = this.assets.getTexture('queens_page_five');
			}
			
			CreateOpenBookHit()
		//	CreateOpenBookHit(openBookcurrentPage);
			
			if(Fade === false){
				Animating = false;
				openBook.alpha = 1;
				
			}else{
				
				OpenBookTween = new Tween(openBook, 0.5, Transitions.LINEAR);
				OpenBookTween.fadeTo(1);
				OpenBookTween.onComplete = function():void{
					//	CreateOpenNotePadHit();
					Animating = false;
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
				//hit_OpenBook.graphics.clear();
				//	hit_openBookBack.graphics.clear();
				//	hit_openBookNext.graphics.clear();
				Animating = false;
				CloseBook();
				
			};
			Starling.juggler.add(OpenBookTween);		
		}
		
		public function CloseBook():void{
			this.removeChild(openBook);
			openBook.dispose();
		}
		
		private function CreateOpenBookHit():void{
			hit_openBookBack = new Shape();
			this.addChild(hit_openBookBack);
			hit_openBookBack.graphics.beginFill(0x00ff00);
			hit_openBookBack.graphics.lineTo(65,15);		
			hit_openBookBack.graphics.lineTo(287,0);		
			hit_openBookBack.graphics.lineTo(380,7);		
			hit_openBookBack.graphics.lineTo(385,490);		
			hit_openBookBack.graphics.lineTo(269,493);		
			hit_openBookBack.graphics.lineTo(50,504);		

			hit_openBookBack.graphics.endFill(false);
			hit_openBookBack.alpha = 0.0;
			hit_openBookBack.touchable = false;
			hit_openBookBack.graphics.precisionHitTest = true;	
			
			hit_openBookNext = new Shape();
			this.addChild(hit_openBookNext);
			hit_openBookNext.graphics.beginFill(0x00ff00);
			hit_openBookNext.graphics.lineTo(390,5);		
			hit_openBookNext.graphics.lineTo(545,3);		
			hit_openBookNext.graphics.lineTo(714,384);		
			hit_openBookNext.graphics.lineTo(395,494);		

			hit_openBookNext.graphics.endFill(false);
			hit_openBookNext.alpha = 0.0;
			hit_openBookNext.touchable = false;
			hit_openBookNext.graphics.precisionHitTest = true;	
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
		
		private function DoorOneTouch():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
			trace("touch Hatch");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorOne'] != 'open'){
					trace(1);
				//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
					SaveArray['DoorOne'] = 'open';
					
					doorOne.alpha = 1;
					hit_doorOne.graphics.clear();
					CreateDoorOneHit(true);
					//CreateFrighterLowerHit();
					doorOneOpen = true;
					//CreateJunkInteriorHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['CelticTriangle'] == 'PickedUp'){
						CelticTriangle.alpha = 0;
					}else{
						CelticTriangle.alpha = 1;
					}
					CreateCelticHit();
					
				}else{
					trace(2);
				//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
					SaveArray['DoorOne'] = 'close';
					
					doorOne.alpha = 0;
					
					removeChild(hit_celticTriangle);
					hit_doorOne.graphics.clear();
					
					CreateDoorOneHit(false);
					doorOneOpen = false;
					CelticTriangle.alpha = 0;
				}
				
			}else{
				trace(3)
			//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
				SaveArray['DoorOne'] = 'open';
				
				doorOne.alpha = 1;
				hit_doorOne.graphics.clear();
				CreateDoorOneHit(true);
				//CreateFrighterLowerHit();
				doorOneOpen = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['CelticTriangle'] == 'PickedUp'){
																			       
					}else{
						CelticTriangle.alpha = 1;
					}
				}else{
					CelticTriangle.alpha = 1;
				}
				CreateCelticHit();
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);	
		
		}
		
		private function DoorTwoTouch():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
		//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			trace("touch Hatch");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorTwo'] != 'open'){
					trace(1);
					SaveArray['DoorTwo'] = 'open';
					
					doorTwo.alpha = 1;
					hit_doorTwo.graphics.clear();
					CreateDoorTwoHit(true);
					//CreateFrighterLowerHit();
					

					doorTwoOpen = true;
					//CreateJunkInteriorHit();
					CreateBookHit();
					
				}else{
					trace(2);
					SaveArray['DoorTwo'] = 'close';
					
					doorTwo.alpha = 0;
				
					removeChild(hit_book);
					hit_doorTwo.graphics.clear();
					
					CreateDoorTwoHit(false);
					doorTwoOpen = false;
					
				}
				
			}else{
				trace(3)
				SaveArray['DoorTwo'] = 'open';
				
				doorTwo.alpha = 1;
				hit_doorTwo.graphics.clear();
				CreateDoorTwoHit(true);

				doorTwoOpen = true;
				CreateBookHit();
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);	
			
		}
		
		private function DoorThreeTouch():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DoorMetalRustyOpen();
			//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			trace("touch Hatch");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker['DoorThree'] != 'open'){
					trace(1);
					SaveArray['DoorThree'] = 'open';
					
					doorThree.alpha = 1;
					hit_doorThree.graphics.clear();
					CreateDoorThreeHit(true);
					//CreateFrighterLowerHit();
					doorThreeOpen = true;
					//CreateJunkInteriorHit();
					
				}else{
					trace(2);
					SaveArray['DoorThree'] = 'close';
					
					doorThree.alpha = 0;
					
					//	removeChild(hit_FreighterLower);
					hit_doorThree.graphics.clear();
					
					CreateDoorThreeHit(false);
					doorThreeOpen = false;
					
				}
				
			}else{
				trace(3)
				SaveArray['DoorThree'] = 'open';
				
				doorThree.alpha = 1;
				hit_doorThree.graphics.clear();
				CreateDoorThreeHit(true);
				//CreateFrighterLowerHit();
				doorThreeOpen = true;
				
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);	
			
		}	
		
		private function CelticHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["CelticTriangle"] == "PickedUp"){
					
				}else{
					CelticTriangle.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
					SaveArray["CelticTriangle"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Celtic,
						'item_Celtic',
						'inven_celtic_sm'
					);
					
					
				}
			}else{
				CelticTriangle.alpha = 0;
				SaveArray["CelticTriangle"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Celtic,
					'item_Celtic',
					'inven_celtic_sm'
				);
			}
		}
		
		
		private function PiggyHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker["Piggy"] == "PickedUp"){
					
				}else{
				//	Piggy.alpha = 0;
				//	SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterLocker;
				//	SaveArray['Piggy'] = "PickedUp";
				//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
					
				/*	(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Piggy,
						'item_Piggy',
						'inven_piggy_sm'
					);
				*/	
					
				}
			}else{
			//	Piggy.alpha = 0;
			//	SaveArray['Piggy'] = "PickedUp";
			//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
			/*	
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Piggy,
					'item_Piggy',
					'inven_piggy_sm'
				);
			*/
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
			
			
			this.assets.removeTexture("freighterLocker_bg",true);
			this.assets.removeTexture("FreighterLocker_Sprite",true);
			this.assets.removeTexture("FreighterLocker_Sprite_02",true);
			this.assets.removeTextureAtlas("FreighterLocker_Sprite",true);
			this.assets.removeTextureAtlas("FreighterLocker_Sprite_02",true);
			
		//	this.assets.removeTexture("QueensBook_Sprite",true);
		//	this.assets.removeTextureAtlas("QueensBook_Sprite",true);
			
			(stage.getChildAt(0) as Object).falseAsset("freighterLocker_01");
			
			(stage.getChildAt(0) as Object).falseAsset("freighterLocker_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterLocker_03");
			(stage.getChildAt(0) as Object).falseAsset("freighterLocker_04");
			(stage.getChildAt(0) as Object).falseAsset("freighterLocker_05");
			
		//	(stage.getChildAt(0) as Object).falseAsset("freighterLocker_04");
		//	(stage.getChildAt(0) as Object).falseAsset("freighterLocker_05");
			
			
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