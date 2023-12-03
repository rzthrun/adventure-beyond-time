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
	
	public class JungleHole extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var cover:Image;
		private var book:Image;
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		
		private var hit_OpenBook:Shape;
		
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		
		private var hit_cover:Shape;
		private var hit_book:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		private var coverOpen:Boolean = false;
		
		private var Animating:Boolean = false;
		
		public function JungleHole(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleHole_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHole/jungleHole_bg.jpg'));
				game.TrackAssets('jungleHole_01');
			}
			if(game.CheckAsset('jungleHole_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHole/JungleHole_SpriteSheet.atf'));
				game.TrackAssets('jungleHole_02');
			}
			if(game.CheckAsset('jungleHole_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHole/JungleHole_SpriteSheet.xml'));
				game.TrackAssets('jungleHole_03');
			}
			if(game.CheckAsset('jungleHole_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHole/JungleHole_SpriteSheet_02.atf'));
				game.TrackAssets('jungleHole_04');
			}
			if(game.CheckAsset('jungleHole_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHole/JungleHole_SpriteSheet_02.xml'));
				game.TrackAssets('jungleHole_05');
			}

			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleHole","JungleHoleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleHole_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			book = new Image(this.assets.getTexture('book'));
			book.touchable = false;
			book.x = 320;
			book.y = 170;
			this.addChildAt(book,1);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole['Cover'] == 'open'){
					cover = new Image(this.assets.getTexture('cover_off'));
					cover.touchable = false;
					cover.x = 0;
					cover.y = 129;
					alpha = 1;
					CreateCoverHit(true);
					CreateBookHit();
					coverOpen = true;
				}else{
					cover = new Image(this.assets.getTexture('cover_on'));
					cover.touchable = false;
					cover.x = 196;
					cover.y = 14;
					alpha = 1;
					CreateCoverHit(false);
					coverOpen = false;
				}
			}else{
				cover = new Image(this.assets.getTexture('cover_on'));
				cover.touchable = false;
				cover.x = 196;
				cover.y = 14;
				alpha = 1;
				CreateCoverHit(false);
				coverOpen = false;
				
			}
			
			this.addChildAt(cover,2);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole["Book"] == "open"){
					trace("Book is Open");
					BookIsOpen = true;
				//	OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
						//openBookPages.texture = this.assets.getTexture('buc_page_zero');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
						//openBookPages.texture = this.assets.getTexture('buc_page_one');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole["BookCurrentPage"] == 2){
						openBookcurrentPage = 2;
						//openBookPages.texture = this.assets.getTexture('buc_page_two');
						
					}else{
						openBookcurrentPage = 0;
					//	openBookPages.texture = this.assets.getTexture('buc_page_zero');
					}
					OpenBook();
					this.addChild(goback);
				}
			}
			
			
			//FadeOutOcean(1);			


			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);

		}
		
		private function CreateBookHit():void{
			hit_book = new Shape();
			addChildAt(hit_book,3);
			hit_book.graphics.beginFill(0x00FF00);
			hit_book.graphics.lineTo(318,163);	
			hit_book.graphics.lineTo(462,177);	
			hit_book.graphics.lineTo(484,368);	
			hit_book.graphics.lineTo(330,364);	
			
			hit_book.graphics.endFill(false);
			hit_book.touchable = false;
			hit_book.alpha = 0.0;
			hit_book.graphics.precisionHitTest = true;				
			
		}
		
		private function CreateCoverHit(open:Boolean = false):void{
			hit_cover = new Shape();
			this.addChild(hit_cover);
			if(open === false){
				
				hit_cover.x = 0;
				hit_cover.y = 0;
				hit_cover.graphics.beginFill(0x0000FF);
				hit_cover.graphics.lineTo(200,351);	
				hit_cover.graphics.lineTo(264,56);	
				hit_cover.graphics.lineTo(582,37);	
				hit_cover.graphics.lineTo(566,375);	
				hit_cover.graphics.lineTo(352,376);	
				
				hit_cover.graphics.endFill(false);
				
				hit_cover.alpha = 0.0;
				
				hit_cover.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_cover.x = 0;
				hit_cover.y = 0;
				hit_cover.graphics.beginFill(0x0000FF);		
				hit_cover.graphics.lineTo(0,224);	
				hit_cover.graphics.lineTo(230,132);	
				hit_cover.graphics.lineTo(240,141);	
				hit_cover.graphics.lineTo(83,360);	
				hit_cover.graphics.lineTo(0,374);	
				
				
				hit_cover.graphics.endFill(false);
				hit_cover.alpha = 0.0;
				
				hit_cover.graphics.precisionHitTest = true;				
			}
			hit_cover.touchable = false;
			
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
								FadeOut((JungleEdge as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEdgeObj,true
								);
							}else if(coverOpen === true){
								if(hit_cover.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									CoverTouch();
									
									//	HatchTouch();
								}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
									BookIsOpen = true;
									OpenBook(true, 0)
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole;
									}		
									SaveArray['Book'] = "open";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHole',SaveArray);
								}
							}else{
								if(hit_cover.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									CoverTouch();
									//HatchTouch();
								}
							}
						}else{
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								trace("GoBackClick");
								RemoveBook();
								BookIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole;
								}		
								SaveArray['Book'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHole',SaveArray);
							}else if(hit_OpenBook.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole;
								}
								if(openBookcurrentPage == 0){
									SaveArray['BookCurrentPage'] = 1;
									openBookcurrentPage = 1;
									openBookPages.texture = this.assets.getTexture('buc_page_one');
									hit_OpenBook.graphics.clear();
									CreateOpenBookHit(1);
								}else if(openBookcurrentPage == 1){
									SaveArray['BookCurrentPage'] = 2;
									openBookcurrentPage = 2;
									openBookPages.texture = this.assets.getTexture('buc_page_two');
									hit_OpenBook.graphics.clear();
									CreateOpenBookHit(2);
								}else if(openBookcurrentPage == 2){
									SaveArray['BookCurrentPage'] = 0;
									openBookcurrentPage = 0;
									openBookPages.texture = this.assets.getTexture('buc_page_zero');
									hit_OpenBook.graphics.clear();
									CreateOpenBookHit(0);
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHole',SaveArray);
							}
						}
					}
				}
			}
		}
		
		
		private function CoverTouch():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
			trace("touch Hatch");
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHole['Cover'] != 'open'){
					trace(1);
					SaveArray['Cover'] = 'open';
					
					//hatch.alpha = 1;
					cover.texture = this.assets.getTexture('cover_off');
					cover.x = 0;
					cover.y = 129;
					cover.width = 251;
					cover.height = 347;
					hit_cover.graphics.clear();
					CreateCoverHit(true);
					CreateBookHit();
					coverOpen = true;
					//CreateJunkInteriorHit();
					
				}else{
					trace(2);
					SaveArray['Cover'] = 'close';
					
					cover.texture = this.assets.getTexture('cover_on');
					cover.x = 196;
					cover.y = 14;
					cover.width = 434;
					cover.height = 394;
					
					removeChild(hit_book);
					hit_cover.graphics.clear();
					
					CreateCoverHit(false);
					coverOpen = false;
					
				}
				
			}else{
				trace(3)
				SaveArray['Cover'] = 'open';
				
				cover.texture = this.assets.getTexture('cover_off');
				cover.x = 0;
				cover.y = 129;
				cover.width = 251;
				cover.height = 347;
				hit_cover.graphics.clear();
				CreateCoverHit(true);
				CreateBookHit();
				coverOpen = true;
				//CreateJunkInteriorHit();
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHole',SaveArray);	
		}
		
		private function OpenBook(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openBook = new Sprite();
			openBook.alpha = 0;
			CreateOpenBookBg();
			openBookPages = new Image(this.assets.getTexture('buc_page_zero'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChildAt(openBook,4);
			this.addChildAt(goback,5);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = this.assets.getTexture('buc_page_zero');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = this.assets.getTexture('buc_page_one');
			}else if(openBookcurrentPage == 2){
				openBookPages.texture = this.assets.getTexture('buc_page_two');
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
			}else if(page == 1 || page == 2){
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
			
			
			this.assets.removeTexture("jungleHole_bg",true);
			this.assets.removeTexture("JungleHole_SpriteSheet",true);
			this.assets.removeTextureAtlas("JungleHole_SpriteSheet",true);
			this.assets.removeTexture("JungleHole_SpriteSheet_02",true);
			this.assets.removeTextureAtlas("JungleHole_SpriteSheet_02",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleHole_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleHole_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleHole_03");
			(stage.getChildAt(0) as Object).falseAsset("jungleHole_04");
			(stage.getChildAt(0) as Object).falseAsset("jungleHole_05");
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