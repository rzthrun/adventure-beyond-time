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
	
	
	public class CoastSkeleton extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var shell:Image;
		
		private var hit_shell:Shape;
		private var hit_book:Shape;
		private var hit_skeleton:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		private var Animating:Boolean = false;
		private var goback:GoBackButton;
		public function CoastSkeleton(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastSkeleton_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastSkeleton/coastSkeleton_bg.jpg'));
				game.TrackAssets('coastSkeleton_01');
			}
			if(game.CheckAsset('coastSkeleton_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastSkeleton/CoastSkeleton_Sprite_01.png'));
				game.TrackAssets('coastSkeleton_02');
			}
			if(game.CheckAsset('coastSkeleton_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastSkeleton/CoastSkeleton_Sprite_01.xml'));
				game.TrackAssets('coastSkeleton_03');
			}
			if(game.CheckAsset('coastSkeleton_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastSkeleton/CoastSkeleton_Sprite_02.png'));
				game.TrackAssets('coastSkeleton_04');
			}
			if(game.CheckAsset('coastSkeleton_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastSkeleton/CoastSkeleton_Sprite_02.xml'));
				game.TrackAssets('coastSkeleton_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastSkeleton","CoastSkeletonObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastSkeleton_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
		
			shell = new Image(this.assets.getTexture('shell'));
			shell.touchable = false;
			shell.x = 101;
			shell.y = 237;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){			
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton["Shell"] == "PickedUp"){
					shell.alpha = 0;
				}else{
					shell.alpha = 1;
				}
			}else{
				shell.alpha = 1;
			}		
			this.addChildAt(shell,1);
			
			CreateHitBook();
			CreateHitShell();
			CreateHitSkeleton();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton["Book"] == "open"){
					BookIsOpen = true;
					OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
						openBookPages.texture = this.assets.getTexture('page_00');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
						openBookPages.texture = this.assets.getTexture('page_01');
					}else{
						openBookcurrentPage = 0;
						openBookPages.texture = this.assets.getTexture('page_00');
					}
					
					this.addChild(goback);
				}
			}
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,2);
						},1.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,4);
					},1.5);
				}
			}
			
		}
		//hit_skeleton
		
		private function CreateHitSkeleton():void{
			hit_skeleton = new Shape();
			hit_skeleton.touchable = false;
			hit_skeleton.graphics.beginFill(0xff0000);
			
			
			hit_skeleton.graphics.lineTo(264,227);			
			hit_skeleton.graphics.lineTo(313,120);			
			hit_skeleton.graphics.lineTo(421,1);			
			hit_skeleton.graphics.lineTo(566,62);			
			hit_skeleton.graphics.lineTo(389,359);			
			hit_skeleton.graphics.lineTo(285,334);			
			
			hit_skeleton.graphics.endFill(false);
			hit_skeleton.alpha = 0.0;
			
			hit_skeleton.graphics.precisionHitTest = true;	
			this.addChild(hit_skeleton);
		}
		
		private function CreateHitShell():void{
			hit_shell = new Shape();
			hit_shell.touchable = false;
			hit_shell.graphics.beginFill(0xff0000);
			
			
			hit_shell.graphics.lineTo(77,292);	
			hit_shell.graphics.lineTo(175,212);	
			hit_shell.graphics.lineTo(253,231);	
			hit_shell.graphics.lineTo(267,321);	
			hit_shell.graphics.lineTo(117,362);	

			hit_shell.graphics.endFill(false);
			hit_shell.alpha = 0.0;
			
			hit_shell.graphics.precisionHitTest = true;	
			this.addChild(hit_shell);
		}
		
		private function CreateHitBook():void{
			hit_book = new Shape();
			hit_book.touchable = false;
			hit_book.graphics.beginFill(0xff0000);
			
			
			hit_book.graphics.lineTo(511,260);	
			hit_book.graphics.lineTo(627,270);	
			hit_book.graphics.lineTo(623,415);	
			hit_book.graphics.lineTo(494,409);	
		
			
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
					if(Animating === false){
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(BookIsOpen === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CoastCaveExterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveExteriorObj,true
							);
						}else if(hit_shell.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							ShellHandler();
						}else if(hit_skeleton.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A skeleton... decomposed and washed away.");

						}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							BookIsOpen = true;
							OpenBook(true, openBookcurrentPage);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton;
							}		
							SaveArray['Book'] = "open";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
							
						}
					}else{
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							trace("GoBackClick");
							RemoveBook();
							BookIsOpen = false;	
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton;
							}		
							SaveArray['Book'] = "closed";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
						}
						else if(hit_openBookNext.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton;
							}
							
							if(openBookcurrentPage == 0){
								SaveArray['BookCurrentPage'] = 1;
								openBookcurrentPage = 1;
								openBookPages.texture = this.assets.getTexture('page_01');
							}else if(openBookcurrentPage == 1){
								
								SaveArray['BookCurrentPage'] = 0;
								openBookcurrentPage = 0;
								openBookPages.texture = this.assets.getTexture('page_00');
							}
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
						}
						else if(hit_openBookBack.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton;
							}
							if(openBookcurrentPage == 0){
								SaveArray['BookCurrentPage'] = 1;
								openBookcurrentPage = 1;
								openBookPages.texture = this.assets.getTexture('page_01');
							
							}else if(openBookcurrentPage == 1){
								SaveArray['BookCurrentPage'] = 0;
								openBookcurrentPage = 0;
								openBookPages.texture = this.assets.getTexture('page_00');
							}
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
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
			openBookPages = new Image(this.assets.getTexture('page_00'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChildAt(openBook,5);
			this.addChildAt(goback,6);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = this.assets.getTexture('page_00');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = this.assets.getTexture('page_01');
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
		
		private function ShellHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton["Shell"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Looks like whomever this used to be was clutching the shell when they passed away...");

				}else{
					shell.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton;
					}
					SaveArray['Shell'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
					
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Shell,
						'item_Shell',
						'inven_shell_sm'
					);
				}
			}else{
				shell.alpha = 0;
			
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton;
				}
				SaveArray['Shell'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastSkeleton',SaveArray);
				
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Shell,
					'item_Shell',
					'inven_shell_sm'
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
			
			
			this.assets.removeTexture("coastSkeleton_bg",true);
			this.assets.removeTexture("CoastSkeleton_Sprite_01",true);
			this.assets.removeTexture("CoastSkeleton_Sprite_02",true);
			this.assets.removeTextureAtlas("CoastSkeleton_Sprite_01",true);
			this.assets.removeTextureAtlas("CoastSkeleton_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("coastSkeleton_01");
			(stage.getChildAt(0) as Object).falseAsset("coastSkeleton_02");
			(stage.getChildAt(0) as Object).falseAsset("coastSkeleton_03");
			(stage.getChildAt(0) as Object).falseAsset("coastSkeleton_04");
			(stage.getChildAt(0) as Object).falseAsset("coastSkeleton_05");
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