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
	
	
	public class JunkTopDeck extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var lever:Image;
		private var scroll_open:Image;
		private var tiger_coin:Image;
		
		private var hit_lever:Shape;
		private var hit_scroll:Shape;
		private var hit_scroll_upper:Shape;
		private var hit_painting:Shape;
		private var hit_tiger_coin:Shape;
		
		
		private var ScrollIsOpen:Boolean = false;

		private var openBookbg:Shape;
		
		private var openLetter:Sprite;
		private var openLetterPages:Image;
		private var hit_openLetter:Shape;
		public var OpenLetterTween:Tween;
		private var LetterIsOpen:Boolean = false;
		
		private var hit_letter_cubs:Shape;
		private var hit_letter_tigerHead:Shape;
		private var hit_letter_tigerBody:Shape;
		private var hit_letter:Shape;
		
		private var hit_forest:Shape;
		private var hit_floor:Shape;
		private var hit_bollards:Shape;
		private var hit_steering:Shape;
		private var hit_mast:Shape;
		
		private var animating:Boolean = false;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function JunkTopDeck(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('junkTopDeck_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkTopDeck/junkTopDeck_bg.jpg'));
				game.TrackAssets('junkTopDeck_01');
			}
			if(game.CheckAsset('junkTopDeck_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkTopDeck/JunkTopDeck_Sprite.atf'));
				game.TrackAssets('junkTopDeck_02');
			}
			if(game.CheckAsset('junkTopDeck_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkTopDeck/JunkTopDeck_Sprite.xml'));
				game.TrackAssets('junkTopDeck_03');
			}
			if(game.CheckAsset('junkTopDeck_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkTopDeck/JunkTopDeck_Sprite_02.atf'));
				game.TrackAssets('junkTopDeck_04');
			}
			if(game.CheckAsset('junkTopDeck_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkTopDeck/JunkTopDeck_Sprite_02.xml'));
				game.TrackAssets('junkTopDeck_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JunkTopDeck","JunkTopDeckObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			
			
			bg = new Image(this.assets.getTexture('junkTopDeck_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
						
			tiger_coin =  new Image(this.assets.getTexture('tiger_coin'));
			tiger_coin.smoothing = TextureSmoothing.NONE;
			tiger_coin.touchable = true;
			tiger_coin.x = 565;
			tiger_coin.y = 1;
			
			
			scroll_open =  new Image(this.assets.getTexture('scroll_open'));
			scroll_open.smoothing = TextureSmoothing.NONE;

			scroll_open.touchable = true;
			scroll_open.x = 251;
			scroll_open.y = 183;
			
			
			lever =  new Image(this.assets.getTexture('lever'));
			lever.smoothing = TextureSmoothing.NONE;
			lever.touchable = true;
			lever.x = 128;
			lever.y = 300;
			
			
			this.addChildAt(tiger_coin,1);
			
			this.addChildAt(scroll_open,2);
			
			this.addChildAt(lever,3);
			
			CreateForestHit();
			CreateFloorHit();
			CreateBollardsHit();
			CreateSteeringHit();
			CreateMastHit();
			CreateScrollHit();
			CreateLeverHit();
			CreateCoinHit();
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck["Coin"] == "PickedUp"){
					tiger_coin.alpha = 0;
				}else{
					tiger_coin.alpha = 1;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck["Lever"] == "PickedUp"){
					lever.alpha = 0;
				}else{
					lever.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck["Scroll"] == "open"){
					ScrollIsOpen = true;
					scroll_open.alpha = 1;
					ScrollHandler(true,true);
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck["Letter"] == "open"){
						LetterIsOpen = true;
						OpenLetter(false, 0)
					}else{
						
					}

					
					
				}else{
					scroll_open.alpha = 0;
				}
				
			}else{
				tiger_coin.alpha = 1;
				scroll_open.alpha = 0;
				lever.alpha = 1;
			}
			
		
		
			//FadeOutOcean(1);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'BirdsOne';
			},0.7);
		}
		
		
		private function CreateMastHit():void{
			hit_mast = new Shape();
			
			hit_mast.graphics.beginFill(0x00FF00);
			
			hit_mast.graphics.lineTo(322,0);
			hit_mast.graphics.lineTo(573,0);
			hit_mast.graphics.lineTo(548,169);
			hit_mast.graphics.lineTo(513,167);
			hit_mast.graphics.lineTo(456,87);
			hit_mast.graphics.lineTo(373,90);		
			
			hit_mast.graphics.endFill(false);
			hit_mast.touchable = false;
			hit_mast.alpha = 0.0;
			hit_mast.graphics.precisionHitTest = true;				
			addChild(hit_mast);
		}
		
		private function CreateSteeringHit():void{
			hit_steering = new Shape();
			
			hit_steering.graphics.beginFill(0x00FF00);
			
			hit_steering.graphics.lineTo(8,243);
			hit_steering.graphics.lineTo(112,200);
			hit_steering.graphics.lineTo(337,258);
			hit_steering.graphics.lineTo(334,282);
			hit_steering.graphics.lineTo(112,359);
			hit_steering.graphics.lineTo(1,332);
			
			hit_steering.graphics.endFill(false);
			hit_steering.touchable = false;
			hit_steering.alpha = 0.0;
			hit_steering.graphics.precisionHitTest = true;				
			addChild(hit_steering);
		}
		
		private function CreateBollardsHit():void{
			hit_bollards = new Shape();
			
			hit_bollards.graphics.beginFill(0x00FF00);
			
			hit_bollards.graphics.lineTo(643,200);
			hit_bollards.graphics.lineTo(729,207);
			hit_bollards.graphics.lineTo(726,209);
			hit_bollards.graphics.lineTo(725,386);
			hit_bollards.graphics.lineTo(603,433);
			
			hit_bollards.graphics.endFill(false);
			hit_bollards.touchable = false;
			hit_bollards.alpha = 0.0;
			hit_bollards.graphics.precisionHitTest = true;				
			addChild(hit_bollards);
		}
		
		private function CreateFloorHit():void{
			hit_floor = new Shape();
			
			hit_floor.graphics.beginFill(0x00FF00);
			
			hit_floor.graphics.lineTo(49,325);
			hit_floor.graphics.lineTo(360,240);
			hit_floor.graphics.lineTo(582,234);
			hit_floor.graphics.lineTo(654,239);
			hit_floor.graphics.lineTo(574,512);
			hit_floor.graphics.lineTo(573,512);
			hit_floor.graphics.lineTo(159,503);
			
			hit_floor.graphics.endFill(false);
			hit_floor.touchable = false;
			hit_floor.alpha = 0.0;
			hit_floor.graphics.precisionHitTest = true;				
			addChild(hit_floor);
		}
		
		private function CreateForestHit():void{
			hit_forest = new Shape();
			
			hit_forest.graphics.beginFill(0x00FF00);
			
			hit_forest.graphics.lineTo(0,0);
			hit_forest.graphics.lineTo(312,0);
			hit_forest.graphics.lineTo(371,149);
			hit_forest.graphics.lineTo(0,190);
			
			hit_forest.graphics.endFill(false);
			hit_forest.touchable = false;
			hit_forest.alpha = 0.0;
			hit_forest.graphics.precisionHitTest = true;				
			addChild(hit_forest);
		}
		
		
		private function CreateScrollHit(open:Boolean = false):void{
			hit_scroll = new Shape();
			
			if(open === false){
				
				hit_scroll.x = 0;
				hit_scroll.y = 0;
				hit_scroll.graphics.beginFill(0x0000FF);
				hit_scroll.graphics.lineTo(293,188);	
				hit_scroll.graphics.lineTo(313,161);	
				hit_scroll.graphics.lineTo(526,178);	
				hit_scroll.graphics.lineTo(544,196);	
				hit_scroll.graphics.lineTo(537,227);	
				hit_scroll.graphics.lineTo(318,220);	

				hit_scroll.graphics.endFill(false);
				
				hit_scroll.alpha = 0.0;
				
				hit_scroll.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_scroll.x = 0;
				hit_scroll.y = 0;
				hit_scroll.graphics.beginFill(0x0000FF);		
				hit_scroll.graphics.lineTo(265,350);	
				hit_scroll.graphics.lineTo(529,371);	
				hit_scroll.graphics.lineTo(543,396);	
				hit_scroll.graphics.lineTo(520,423);	
				hit_scroll.graphics.lineTo(243,396);	
				hit_scroll.graphics.lineTo(241,370);	

				
				hit_scroll.graphics.endFill(false);
				hit_scroll.alpha = 0.0;
				
				hit_scroll.graphics.precisionHitTest = true;				
			}
			hit_scroll.touchable = false;
			this.addChild(hit_scroll);
			
		}		
		

		private function CreateScrollUpperHit():void{
			hit_scroll_upper = new Shape();
			
			hit_scroll_upper.graphics.beginFill(0x00FF00);
			hit_scroll_upper.graphics.lineTo(286,186);	
			hit_scroll_upper.graphics.lineTo(301,170);	
			hit_scroll_upper.graphics.lineTo(528,181);	
			hit_scroll_upper.graphics.lineTo(545,193);	
			hit_scroll_upper.graphics.lineTo(540,221);	
			hit_scroll_upper.graphics.lineTo(523,227);	
			hit_scroll_upper.graphics.lineTo(292,220);	
						
			hit_scroll_upper.graphics.endFill(false);
			hit_scroll_upper.touchable = false;
			hit_scroll_upper.alpha = 0.0;
			hit_scroll_upper.graphics.precisionHitTest = true;		
			addChild(hit_scroll_upper);
			
		}
		
		
		
		private function CreatePaintingHit():void{
			hit_painting = new Shape();
			
			hit_painting.graphics.beginFill(0x00FF00);
			hit_painting.graphics.lineTo(334,222);	
			hit_painting.graphics.lineTo(483,227);	
			hit_painting.graphics.lineTo(472,359);	
			hit_painting.graphics.lineTo(315,347);	
			
			hit_painting.graphics.endFill(false);
			hit_painting.touchable = false;
			hit_painting.alpha = 0.0;
			hit_painting.graphics.precisionHitTest = true;				
			this.addChild(hit_painting);
		}
		
		
		private function CreateLeverHit():void{
			hit_lever = new Shape();
			
			hit_lever.graphics.beginFill(0x00FF00);
			hit_lever.graphics.lineTo(121,318);	
			hit_lever.graphics.lineTo(201,295);	
			hit_lever.graphics.lineTo(260,343);	
			hit_lever.graphics.lineTo(236,369);	
			hit_lever.graphics.lineTo(168,381);	
			hit_lever.graphics.lineTo(126,348);	

			 
			hit_lever.graphics.endFill(false);
			hit_lever.touchable = false;
			hit_lever.alpha = 0.0;
			hit_lever.graphics.precisionHitTest = true;				
			this.addChild(hit_lever);
		}
		
		private function CreateCoinHit():void{
			hit_tiger_coin = new Shape();
			
			hit_tiger_coin.graphics.beginFill(0x00FF00);
			hit_tiger_coin.graphics.lineTo(544,84);	
			hit_tiger_coin.graphics.lineTo(573,63);	
			hit_tiger_coin.graphics.lineTo(615,64);	
			hit_tiger_coin.graphics.lineTo(640,90);	
			hit_tiger_coin.graphics.lineTo(637,136);	
			hit_tiger_coin.graphics.lineTo(605,158);	
			hit_tiger_coin.graphics.lineTo(568,158);	

			
			hit_tiger_coin.graphics.endFill(false);
			hit_tiger_coin.alpha = 0.0;
			hit_tiger_coin.touchable = false;
			
			hit_tiger_coin.graphics.precisionHitTest = true;				
			this.addChild(hit_tiger_coin);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(animating === false){
						if(LetterIsOpen === false){
							trace("1");
							if(targ == goback.SourceImage){
								trace("2");
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();
								
								FadeOut((JunkDeck as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkDeckObj,true
								);
							}else if(hit_tiger_coin.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
								trace("4");
								CoinHandler();		
								
							}else if(hit_lever.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								trace("3");
								LeverHandler();
							
								
							}else if(ScrollIsOpen === false){
								if(hit_scroll.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									ScrollHandler(true);
								}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Light rays shine through wafts of mist between the trees.");
								}else if(hit_steering.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's rudder lays to the side.");
								}else if(hit_bollards.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Bollards: used for securing ropes and other things.");
								}else if(hit_mast.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rear mast has broken in two.");
								}else if(hit_floor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor squeaks and groans under my feet.");
								}
							}else{
								if(hit_scroll.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									ScrollHandler(false);
								}else if(hit_scroll_upper.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									ScrollHandler(false);
								}else if(hit_painting.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
									animating = true;
									LetterIsOpen = true;
									OpenLetter(true, 0)
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
									}		
									SaveArray['Letter'] = "open";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkTopDeck',SaveArray);

								}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Light rays shine through wafts of mist between the trees.");
								}else if(hit_steering.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's rudder lays to the side.");
								}else if(hit_bollards.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Bollards: used for securing ropes and other things.");
								}else if(hit_mast.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rear mast has broken in two.");
								}else if(hit_floor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The floor squeaks and groans under my feet.");
								}
								
								
								
							}
						}else{
							
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.HideReadOut();
								animating = true;
								trace("GoBackClick");
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageTurn();
								RemoveLetter();
								LetterIsOpen = false;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
								}		
								SaveArray['Letter'] = "closed";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkTopDeck',SaveArray);
							}
							if(hit_letter_tigerHead.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Don't mess with mother tigers.");
							}else if(hit_letter_tigerBody.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The scroll depicts a ferocious white tiger.");
								
							}else if(hit_letter_cubs.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Awwww...");
								//HELLO: 84.375 ,413.44
							}else if(hit_letter.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The painting was made from ink strokes on finely made silk cloth.");
								//HELLO: 84.375 ,413.44
							}
						}
					}
					
				}
			}
		}
		private function CoinHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck["Coin"] == "PickedUp"){
					
				}else{
					
					tiger_coin.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
					}
					SaveArray['Coin'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkTopDeck',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTiger,
						'item_CoinTiger',
						'inven_coinTiger_sm'
					);
				}
			}else{
				tiger_coin.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
				}
				SaveArray['Coin'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkTopDeck',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_CoinTiger,
					'item_CoinTiger',
					'inven_coinTiger_sm'
				);
			}
			
		}
		private function LeverHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck["Lever"] == "PickedUp"){
					if(hit_steering.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's rudder lays to the side.");
					}
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					lever.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
					}
					SaveArray['Lever'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkTopDeck',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Lever,
						'item_Lever',
						'inven_lever_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				lever.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
				}
				SaveArray['Lever'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkTopDeck',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Lever,
					'item_Lever',
					'inven_lever_sm'
				);
			}
			
		}
		
	
		
		
		private function OpenLetter(Fade:Boolean = false,page:Number = 0):void{
			openLetter = new Sprite();
			openLetter.alpha = 0;
			CreateOpenBookBg();
			openLetterPages = new Image(this.assets.getTexture('tigerScroll'));
			this.openLetter.addChildAt(openBookbg,0);
			openLetterPages.touchable = false;
			openLetter.addChild(openLetterPages);
			openLetterPages.touchable = false;
			
			CreateOpenLetterHits();
			
			this.addChildAt(openLetter,11);
			this.addChildAt(goback,12);
			
			
			if(Fade === false){
				openLetter.alpha = 1;
				//	CreateOpenNotePadHit();
			}else{
				
				OpenLetterTween = new Tween(openLetter, 0.5, Transitions.LINEAR);
				OpenLetterTween.fadeTo(1);
				OpenLetterTween.onComplete = function():void{
					//		CreateOpenNotePadHit();
					animating = false;
				};
				Starling.juggler.add(OpenLetterTween);	
				
			}
		}
		private function RemoveLetter():void{
			//Starling.juggler.purge();
			OpenLetterTween = new Tween(openLetter, 0.5, Transitions.LINEAR);
			OpenLetterTween.fadeTo(0);
			OpenLetterTween.onComplete = function():void{
				animating = false;
				
				hit_letter_tigerHead.graphics.clear();
				hit_letter_tigerBody.graphics.clear();
				hit_letter_cubs.graphics.clear();
				hit_letter.graphics.clear();
				CloseLetter();
				
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
		
		
		
		
		private function CreateOpenLetterHits():void{
			/*
			
			
			private var hit_letter_cubs:Shape;
			private var hit_letter_tigerHead:Shape;
			private var hit_letter_tigerBody:Shape;
			*/
			hit_letter = new Shape();
			this.addChild(hit_letter);
			hit_letter.graphics.beginFill(0x0000FF);
			hit_letter.graphics.lineTo(46,1);	
			hit_letter.graphics.lineTo(610,0);	
			hit_letter.graphics.lineTo(682,117);	
			hit_letter.graphics.lineTo(717,124);	
			hit_letter.graphics.lineTo(741,385);	
			hit_letter.graphics.lineTo(611,395);	
			hit_letter.graphics.lineTo(588,484);	
			hit_letter.graphics.lineTo(94,476);	
			hit_letter.graphics.lineTo(63,396);	
			hit_letter.graphics.lineTo(46,393);	

			hit_letter.graphics.endFill(false);
			hit_letter.alpha = 0.0;
			hit_letter.touchable = false;
			hit_letter.graphics.precisionHitTest = true;	
			
			
			hit_letter_tigerBody = new Shape();
			this.addChild(hit_letter_tigerBody);
			hit_letter_tigerBody.graphics.beginFill(0x0000FF);
			hit_letter_tigerBody.graphics.lineTo(316,96);	
			hit_letter_tigerBody.graphics.lineTo(355,16);	
			hit_letter_tigerBody.graphics.lineTo(520,16);	
			hit_letter_tigerBody.graphics.lineTo(673,148);	
			hit_letter_tigerBody.graphics.lineTo(626,298);	
			hit_letter_tigerBody.graphics.lineTo(364,316);	
			hit_letter_tigerBody.graphics.lineTo(306,232);	
			hit_letter_tigerBody.graphics.lineTo(363,197);	
			hit_letter_tigerBody.graphics.lineTo(356,124);	
			
			
			hit_letter_tigerBody.graphics.endFill(false);
			hit_letter_tigerBody.alpha = 0.0;
			hit_letter_tigerBody.touchable = false;
			hit_letter_tigerBody.graphics.precisionHitTest = true;	
			
			hit_letter_tigerHead = new Shape();
			this.addChild(hit_letter_tigerHead);
			hit_letter_tigerHead.graphics.beginFill(0x0000FF);
			hit_letter_tigerHead.graphics.lineTo(230,189);	
			hit_letter_tigerHead.graphics.lineTo(260,127);	
			hit_letter_tigerHead.graphics.lineTo(313,106);	
			hit_letter_tigerHead.graphics.lineTo(350,129);	
			hit_letter_tigerHead.graphics.lineTo(358,195);	
			hit_letter_tigerHead.graphics.lineTo(268,245);	
			hit_letter_tigerHead.graphics.lineTo(248,225);	

			hit_letter_tigerHead.graphics.endFill(false);
			hit_letter_tigerHead.alpha = 0.0;
			hit_letter_tigerHead.touchable = false;
			hit_letter_tigerHead.graphics.precisionHitTest = true;	
			
		
			hit_letter_cubs = new Shape();
			this.addChild(hit_letter_cubs);
			hit_letter_cubs.graphics.beginFill(0x0000FF);
			hit_letter_cubs.graphics.lineTo(80,236);	
			hit_letter_cubs.graphics.lineTo(199,96);	
			hit_letter_cubs.graphics.lineTo(222,187);	
			hit_letter_cubs.graphics.lineTo(243,228);	
			hit_letter_cubs.graphics.lineTo(265,246);	
			hit_letter_cubs.graphics.lineTo(308,247);	
			hit_letter_cubs.graphics.lineTo(387,352);	
			hit_letter_cubs.graphics.lineTo(240,484);	
			hit_letter_cubs.graphics.lineTo(131,474);	
	

			hit_letter_cubs.graphics.endFill(false);
			hit_letter_cubs.alpha = 0.0;
			hit_letter_cubs.touchable = false;
			hit_letter_cubs.graphics.precisionHitTest = true;	
			
		}
		
		
		
		
		private function ScrollHandler(OpenClose:Boolean, fromSave:Boolean = false):void{
			/*
			false = close
			true = open
			*/
			if(fromSave === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PageUnroll();
			}
			if(OpenClose === true){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
				}
				trace(1);
				SaveArray['Scroll'] = 'open';
				
				//hatch.alpha = 1;
				scroll_open.alpha = 1;
				ScrollIsOpen = true;
				hit_scroll.graphics.clear();
				CreateScrollUpperHit();
				CreatePaintingHit();
			
			}else{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkTopDeck;
				}
				trace(1);
				SaveArray['Scroll'] = 'closed';
				
				//hatch.alpha = 1;
				scroll_open.alpha = 0;
				ScrollIsOpen = false;
				hit_scroll.graphics.clear();
				this.removeChild(hit_scroll_upper);
				this.removeChild(hit_painting);
			}
			
			CreateScrollHit(ScrollIsOpen);
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkTopDeck',SaveArray);	
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
			
			
			this.assets.removeTexture("junkTopDeck_bg",true);
			this.assets.removeTexture("JunkTopDeck_Sprite",true);
			this.assets.removeTexture("JunkTopDeck_Sprite_02",true);
			this.assets.removeTextureAtlas("JunkTopDeck_Sprite",true);
			this.assets.removeTextureAtlas("JunkTopDeck_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("junkTopDeck_01");
			(stage.getChildAt(0) as Object).falseAsset("junkTopDeck_02");
			(stage.getChildAt(0) as Object).falseAsset("junkTopDeck_03");
			(stage.getChildAt(0) as Object).falseAsset("junkTopDeck_04");
			(stage.getChildAt(0) as Object).falseAsset("junkTopDeck_05");
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
