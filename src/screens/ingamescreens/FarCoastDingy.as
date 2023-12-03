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
	
	
	public class FarCoastDingy extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var helmet_lid:Image;
		
		private var hit_book:Shape;
		private var hit_helmet:Shape;
		
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		
		private var hit_OpenBook:Shape;
		
		private var hit_boat:Shape;
		private var BoatHitCounter:int = 0;
		
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
//farCoastDingy_bg		
		public function FarCoastDingy(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('farCoastDingy_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastDingy/farCoastDingy_bg.jpg'));
				game.TrackAssets('farCoastDingy_01');
			}
			if(game.CheckAsset('farCoastDingy_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastDingy/FarCoastDingy_Sprite.png'));
				game.TrackAssets('farCoastDingy_02');
			}
			if(game.CheckAsset('farCoastDingy_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoastDingy/FarCoastDingy_Sprite.xml'));
				game.TrackAssets('farCoastDingy_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FarCoastDingy","FarCoastDingyObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('farCoastDingy_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			helmet_lid = new Image(this.assets.getTexture('helmet_lid_open'));
			helmet_lid.touchable = false;
			helmet_lid.x = 478;
			helmet_lid.y = 181;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Lid'] == 'Open'){
					helmet_lid.alpha = 1;
				}else{
					helmet_lid.alpha = 0;
				}
			}else{
				helmet_lid.alpha = 0;
			}

			this.addChildAt(helmet_lid,1);
			
			CreateHitBoat();
			CreateHitHelmet();
			CreateHitBook();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy["Book"] == "open"){
					trace("Book is Open");
					BookIsOpen = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;						
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy["BookCurrentPage"] == 2){
						openBookcurrentPage = 2;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy["BookCurrentPage"] == 3){
						openBookcurrentPage = 3;
					}else{
						openBookcurrentPage = 0;					
					}
					OpenBook();
					this.addChild(goback);
				}
			}
			
		
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
		
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastDingy',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastDingy',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,2);
					},0.5);
				}
			}
			
		}
		
//hit_boat
		private function CreateHitBoat():void{
			hit_boat = new Shape();
			hit_boat.touchable = false;
			hit_boat.graphics.beginFill(0xff0000);
			
			hit_boat.graphics.lineTo(26,252);																																																																																																																														
			hit_boat.graphics.lineTo(238,136);																																																																																																																														
			hit_boat.graphics.lineTo(627,38);																																																																																																																														
			hit_boat.graphics.lineTo(738,122);																																																																																																																														
			hit_boat.graphics.lineTo(486,349);																																																																																																																														
			hit_boat.graphics.lineTo(269,411);																																																																																																																														
			hit_boat.graphics.lineTo(118,399);																																																																																																																														
			
			hit_boat.graphics.endFill(false);
			hit_boat.alpha = 0.0;
			
			hit_boat.graphics.precisionHitTest = true;	
			this.addChild(hit_boat);
		}
		
		private function CreateHitHelmet():void{
			hit_helmet = new Shape();
			hit_helmet.touchable = false;
			hit_helmet.graphics.beginFill(0xff0000);
			
			hit_helmet.graphics.lineTo(471,205);																																																																																																																														
			hit_helmet.graphics.lineTo(605,146);																																																																																																																														
			hit_helmet.graphics.lineTo(672,147);																																																																																																																														
			hit_helmet.graphics.lineTo(717,167);																																																																																																																														
			hit_helmet.graphics.lineTo(773,272);																																																																																																																														
			hit_helmet.graphics.lineTo(773,305);																																																																																																																														
			hit_helmet.graphics.lineTo(710,387);																																																																																																																														
			hit_helmet.graphics.lineTo(488,350);																																																																																																																														
			hit_helmet.graphics.lineTo(476,275);																																																																																																																														
																																																																																																																													
			hit_helmet.graphics.endFill(false);
			hit_helmet.alpha = 0.0;
			
			hit_helmet.graphics.precisionHitTest = true;	
			this.addChild(hit_helmet);
		}
		
		private function CreateHitBook():void{
			hit_book = new Shape();
			hit_book.touchable = false;
			hit_book.graphics.beginFill(0xff0000);
			
			hit_book.graphics.lineTo(266,159);																																																																																																																														
			hit_book.graphics.lineTo(372,143);																																																																																																																														
			hit_book.graphics.lineTo(406,273);																																																																																																																														
			hit_book.graphics.lineTo(303,295);																																																																																																																														
			
			hit_book.graphics.endFill(false);
			hit_book.alpha = 0.0;
			
			hit_book.graphics.precisionHitTest = true;	
			this.addChild(hit_book);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(BookIsOpen === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((FarCoast as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastObj,true
							);
						}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							BookIsOpen = true;
							OpenBook(true, 0)
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy;
							}		
							SaveArray['Book'] = "open";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastDingy',SaveArray);
						}else if(hit_helmet.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((FarCoastHelmet as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastHelmetObj,true
							);		
						}else if(hit_boat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BoatHitCounter == 0){
								BoatHitCounter = 1;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('An old fishing trolley.');
							}else if(BoatHitCounter == 1){
								BoatHitCounter = 2;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('What was the fisherman looking for with the diving gear?');
							}else if(BoatHitCounter == 2){
								BoatHitCounter = 3;
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The boat is beyond repair.');
							}else if(BoatHitCounter == 3){
								BoatHitCounter = 0;
								
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Another soul lost to the seas...');
							}
								
						}
						
						//BoatHitCounter
					}else{
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							trace("GoBackClick");
							RemoveBook();
							BookIsOpen = false;	
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy;
							}		
							SaveArray['Book'] = "closed";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastDingy',SaveArray);
						}else if(hit_OpenBook.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastDingy;
							}
							if(openBookcurrentPage == 0){
								SaveArray['BookCurrentPage'] = 1;
								openBookcurrentPage = 1;
								openBookPages.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_01');
								hit_OpenBook.graphics.clear();
								CreateOpenBookHit(1);
							}else if(openBookcurrentPage == 1){
								SaveArray['BookCurrentPage'] = 2;
								openBookcurrentPage = 2;
								openBookPages.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_02');
								hit_OpenBook.graphics.clear();
								CreateOpenBookHit(2);
							}else if(openBookcurrentPage == 2){
								SaveArray['BookCurrentPage'] = 3;
								openBookcurrentPage = 3;
								openBookPages.texture =(stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_03');
								hit_OpenBook.graphics.clear();
								CreateOpenBookHit(3);
							}else if(openBookcurrentPage == 3){
								SaveArray['BookCurrentPage'] = 0;
								openBookcurrentPage = 0;
								openBookPages.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_00');
								hit_OpenBook.graphics.clear();
								CreateOpenBookHit(0);
							}
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FarCoastDingy',SaveArray);
						}
					}
				}
			}
		}
		
		
		private function OpenBook(Fade:Boolean = false,page:Number = 0):void{
			openBook = new Sprite();
			openBook.alpha = 0;
			CreateOpenBookBg();
			openBookPages = new Image((stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_00'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChildAt(openBook,4);
			this.addChildAt(goback,5);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_00');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_01');
			}else if(openBookcurrentPage == 2){
				openBookPages.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_02');
			}else if(openBookcurrentPage == 3){
				openBookPages.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('TwentyThousand_page_03');
			}
			
			
			CreateOpenBookHit(openBookcurrentPage);
			
			if(Fade === false){
				openBook.alpha = 1;
				
			}else{
				
				OpenBookTween = new Tween(openBook, 0.5, Transitions.LINEAR);
				OpenBookTween.fadeTo(1);
				OpenBookTween.onComplete = function():void{
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
			}else if(page == 1 || page == 2 || page == 3){
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
			Starling.juggler.purge();
			OpenBookTween = new Tween(openBook, 0.5, Transitions.LINEAR);
			OpenBookTween.fadeTo(0);
			OpenBookTween.onComplete = function():void{
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
			
			
			this.assets.removeTexture("farCoastDingy_bg",true);
			this.assets.removeTexture("FarCoastDingy_Sprite",true);
			this.assets.removeTextureAtlas("FarCoastDingy_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("farCoastDingy_01");
			(stage.getChildAt(0) as Object).falseAsset("farCoastDingy_02");
			(stage.getChildAt(0) as Object).falseAsset("farCoastDingy_03");
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