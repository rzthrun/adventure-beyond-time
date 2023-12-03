package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
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
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	
	
	public class SubmarineWirePuzzle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var wire_blue:Image;
		private var wire_blue_sprite:Sprite;
		private var hit_wire_blue:Shape;
		
		private var wire_green:Image;
		private var wire_green_sprite:Sprite;
		private var hit_wire_green:Shape;
		
		private var wire_red:Image;
		private var wire_red_sprite:Sprite;
		private var hit_wire_red:Shape;
		
		private var wire_yellow:Image;
		private var wire_yellow_sprite:Sprite;
		private var hit_wire_yellow:Shape;
		
		private var solder_blue:Image;
		private var solder_green:Image;
		private var solder_red:Image;
		private var solder_yellow:Image;
		
		private var hit_solder_blue:Shape;
		private var hit_solder_green:Shape;
		private var hit_solder_red:Shape;
		private var hit_solder_yellow:Shape;
		
		private var spark_mc:MovieClip;
		private var smoke_blue:Image;
		private var smoke_red:Image;
		private var smoke_yellow:Image;
		private var smoke_green:Image;
		
		private var WireFlag:String = null;
		private var SolderFlag:String = null;
		private var Solved:Boolean = false;
		private var Animating:Boolean = false;
		public var delayedcall:DelayedCall;
		
		private var SolderBlueAttached:Boolean = false;
		private var SolderRedAttached:Boolean = false;
		private var SolderYellowAttached:Boolean = false;
		private var SolderGreenAttached:Boolean = false;
		
		private var smokeBlueTween:Tween;
		private var smokeRedTween:Tween;
		private var smokeYellowTween:Tween;
		private var smokeGreenTween:Tween;
		
		private var hit_bg:Shape;
		private var PhraseCounter:int = 0;;
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function SubmarineWirePuzzle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarineWirePuzzle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineWirePuzzle/submarineWirePuzzle_bg.jpg'));
				game.TrackAssets('submarineWirePuzzle_01');
			}
			if(game.CheckAsset('submarineWirePuzzle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineWirePuzzle/SubmarineWirePuzzle_Sprite.png'));
				game.TrackAssets('submarineWirePuzzle_02');
			}
			if(game.CheckAsset('submarineWirePuzzle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineWirePuzzle/SubmarineWirePuzzle_Sprite.xml'));
				game.TrackAssets('submarineWirePuzzle_03');
			}
			
			if(game.CheckAsset('submarineWirePuzzle_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineWirePuzzle/SubmarineWirePuzzle_Sprite_02.png'));
				game.TrackAssets('submarineWirePuzzle_04');
			}
			if(game.CheckAsset('submarineWirePuzzle_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarineWirePuzzle/SubmarineWirePuzzle_Sprite_02.xml'));
				game.TrackAssets('submarineWirePuzzle_06');
			}
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			//SubmarineWirePuzzle_Sprite
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarineWirePuzzle","SubmarineWirePuzzleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarineWirePuzzle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			solder_blue = new Image(this.assets.getTexture('solder_blue'));
			solder_blue.touchable = false;
			solder_blue.x = 453;
			solder_blue.y = 303;
			
			
			solder_green = new Image(this.assets.getTexture('solder_green'));
			solder_green.touchable = false;
			solder_green.x = 101;
			solder_green.y = 298;			
			
			solder_red = new Image(this.assets.getTexture('solder_red'));
			solder_red.touchable = false;
			solder_red.x = 354;
			solder_red.y = 118;
			
			solder_yellow = new Image(this.assets.getTexture('solder_yellow'));
			solder_yellow.touchable = false;
			solder_yellow.x = 644;
			solder_yellow.y = 186;

			wire_blue_sprite = new Sprite();
			wire_blue_sprite.x = 300;
			wire_blue_sprite.y = 0;

			wire_blue = new Image(this.assets.getTexture('wire_blue'));
			wire_blue.touchable = false;
			wire_blue_sprite.addChild(wire_blue);
			
				
			wire_green_sprite = new Sprite();
			wire_green_sprite.x = 500;
			wire_green_sprite.y = 0;
			
			wire_green = new Image(this.assets.getTexture('wire_green'));
			wire_green.touchable = false;
			wire_green_sprite.addChild(wire_green);
				
	
			wire_red_sprite = new Sprite();
			wire_red_sprite.x = 200;
			wire_red_sprite.y = 0;
			
			wire_red = new Image(this.assets.getTexture('wire_red'));
			wire_red.touchable = false;
			wire_red_sprite.addChild(wire_red);
			
			
			wire_yellow_sprite = new Sprite();
			wire_yellow_sprite.x = 20;
			wire_yellow_sprite.y = 0;
			
			wire_yellow = new Image(this.assets.getTexture('wire_yellow'));
			wire_yellow.touchable = false;
			wire_yellow_sprite.addChild(wire_yellow);
				
			
			spark_mc = new MovieClip(this.assets.getTextures('sparks_'),9);
			//puller_mc.smoothing = TextureSmoothing.NONE;
			spark_mc.x = 0;
			spark_mc.y = 6;
			spark_mc.touchable = false;
			spark_mc.alpha = 0;
			spark_mc.stop;
			spark_mc.loop = true; // default: true
			
			smoke_blue = new Image(this.assets.getTexture('smoke'));
			smoke_blue.touchable = false;
			
			smoke_blue.x = 431;
			smoke_blue.y = 204;
			smoke_blue.alpha = 0;
			
			smoke_red = new Image(this.assets.getTexture('smoke'));
			smoke_red.touchable = false;
			smoke_red.x = 333;
			smoke_red.y = 0;
			smoke_red.alpha = 0;
			
			smoke_yellow = new Image(this.assets.getTexture('smoke'));
			smoke_yellow.touchable = false;
			smoke_yellow.x = 620;
			smoke_yellow.y = 63;
			smoke_yellow.alpha = 0;
			
			smoke_green = new Image(this.assets.getTexture('smoke'));
			smoke_green.touchable = false;
			smoke_green.x = 80;
			smoke_green.y = 170;
			smoke_green.alpha = 0;
		
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_blue_x'] != undefined){
					wire_blue_sprite.x = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_blue_x'];
				}else{
					wire_blue_sprite.x = 300;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_red_x'] != undefined){
					wire_red_sprite.x = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_red_x'];	
				}else{
					wire_red_sprite.x = 200;
				}
			
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_green_x'] != undefined){
					wire_green_sprite.x = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_green_x'];	
				}else{
					wire_green_sprite.x = 500;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_yellow_x'] != undefined){
					wire_yellow_sprite.x = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['wire_yellow_x'];	
				}else{
					wire_yellow_sprite.x = 20;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_blue'] == 'Attached'){
					solder_blue.alpha = 1;
					SolderBlueAttached = true;
				}else{
					solder_blue.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_red'] == 'Attached'){
					solder_red.alpha = 1;
					SolderRedAttached = true;
				}else{
					solder_red.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_yellow'] == 'Attached'){
					solder_yellow.alpha = 1;
					SolderYellowAttached = true;
				}else{
					solder_yellow.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_green'] == 'Attached'){
					solder_green.alpha = 1;
					SolderGreenAttached = true;
					
				}else{
					solder_green.alpha = 0;
				}
				
				
			}else{
				solder_blue.alpha = 0;
				solder_red.alpha = 0;
				solder_yellow.alpha = 0;
				solder_green.alpha = 0;
				wire_green_sprite.x = 500;
				wire_blue_sprite.x = 300;
				wire_red_sprite.x = 200;
				wire_yellow_sprite.x = 20;
			
			}
			CreateBGHit();
			CreateSolderHits();
			CreateWireHits();	
				
			this.addChildAt(wire_blue_sprite,1);
			this.addChildAt(wire_green_sprite,2);
			this.addChildAt(wire_yellow_sprite,3);
			this.addChildAt(wire_red_sprite,4);
			
			
			
			this.addChildAt(solder_blue,5);
			this.addChildAt(solder_green,6);		
			this.addChildAt(solder_red,7);		
			this.addChildAt(solder_yellow,8);
			this.addChildAt(spark_mc,9);
			
			this.addChildAt(smoke_blue,10);
			this.addChildAt(smoke_red,11);
			this.addChildAt(smoke_yellow,12);
			this.addChildAt(smoke_green,13);

			
			
			/*
			private var smoke_blue:Image;
			private var smoke_red:Image;
			private var smoke_yellow:Image;
			private var smoke_green:Image;
			*/
			
			Starling.juggler.add(spark_mc);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		
		/*
		private var hit_bg:Shape;
		private var PhraseCounter:Shape;
		*/
		private function CreateBGHit():void{
			hit_bg = new Shape();
			hit_bg.touchable = false;
			hit_bg.graphics.beginFill(0x00ff00);
			
			hit_bg.graphics.lineTo(73,153);	
			hit_bg.graphics.lineTo(195,90);	
			hit_bg.graphics.lineTo(606,90);	
			hit_bg.graphics.lineTo(645,153);	
			hit_bg.graphics.lineTo(724,369);	
			hit_bg.graphics.lineTo(551,403);	
			hit_bg.graphics.lineTo(134,394);	
			hit_bg.graphics.lineTo(73,369);	
			
		
			hit_bg.graphics.endFill(false);
			hit_bg.alpha = 0.0;
			
			hit_bg.graphics.precisionHitTest = true;	
			this.addChild(hit_bg);
		}
		
		private function CreateWireHits():void{
			hit_wire_blue = new Shape();
			hit_wire_blue.touchable = false;
			hit_wire_blue.graphics.beginFill(0x00ff00);
			
			hit_wire_blue.graphics.lineTo(16,0);	
			hit_wire_blue.graphics.lineTo(81,0);	
			hit_wire_blue.graphics.lineTo(67,64);	
			hit_wire_blue.graphics.lineTo(55,84);	
			hit_wire_blue.graphics.lineTo(11,80);	
			hit_wire_blue.graphics.lineTo(0,60);	
			hit_wire_blue.graphics.lineTo(15,28);	

			hit_wire_blue.graphics.endFill(false);
			hit_wire_blue.alpha = 0.0;
			
			hit_wire_blue.graphics.precisionHitTest = true;	
			wire_blue_sprite.addChild(hit_wire_blue);
			
			
			hit_wire_green = new Shape();
			hit_wire_green.touchable = false;
			hit_wire_green.graphics.beginFill(0x00ff00);
			
			hit_wire_green.graphics.lineTo(16,0);	
			hit_wire_green.graphics.lineTo(81,0);	
			hit_wire_green.graphics.lineTo(71,33);	
			
			hit_wire_green.graphics.lineTo(63,78);	
			hit_wire_green.graphics.lineTo(57,82);	
			hit_wire_green.graphics.lineTo(7,80);	
			hit_wire_green.graphics.lineTo(0,49);	
			
			
			hit_wire_green.graphics.endFill(false);
			hit_wire_green.alpha = 0.0;
			
			hit_wire_green.graphics.precisionHitTest = true;	
			wire_green_sprite.addChild(hit_wire_green);
			
			
			
			hit_wire_red = new Shape();
			hit_wire_red.touchable = false;
			hit_wire_red.graphics.beginFill(0x00ff00);
			
			hit_wire_red.graphics.lineTo(0,0);	
			hit_wire_red.graphics.lineTo(56,0);	
			hit_wire_red.graphics.lineTo(63,32);	
			hit_wire_red.graphics.lineTo(62,76);	
			hit_wire_red.graphics.lineTo(0,78);	
			
			hit_wire_red.graphics.endFill(false);
			hit_wire_red.alpha = 0.0;
			
			hit_wire_red.graphics.precisionHitTest = true;	
			wire_red_sprite.addChild(hit_wire_red);
			
			
			hit_wire_yellow = new Shape();
			hit_wire_yellow.touchable = false;
			hit_wire_yellow.graphics.beginFill(0x00ff00);
			
			hit_wire_yellow.graphics.lineTo(0,0);	
			hit_wire_yellow.graphics.lineTo(60,0);	
			hit_wire_yellow.graphics.lineTo(70,12);	
			hit_wire_yellow.graphics.lineTo(70,58);	
			hit_wire_yellow.graphics.lineTo(62,78);		
			hit_wire_yellow.graphics.lineTo(0,78);	
			hit_wire_yellow.graphics.lineTo(0,66);	
			
			hit_wire_yellow.graphics.endFill(false);
			hit_wire_yellow.alpha = 0.0;
			
			hit_wire_yellow.graphics.precisionHitTest = true;	
			wire_yellow_sprite.addChild(hit_wire_yellow);
		}
		
		private function CreateSolderHits():void{
			hit_solder_blue = new Shape();
			hit_solder_blue.touchable = false;
			hit_solder_blue.graphics.beginFill(0x00ff00);
			
			hit_solder_blue.graphics.lineTo(418,310);	
			hit_solder_blue.graphics.lineTo(433,280);	
			hit_solder_blue.graphics.lineTo(481,280);	
			hit_solder_blue.graphics.lineTo(506,305);	
			hit_solder_blue.graphics.lineTo(518,340);	
			hit_solder_blue.graphics.lineTo(498,366);	
			hit_solder_blue.graphics.lineTo(450,362);	

			hit_solder_blue.graphics.endFill(false);
			hit_solder_blue.alpha = 0.0;
			
			hit_solder_blue.graphics.precisionHitTest = true;	
			this.addChild(hit_solder_blue);
			
			
			hit_solder_green = new Shape();
			hit_solder_green.touchable = false;
			hit_solder_green.graphics.beginFill(0x00ff00);
			
			hit_solder_green.graphics.lineTo(78,291);	
			hit_solder_green.graphics.lineTo(140,275);	
			hit_solder_green.graphics.lineTo(168,298);	
			hit_solder_green.graphics.lineTo(161,332);	
			hit_solder_green.graphics.lineTo(113,353);	
			hit_solder_green.graphics.lineTo(83,340);	

			hit_solder_green.graphics.endFill(false);
			hit_solder_green.alpha = 0.0;
			
			hit_solder_green.graphics.precisionHitTest = true;	
			this.addChild(hit_solder_green);
			
			
			hit_solder_red = new Shape();
			hit_solder_red.touchable = false;
			hit_solder_red.graphics.beginFill(0x00ff00);
			
			hit_solder_red.graphics.lineTo(333,133);	
			hit_solder_red.graphics.lineTo(346,107);	
			hit_solder_red.graphics.lineTo(403,101);	
			hit_solder_red.graphics.lineTo(420,127);	
			hit_solder_red.graphics.lineTo(409,151);	
			hit_solder_red.graphics.lineTo(354,160);	

			hit_solder_red.graphics.endFill(false);
			hit_solder_red.alpha = 0.0;
			
			hit_solder_red.graphics.precisionHitTest = true;	
			this.addChild(hit_solder_red);
			
			
			hit_solder_yellow = new Shape();
			hit_solder_yellow.touchable = false;
			hit_solder_yellow.graphics.beginFill(0x00ff00);
			
			hit_solder_yellow.graphics.lineTo(620,189);	
			hit_solder_yellow.graphics.lineTo(641,160);	
			hit_solder_yellow.graphics.lineTo(689,172);	
			hit_solder_yellow.graphics.lineTo(704,217);	
			hit_solder_yellow.graphics.lineTo(677,250);	
			hit_solder_yellow.graphics.lineTo(628,231);	

			
			hit_solder_yellow.graphics.endFill(false);
			hit_solder_yellow.alpha = 0.0;
			
			hit_solder_yellow.graphics.precisionHitTest = true;	
			this.addChild(hit_solder_yellow);
			
		}
		
		/*
		
		private var hit_solder_blue:Shape;
		private var hit_solder_green:Shape;
		private var hit_solder_red:Shape;
		private var hit_solder_yellow:Shape;
		*/
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if(Animating === false){
				if (touches.length > 0){
					if (touches[0].phase == TouchPhase.BEGAN) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							
						
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							Starling.juggler.purge()
							FadeOut((SubmarineConsole as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineConsoleObj,true
							);
						}else if(hit_solder_red.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SolderFlag = 'red';
							SolderHandler(SolderFlag);
						}else if(hit_solder_yellow.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SolderFlag = 'yellow';
							SolderHandler(SolderFlag);
						}else if(hit_solder_green.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SolderFlag = 'green';
							SolderHandler(SolderFlag);
						}else if(hit_solder_blue.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SolderFlag = 'blue';
							SolderHandler(SolderFlag);
						
						}else if(Solved === false){	
							if(hit_wire_red.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								trace("blue wire hit");
								WireFlag = "red";	
							}else if(hit_wire_yellow.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								WireFlag = "yellow";	
							}else if(hit_wire_green.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								WireFlag = "green";	
							}else if(hit_wire_blue.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								WireFlag = "blue";	
							}else if(hit_bg.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wires are badly tangled together.");
									
								
							}
						}
					}else if(touches[0].phase == TouchPhase.MOVED){
						trace("MOUSE MOVED: "+touches[0].globalX+" ,"+touches[0].globalY);
						
						if(Solved === false){
							if(WireFlag != null){
								WireHandler();
								
							}
						}
					}else if(touches[0].phase == TouchPhase.ENDED){
						(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("Spark");
						SolderFlag = null;
						
						WireUpHandler();
					}
				}
			}
		}
		
		
		private function RemoveSolderIron():void{
			if(SolderBlueAttached === true){
				if(SolderRedAttached === true){
					if(SolderYellowAttached === true){
						if(SolderGreenAttached === true){
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
								.InventoryObj.removeItemFromInventory(
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.item_Solder,
									"item_Solder"
								);
						}
					}
				}
			}
		}
		
		private function SolderHandler(color:String):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle['solder_'+color] == 'Attached'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I used the soldering iron to reconnect the ends of the wire.");
				}else{
					
					
					if(color == 'blue'){
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Solder)
							
						{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
							SolderBlueAttached = true;
							solder_blue.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle;
							}
							SaveArray['solder_'+color] = 'Attached';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
							SmokeBlueIn();
							RemoveSolderIron();
							Solve();
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is torn; I need to fuse it back together.");
						}
					}else if(color == 'red'){
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Solder)
							
						{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
							SolderRedAttached = true;
							solder_red.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle;
							}
							SaveArray['solder_'+color] = 'Attached';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
							SmokeRedIn();
							RemoveSolderIron();
							Solve();
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is ripped in two; I need to fuse it back together.");
						}
					}else if(color == 'yellow'){
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Solder)
							
						{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
							SolderYellowAttached = true;
							solder_yellow.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle;
							}
							SaveArray['solder_'+color] = 'Attached';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
							SmokeYellowIn();
							RemoveSolderIron();
							Solve();
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is torn in two; I must reconnect it.");
						}
					}else if(color == 'green'){
						if((stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.armedItem
							== 
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.inventoryBarObj
							.item_Solder)
							
						{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
							SolderGreenAttached = true;
							solder_green.alpha = 1;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle;
							}
							SaveArray['solder_'+color] = 'Attached';
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
							SmokeGreenIn();
							RemoveSolderIron();
							Solve();
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is torn in two; I need to reconnect the ends.");
						}
					}
				}
			}else{
				if(color == 'blue'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Solder)
						
					{
						SolderBlueAttached = true;
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
						solder_blue.alpha = 1;
						SaveArray['solder_'+color] = 'Attached';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						SmokeBlueIn();
						RemoveSolderIron();
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is torn in two; I need to reconnect the ends.");
					}
				}else if(color == 'red'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Solder)
						
					{
						SolderRedAttached = true;
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
						solder_red.alpha = 1;
						SaveArray['solder_'+color] = 'Attached';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						SmokeRedIn();
						RemoveSolderIron();
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is torn in two; I need to reconnect the ends.");
					}
				}else if(color == 'yellow'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Solder)
						
					{
						SolderYellowAttached = true;
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
						solder_yellow.alpha = 1;
						SaveArray['solder_'+color] = 'Attached';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						SmokeYellowIn();
						RemoveSolderIron();
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is torn in two; I need to reconnect the ends.");
					}
				}else if(color == 'green'){
					if((stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.armedItem
						== 
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.inventoryBarObj
						.item_Solder)
						
					{
						SolderGreenAttached = true;
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SizzleTwo();
						solder_green.alpha = 1;
						SaveArray['solder_'+color] = 'Attached';
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						SmokeGreenIn();
						RemoveSolderIron();
						Solve();
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wire here is torn in two; I need to reconnect the ends.");
					}
				}
			}
		}
		private function SmokeBlueIn():void{
			smokeBlueTween = new Tween(smoke_blue, 1, Transitions.LINEAR);
			smokeBlueTween.fadeTo(1);
			smokeBlueTween.onComplete = function():void{	
				SmokeBlueOut();
			}
			Starling.juggler.add(smokeBlueTween);
		}
		private function SmokeBlueOut():void{
			smokeBlueTween = new Tween(smoke_blue, 2.5, Transitions.LINEAR);
			smokeBlueTween.fadeTo(0);
			smokeBlueTween.onComplete = function():void{	
				smokeBlueTween = null;
			}
			Starling.juggler.add(smokeBlueTween);
		}
		
		private function SmokeRedIn():void{
			smokeRedTween = new Tween(smoke_red, 1, Transitions.LINEAR);
			smokeRedTween.fadeTo(1);
			smokeRedTween.onComplete = function():void{	
				SmokeRedOut();
			}
			Starling.juggler.add(smokeRedTween);
		}
		private function SmokeRedOut():void{
			smokeRedTween = new Tween(smoke_red, 2.5, Transitions.LINEAR);
			smokeRedTween.fadeTo(0);
			smokeRedTween.onComplete = function():void{	
				smokeRedTween = null;
			}
			Starling.juggler.add(smokeRedTween);
		}
		

		private function SmokeYellowIn():void{
			smokeYellowTween = new Tween(smoke_yellow, 1, Transitions.LINEAR);
			smokeYellowTween.fadeTo(1);
			smokeYellowTween.onComplete = function():void{	
				SmokeYellowOut();
			}
			Starling.juggler.add(smokeYellowTween);
		}
		private function SmokeYellowOut():void{
			smokeYellowTween = new Tween(smoke_yellow, 2.5, Transitions.LINEAR);
			smokeYellowTween.fadeTo(0);
			smokeYellowTween.onComplete = function():void{	
				smokeYellowTween = null;
			}
			Starling.juggler.add(smokeYellowTween);
		}
		
		
		private function SmokeGreenIn():void{
			smokeGreenTween = new Tween(smoke_green, 1, Transitions.LINEAR);
			smokeGreenTween.fadeTo(1);
			smokeGreenTween.onComplete = function():void{	
				SmokeGreenOut();
			}
			Starling.juggler.add(smokeGreenTween);
		}
		private function SmokeGreenOut():void{
			smokeGreenTween = new Tween(smoke_green, 2.5, Transitions.LINEAR);
			smokeGreenTween.fadeTo(0);
			smokeGreenTween.onComplete = function():void{	
				smokeGreenTween = null;
			}
			Starling.juggler.add(smokeGreenTween);
		}
		
		
		private function WireUpHandler():void{
			if(WireFlag == null){
				
			}else{
		
				spark_mc.stop();
				spark_mc.alpha = 0;
								
				trace("1");
				trace("WIRE UP HANDLER");
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle;
				}
				
				if(this[("wire_"+WireFlag+"_sprite")].x < 101-37){
					trace("8");
					if(this[("wire_"+WireFlag+"_sprite")].x > 71-37){
						
						this[("wire_"+WireFlag+"_sprite")].x = 86-37;
						trace("9");
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;				
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						Solve();
						
					}else{
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;				
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						
						
					}
				}
				else if(this[("wire_"+WireFlag+"_sprite")].x < 323-37){
					trace("6");
					if(this[("wire_"+WireFlag+"_sprite")].x > 293-37){
						
						this[("wire_"+WireFlag+"_sprite")].x = 308-37;
						trace("7");
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;				
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						
						Solve();
					}else{
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;				
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						
						
					}
					
				}
				else if(this[("wire_"+WireFlag+"_sprite")].x < 481-37){
					trace("4");
					if(this[("wire_"+WireFlag+"_sprite")].x > 450-37){
						this[("wire_"+WireFlag+"_sprite")].x = 465-37;
						trace("5");
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;				
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						
						Solve();
					}else{
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;				
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						
						
					}
					
				}
				
				else if(this[("wire_"+WireFlag+"_sprite")].x < 655-37){
					trace("2");
					if(this[("wire_"+WireFlag+"_sprite")].x > 625-37){
						this[("wire_"+WireFlag+"_sprite")].x = 640-37;
						trace("3");
											
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;				
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						
						Solve();
					}else{
						
						SaveArray['wire_'+WireFlag+'_x'] = this[("wire_"+WireFlag+"_sprite")].x;
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);
						
						
					}
					
				}
				WireFlag = null;
				
			}

			
		}
		
		private function WireHandler():void{
			if(touches[0].globalX < 670){
				this[("wire_"+WireFlag+"_sprite")].x = 	touches[0].globalX-37;
				
				if(this[("wire_"+WireFlag+"_sprite")].x < 101-37){
					if(this[("wire_"+WireFlag+"_sprite")].x > 71-37){
						if((stage.getChildAt(0) as Object).SoundFXObj.soundManager.soundIsPlaying('Spark') === true){
							
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Spark();
						}
						spark_mc.x = 71-42;
						
						spark_mc.alpha = 1;
						spark_mc.play();
					
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("Spark");
						spark_mc.alpha = 0;
						spark_mc.stop();
					}
				}else if(this[("wire_"+WireFlag+"_sprite")].x < 323-37){
					if(this[("wire_"+WireFlag+"_sprite")].x > 293-37){
						if((stage.getChildAt(0) as Object).SoundFXObj.soundManager.soundIsPlaying('Spark') === true){
							
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Spark();
						}
						spark_mc.x = 293-42;
						
						spark_mc.alpha = 1;
						spark_mc.play();
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("Spark");
						spark_mc.alpha = 0;
						spark_mc.stop();
					}
				}else if(this[("wire_"+WireFlag+"_sprite")].x < 481-37){
					if(this[("wire_"+WireFlag+"_sprite")].x > 450-37){
						if((stage.getChildAt(0) as Object).SoundFXObj.soundManager.soundIsPlaying('Spark') === true){
						
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Spark();
						}
						spark_mc.x = 450-42;
						
						spark_mc.alpha = 1;
						spark_mc.play();
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("Spark");
						spark_mc.alpha = 0;
						spark_mc.stop();
					}
				}
				else if(this[("wire_"+WireFlag+"_sprite")].x < 655-37){
					if(this[("wire_"+WireFlag+"_sprite")].x > 625-37){
						if((stage.getChildAt(0) as Object).SoundFXObj.soundManager.soundIsPlaying('Spark') === true){
							
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Spark();
						}
						
						spark_mc.x = 625-42;
						
						spark_mc.alpha = 1;
						spark_mc.play();
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("Spark");
						spark_mc.alpha = 0;
						spark_mc.stop();
					}
				}else{
					
					spark_mc.alpha = 0;
					spark_mc.stop();
				}
				
			}
		}
		
		private function Solve():void{
			if(wire_red_sprite.x == 86-37){
				if(wire_yellow_sprite.x == 308-37){
					if(wire_green_sprite.x == 465-37){
						if(wire_blue_sprite.x == 640-37){
							if(SolderBlueAttached === true){
								if(SolderRedAttached === true){
									if(SolderYellowAttached === true){
										if(SolderGreenAttached === true){
											trace("Solved");
											(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BigLights();

											Animating = true;
											Solved = true;
											(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
											
											if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle != undefined){
												SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarineWirePuzzle;
											}
											SaveArray['Solved'] = 'Yes'; 
											(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarineWirePuzzle',SaveArray);	
											
											delayedcall = new DelayedCall(function():void{
												
												(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_EnergyPulse();
												Animating = false;
												FadeOut(SubmarineConsole,(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineConsoleObj,true)
												
											},3);
											
											
											Starling.juggler.add(delayedcall);
											
											
										}
									}
								}
							}
							
						}
								
					}
						
				}
				
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
			
			;
			
			this.assets.removeTexture("submarineWirePuzzle_bg",true);
			this.assets.removeTexture("SubmarineWirePuzzle_Sprite",true);
			this.assets.removeTextureAtlas("SubmarineWirePuzzle_Sprite",true);
			this.assets.removeTexture("SubmarineWirePuzzle_Sprite_02",true);
			this.assets.removeTextureAtlas("SubmarineWirePuzzle_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("submarineWirePuzzle_01");
			(stage.getChildAt(0) as Object).falseAsset("submarineWirePuzzle_02");
			(stage.getChildAt(0) as Object).falseAsset("submarineWirePuzzle_03");
			(stage.getChildAt(0) as Object).falseAsset("submarineWirePuzzle_04");
			(stage.getChildAt(0) as Object).falseAsset("submarineWirePuzzle_05");
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