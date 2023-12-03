package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class TriremeDeck extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var waterfall_mc:MovieClip;
		
		private var fish:Image;
		private var ladder:Image;
		private var lid:Image;
		
		private var hit_FarCoastCorner:Shape;
		private var hit_TriremeInterior:Shape;
		private var hit_fish:Shape;
		private var hit_book:Shape;
		
		private var hit_vase:Shape;
		private var hit_sheild:Shape;
		private var hit_rope:Shape;
		
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		public var OpenBookTween:Tween;
		
		private var BookIsOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function TriremeDeck(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('triremeDeck_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDeck/triremeDeck_bg.jpg'));
				game.TrackAssets('triremeDeck_01');
			}
			if(game.CheckAsset('triremeDeck_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDeck/triremeDeck_Sprite_01.atf'));
				game.TrackAssets('triremeDeck_02');
			}
			if(game.CheckAsset('triremeDeck_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDeck/triremeDeck_Sprite_01.xml'));
				game.TrackAssets('triremeDeck_03');
			}
			
			if(game.CheckAsset('triremeDeck_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDeck/triremeDeck_Sprite_02.png'));
				game.TrackAssets('triremeDeck_04');
			}
			if(game.CheckAsset('triremeDeck_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TriremeDeck/triremeDeck_Sprite_02.xml'));
				game.TrackAssets('triremeDeck_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("TriremeDeck","TriremeDeckObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('triremeDeck_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			waterfall_mc = new MovieClip(this.assets.getTextures('falling_water_'),6);
			//		LargeWheel_mc.smoothing = TextureSmoothing.NONE;
			waterfall_mc.smoothing = TextureSmoothing.NONE;

			waterfall_mc.x = 1;
			waterfall_mc.y = 1;
			waterfall_mc.alpha = 0.7;
			waterfall_mc.touchable = false;
			waterfall_mc.loop = true; // default: true
			waterfall_mc.play();
			this.addChildAt(waterfall_mc,1);	
			
			
			fish = new Image(this.assets.getTexture('fish'));
			fish.smoothing = TextureSmoothing.NONE;

			fish.touchable = false;
			fish.x = 378;
			fish.y = 314;
				
			ladder = new Image(this.assets.getTexture('interior_ladder'));
			ladder.smoothing = TextureSmoothing.NONE;

			ladder.touchable = false;
			ladder.x = 434;
			ladder.y = 90;

			lid = new Image(this.assets.getTexture('interior_lid'));
			lid.smoothing = TextureSmoothing.NONE;

			lid.touchable = false;
			lid.x = 471;
			lid.y = 95;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeInterior["Ladder"] == "PickedUp"){
					ladder.alpha = 0; 
				}else{
					ladder.alpha = 1;
				}
			}else{
				ladder.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDevice['Lid'] == 'Open'){
					lid.alpha = 1;
				}else{
					lid.alpha = 0;
				}
			}else{
				lid.alpha = 0;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck['Fish'] == 'PickedUp'){
					fish.alpha = 0;
				}else{
					fish.alpha = 1;
				}
			}else{
				fish.alpha = 1;
			}
			
		
			
			this.addChildAt(fish,2);
			this.addChildAt(ladder,3);			
			this.addChildAt(lid,4);
			
			
			Starling.juggler.add(waterfall_mc);
			
			CreateHitVase();
			CreateHitSheild();
			CreateHitRope();
			CreateHitFarCoastCorner();
			CreateHitTriremeInterior();
			CreateHitFish();
			CreateHitBook();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
		//	this.addChild(goback);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck["Book"] == "open"){
					BookIsOpen = true;
					OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
						openBookPages.texture = this.assets.getTexture('page_00');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
						openBookPages.texture = this.assets.getTexture('page_01');
					}
					
					//this.addChild(goback);
				}
			}
			
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
			if((stage.getChildAt(0) as Object).AmbientObj.currentAmbient == 'Waterfall'){
				trace("BARK1");
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
				},1);
			}else{
				trace("BARK2");
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaterfall(true,999);
				},1);
			}
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Waterfall';
		}
		
		private function CreateHitRope():void{
			hit_rope = new Shape();
			hit_rope.touchable = false;
			hit_rope.graphics.beginFill(0x0000ff);
			
			hit_rope.graphics.lineTo(96,398);																																																																																																																														
			hit_rope.graphics.lineTo(174,363);																																																																																																																														
			hit_rope.graphics.lineTo(271,382);																																																																																																																														
			hit_rope.graphics.lineTo(180,506);																																																																																																																														
			hit_rope.graphics.lineTo(71,506);																																																																																																																														
		
			hit_rope.graphics.endFill(false);
			hit_rope.alpha = 0.0;
			
			hit_rope.graphics.precisionHitTest = true;	
			this.addChild(hit_rope);
		}
		
		private function CreateHitSheild():void{
			hit_sheild = new Shape();
			hit_sheild.touchable = false;
			hit_sheild.graphics.beginFill(0x0000ff);
			
			hit_sheild.graphics.lineTo(50,284);																																																																																																																														
			hit_sheild.graphics.lineTo(61,199);																																																																																																																														
			hit_sheild.graphics.lineTo(115,183);																																																																																																																														
			hit_sheild.graphics.lineTo(142,201);																																																																																																																														
			hit_sheild.graphics.lineTo(194,344);																																																																																																																														
			hit_sheild.graphics.lineTo(153,369);																																																																																																																														
			hit_sheild.graphics.lineTo(94,346);																																																																																																																														
		
			hit_sheild.graphics.endFill(false);
			hit_sheild.alpha = 0.0;
			
			hit_sheild.graphics.precisionHitTest = true;	
			this.addChild(hit_sheild);
		}
		private function CreateHitVase():void{
			hit_vase = new Shape();
			hit_vase.touchable = false;
			hit_vase.graphics.beginFill(0x0000ff);
			
			hit_vase.graphics.lineTo(636,213);																																																																																																																														
			hit_vase.graphics.lineTo(787,178);																																																																																																																														
			hit_vase.graphics.lineTo(790,285);																																																																																																																														
			hit_vase.graphics.lineTo(651,298);																																																																																																																														
			
			hit_vase.graphics.endFill(false);
			hit_vase.alpha = 0.0;
			
			hit_vase.graphics.precisionHitTest = true;	
			this.addChild(hit_vase);
		}
		
		private function CreateHitBook():void{
			hit_book = new Shape();
			hit_book.touchable = false;
			hit_book.graphics.beginFill(0x0000ff);
			
			hit_book.graphics.lineTo(153,202);																																																																																																																														
			hit_book.graphics.lineTo(256,168);																																																																																																																														
			hit_book.graphics.lineTo(275,173);																																																																																																																														
			hit_book.graphics.lineTo(320,286);																																																																																																																														
			hit_book.graphics.lineTo(308,324);																																																																																																																														
			hit_book.graphics.lineTo(206,361);																																																																																																																														

			hit_book.graphics.endFill(false);
			hit_book.alpha = 0.0;
			
			hit_book.graphics.precisionHitTest = true;	
			this.addChild(hit_book);
		}
		
		private function CreateHitFish():void{
			hit_fish = new Shape();
			hit_fish.touchable = false;
			hit_fish.graphics.beginFill(0x0000ff);
			
			hit_fish.graphics.lineTo(345,386);																																																																																																																														
			hit_fish.graphics.lineTo(442,327);																																																																																																																														
			hit_fish.graphics.lineTo(625,319);																																																																																																																														
			hit_fish.graphics.lineTo(733,297);																																																																																																																														
			hit_fish.graphics.lineTo(773,372);																																																																																																																														
			hit_fish.graphics.lineTo(422,465);																																																																																																																														
			hit_fish.graphics.lineTo(355,440);																																																																																																																														

			hit_fish.graphics.endFill(false);
			hit_fish.alpha = 0.0;
			
			hit_fish.graphics.precisionHitTest = true;	
			this.addChild(hit_fish);
		}
		
		private function CreateHitFarCoastCorner():void{
			hit_FarCoastCorner = new Shape();
			hit_FarCoastCorner.touchable = false;
			hit_FarCoastCorner.graphics.beginFill(0xff0000);
			
			hit_FarCoastCorner.graphics.lineTo(0,0);																																																																																																																														
			hit_FarCoastCorner.graphics.lineTo(188,0);																													
			hit_FarCoastCorner.graphics.lineTo(218,48);	
			hit_FarCoastCorner.graphics.lineTo(296,80);	
			hit_FarCoastCorner.graphics.lineTo(0,186);
			hit_FarCoastCorner.graphics.endFill(false);
			hit_FarCoastCorner.alpha = 0.0;
			
			hit_FarCoastCorner.graphics.precisionHitTest = true;	
			this.addChild(hit_FarCoastCorner);
		}
		private function CreateHitTriremeInterior():void{
			hit_TriremeInterior = new Shape();
			hit_TriremeInterior.touchable = false;
			hit_TriremeInterior.graphics.beginFill(0xff0000);
			
			hit_TriremeInterior.graphics.lineTo(360,124);																																																																																																																														
			hit_TriremeInterior.graphics.lineTo(696,48);																																																																																																																														
			hit_TriremeInterior.graphics.lineTo(720,194);																																																																																																																														
			hit_TriremeInterior.graphics.lineTo(617,208);																																																																																																																														
			hit_TriremeInterior.graphics.lineTo(626,318);																																																																																																																														
			hit_TriremeInterior.graphics.lineTo(360,332);																																																																																																																														
			hit_TriremeInterior.graphics.lineTo(375,247);		
			hit_TriremeInterior.graphics.endFill(false);
			hit_TriremeInterior.alpha = 0.0;

			
			hit_TriremeInterior.graphics.precisionHitTest = true;	
			this.addChild(hit_TriremeInterior);
		}
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED){
					if(BookIsOpen === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(hit_FarCoastCorner.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SplashOut();
							FadeOut((FarCoastCorner as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastCornerObj,true
							);	
						}else if(hit_TriremeInterior.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();
							
							FadeOut((TriremeInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.TriremeInteriorObj,true
							);	
						}else if(hit_fish.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FishHandler();
						}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							BookIsOpen = true;
							OpenBook(true, openBookcurrentPage);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck;
							}		
							SaveArray['Book'] = "open";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDeck',SaveArray);					
						}else if(hit_vase.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Fragments of pottery.');
						}else if(hit_sheild.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('A shield with fish and a person sailing painted on it.');
						}else if(hit_rope.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('A rusted, broken spear tip and some decaying rope.');
						}
						/*
						private var hit_vase:Shape;
						private var hit_sheild:Shape;
						private var hit_rope:Shape;
						*/
					}else{
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							trace("GoBackClick");
							RemoveBook();
							BookIsOpen = false;	
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck;
							}		
							SaveArray['Book'] = "closed";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDeck',SaveArray);
						}
						else if(hit_openBookNext.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck;
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
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDeck',SaveArray);
						}
						else if(hit_openBookBack.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck;
							}
							if(openBookcurrentPage == 1){
								SaveArray['BookCurrentPage'] = 0;
								openBookcurrentPage = 0;
								openBookPages.texture = this.assets.getTexture('page_00');
							}else if(openBookcurrentPage == 0){
								SaveArray['BookCurrentPage'] = 1;
								openBookcurrentPage = 1;
								openBookPages.texture = this.assets.getTexture('page_01');
							}
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDeck',SaveArray);
						}
					}
				}
			}
		}
		
		private function FishHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck['Fish'] == 'PickedUp'){
					
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					fish.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck;
					}
					SaveArray["Fish"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDeck',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Fish,
						'item_Fish',
						'inven_fish_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				fish.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TriremeDeck;
				}
				SaveArray["Fish"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TriremeDeck',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Fish,
					'item_Fish',
					'inven_fish_sm'
				);
			}
		}
		
		
		
		
		
		private function OpenBook(Fade:Boolean = false,page:Number = 0):void{
			openBook = new Sprite();
			openBook.alpha = 0;
			CreateOpenBookBg();
			openBookPages = new Image(this.assets.getTexture('page_00'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			openBook.addChild(goback);
			this.addChildAt(openBook,7);
			
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = this.assets.getTexture('page_00');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = this.assets.getTexture('page_01');
			}
			
			CreateOpenBookHit()
			//	CreateOpenBookHit(openBookcurrentPage);
			
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
		
		private function RemoveBook():void{
			//Starling.juggler.purge();
			OpenBookTween = new Tween(openBook, 0.5, Transitions.LINEAR);
			OpenBookTween.fadeTo(0);
			OpenBookTween.onComplete = function():void{
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
			
			
	//		this.removeChild(goback);
	//		goback = null;			
			
			
			this.assets.removeTexture("triremeDeck_bg",true);
			this.assets.removeTexture("triremeDeck_Sprite_01",true);
			this.assets.removeTextureAtlas("triremeDeck_Sprite_01",true);
			this.assets.removeTexture("triremeDeck_Sprite_02",true);
			this.assets.removeTextureAtlas("triremeDeck_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("triremeDeck_01");
			(stage.getChildAt(0) as Object).falseAsset("triremeDeck_02");
			(stage.getChildAt(0) as Object).falseAsset("triremeDeck_03");
			(stage.getChildAt(0) as Object).falseAsset("triremeDeck_04");
			(stage.getChildAt(0) as Object).falseAsset("triremeDeck_05");
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