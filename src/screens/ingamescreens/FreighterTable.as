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
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	
	public class FreighterTable extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var Puller:Image;
		private var compass:Image;
		private var needle:Image;
		
		private var hit_puller:Shape;
		private var hit_compass:Shape;
		
		private var hit_abacus:Shape;
		private var hit_drawingCompass:Shape;
		
		private var openCompassbg:Shape;
		private var openCompass:Sprite;
		private var openCompassPage:Image;
		private var openCompassNeedleSprite:Sprite;
		private var openCompassNeedle:Image;
		private var CompassIsOpen:Boolean = false;
		public var OpenCompassTween:Tween;
		public var NeedleSpinTween:Tween;
		private var hit_openCompass:Shape;
		private var hit_openNeedle:Shape;
		private var CompassMoving:Boolean = true;
		private var RotateCall:Function;
		
		//private var hit_CoastCaveExterior:Shape;		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
				
		
		public function FreighterTable(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterTable_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterTable/freighterTable_bg.jpg'));
				game.TrackAssets('freighterTable_01');
			}
			if(game.CheckAsset('freighterTable_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterTable/FreighterTable_Sprite.atf'));
				game.TrackAssets('freighterTable_02');
			}
			if(game.CheckAsset('freighterTable_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterTable/FreighterTable_Sprite.xml'));
				game.TrackAssets('freighterTable_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterTable","FreighterTableObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('freighterTable_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			/*
			private var Puller:Image;
			private var compass:Image;
			*/
			Puller = new Image(this.assets.getTexture('pull'));
			Puller.smoothing = TextureSmoothing.NONE;
			Puller.touchable = false;
			Puller.x = 1;
			Puller.y = 115;
			
			compass = new Image(this.assets.getTexture('compass'));
			compass.smoothing = TextureSmoothing.NONE;
			compass.touchable = false;
			compass.x = 394;
			compass.y = 183;
			compass.alpha = 1;
			
			needle = new Image(this.assets.getTexture('needle'));
			needle.touchable = false;
			needle.x = 461;
			needle.y = 249;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable['Puller'] == 'PickedUp'){
					Puller.alpha = 0;
				}else{
					Puller.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable['Needle'] == 'PickedUp'){
					needle.alpha = 0;
					CompassMoving = false;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable['Needle'] == 'Stopped'){
					needle.alpha = 1;
					CompassMoving = false;
				}else{
					needle.alpha = 1;
				}
			}else{
				Puller.alpha = 1;
				needle.alpha = 1;
			}
				
			this.addChildAt(Puller,1);
			this.addChildAt(compass,2);
			this.addChildAt(needle,3);
			
			//FadeOutOcean(1);
			CreatePullerHit();
			CreateCompassHit();
			CreateDrawingCompassHit();
			CreateAbacusHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			//(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,2);
			//(stage.getChildAt(0) as Object).MusicObj.LoadShipGroansOne(true,999);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,2);
					},0.5);
				}
			}
		}
		

		private function CreateDrawingCompassHit():void{
			hit_drawingCompass = new Shape();
			hit_drawingCompass.touchable = false;
			hit_drawingCompass.graphics.beginFill(0xff0000);
			
			hit_drawingCompass.graphics.lineTo(400,85);	
			hit_drawingCompass.graphics.lineTo(625,92);	
			hit_drawingCompass.graphics.lineTo(634,119);	
			hit_drawingCompass.graphics.lineTo(447,193);	
			hit_drawingCompass.graphics.lineTo(412,170);	
		
			hit_drawingCompass.graphics.endFill(false);
			hit_drawingCompass.alpha = 0.0;
			
			hit_drawingCompass.graphics.precisionHitTest = true;	
			this.addChild(hit_drawingCompass);
		}
		
		private function CreateAbacusHit():void{
			hit_abacus = new Shape();
			hit_abacus.touchable = false;
			hit_abacus.graphics.beginFill(0xff0000);
			
			hit_abacus.graphics.lineTo(96,31);	
			hit_abacus.graphics.lineTo(289,0);	
			hit_abacus.graphics.lineTo(326,98);	
			hit_abacus.graphics.lineTo(121,133);	

			hit_abacus.graphics.endFill(false);
			hit_abacus.alpha = 0.0;
			
			hit_abacus.graphics.precisionHitTest = true;	
			this.addChild(hit_abacus);
		}
		
		private function CreatePullerHit():void{
			hit_puller = new Shape();
			hit_puller.touchable = false;
			hit_puller.graphics.beginFill(0xff0000);
			
			hit_puller.graphics.lineTo(60,139);	
			hit_puller.graphics.lineTo(131,141);	
			hit_puller.graphics.lineTo(224,146);	
			hit_puller.graphics.lineTo(360,204);	
			hit_puller.graphics.lineTo(344,249);	
			hit_puller.graphics.lineTo(301,295);	
			hit_puller.graphics.lineTo(106,249);	
			hit_puller.graphics.lineTo(22,193);	
			hit_puller.graphics.endFill(false);
			hit_puller.alpha = 0.0;
			
			hit_puller.graphics.precisionHitTest = true;	
			this.addChild(hit_puller);
		}
		
		private function CreateCompassHit():void{
			hit_compass = new Shape();
			hit_compass.touchable = false;
			hit_compass.graphics.beginFill(0xff0000);
			
			hit_compass.graphics.lineTo(422,245);	
			hit_compass.graphics.lineTo(443,219);	
			hit_compass.graphics.lineTo(480,210);	
			hit_compass.graphics.lineTo(523,215);	
			hit_compass.graphics.lineTo(559,243);	
			hit_compass.graphics.lineTo(568,283);	
			hit_compass.graphics.lineTo(554,316);	
			hit_compass.graphics.lineTo(520,336);	
			hit_compass.graphics.lineTo(476,336);	
			hit_compass.graphics.lineTo(427,310);	
			hit_compass.graphics.lineTo(418,281);	
			hit_compass.graphics.endFill(false);
			hit_compass.alpha = 0.0;
			
			hit_compass.graphics.precisionHitTest = true;	
			this.addChild(hit_compass);
		}
		
		private function CreateOpenCompassHit():void{
			hit_openCompass = new Shape();
			hit_openCompass.touchable = false;
			hit_openCompass.graphics.beginFill(0xff0000);
			
			hit_openCompass.graphics.lineTo(192,267);	
			hit_openCompass.graphics.lineTo(215,163);	
			hit_openCompass.graphics.lineTo(291,81);	
			hit_openCompass.graphics.lineTo(398,53);	
			hit_openCompass.graphics.lineTo(498,80);	
			hit_openCompass.graphics.lineTo(571,156);	
			hit_openCompass.graphics.lineTo(599,232);	
			hit_openCompass.graphics.lineTo(580,343);	
			hit_openCompass.graphics.lineTo(498,436);	
			hit_openCompass.graphics.lineTo(405,463);	
			hit_openCompass.graphics.lineTo(295,434);	
			hit_openCompass.graphics.lineTo(222,365);	
			
			hit_openCompass.graphics.endFill(false);
			hit_openCompass.alpha = 0.0;
			
			hit_openCompass.graphics.precisionHitTest = true;	
			openCompass.addChild(hit_openCompass);
		}
		
		private function CreateOpenNeedleHit():void{
			hit_openNeedle = new Shape();
			hit_openNeedle.touchable = false;
			hit_openNeedle.graphics.beginFill(0x00ff00);
			hit_openNeedle.graphics.lineTo(-25,-180);	
			hit_openNeedle.graphics.lineTo(25,-180);	
			hit_openNeedle.graphics.lineTo(25,180);	
			hit_openNeedle.graphics.lineTo(-25,180);	
	
			hit_openNeedle.graphics.endFill(false);
			hit_openNeedle.alpha = 0.0;
			
			hit_openNeedle.graphics.precisionHitTest = true;	
			openCompassNeedleSprite.addChild(hit_openNeedle);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(CompassIsOpen === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((FreighterInterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterInteriorObj,true
							);
						}else if(hit_puller.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							trace("hit_puller CLICKED");
							PullerHandler();
						}else if(hit_compass.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							trace("hit_compass CLICKED");
							CompassIsOpen = true;
							OpenCompass(true);
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable;
							}		
							SaveArray['Compass'] = "open";
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
						}else if(hit_abacus.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An abacus - an ancient method of calculation.");
							
						}else if(hit_drawingCompass.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A drawing compass, used for creating precise curves and spirals.");
							
						}		
						
						//		private var hit_abacus:Shape;
						//		private var hit_drawingCompass:Shape;
					}else{
						if(targ == goback.SourceImage){
							exitCompass();
						}
						else if(hit_openNeedle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(CompassMoving === true){
								CompassMoving = false;
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
								removeEventListener(EnterFrameEvent.ENTER_FRAME, RotateCall);
								

								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable;
								}
								SaveArray['Needle'] = "Stopped";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've managed to stop the compass needle.");
							}else{
								NeedleHandler();
							}
							
						}
						else if(hit_openCompass.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(CompassMoving === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The compass needle is spinning wildly around and around.");
							}
							else{
								AttacheNeedle();
								
							}
						}else if(openCompassbg.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
						}
						
					}
				}
			}
		}

		private function exitCompass():void{
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
			trace("GoBackClick");
			(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
			RemoveCompass();
			CompassIsOpen = false;	
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable;
			}		
			SaveArray['Compass'] = "closed";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
		}
		
		private function AttacheNeedle():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Compass)
			{
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
				CompassMoving = true;
				needle.alpha = 1;
				openCompassNeedleSprite.alpha = 1;
				addEventListener(EnterFrameEvent.ENTER_FRAME, RotateCall = function():void{
					//openCompassNeedle.rotation += deg2rad(randomRange(5,16));
					openCompassNeedleSprite.rotation += deg2rad(9);
					
				});
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable;
				}
				SaveArray['Needle'] = 'Attached';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler.InventoryObj.removeItemFromInventory(
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.item_Compass,
					"item_Compass"
				);
			}else{
				NoNeddleHandler();
			}
			
		}
		
		private function NoNeddleHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable["Needle"] == "PickedUp"){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Apparently, a traditional magnetic compass is useless on this island.");
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I've managed to stop the wild spinning of the compass needle.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The magnetized needle seems unable to find the North Pole.");
			}
		}
		
		private function NeedleHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable["Needle"] == "PickedUp"){
					AttacheNeedle();
				}else{
					openCompassNeedleSprite.alpha = 0;
					needle.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable;
					}
					SaveArray['Needle'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Compass,
						'item_Compass',
						'inven_compass_sm'
					);
					//(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The compass needle is spinning wildly around and around.");
					
				}
			}else{
				openCompassNeedleSprite.alpha = 0;
				needle.alpha = 0;
				SaveArray['Needle'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterLocker',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Compass,
					'item_Compass',
					'inven_compass_sm'
				);
			}
		}
		
		
		private function OpenCompass(Fade:Boolean = false):void{
			openCompass = new Sprite();
			openCompass.alpha = 0;
			CreateOpenCompassBg();
			openCompassPage = new Image(this.assets.getTexture('close_compass'));
			openCompassPage.touchable = false;
			this.openCompass.addChildAt(openCompassbg,0);
			openCompassPage.x = 191;
			openCompassPage.y = 5;
			openCompass.addChild(openCompassPage);
			
			openCompassNeedleSprite = new Sprite();
			openCompassNeedleSprite.x = 399;
			openCompassNeedleSprite.y = 256;
			openCompass.addChild(openCompassNeedleSprite);
			
			openCompassNeedle = new Image(this.assets.getTexture('close_needle'));
			openCompassNeedle.touchable = false;
			
			openCompassNeedle.pivotX = 13;
			openCompassNeedle.pivotY = 177;
			openCompassNeedle.x = 0;
			openCompassNeedle.y = 0;
			
			
			this.addChild(openCompass);
			this.addChild(goback);
			
			CreateOpenCompassHit();
			CreateOpenNeedleHit();
			//CreateOpenBookHit()
			//	CreateOpenBookHit(openBookcurrentPage);
			openCompassNeedleSprite.addChild(openCompassNeedle);
			if(Fade === false){
				openCompass.alpha = 1;
				
			}else{
				
			//	tween.animate("rotation", deg2rad(45));
				
				OpenCompassTween = new Tween(openCompass, 0.5, Transitions.LINEAR);
				OpenCompassTween.fadeTo(1);
				OpenCompassTween.onComplete = function():void{
					//	CreateOpenNotePadHit();
				};
				Starling.juggler.add(OpenCompassTween);	
				
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable["Needle"] == "PickedUp"){
					CompassMoving = false;
					openCompassNeedleSprite.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable["Needle"] == "Stopped"){
					CompassMoving = false;
				}else{
					addEventListener(EnterFrameEvent.ENTER_FRAME, RotateCall = function():void{
						//openCompassNeedle.rotation += deg2rad(randomRange(5,16));
						openCompassNeedleSprite.rotation += deg2rad(9);
						
					});
				}
			}else{
				addEventListener(EnterFrameEvent.ENTER_FRAME, RotateCall = function():void{
					//openCompassNeedle.rotation += deg2rad(randomRange(5,16));
					openCompassNeedleSprite.rotation += deg2rad(9);
					
				});
			}

			//	CreateOpenBookHit(page);
		}
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function RemoveCompass():void{
			//Starling.juggler.purge();
			OpenCompassTween = new Tween(openCompass, 0.5, Transitions.LINEAR);
			OpenCompassTween.fadeTo(0);
			OpenCompassTween.onComplete = function():void{
				//hit_OpenBook.graphics.clear();
				//	hit_openBookBack.graphics.clear();
				//	hit_openBookNext.graphics.clear();
				CloseCompass();
				
			};
			Starling.juggler.add(OpenCompassTween);		
		}
		
		public function CloseCompass():void{
			removeEventListener(EnterFrameEvent.ENTER_FRAME, RotateCall);
			this.removeChild(openCompass);
			openCompass.dispose();
		}
		
		private function CreateOpenCompassBg():void{
			openCompassbg = new Shape();
			openCompassbg.graphics.beginFill(0x000000);
			openCompassbg.graphics.lineTo(0,0);	
			openCompassbg.graphics.lineTo(800,0);	
			openCompassbg.graphics.lineTo(800,512);	
			openCompassbg.graphics.lineTo(0,512);	
			openCompassbg.touchable = false;
			openCompassbg.graphics.endFill(false);
			openCompassbg.alpha = 0.5;
			//	openBookbg.graphics.precisionHitTest = true;				
			
		}	
		
		
		private function PullerHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable["Puller"] == "PickedUp"){
					
				}else{
				//	(stage.getChildAt(0) as Object).MusicObj.LoadDoom(true,2);
					Puller.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterTable;
					SaveArray['Puller'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Puller,
						'item_Puller',
						'inven_puller_sm'
					);
					
					
				}
			}else{
				
				Puller.alpha = 0;
				SaveArray['Puller'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterTable',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Puller,
					'item_Puller',
					'inven_puller_sm'
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
			
			this.assets.removeTexture("freighterTable_bg",true);
			this.assets.removeTexture("FreighterLocker_Sprite",true);
			this.assets.removeTextureAtlas("FreighterLocker_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterTable_01");
			(stage.getChildAt(0) as Object).falseAsset("freighterTable_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterTable_03");
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
