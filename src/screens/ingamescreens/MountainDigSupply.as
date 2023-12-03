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
	
	public class MountainDigSupply extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var lid:Image;
		private var marble:Image;
		private var trowel:Image;
		
		private var hit_lid:Shape;
		private var hit_trowel:Shape;
		private var hit_diary:Shape;
		private var hit_marble:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var LidOpen:Boolean = false;
		private var LidUnlocked:Boolean = false;
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		
		private var goback:GoBackButton;
		
		private var hit_boxOne:Shape;
		private var hit_boxTwo:Shape;
		
		private var Animating:Boolean = false;
		
		public function MountainDigSupply(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('mountainDigSupply_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigSupply/mountainDigSupply_bg.jpg'));
				game.TrackAssets('mountainDigSupply_01');
			}
			if(game.CheckAsset('mountainDigSupply_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigSupply/MountainDigSupply_Sprite.atf'));
				game.TrackAssets('mountainDigSupply_02');
			}
			if(game.CheckAsset('mountainDigSupply_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigSupply/MountainDigSupply_Sprite.xml'));
				game.TrackAssets('mountainDigSupply_03');
			}
			if(game.CheckAsset('mountainDigSupply_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigSupply/MountainDigSupply_Sprite_02.png'));
				game.TrackAssets('mountainDigSupply_04');
			}
			if(game.CheckAsset('mountainDigSupply_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDigSupply/MountainDigSupply_Sprite_02.xml'));
				game.TrackAssets('mountainDigSupply_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("MountainDigSupply","MountainDigSupplyObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		//	if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
		//		SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
		//	}
		//	
		//	SaveArray['Trowel'] = 'no';
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
			
			bg = new Image(this.assets.getTexture('mountainDigSupply_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			marble = new Image(this.assets.getTexture('marble'));
			marble.smoothing = TextureSmoothing.NONE;
			marble.touchable = false;
			marble.x = 165;
			marble.y = 226;
			
			
			lid = new Image(this.assets.getTexture('lid'));
			lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 0;
			lid.y = 98;
			
			
			trowel = new Image(this.assets.getTexture('trowel'));
			trowel.smoothing = TextureSmoothing.NONE;
			trowel.touchable = false;
			trowel.x = 295;
			trowel.y = 164;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Trowel'] == 'PickedUp'){
					trowel.alpha = 0;
				}else{
					trowel.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['LidUnlocked'] == 'Yes'){
					LidUnlocked = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Lid'] == 'Open'){
						LidOpen = true;
						lid.alpha = 0;
						CreateMarbleHit();
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Marble'] == 'PickedUp'){
							marble.alpha = 0;
						}else{
							marble.alpha = 1;
						}
					}else{
						lid.alpha = 1;
					}
				}else{
					lid.alpha = 1;
				}
				
			}else{
				marble.alpha = 1;
				lid.alpha = 1;
				trowel.alpha = 1;
			}
			
			
			this.addChildAt(marble,1);
			this.addChildAt(lid,2);		
			this.addChildAt(trowel,3);
			//FadeOutOcean(1);
			CreateBoxOneHit();
			CreateBoxTwoHit();
			CreateLidHit(LidOpen);
			CreateTrowelHit();
			CreateDiaryHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply["Book"] == "open"){
					BookIsOpen = true;
					OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
						openBookPages.texture = this.assets.getTexture('doctor_book_page_00');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
						openBookPages.texture = this.assets.getTexture('doctor_book_page_01');
					}else{
						openBookcurrentPage = 0;
						openBookPages.texture = this.assets.getTexture('doctor_book_page_00');
					}
					
					this.addChild(goback);
				}
			}
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
			},0.5);
		}
		
		private function CreateMarbleHit():void{
			hit_marble = new Shape();
			hit_marble.touchable = false;
			hit_marble.graphics.beginFill(0xff0000);
			
			hit_marble.graphics.lineTo(138,248);							
			hit_marble.graphics.lineTo(218,193);							
			hit_marble.graphics.lineTo(398,264);							
			hit_marble.graphics.lineTo(317,350);							
			
			hit_marble.graphics.endFill(false);
			
			hit_marble.alpha = 0.0;
			
			hit_marble.graphics.precisionHitTest = true;	
			this.addChild(hit_marble);
		}
		
		/*
		private var hit_boxOne:Shape;
		private var hit_boxTwo:Shape;
		*/
		private function CreateBoxOneHit():void{
			hit_boxOne = new Shape();
			hit_boxOne.touchable = false;
			hit_boxOne.graphics.beginFill(0xff0000);
			
			hit_boxOne.graphics.lineTo(194,0);				
			hit_boxOne.graphics.lineTo(402,0);				
			hit_boxOne.graphics.lineTo(405,136);				
			hit_boxOne.graphics.lineTo(238,181);				
			
			hit_boxOne.graphics.endFill(false);
			
			hit_boxOne.alpha = 0.0;
			
			hit_boxOne.graphics.precisionHitTest = true;	
			this.addChild(hit_boxOne);
		}
		private function CreateBoxTwoHit():void{
			hit_boxTwo = new Shape();
			hit_boxTwo.touchable = false;
			hit_boxTwo.graphics.beginFill(0xff0000);
			
			hit_boxTwo.graphics.lineTo(440,12);				
			hit_boxTwo.graphics.lineTo(602,37);				
			hit_boxTwo.graphics.lineTo(560,164);				
			hit_boxTwo.graphics.lineTo(413,142);				
			
			hit_boxTwo.graphics.endFill(false);
			
			hit_boxTwo.alpha = 0.0;
			
			hit_boxTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_boxTwo);
		}

		
		private function CreateDiaryHit():void{
			hit_diary = new Shape();
			hit_diary.touchable = false;
			hit_diary.graphics.beginFill(0xff0000);
			
			hit_diary.graphics.lineTo(470,323);				
			hit_diary.graphics.lineTo(585,247);				
			hit_diary.graphics.lineTo(689,314);				
			hit_diary.graphics.lineTo(581,423);				

			hit_diary.graphics.endFill(false);
			
			hit_diary.alpha = 0.0;
			
			hit_diary.graphics.precisionHitTest = true;	
			this.addChild(hit_diary);
		}
		
		private function CreateTrowelHit():void{
			hit_trowel = new Shape();
			hit_trowel.touchable = false;
			hit_trowel.graphics.beginFill(0xff0000);
			
			hit_trowel.graphics.lineTo(300,180);				
			hit_trowel.graphics.lineTo(306,149);				
			hit_trowel.graphics.lineTo(473,165);				
			hit_trowel.graphics.lineTo(570,209);				
			hit_trowel.graphics.lineTo(556,248);				
			hit_trowel.graphics.lineTo(408,243);				

			hit_trowel.graphics.endFill(false);
			
			hit_trowel.alpha = 0.0;
			
			hit_trowel.graphics.precisionHitTest = true;	
			this.addChild(hit_trowel);
		}
		
		private function CreateLidHit(open:Boolean = false):void{

			hit_lid = new Shape();
			hit_lid.touchable = false
			
			if(open === false){
				hit_lid.x = 0;
				hit_lid.y = 0;
				
				hit_lid.graphics.beginFill(0x00FF00);
				
				hit_lid.graphics.lineTo(111,247);		
				hit_lid.graphics.lineTo(213,176);		
				hit_lid.graphics.lineTo(417,256);		
				hit_lid.graphics.lineTo(415,327);		
				hit_lid.graphics.lineTo(337,422);		
				hit_lid.graphics.lineTo(130,316);		
				
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				hit_lid.graphics.precisionHitTest = true;
			}else{
				hit_lid.x = 0;
				hit_lid.y = 0;
				
				hit_lid.graphics.beginFill(0x00FF00);

				hit_lid.graphics.lineTo(12,247);	
				hit_lid.graphics.lineTo(109,105);	
				hit_lid.graphics.lineTo(160,177);	
				hit_lid.graphics.lineTo(85,323);	
				
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				hit_lid.graphics.precisionHitTest = true;	
			}
			
			addChild(hit_lid);
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
								FadeOut((MountainDig as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainDigObj,true
								);
								
							}else if(hit_trowel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								TrowelHandler();
							}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(LidUnlocked === true){
									LidHandler();
								}else{
									Unlocker();
								}	
							}else if(hit_diary.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								BookIsOpen = true;
								OpenBook(true, openBookcurrentPage);
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
								}		
								SaveArray['Book'] = "open";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
		
							
							}else if(LidOpen === true){
								if(hit_marble.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									MarbleHandler();
								}
							}else if(hit_boxOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wooden crate has been emptied of supplies.");
								
							}else if(hit_boxTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The crate is empty.");
								
							}
							/*
							private var hit_boxOne:Shape;
							private var hit_boxTwo:Shape;
							*/
						}else{
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								trace("GoBackClick");
								RemoveBook();
								BookIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
								}		
								SaveArray['Book'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
							}
							else if(hit_openBookNext.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
								}
								
								if(openBookcurrentPage == 0){
									SaveArray['BookCurrentPage'] = 1;
									openBookcurrentPage = 1;
									openBookPages.texture = this.assets.getTexture('doctor_book_page_01');
								}else if(openBookcurrentPage == 1){
									
									SaveArray['BookCurrentPage'] = 0;
									openBookcurrentPage = 0;
									openBookPages.texture = this.assets.getTexture('doctor_book_page_00');
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
							}
							else if(hit_openBookBack.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
								}
								if(openBookcurrentPage == 0){
									SaveArray['BookCurrentPage'] = 1;
									openBookcurrentPage = 1;
									openBookPages.texture = this.assets.getTexture('doctor_book_page_01');
									
								}else if(openBookcurrentPage == 1){
									SaveArray['BookCurrentPage'] = 0;
									openBookcurrentPage = 0;
									openBookPages.texture = this.assets.getTexture('doctor_book_page_00');
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
							}		
							
						}
					}
				}
			}
		}
		
		
		private function OpenBook(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openBook = new Sprite();
			openBook.alpha = 0;
			CreateOpenBookBg();
			openBookPages = new Image(this.assets.getTexture('doctor_book_page_00'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChildAt(openBook,5);
			this.addChildAt(goback,6);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = this.assets.getTexture('doctor_book_page_00');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = this.assets.getTexture('doctor_book_page_01');
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
				Animating = false;
				//hit_OpenBook.graphics.clear();
				//	hit_openBookBack.graphics.clear();
				//	hit_openBookNext.graphics.clear();
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
			hit_openBookNext.graphics.lineTo(667,3);		
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
		
		
		private function MarbleHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Marble'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The box is empty.");

				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					marble.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
					}
					SaveArray['Marble'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Marble,
						'item_Marble',
						'inven_marble_sm'
					);	
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				marble.alpha = 0;
				SaveArray['Marble'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Marble,
					'item_Marble',
					'inven_marble_sm'
				);	
			}
		}
		
		private function Unlocker():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Hammer)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'm removing the nails from the lid of the box...");

				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RemoveNail3x();
				Animating = true;
				LidUnlocked = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
				}
				SaveArray["LidUnlocked"] = "Yes";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['RightUnlocked'] == 'Yes'){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['LeftUnlocked'] == 'Yes'){
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
								.InventoryObj.removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Hammer,
									"item_Hammer"
								);
						}

					}
				}
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();

					Animating = false;
					LidHandler();
				},3);
				
				
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The box is nailed shut.");
			}
		}
		
		private function LidHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();

			if(LidOpen === false){
				
				LidOpen = true;
				lid.alpha = 0;
				hit_lid.graphics.clear();
				CreateLidHit(true);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Marble'] == 'PickedUp'){
						marble.alpha = 0;
					}else{
						marble.alpha = 1;
					}
				}
				SaveArray["Lid"] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
				
				CreateMarbleHit();
				
			}else{
				LidOpen = false;
				lid.alpha = 1;
				marble.alpha = 0;
				this.removeChild(hit_marble);
				hit_lid.graphics.clear();
				
				CreateLidHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
				}
				SaveArray["Lid"] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
			
			}
		}
		
		private function TrowelHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Trowel'] == 'PickedUp'){
					
				}else{
					trowel.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply;
					}
					SaveArray['Trowel'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Trowel,
						'item_Trowel',
						'inven_trowel_sm'
					);	
				}
			}else{
				trowel.alpha = 0;
				SaveArray['Trowel'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('MountainDigSupply',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Trowel,
					'item_Trowel',
					'inven_trowel_sm'
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
			
			
			this.assets.removeTexture("mountainDigSupply_bg",true);
			this.assets.removeTexture("MountainDigSupply_Sprite",true);
			this.assets.removeTexture("MountainDigSupply_Sprite_02",true);
			this.assets.removeTextureAtlas("MountainDigSupply_Sprite",true);
			this.assets.removeTextureAtlas("MountainDigSupply_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("mountainDigSupply_01");
			(stage.getChildAt(0) as Object).falseAsset("mountainDigSupply_02");
			(stage.getChildAt(0) as Object).falseAsset("mountainDigSupply_03");
			(stage.getChildAt(0) as Object).falseAsset("mountainDigSupply_04");
			(stage.getChildAt(0) as Object).falseAsset("mountainDigSupply_05");
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