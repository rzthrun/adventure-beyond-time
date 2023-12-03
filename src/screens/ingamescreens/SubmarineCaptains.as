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
	
	public class SubmarineCaptains extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var bed_lid:Image;
		private var bed_pillow:Image;
		private var bed_coin:Image;
		private var bed_wire_cutters:Image;
		private var table_screen:Image;
		private var table_disc:Image;
		
		private var hit_book:Shape;
		private var hit_bed:Shape;
		private var hit_table:Shape;
		
		private var hit_books:Shape;
		private var hit_boat:Shape;
		private var hit_carrier:Shape;
		private var hit_bedspread:Shape;
		
		private var openBookbg:Shape;
		private var openBook:Sprite;
		private var openBookPages:Image;
		private var openBookcurrentPage:Number = 0;
		private var hit_openBookBack:Shape;
		private var hit_openBookNext:Shape;
		public var OpenBookTween:Tween;
		private var BookIsOpen:Boolean = false;
		
		private var Animating:Boolean = false;
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function SubmarineCaptains(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineCaptains_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptains/submarineCaptains_bg.jpg'));
				game.TrackAssets('submarineCaptains_01');
			}
			if(game.CheckAsset('submarineCaptains_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptains/SubmarineCaptains_Sprite_01.png'));
				game.TrackAssets('submarineCaptains_02');
			}
			if(game.CheckAsset('submarineCaptains_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptains/SubmarineCaptains_Sprite_01.xml'));
				game.TrackAssets('submarineCaptains_03');
			}
	//		if(game.CheckAsset('submarineCaptains_04') === false){
	//			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptains/SubmarineCaptains_Sprite_02.png'));
	//			game.TrackAssets('submarineCaptains_04');
	//		}
	//		if(game.CheckAsset('submarineCaptains_05') === false){
	//			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineCaptains/SubmarineCaptains_Sprite_02.xml'));
	//			game.TrackAssets('submarineCaptains_05');
	//		}
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineCaptains","SubmarineCaptainsObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineCaptains_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			bed_coin = new Image(this.assets.getTexture('bed_coin'));
			bed_coin.touchable = false;
			bed_coin.x = 349;
			bed_coin.y = 239;
		
			
			bed_wire_cutters = new Image(this.assets.getTexture('bed_wires'));
			bed_wire_cutters.touchable = false;
			bed_wire_cutters.x = 359;
			bed_wire_cutters.y = 116;

			bed_pillow = new Image(this.assets.getTexture('bed_pillow'));
			bed_pillow.touchable = false;
			bed_pillow.x = 191;
			bed_pillow.y = 196;
			
			bed_lid = new Image(this.assets.getTexture('bed_lid'));
			bed_lid.touchable = false;
			bed_lid.x = 238;
			bed_lid.y = 50;
			
			table_disc = new Image(this.assets.getTexture('table_floppy'));
			table_disc.touchable = false;
			table_disc.x = 573;
			table_disc.y = 277;

			table_screen = new Image(this.assets.getTexture('table_screen'));
			table_screen.touchable = false;
			table_screen.x = 636;
			table_screen.y = 158;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Pillow'] == 'Off'){
					bed_pillow.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Coin'] == 'PickedUp'){
						bed_coin.alpha = 0;
					}else{
						bed_coin.alpha = 1;
					}
				}else{
					bed_coin.alpha = 0;
					bed_pillow.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['Lid'] == 'Off'){
					bed_lid.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsBed['WireCutters'] == 'PickedUp'){
						bed_wire_cutters.alpha = 0;
					}else{
						bed_wire_cutters.alpha = 1;
					}
				}else{
					bed_lid.alpha = 1;
					bed_wire_cutters.alpha = 0;
				}
				
			}else{
				bed_coin.alpha = 0;
				bed_wire_cutters.alpha = 0;
				bed_pillow.alpha = 1;
				bed_lid.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable['Floppy'] == 'PickedUp'){
					table_disc.alpha = 0;
				}else{
					table_disc.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptainsTable['ScreenOn'] == 'yes'){
					table_screen.alpha = 1;
				}else{
					table_screen.alpha = 0;
				}
			}else{
				table_disc.alpha = 1;
				table_screen.alpha = 0;
			}
			
			
		
			
			this.addChildAt(bed_coin,1);
			this.addChildAt(bed_wire_cutters,2);	
			this.addChildAt(bed_pillow,3);		
			this.addChildAt(bed_lid,4);			
			this.addChildAt(table_disc,5);			
			this.addChildAt(table_screen,6);

			CreateHitBedSpread();
			CreateHitBooks();
			CreateHitCarrier();
			CreateHitBoat();
			CreateHitBook();
			CreateHitBed();
			CreateHitTable();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains["Book"] == "open"){
					BookIsOpen = true;
					OpenBook();
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains["BookCurrentPage"] == 0){
						openBookcurrentPage = 0;
						openBookPages.texture =  (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_01');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains["BookCurrentPage"] == 1){
						openBookcurrentPage = 1;
						openBookPages.texture =  (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_02');
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains["BookCurrentPage"] == 2){
						openBookcurrentPage = 2;
						openBookPages.texture =  (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_03');
					}else{
						openBookcurrentPage = 0;
						openBookPages.texture =  (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_01');
					}
					
					this.addChild(goback);
				}
			}
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDrips",0,0.5,'stop');
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptains',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptains',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSunShine(true,2);
					},0.5);
				}
			}
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,2);
		}
		
		private function CreateHitBedSpread():void{
			hit_bedspread = new Shape();
			hit_bedspread.touchable = false;
			hit_bedspread.graphics.beginFill(0x00ff00);
			
			hit_bedspread.graphics.lineTo(0,328);	
			hit_bedspread.graphics.lineTo(461,277);	
			hit_bedspread.graphics.lineTo(453,361);	
			hit_bedspread.graphics.lineTo(242,504);	
			hit_bedspread.graphics.lineTo(187,504);	
			hit_bedspread.graphics.lineTo(92,478);	
			
			hit_bedspread.graphics.endFill(false);
			hit_bedspread.alpha = 0.0;
			hit_bedspread.graphics.precisionHitTest = true;	
			this.addChild(hit_bedspread);
			
		}
		
		private function CreateHitCarrier():void{
			hit_carrier = new Shape();
			hit_carrier.touchable = false;
			hit_carrier.graphics.beginFill(0x00ff00);
			
			hit_carrier.graphics.lineTo(0,223);	
			hit_carrier.graphics.lineTo(151,209);	
			hit_carrier.graphics.lineTo(154,269);	
			hit_carrier.graphics.lineTo(0,303);	
			
			hit_carrier.graphics.endFill(false);
			hit_carrier.alpha = 0.0;
			hit_carrier.graphics.precisionHitTest = true;	
			this.addChild(hit_carrier);
			
		}
		
		private function CreateHitBoat():void{
			hit_boat = new Shape();
			hit_boat.touchable = false;
			hit_boat.graphics.beginFill(0x00ff00);
			
			hit_boat.graphics.lineTo(103,29);	
			hit_boat.graphics.lineTo(136,35);	
			hit_boat.graphics.lineTo(153,126);	
			hit_boat.graphics.lineTo(73,120);	
			
			hit_boat.graphics.endFill(false);
			hit_boat.alpha = 0.0;
			hit_boat.graphics.precisionHitTest = true;	
			this.addChild(hit_boat);
			
		}
		
		private function CreateHitBooks():void{
			hit_books = new Shape();
			hit_books.touchable = false;
			hit_books.graphics.beginFill(0x00ff00);
			
			hit_books.graphics.lineTo(0,133);	
			hit_books.graphics.lineTo(165,139);	
			hit_books.graphics.lineTo(163,195);	
			hit_books.graphics.lineTo(0,211);	
			
			hit_books.graphics.endFill(false);
			hit_books.alpha = 0.0;
			hit_books.graphics.precisionHitTest = true;	
			this.addChild(hit_books);
			
		}
		
		private function CreateHitBed():void{
			hit_bed = new Shape();
			hit_bed.touchable = false;
			hit_bed.graphics.beginFill(0x00ff00);
			
			hit_bed.graphics.lineTo(208,41);	
			hit_bed.graphics.lineTo(498,57);	
			hit_bed.graphics.lineTo(476,216);	
			hit_bed.graphics.lineTo(436,298);	
			hit_bed.graphics.lineTo(285,278);	
			hit_bed.graphics.lineTo(183,266);	
			hit_bed.graphics.lineTo(178,151);	
			
			hit_bed.graphics.endFill(false);
			hit_bed.alpha = 0.0;
			hit_bed.graphics.precisionHitTest = true;	
			this.addChild(hit_bed);
			
		}
		
		private function CreateHitTable():void{
			hit_table = new Shape();
			hit_table.touchable = false;
			hit_table.graphics.beginFill(0x00ff00);
			
			hit_table.graphics.lineTo(531,78);	
			hit_table.graphics.lineTo(657,74);	
			hit_table.graphics.lineTo(791,155);	
			hit_table.graphics.lineTo(790,156);	
			hit_table.graphics.lineTo(785,295);	
			hit_table.graphics.lineTo(661,326);	
			hit_table.graphics.lineTo(473,286);	
			hit_table.graphics.lineTo(505,162);	

			
			hit_table.graphics.endFill(false);
			hit_table.alpha = 0.0;
			hit_table.graphics.precisionHitTest = true;	
			this.addChild(hit_table);
			
		}
		
		
		private function CreateHitBook():void{
			hit_book = new Shape();
			hit_book.touchable = false;
			hit_book.graphics.beginFill(0x00ff00);
			
			hit_book.graphics.lineTo(125,298);	
			hit_book.graphics.lineTo(185,273);	
			hit_book.graphics.lineTo(284,282);	
			hit_book.graphics.lineTo(338,316);	
			hit_book.graphics.lineTo(335,350);	
			hit_book.graphics.lineTo(155,366);	

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
					if(BookIsOpen === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((SubmarineInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineInteriorObj,true
							);
						}else if(hit_bed.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((SubmarineCaptainsBed as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsBedObj,true
							);
						}else if(hit_table.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((SubmarineCaptainsTable as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineCaptainsTableObj,true
							);
						
						}else if(hit_book.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							BookIsOpen = true;
							OpenBook(true, openBookcurrentPage);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains;
							}		
							SaveArray['Book'] = "open";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptains',SaveArray);
							
						}else if(hit_books.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are books on history and anthropology interspersed among pulpy sci-fi and adventure novels.");						
						}else if(hit_boat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A model of a sailboat.");						
						}else if(hit_carrier.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A plastic scale model of an aircraft carrier.");						
						}else if(hit_bedspread.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The spartan bed is neatly made.");						
						}
						
					
					
					}else{
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							trace("GoBackClick");
							RemoveBook();
							BookIsOpen = false;	
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains;
							}		
							SaveArray['Book'] = "closed";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptains',SaveArray);
						}
						else if(hit_openBookNext.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains;
							}
							
							if(openBookcurrentPage == 0){
								SaveArray['BookCurrentPage'] = 1;
								openBookcurrentPage = 1;
								openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_02');
							}else if(openBookcurrentPage == 1){
								SaveArray['BookCurrentPage'] = 2;
								openBookcurrentPage = 2;
								openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_03');
							}else if(openBookcurrentPage == 2){
								SaveArray['BookCurrentPage'] = 0;
								openBookcurrentPage = 0;
								openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_01');
							}
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptains',SaveArray);
						}
						else if(hit_openBookBack.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineCaptains;
							}
							if(openBookcurrentPage == 0){
								SaveArray['BookCurrentPage'] = 2;
								openBookcurrentPage = 2;
								openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_03');
							}else if(openBookcurrentPage == 1){
								SaveArray['BookCurrentPage'] = 0;
								openBookcurrentPage = 0;
								openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_01');
							}else if(openBookcurrentPage == 2){
								SaveArray['BookCurrentPage'] = 1;
								openBookcurrentPage = 1;
								openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_02');
							}
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineCaptains',SaveArray);
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
			openBookPages = new Image((stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_01'));
			this.openBook.addChildAt(openBookbg,0);
			openBook.addChild(openBookPages);
			openBookPages.touchable = false;
			
			
			this.addChildAt(openBook,7);
			this.addChildAt(goback,8);
			
			if(openBookcurrentPage == 0){
				openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_01');
			}else if(openBookcurrentPage == 1){
				openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_02');
			}else if(openBookcurrentPage == 2){
				openBookPages.texture = (stage.getChildAt(0) as Object).SubmarineCaptainsImages.assets.getTexture('chinese_page_03');
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
				CloseBook();
				Animating = false;
				
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
			
			
			this.removeChild(goback);
			goback = null;			
			
			
			this.assets.removeTexture("submarineCaptains_bg",true);
			this.assets.removeTexture("SubmarineCaptains_Sprite_01",true);
			this.assets.removeTextureAtlas("SubmarineCaptains_Sprite_01",true);
		//	this.assets.removeTexture("SubmarineCaptains_Sprite_02",true);
		//	this.assets.removeTextureAtlas("SubmarineCaptains_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptains_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptains_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineCaptains_03");
		//	(stage.getChildAt(0) as Object).falseAsset("submarineCaptains_04");
		//	(stage.getChildAt(0) as Object).falseAsset("submarineCaptains_05");
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
