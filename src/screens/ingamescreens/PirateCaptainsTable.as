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
	
	
	public class PirateCaptainsTable extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var skull:Image;
		private var sculptTools:Image;
		
		private var hit_sculptTools:Shape;
		private var hit_skull:Shape;
		private var hit_letter_desk:Shape;
		
		private var hit_head:Shape;
		private var hit_bird:Shape;
		private var hit_ink:Shape;
		private var hit_wine:Shape;
		private var hit_lantern:Shape;
		private var hit_hourGlass:Shape;
		private var hit_painting:Shape;
		
	//	private var hit_letter:Shape
		private var openLetter:Sprite;
		private var openLetterPages:Image;
		private var hit_openLetter:Shape;
		public var OpenLetterTween:Tween;
		
		private var openBookbg:Shape;
		
		private var LetterIsOpen:Boolean = false;
		
		private var Animating:Boolean = false;
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function PirateCaptainsTable(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('pirateCaptainsTable_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsTable/pirateCaptainsTable_bg.jpg'));
				game.TrackAssets('pirateCaptainsTable_01');
			}
			if(game.CheckAsset('pirateCaptainsTable_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsTable/PirateCaptainsTable_Sprite_01.atf'));
				game.TrackAssets('pirateCaptainsTable_02');
			}
			if(game.CheckAsset('pirateCaptainsTable_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsTable/PirateCaptainsTable_Sprite_01.xml'));
				game.TrackAssets('pirateCaptainsTable_03');
			}
			if(game.CheckAsset('pirateCaptainsTable_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsTable/PirateCaptainsTable_Sprite_02.atf'));
				game.TrackAssets('pirateCaptainsTable_04');
			}
			if(game.CheckAsset('pirateCaptainsTable_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/PirateCaptainsTable/PirateCaptainsTable_Sprite_02.xml'));
				game.TrackAssets('pirateCaptainsTable_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("PirateCaptainsTable","PirateCaptainsTableObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		
			
			bg = new Image(this.assets.getTexture('pirateCaptainsTable_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			skull = new Image(this.assets.getTexture('skull'));
			skull.smoothing = TextureSmoothing.NONE;

			skull.touchable = false;
			skull.x = 496;
			skull.y = 204;
			
			
			sculptTools = new Image(this.assets.getTexture('sculptTools'));
			sculptTools.smoothing = TextureSmoothing.NONE;

			sculptTools.touchable = false;
			sculptTools.x = 6;
			sculptTools.y = 338;
		

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable['SculptTools'] == 'PickedUp'){
					sculptTools.alpha = 0;
				}else{
					sculptTools.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable['Skull'] == 'PickedUp'){
					skull.alpha = 0;
				}else{
					skull.alpha = 1;
				}
				
				
				
			}else{
				skull.alpha = 1;
				sculptTools.alpha = 1;
			}
		
			this.addChildAt(skull,1);
			this.addChildAt(sculptTools,2);
			
			//FadeOutOcean(1);
			CreatePaintingHit();
			CreateInkHit();
			CreateBirdHit();
			CreateHeadHit();
			CreateLanternHit();
			CreateHourGlassHit();
			CreateWineHit();
			
			CreateToolsHit();
			CreateLetterDeskHit();
			CreateSkullHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable['Letter'] == 'open'){
					LetterIsOpen = true;
					OpenLetter(false);
					this.addChild(goback);
				}
			}
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
			
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("Waves_02",((stage.getChildAt(0) as Object).MusicObj.globalVol-0.3),1.0);
			},0.5);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolume("ShipCreaks",((stage.getChildAt(0) as Object).MusicObj.globalVol-0.3),1.0);
			
			
			
		}
	//hit_painting
		private function CreatePaintingHit():void{
			hit_painting = new Shape();
			hit_painting.touchable = false;
			hit_painting.graphics.beginFill(0xff0000);
			
			hit_painting.graphics.lineTo(441,0);		
			hit_painting.graphics.lineTo(676,0);		
			hit_painting.graphics.lineTo(690,154);		
			hit_painting.graphics.lineTo(448,160);		
						
			hit_painting.graphics.endFill(false);
			hit_painting.alpha = 0.0;
			
			hit_painting.graphics.precisionHitTest = true;	
			this.addChild(hit_painting);
		}
		
		private function CreateInkHit():void{
			hit_ink = new Shape();
			hit_ink.touchable = false;
			hit_ink.graphics.beginFill(0xff0000);
			
			hit_ink.graphics.lineTo(597,117);		
			hit_ink.graphics.lineTo(625,102);		
			hit_ink.graphics.lineTo(713,179);		
			hit_ink.graphics.lineTo(757,288);		
			hit_ink.graphics.lineTo(747,366);		
			hit_ink.graphics.lineTo(670,344);		
			hit_ink.graphics.lineTo(681,258);		
			
			hit_ink.graphics.endFill(false);
			hit_ink.alpha = 0.0;
			
			hit_ink.graphics.precisionHitTest = true;	
			this.addChild(hit_ink);
		}
		
		private function CreateBirdHit():void{
			hit_bird = new Shape();
			hit_bird.touchable = false;
			hit_bird.graphics.beginFill(0xff0000);
			
			hit_bird.graphics.lineTo(508,187);		
			hit_bird.graphics.lineTo(559,26);		
			hit_bird.graphics.lineTo(592,35);		
			hit_bird.graphics.lineTo(616,248);		
			hit_bird.graphics.lineTo(580,265);		
			
			hit_bird.graphics.endFill(false);
			hit_bird.alpha = 0.0;
			
			hit_bird.graphics.precisionHitTest = true;	
			this.addChild(hit_bird);
		}
		
		
		private function CreateHourGlassHit():void{
			hit_hourGlass = new Shape();
			hit_hourGlass.touchable = false;
			hit_hourGlass.graphics.beginFill(0xff0000);
			
			hit_hourGlass.graphics.lineTo(221,149);		
			hit_hourGlass.graphics.lineTo(312,151);		
			hit_hourGlass.graphics.lineTo(309,287);		
			hit_hourGlass.graphics.lineTo(255,288);		
			
			hit_hourGlass.graphics.endFill(false);
			hit_hourGlass.alpha = 0.0;
			
			hit_hourGlass.graphics.precisionHitTest = true;	
			this.addChild(hit_hourGlass);
		}
		
		private function CreateWineHit():void{
			hit_wine = new Shape();
			hit_wine.touchable = false;
			hit_wine.graphics.beginFill(0xff0000);
			
			hit_wine.graphics.lineTo(305,154);		
			hit_wine.graphics.lineTo(364,155);		
			hit_wine.graphics.lineTo(366,328);		
			hit_wine.graphics.lineTo(321,328);		
			
			hit_wine.graphics.endFill(false);
			hit_wine.alpha = 0.0;
			
			hit_wine.graphics.precisionHitTest = true;	
			this.addChild(hit_wine);
		}
		
		private function CreateLanternHit():void{
			hit_lantern = new Shape();
			hit_lantern.touchable = false;
			hit_lantern.graphics.beginFill(0xff0000);
			
			hit_lantern.graphics.lineTo(348,147);		
			hit_lantern.graphics.lineTo(371,44);		
			hit_lantern.graphics.lineTo(410,49);		
			hit_lantern.graphics.lineTo(441,160);		
			hit_lantern.graphics.lineTo(525,195);		
			hit_lantern.graphics.lineTo(557,264);		
			hit_lantern.graphics.lineTo(526,295);		
			hit_lantern.graphics.lineTo(439,277);		
			hit_lantern.graphics.lineTo(362,274);		
			
			hit_lantern.graphics.endFill(false);
			hit_lantern.alpha = 0.0;
			
			hit_lantern.graphics.precisionHitTest = true;	
			this.addChild(hit_lantern);
		}
		
		private function CreateHeadHit():void{
			hit_head = new Shape();
			hit_head.touchable = false;
			hit_head.graphics.beginFill(0xff0000);
			
			hit_head.graphics.lineTo(0,106);	
			hit_head.graphics.lineTo(136,43);	
			hit_head.graphics.lineTo(253,254);	
			hit_head.graphics.lineTo(246,306);	
			hit_head.graphics.lineTo(180,330);	
			hit_head.graphics.lineTo(0,224);	
			
			
			hit_head.graphics.endFill(false);
			hit_head.alpha = 0.0;
			
			hit_head.graphics.precisionHitTest = true;	
			this.addChild(hit_head);
		}
		
		private function CreateLetterDeskHit():void{
			hit_letter_desk = new Shape();
			hit_letter_desk.touchable = false;
			hit_letter_desk.graphics.beginFill(0xff0000);
			
			hit_letter_desk.graphics.lineTo(346,341);	
			hit_letter_desk.graphics.lineTo(510,318);	
			hit_letter_desk.graphics.lineTo(601,423);	
			hit_letter_desk.graphics.lineTo(588,459);	
			hit_letter_desk.graphics.lineTo(407,491);	
	
			hit_letter_desk.graphics.endFill(false);
			hit_letter_desk.alpha = 0.0;
			
			hit_letter_desk.graphics.precisionHitTest = true;	
			this.addChild(hit_letter_desk);
		}
		
		private function CreateToolsHit():void{
			hit_sculptTools = new Shape();
			hit_sculptTools.touchable = false;
			hit_sculptTools.graphics.beginFill(0xff0000);
			
			hit_sculptTools.graphics.lineTo(17,373);	
			hit_sculptTools.graphics.lineTo(289,321);	
			hit_sculptTools.graphics.lineTo(346,368);	
			hit_sculptTools.graphics.lineTo(148,475);	

			hit_sculptTools.graphics.endFill(false);
			hit_sculptTools.alpha = 0.0;
			
			hit_sculptTools.graphics.precisionHitTest = true;	
			this.addChild(hit_sculptTools);
		}

		private function CreateSkullHit():void{
			hit_skull = new Shape();
			hit_skull.touchable = false;
			hit_skull.graphics.beginFill(0xff0000);
			
			hit_skull.graphics.lineTo(506,257);	
			hit_skull.graphics.lineTo(561,194);	
			hit_skull.graphics.lineTo(660,218);	
			hit_skull.graphics.lineTo(679,275);	
			hit_skull.graphics.lineTo(640,360);	
			hit_skull.graphics.lineTo(562,359);	
			hit_skull.graphics.lineTo(533,328);	
		
			hit_skull.graphics.endFill(false);
			hit_skull.alpha = 0.0;
			
			hit_skull.graphics.precisionHitTest = true;	
			this.addChild(hit_skull);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(LetterIsOpen === false){
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((PirateCaptains as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.PirateCaptainsObj,true
								);
								
							}else if(hit_skull.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
								SkullHandler();
							}else if(hit_sculptTools.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
								ToolsHandler();
							}else if(hit_letter_desk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								LetterIsOpen = true;
								OpenLetter(true, 0)
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable;
								}		
								SaveArray['Letter'] = "open";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsTable',SaveArray);
							}else if(hit_head.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The face of a queen is visible in the worn stone.");
							}else if(hit_wine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wine has long since gone stale.");
							}else if(hit_hourGlass.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hour glass has no sand.");
							}else if(hit_lantern.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An oil lantern and a reconstructed urn.");
							}else if(hit_bird.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A statue of a falcon made from fine metal.");
							}else if(hit_ink.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A writing quill and ink well.");
							}else if(hit_painting.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An abstract painting rests against the wall.");
							}
						
							
						}else{
							if(targ == goback.SourceImage){
								trace("GoBackClick");
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								RemoveLetter();
								LetterIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable;
								}		
								SaveArray['Letter'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsTable',SaveArray);
							}else if(hit_openLetter.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A letter to Doctor Von Awesome from the Pirate Captain, I presume.");
							}
						}
					}
				}
			}
		}
		
		private function SkullHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable['Skull'] == 'PickedUp'){
					if(hit_lantern.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An oil lantern and a reconstructed urn.");
					}else if(hit_bird.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A statue of a falcon made from fine metal.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					skull.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable;
					}
					SaveArray["Skull"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsTable',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Human,
						'item_Human',
						'inven_human_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				skull.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable;
				}
				SaveArray["Skull"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsTable',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Human,
					'item_Human',
					'inven_human_sm'
				);
			}
		}
	
		private function ToolsHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable['SculptTools'] == 'PickedUp'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The table is lavishly and intricately inlaid with detail.");
				}else{
					sculptTools.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable;
					}
					SaveArray["SculptTools"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsTable',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_SculptTools,
						'item_SculptTools',
						'inven_sculptTools_sm'
					);
				}
			}else{
				sculptTools.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.PirateCaptainsTable;
				}
				SaveArray["SculptTools"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('PirateCaptainsTable',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_SculptTools,
					'item_SculptTools',
					'inven_sculptTools_sm'
				);
			}
		}
		
		private function OpenLetter(Fade:Boolean = false,page:Number = 0):void{
			Animating = true;
			openLetter = new Sprite();
			openLetter.alpha = 0;
			CreateOpenBookBg();
			openLetterPages = new Image(this.assets.getTexture('letter'));
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
			
			
			this.assets.removeTexture("pirateCaptainsTable_bg",true);
			this.assets.removeTexture("PirateCaptainsTable_Sprite_01",true);
			this.assets.removeTextureAtlas("PirateCaptainsTable_Sprite_01",true);
			this.assets.removeTexture("PirateCaptainsTable_Sprite_02",true);
			this.assets.removeTextureAtlas("PirateCaptainsTable_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsTable_01");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsTable_02");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsTable_03");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsTable_04");
			(stage.getChildAt(0) as Object).falseAsset("pirateCaptainsTable_05");
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