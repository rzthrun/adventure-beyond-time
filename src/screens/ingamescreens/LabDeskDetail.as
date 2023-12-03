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
	
	public class LabDeskDetail extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;

		private var solder:Image;
		private var mortar:Image;
		private var mix:Image;
		private var screen:Image;
		
		private var hit_solder:Shape;
		private var hit_mortar:Shape;
		private var hit_book:Shape;
		private var hit_screen:Shape;
		
		private var hit_mat:Shape;
		private var hit_glasses:Shape;
		
		private var BowlState:String = null;
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		
		private var hit_OpenBook:Shape;
		
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		
		private var Animating:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;

		
		public function LabDeskDetail(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('labDeskDetail_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDeskDetail/labDeskDetail_bg.jpg'));
				game.TrackAssets('labDeskDetail_01');
			}
			if(game.CheckAsset('labDeskDetail_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDeskDetail/LabDeskDetail_Sprite.atf'));
				game.TrackAssets('labDeskDetail_02');
			}
			if(game.CheckAsset('labDeskDetail_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDeskDetail/LabDeskDetail_Sprite.xml'));
				game.TrackAssets('labDeskDetail_03');
			}
			if(game.CheckAsset('labDeskDetail_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDeskDetail/LabDeskDetail_Sprite_02.atf'));
				game.TrackAssets('labDeskDetail_04');
			}
			if(game.CheckAsset('labDeskDetail_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/LabDeskDetail/LabDeskDetail_Sprite_02.xml'));
				game.TrackAssets('labDeskDetail_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("LabDeskDetail","LabDeskDetailObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('labDeskDetail_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			solder = new Image(this.assets.getTexture('solder'));
			solder.smoothing = TextureSmoothing.NONE;
			solder.touchable = false;
			solder.x = 502;
			solder.y = 87;
					
			mortar = new Image(this.assets.getTexture('mortar_empty'));
			mortar.smoothing = TextureSmoothing.NONE;
			mortar.touchable = false;
			mortar.x = 346;
			mortar.y = 161;
						
			mix = new Image(this.assets.getTexture('mix'));
			mix.smoothing = TextureSmoothing.NONE;
			mix.touchable = false;
			mix.x = 378;
			mix.y = 145;			
			
			screen = new Image(this.assets.getTexture('computer_screen_corner'));
			screen.smoothing = TextureSmoothing.NONE;
			screen.touchable = false;
			screen.x = 1;
			screen.y = 1;
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Solder"] == "PickedUp"){
					solder.alpha = 0;
				}else{
					solder.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Mortar"] == "PickedUp"){
					BowlState = 'mixed';
					mortar.alpha = 0;
					mix.alpha = 0;
				}else{
					mortar.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == undefined){
						mix.alpha = 0;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'flower'){
						BowlState = 'flower';
						mix.texture = this.assets.getTexture('flowers');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'mushroom'){
						BowlState = 'mushroom';
						mix.texture = this.assets.getTexture('mushroom');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water'){
						BowlState = 'water';
						mix.texture = this.assets.getTexture('water');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water_flower'){
						BowlState = 'water_flower';
						mix.texture = this.assets.getTexture('water_flower');
						mix.alpha = 1;					
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water_mushroom'){
						BowlState = 'water_mushroom';
						mix.texture = this.assets.getTexture('water_mushroom');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'water_flower_mushroom'){
						BowlState = 'water_flower_mushroom';
						mix.texture = this.assets.getTexture('water_flower_mushroom');
						mix.alpha = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'flower_mushroom'){
						BowlState = 'flower_mushroom';
						mix.texture = this.assets.getTexture('flowers_mushroom');
						mix.alpha = 1;	
						
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BowlState"] == 'mixed'){
						BowlState = 'mixed';
						mix.texture = this.assets.getTexture('mix');
						mix.alpha = 1;
					}
					
				}
			}else{
				mix.alpha = 0;
				mortar.alpha = 1;
				solder.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Computer"] == "On"){
					screen.alpha = 1;
				}else{
					screen.alpha = 0;
				}
			}else{
				screen.alpha = 0;
			}
		
			
			this.addChildAt(solder,1);			
			this.addChildAt(mortar,2);				
			this.addChildAt(mix,3);				
			this.addChildAt(screen,4);	
			
			CreateHitMap();
			CreateHitGlasses();
			CreateHitSolder();
			CreateHitMortar();
			CreateHitBook();
			CreateHitScreen();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Book"] == "open"){
					trace("Book is Open");
					BookIsOpen = true;
					//	OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
						//openBookPages.texture = this.assets.getTexture('buc_page_zero');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;

					}else{
						openBookcurrentPage = 0;
						//	openBookPages.texture = this.assets.getTexture('buc_page_zero');
					}
					OpenBook();
					this.addChild(goback);
				}
			}
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
		}
		
		private function CreateHitGlasses():void{
			hit_glasses = new Shape();
			hit_glasses.touchable = false;
			hit_glasses.graphics.beginFill(0xff0000);
			
			hit_glasses.graphics.lineTo(121,0);				
			hit_glasses.graphics.lineTo(580,0);				
			hit_glasses.graphics.lineTo(585,94);				
			hit_glasses.graphics.lineTo(462,107);				
			hit_glasses.graphics.lineTo(348,179);				
			hit_glasses.graphics.lineTo(155,129);				
			
			hit_glasses.graphics.endFill(false);
			
			hit_glasses.alpha = 0.0;
			
			hit_glasses.graphics.precisionHitTest = true;	
			this.addChild(hit_glasses);
		}
		
		private function CreateHitMap():void{
			hit_mat = new Shape();
			hit_mat.touchable = false;
			hit_mat.graphics.beginFill(0xff0000);
			
			hit_mat.graphics.lineTo(11,201);				
			hit_mat.graphics.lineTo(488,122);				
			hit_mat.graphics.lineTo(717,384);				
			hit_mat.graphics.lineTo(571,512);				
			hit_mat.graphics.lineTo(76,512);				
		
			hit_mat.graphics.endFill(false);
			
			hit_mat.alpha = 0.0;
			
			hit_mat.graphics.precisionHitTest = true;	
			this.addChild(hit_mat);
		}
		
		private function CreateHitMortar():void{
			hit_mortar = new Shape();
			hit_mortar.touchable = false;
			hit_mortar.graphics.beginFill(0xff0000);
			
			hit_mortar.graphics.lineTo(326,225);				
			hit_mortar.graphics.lineTo(380,150);				
			hit_mortar.graphics.lineTo(509,147);				
			hit_mortar.graphics.lineTo(567,215);				
			hit_mortar.graphics.lineTo(531,356);				
			hit_mortar.graphics.lineTo(374,353);				
			hit_mortar.graphics.lineTo(341,300);				

			hit_mortar.graphics.endFill(false);
			
			hit_mortar.alpha = 0.0;
			
			hit_mortar.graphics.precisionHitTest = true;	
			this.addChild(hit_mortar);
		}
		
		private function CreateHitSolder():void{
			hit_solder = new Shape();
			hit_solder.touchable = false;
			hit_solder.graphics.beginFill(0xff0000);
			
			hit_solder.graphics.lineTo(481,103);				
			hit_solder.graphics.lineTo(516,74);				
			hit_solder.graphics.lineTo(675,149);				
			hit_solder.graphics.lineTo(796,264);				
			hit_solder.graphics.lineTo(794,348);				
			hit_solder.graphics.lineTo(659,295);				
			hit_solder.graphics.lineTo(560,201);				
			
			hit_solder.graphics.endFill(false);
			
			hit_solder.alpha = 0.0;
			
			hit_solder.graphics.precisionHitTest = true;	
			this.addChild(hit_solder);
		}
		
		private function CreateHitBook():void{
			hit_book = new Shape();
			hit_book.touchable = false;
			hit_book.graphics.beginFill(0xff0000);
			
			hit_book.graphics.lineTo(4,254);				
			hit_book.graphics.lineTo(204,179);				
			hit_book.graphics.lineTo(341,357);				
			hit_book.graphics.lineTo(108,483);				

			hit_book.graphics.endFill(false);
			
			hit_book.alpha = 0.0;
			
			hit_book.graphics.precisionHitTest = true;	
			this.addChild(hit_book);
		}
		
		private function CreateHitScreen():void{
			hit_screen = new Shape();
			hit_screen.touchable = false;
			hit_screen.graphics.beginFill(0xff0000);
			
			hit_screen.graphics.lineTo(0,0);				
			hit_screen.graphics.lineTo(101,1);				
			hit_screen.graphics.lineTo(136,116);				
			hit_screen.graphics.lineTo(0,151);				

			hit_screen.graphics.endFill(false);
			
			hit_screen.alpha = 0.0;
			
			hit_screen.graphics.precisionHitTest = true;	
			this.addChild(hit_screen);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){	
						if(BookIsOpen === false){
							trace(touches[0].globalX+" ,"+touches[0].globalY);
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((LabDesk as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.LabDeskObj,true
								);
							}else if(hit_solder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								SolderHandler();					
							}else if(hit_mortar.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(BowlState == 'mixed'){
									MortarPickerUpper();
								}else{
									MortarHandler();
								}
							}else if(hit_screen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Computer"] == "On"){
										FadeOut((LabComputer as Class), 
											(stage.getChildAt(0) as Object).screenGamePlayHandler.LabComputerObj,true
										);
									}
								}	
							}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								BookIsOpen = true;
								OpenBook(true, 0)
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
								}		
								SaveArray['Book'] = "open";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
							}else if(hit_glasses.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A metal chalice, lamp and chemistry equipment.");						
							}else if(hit_mat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A knit woolen mat is draped over the table.");						
							}
							
							/*
							private var hit_mat:Shape;
							private var hit_glasses:Shape;
							*/
							
						}else{
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								trace("GoBackClick");
								RemoveBook();
								BookIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
								}		
								SaveArray['Book'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
							}else if(hit_OpenBook.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
								}
								if(openBookcurrentPage == 0){
									SaveArray['BookCurrentPage'] = 1;
									openBookcurrentPage = 1;
									openBookPages.texture = this.assets.getTexture('mandelbrot_page_01');
									hit_OpenBook.graphics.clear();
									CreateOpenBookHit(1);
								}else if(openBookcurrentPage == 1){
									SaveArray['BookCurrentPage'] = 0;
									openBookcurrentPage = 0;
									openBookPages.texture = this.assets.getTexture('mandelbrot_page_00');
									hit_OpenBook.graphics.clear();
									CreateOpenBookHit(0);
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
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
			openBookPages = new Image(this.assets.getTexture('mandelbrot_page_00'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChildAt(openBook,7);
			this.addChildAt(goback,8);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = this.assets.getTexture('mandelbrot_page_00');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = this.assets.getTexture('mandelbrot_page_01');
			}
			
			
			CreateOpenBookHit(openBookcurrentPage);
			
			if(Fade === false){
				openBook.alpha = 1;
				Animating = false;
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
		
		private function CreateOpenBookHit(page:Number = 0):void{
			hit_OpenBook = new Shape();
			openBook.addChild(hit_OpenBook);
			hit_OpenBook.graphics.beginFill(0x00ff00);
			if(page == 0){
				hit_OpenBook.graphics.lineTo(227,3);	
				hit_OpenBook.graphics.lineTo(565,0);	
				hit_OpenBook.graphics.lineTo(562,501);	
				hit_OpenBook.graphics.lineTo(229,497);	
			}else if(page == 1){
				hit_OpenBook.graphics.lineTo(90,7);	
				hit_OpenBook.graphics.lineTo(349,0);	
				hit_OpenBook.graphics.lineTo(409,6);	
				hit_OpenBook.graphics.lineTo(473,0);	
				hit_OpenBook.graphics.lineTo(718,8);	
				hit_OpenBook.graphics.lineTo(716,105);	
				hit_OpenBook.graphics.lineTo(710,497);		
				hit_OpenBook.graphics.lineTo(475,505);	
				hit_OpenBook.graphics.lineTo(404,496);	
				hit_OpenBook.graphics.lineTo(333,502);	
				hit_OpenBook.graphics.lineTo(83,496);	
				//hit_OpenBook.graphics.lineTo(83,376);	
				
			}
			hit_OpenBook.graphics.endFill(false);
			hit_OpenBook.alpha = 0.0;
			hit_OpenBook.graphics.precisionHitTest = true;
			openBookcurrentPage = page;
		}
		
		private function RemoveBook():void{
			Animating = true;
			Starling.juggler.purge();
			OpenBookTween = new Tween(openBook, 0.5, Transitions.LINEAR);
			OpenBookTween.fadeTo(0);
			OpenBookTween.onComplete = function():void{
				Animating = false;
				hit_OpenBook.graphics.clear();
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
		
		
		private function MortarPickerUpper():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Mortar"] == "PickedUp"){
					if(hit_mat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A knit woolen mat is draped over the table.");						
					}
				}else{
					mortar.alpha = 0;
					mix.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
					}
					SaveArray['Mortar'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Motor,
						'item_Motor',
						'inven_motor_sm'
					);
					
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadBeatDownOne(true,1);
						},1);
					}
				}
			}else{
				mortar.alpha = 0;
				mix.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
				}
				SaveArray['Mortar'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
				
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Motor,
					'item_Motor',
					'inven_motor_sm'
				);
				
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadBeatDownOne(true,1);
					},1);
				}
				
			}
		}
		
		private function MortarHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Flower)
			{	
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
				}
								
				if(BowlState == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					BowlState = 'flower';
					mix.texture = this.assets.getTexture('flowers');
				}else if(BowlState == 'mushroom'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					BowlState = 'flower_mushroom';
					mix.texture = this.assets.getTexture('flowers_mushroom');
				}else if(BowlState == 'water'){
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
					BowlState = 'water_flower';
					mix.texture = this.assets.getTexture('water_flower');
				}else if(BowlState == 'water_mushroom'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
					BowlState = 'water_flower_mushroom';
					mix.texture = this.assets.getTexture('water_flower_mushroom');
				}
				mix.alpha = 1;
				SaveArray['BowlState'] = BowlState;
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
						
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Flower,
						"item_Flower"
					);
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Mushroom)
			{	
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
				}
				
				if(BowlState == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					BowlState = 'mushroom';
					mix.texture = this.assets.getTexture('mushroom');
				}else if(BowlState == 'flower'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					BowlState = 'flower_mushroom';
					mix.texture = this.assets.getTexture('flowers_mushroom');
				}else if(BowlState == 'water'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
					BowlState = 'water_mushroom';
					mix.texture = this.assets.getTexture('water_mushroom');
				}else if(BowlState == 'water_flower'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
					BowlState = 'water_flower_mushroom';
					mix.texture = this.assets.getTexture('water_flower_mushroom');
				}
				mix.alpha = 1;
				SaveArray['BowlState'] = BowlState;
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
				
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Mushroom,
						"item_Mushroom"
					);
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_GourdWater)
			{	
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashTwo();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
				}
				
				if(BowlState == null){
					BowlState = 'water';
					mix.texture = this.assets.getTexture('water');
				}else if(BowlState == 'flower'){
					BowlState = 'water_flower';
					mix.texture = this.assets.getTexture('water_flower');
				}else if(BowlState == 'mushroom'){
					BowlState = 'water_mushroom';
					mix.texture = this.assets.getTexture('water_mushroom');
				}else if(BowlState == 'flower_mushroom'){
					BowlState = 'water_flower_mushroom';
					mix.texture = this.assets.getTexture('water_flower_mushroom');
				}
				mix.alpha = 1;
				SaveArray['BowlState'] = BowlState;
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_GourdWater,
						"item_GourdWater"
					);
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Pestle)
			{	
				if(BowlState == null){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Something needs to be in the bowl to grind.");
				}else if(BowlState == 'water_flower_mushroom'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_RemoveNail3x();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
					}
					
					BowlState = 'mixed';
					mix.texture = this.assets.getTexture('mix');
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Pestle,
							"item_Pestle"
						);
					
					SaveArray['BowlState'] = BowlState;
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
				}else if(BowlState == 'flower_mushroom'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This is good, but I should add water before grinding.");
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I think I need to add more before attempting to crush the mixture...");
				}
			}else{
				if(BowlState == null){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A stone bowl.");
				}else if(BowlState == 'mushroom'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've placed the mushroom in the bowl.");
				}else if(BowlState == 'flower_mushroom'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This is good, but I should add water before grinding.");
				}else if(BowlState == 'flower'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've placed the flower in the bowl.");
				}else if(BowlState == 'water'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've placed some water in the bowl.");
				}else if(BowlState == 'water_flower'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've put the water and flower in the bowl, but feel I need another ingredient.");
				}else if(BowlState == 'water_mushroom'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've put the water and the mushroom in the bowl, but feel I need another ingredient.");
				}else if(BowlState == 'water_flower_mushroom'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This is ready. Now I need to break down the mushroom and flower.");
				}
			}
		}
		
		private function SolderHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Solder"] == "PickedUp"){
					if(hit_glasses.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A metal chalice, lamp, and chemistry equipment.");						
					}else if(hit_mat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A knit woolen mat is draped over the table.");						
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					solder.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
					}
					SaveArray['Solder'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Solder,
						'item_Solder',
						'inven_solder_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				solder.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail;
				}
				SaveArray['Solder'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('LabDeskDetail',SaveArray);
				
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Solder,
					'item_Solder',
					'inven_solder_sm'
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
			
			
			this.assets.removeTexture("labDeskDetail_bg",true);
			this.assets.removeTexture("LabDeskDetail_Sprite",true);
			this.assets.removeTexture("LabDeskDetail_Sprite_02",true);
			this.assets.removeTextureAtlas("LabDeskDetail_Sprite",true);
			this.assets.removeTextureAtlas("LabDeskDetail_Sprite_02",true);
		//	this.assets.removeTexture("LabDeskDetail_Sprite_02",true);
		//	this.assets.removeTextureAtlas("LabDeskDetail_Sprite_02",true);
			
			(stage.getChildAt(0) as Object).falseAsset("labDeskDetail_01");
			(stage.getChildAt(0) as Object).falseAsset("labDeskDetail_02");
			(stage.getChildAt(0) as Object).falseAsset("labDeskDetail_03");
			(stage.getChildAt(0) as Object).falseAsset("labDeskDetail_04");
			(stage.getChildAt(0) as Object).falseAsset("labDeskDetail_05");
		//	(stage.getChildAt(0) as Object).falseAsset("labDeskDetail_04");
		//	(stage.getChildAt(0) as Object).falseAsset("labDeskDetail_05");
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
