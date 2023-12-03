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

	
	public class JungleVikingTV extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var potatoWires:Image;
		private var potato:Image;
		private var lid:Image;
		private var ball:Image;
		
		private var screen:MovieClip;
		
		private var hit_plug:Shape;
		private var hit_screen:Shape;
		private var hit_ball:Shape;
		private var hit_table:Shape;
		private var hit_lid:Shape;
		private var hit_switch:Shape;

		private var LidOpen:Boolean = false;
		private var PotatoesAttached:Boolean = false;
		private var WiresAttached:Boolean = false;
		private var Animating:Boolean = false;
		
		private var TVTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		
		public function JungleVikingTV(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleVikingTV_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTV/jungleVikingTV_bg.jpg'));
				game.TrackAssets('jungleVikingTV_01');
			}
			if(game.CheckAsset('jungleVikingTV_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTV/JungleVikingTV_Sprite.atf'));
				game.TrackAssets('jungleVikingTV_02');
			}
			if(game.CheckAsset('jungleVikingTV_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleVikingTV/JungleVikingTV_Sprite.xml'));
				game.TrackAssets('jungleVikingTV_03');
			}
			
			//JungleVikingTV_Sprite
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleVikingTV","JungleVikingTVObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleVikingTV_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			potatoWires = new Image(this.assets.getTexture('potatos_wires'));
			potatoWires.smoothing = TextureSmoothing.NONE;
			potatoWires.touchable = false;
			potatoWires.x = 311;
			potatoWires.y = 195;
			
			potato = new Image(this.assets.getTexture('potatos'));
			potato.smoothing = TextureSmoothing.NONE;
			potato.touchable = false;
			potato.x = 360;
			potato.y = 207;			
			
			lid = new Image(this.assets.getTexture('tv_t_lid'));
			lid.smoothing = TextureSmoothing.NONE;
			lid.touchable = false;
			lid.x = 360;
			lid.y = 180;	
			
			
			ball = new Image(this.assets.getTexture('ball'));
			ball.smoothing = TextureSmoothing.NONE;
			ball.touchable = false;
			ball.x = 385;
			ball.y = 205;	
			
			
			screen = new MovieClip(this.assets.getTextures("screen_"),12);
			screen.smoothing = TextureSmoothing.NONE;
			screen.x = 104;
			screen.y = 52;
			
			screen.touchable = false;
			screen.loop = true; // default: true
			screen.play();
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Potatoes'] == 'Attached'){
					PotatoesAttached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Wires'] == 'Attached'){
						screen.alpha= 1; 
						WiresAttached = true;
						potato.alpha = 0;
						potatoWires.alpha = 1;
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Lid'] == 'Open'){
							LidOpen = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Ball'] == 'PickedUp'){
								ball.alpha = 0;
							}else{
								ball.alpha = 1;
							}
							CreateHitBall();
							
						}else{
							ball.alpha = 0;
							lid.alpha = 0;
						}
						
					}else{
						screen.alpha= 0; 
						potato.alpha = 1;
						potatoWires.alpha = 0;
						lid.alpha = 0;
						ball.alpha = 0;
					}			
				}else{
					potato.alpha = 0;
					potatoWires.alpha = 0;
					lid.alpha = 0;
					ball.alpha = 0;
					screen.alpha= 0; 
				}
				
				
			}else{
				ball.alpha = 0;
				lid.alpha = 0;
				potato.alpha = 0;
				potatoWires.alpha = 0;
				screen.alpha= 0; 
			}
			
			
			this.addChildAt(potato,1);
			this.addChildAt(potatoWires,2);
			this.addChildAt(lid,3);	
			this.addChildAt(ball,4);	
			this.addChildAt(screen,5);	
			
			
			
			//FadeOutOcean(1);
			CreateHitSwitch();
			CreateHitScreen();
			CreateHitPlug();
			CreateHitTable();
			CreateLidHit(LidOpen);
			//CreateHitBall();
			
			Starling.juggler.add(screen);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Potatoes'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Wires'] == 'Attached'){
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).AmbientObj.LoadTVStatic(true,999);
						//	(stage.getChildAt(0) as Object).MusicObj.currentAmbient = 'Jungle_01';
						},0.7);
					}else{
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
							(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
						},0.7);
					}
				}else{
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
						(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
					},0.7);
				}
			}else{
				Starling.juggler.delayCall(function():void{
					(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
					(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
				},0.7);
			}
			
		}
		
		/*
		
		private var hit_plug:Shape;
		private var hit_screen:Shape;
		private var hit_ball:Shape;
		private var hit_table:Shape;
		*/
		//hit_switch
		private function CreateHitSwitch():void{
			hit_switch = new Shape();
			hit_switch.touchable = false;
			hit_switch.graphics.beginFill(0xff0000);
			
			hit_switch.graphics.lineTo(353,49);				
			hit_switch.graphics.lineTo(457,54);				
			hit_switch.graphics.lineTo(460,166);				
			hit_switch.graphics.lineTo(360,161);				
						
			
			hit_switch.graphics.endFill(false);
			hit_switch.alpha = 0.0;
			
			hit_switch.graphics.precisionHitTest = true;	
			this.addChild(hit_switch);
		}
		private function CreateLidHit(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				
				hit_lid.graphics.lineTo(356,170);	
				hit_lid.graphics.lineTo(476,176);	
				hit_lid.graphics.lineTo(475,278);	
				hit_lid.graphics.lineTo(358,270);	

				
				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				
				hit_lid.graphics.lineTo(463,175);	
				hit_lid.graphics.lineTo(541,198);	
				hit_lid.graphics.lineTo(539,312);	
				hit_lid.graphics.lineTo(457,272);	

				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			
		}
		
		private function CreateHitBall():void{
			hit_ball = new Shape();
			hit_ball.touchable = false;
			hit_ball.graphics.beginFill(0xff0000);
			
			hit_ball.graphics.lineTo(370,188);				
			hit_ball.graphics.lineTo(456,192);				
			hit_ball.graphics.lineTo(451,265);				
			hit_ball.graphics.lineTo(373,261);				

			hit_ball.graphics.endFill(false);
			hit_ball.alpha = 0.0;
			
			hit_ball.graphics.precisionHitTest = true;	
			this.addChild(hit_ball);
		}
		
		private function CreateHitTable():void{
			hit_table = new Shape();
			hit_table.touchable = false;
			hit_table.graphics.beginFill(0xff0000);
			
			hit_table.graphics.lineTo(393,348);				
			hit_table.graphics.lineTo(483,304);				
			hit_table.graphics.lineTo(541,309);				
			hit_table.graphics.lineTo(548,197);				
			hit_table.graphics.lineTo(718,234);				
			hit_table.graphics.lineTo(711,391);				
			hit_table.graphics.lineTo(574,501);				
			hit_table.graphics.lineTo(362,458);				
		
			hit_table.graphics.endFill(false);
			hit_table.alpha = 0.0;
			
			hit_table.graphics.precisionHitTest = true;	
			this.addChild(hit_table);
		}
		
		private function CreateHitPlug():void{
			hit_plug = new Shape();
			hit_plug.touchable = false;
			hit_plug.graphics.beginFill(0xff0000);
			
			hit_plug.graphics.lineTo(213,311);				
			hit_plug.graphics.lineTo(376,336);				
			hit_plug.graphics.lineTo(352,456);				
			hit_plug.graphics.lineTo(163,423);				
		
			hit_plug.graphics.endFill(false);
			hit_plug.alpha = 0.0;
			
			hit_plug.graphics.precisionHitTest = true;	
			this.addChild(hit_plug);
		}
		
		private function CreateHitScreen():void{
			hit_screen = new Shape();
			hit_screen.touchable = false;
			hit_screen.graphics.beginFill(0xff0000);
			
			hit_screen.graphics.lineTo(65,40);				
			hit_screen.graphics.lineTo(336,36);				
			hit_screen.graphics.lineTo(348,280);				
			hit_screen.graphics.lineTo(95,260);				
		
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
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((JungleVikingDeck as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingDeckObj,true
							);
						}else if(hit_screen.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							ScreenHandler();
						}else if(hit_plug.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							TableHandler();
						}else if(hit_table.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							TableHandler();
						}else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(PotatoesAttached === true){
								if(WiresAttached === true){
									LidHandler();
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a panel on front here, but I can't get it open.");
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a panel on front here, but I can't get it open.");
							}
						}else if(hit_switch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(WiresAttached === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The switch still doesn't work.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The switch is broken.");

							}
						}else if(LidOpen === true){
							if(hit_ball.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								BallHandler();
							}
						}
					}
					
				}
			}
		}
		
		private function BallHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Ball'] == 'PickedUp'){
					
				}else{
					ball.alpha = 0;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV;
					}
					SaveArray["Ball"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTV',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ball,
						'item_Ball',
						'inven_ball_sm'
					);
				}
			}else{
				ball.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV;
				}
				SaveArray["Ball"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTV',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ball,
					'item_Ball',
					'inven_ball_sm'
				);
			}
		}
		
		
		private function ScreenHandler():void{
			if(PotatoesAttached === true){
				if(WiresAttached === true){
					trace("TV IS ON /// TV IS ON");
					FadeOut((JungleVikingTVStatic as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingTVStaticObj,true
					);
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'll need to supply power to the television if I want to turn it on.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An old television set. It has no power.");
			}
		}
		
		private function TableHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV;
			}
			
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_PotatoesWired)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				PotatoesAttached = true;
				WiresAttached = true;
				
				potatoWires.alpha = 1;
				potato.alpha = 0;
				
				
				SaveArray["Wires"] = "Attached";
				SaveArray["Potatoes"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTV',SaveArray);
				
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_PotatoesWired,
						"item_PotatoesWired"
					);
				
				TurnOnTV();
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Wires)
			{
				if(PotatoesAttached === true){
					//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ItemPlace();
					WiresAttached = true;
					potatoWires.alpha = 1;
					potato.alpha = 0;
					
					
					SaveArray["Wires"] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTV',SaveArray);
					
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Wires,
							"item_Wires"
						);
					
					TurnOnTV();
					
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Attaching the wires won't accomplish anything if there isn't a power source.");
				}
				
				
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Potatoes)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				PotatoesAttached = true;
				potato.alpha = 1;
				
				SaveArray["Potatoes"] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTV',SaveArray);
				
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Potatoes,
						"item_Potatoes"
					);
			
			}else{
				if(PotatoesAttached === true){
					if(WiresAttached === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The potatoes and wires create a crude electrochemical battery. I wonder how long it can power the TV.");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("If I can find a way to connect the potatoes to the TV, I might be able to turn it on.");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("hmm. I need to find a power source if I want to turn the TV on.");
				}
			}
		}
		
		
		private function TurnOnTV():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlop();
			Animating = true;
			TVTween = new Tween(screen, 2, Transitions.LINEAR);
			TVTween.fadeTo(1);
			TVTween.onComplete = function():void{	
				
				Animating = false;
				LidHandler();
				TVTween = null;
			
				(stage.getChildAt(0) as Object).AmbientObj.LoadTVStatic(true,999);
					
				
				
			}
			Starling.juggler.add(TVTween);
		
		}
		
		private function LidHandler():void{
			if(LidOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
				LidOpen = true;
				lid.alpha = 1;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV['Ball'] == 'PickedUp'){
						ball.alpha = 0;
					}else{
						ball.alpha = 1;
					}
				}else{
					ball.alpha = 1;
				}
				hit_lid.graphics.clear();
				CreateLidHit(true);
				CreateHitBall();
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV;
				}
				SaveArray["Lid"] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTV',SaveArray);
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_TVBlip();
				LidOpen = false;
				lid.alpha = 0;
				ball.alpha = 0;
				
				this.removeChild(hit_ball);
				hit_lid.graphics.clear();
				CreateLidHit(false);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleVikingTV;
				}
				SaveArray["Lid"] = "Closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleVikingTV',SaveArray);
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
			
			
			this.assets.removeTexture("jungleVikingTV_bg",true);
			this.assets.removeTexture("JungleVikingTV_Sprite",true);
			this.assets.removeTextureAtlas("JungleVikingTV_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTV_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTV_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleVikingTV_03");
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
