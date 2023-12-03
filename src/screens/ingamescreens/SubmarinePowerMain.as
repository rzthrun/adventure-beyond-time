package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;

	public class SubmarinePowerMain extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var pos_00:Image;
		private var pos_01:Image;
		private var pos_02:Image;
		private var pos_03:Image;
		private var pos_04:Image;
		private var pos_05:Image;
		
		private var hit_pos_00:Shape;
		private var hit_pos_01:Shape;
		private var hit_pos_02:Shape;
		private var hit_pos_03:Shape;
		private var hit_pos_04:Shape;
		private var hit_pos_05:Shape;

		private var pos_00_pos:String = '1';
		private var pos_01_pos:String = '1';
		private var pos_02_pos:String = '1';
		private var pos_03_pos:String = '1';
		private var pos_04_pos:String = '1';
		private var pos_05_pos:String = '1';
		
		private var MouseCurrentAngle:Number = 180;
		private var MousePrevAngle:Number = 180;
		
		private var Solved:Boolean = false;
		private var LeverAttached:Boolean = false;
		private var HandFlag:String = null
		
		private var Animating:Boolean = false;
		public var delayedcall:DelayedCall;

		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function SubmarinePowerMain(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('submarinePowerMain_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarinePowerMain/SubmarinePowerMain_Sprite_02.jpg'));
				game.TrackAssets('submarinePowerMain_01');
			}
			if(game.CheckAsset('submarinePowerMain_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarinePowerMain/SubmarinePowerMain_Sprite_02.xml'));
				game.TrackAssets('submarinePowerMain_02');
			}
			if(game.CheckAsset('submarinePowerMain_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarinePowerMain/SubmarinePowerMain_Sprite.png'));
				game.TrackAssets('submarinePowerMain_03');
			}
			if(game.CheckAsset('submarinePowerMain_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SubmarinePowerMain/SubmarinePowerMain_Sprite.xml'));
				game.TrackAssets('submarinePowerMain_04');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SubmarinePowerMain","SubmarinePowerMainObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('submarinePowerMain_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			pos_00 = new Image(this.assets.getTexture('pos_00_01'));
			pos_00.touchable = false;
			pos_00.x = 78;
			pos_00.y = 61;
			
			
			pos_01 = new Image(this.assets.getTexture('pos_01_01'));
			pos_01.touchable = false;
			pos_01.x = 253;
			pos_01.y = 47;
			
			
			pos_02 = new Image(this.assets.getTexture('pos_02_01'));
			pos_02.touchable = false;
			pos_02.x = 460;
			pos_02.y = 28;
			
			
			pos_03 = new Image(this.assets.getTexture('pos_03_01'));
			pos_03.touchable = false;
			pos_03.x = 82;
			pos_03.y = 250;
			
			
			pos_04 = new Image(this.assets.getTexture('pos_04_01'));
			pos_04.touchable = false;
			pos_04.x = 257;
			pos_04.y = 253;
			
			
			pos_05 = new Image(this.assets.getTexture('pos_05_01'));
			pos_05.touchable = false;
			pos_05.x = 466;
			pos_05.y = 257;
			
			

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['Solved'] == 'Yes'){
					Solved = true;
					bg.texture = this.assets.getTexture('submarinePowerMain_bg_lit');
					pos_00.alpha = 0;
					pos_01.alpha = 0;
					pos_02.alpha = 0;
					pos_03.alpha = 0;
					pos_04.alpha = 0;
					pos_05.alpha = 0;
				}else{
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_00'] == '2'){
						pos_00.texture = this.assets.getTexture('pos_00_02');
						pos_00_pos = '2';
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_00'] == '0'){
						pos_00.texture = this.assets.getTexture('pos_00_00');
						pos_00_pos = '0';
					}else{
						pos_00.texture = this.assets.getTexture('pos_00_01');
						pos_00_pos = '1';
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_01'] == '2'){
						pos_01.texture = this.assets.getTexture('pos_01_02');
						pos_01_pos = '2';
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_01'] == '0'){
						pos_01.texture = this.assets.getTexture('pos_01_00');
						pos_01_pos = '0';
					}else{
						pos_01.texture = this.assets.getTexture('pos_01_01');
						pos_01_pos = '1';
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_02'] == '2'){
						pos_02.texture = this.assets.getTexture('pos_02_02');
						pos_02_pos = '2';
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_02'] == '0'){
						pos_02.texture = this.assets.getTexture('pos_02_00');
						pos_02_pos = '0';
					}else{
						pos_02.texture = this.assets.getTexture('pos_02_01');
						pos_02_pos = '1';
					}
	
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_03'] == '2'){
						pos_03.texture = this.assets.getTexture('pos_03_02');
						pos_03_pos = '2';
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_03'] == '0'){
						pos_03.texture = this.assets.getTexture('pos_03_00');
						pos_03_pos = '0';
					}else{
						pos_03.texture = this.assets.getTexture('pos_03_01');
						pos_03_pos = '1';
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['Lever'] == 'Attached'){
						LeverAttached = true;
						pos_04.alpha = 1;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_04'] == '2'){
							pos_04.texture = this.assets.getTexture('pos_04_02');
							pos_04_pos = '2';
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_04'] == '0'){
							pos_04.texture = this.assets.getTexture('pos_04_00');
							pos_04_pos = '0';
						}else{
							pos_04.texture = this.assets.getTexture('pos_04_01');
							pos_04_pos = '1';
						}	
						
					}else{
						pos_04.alpha = 0;
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_05'] == '2'){
						pos_05.texture = this.assets.getTexture('pos_05_02');
						pos_05_pos = '2';
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['pos_05'] == '0'){
						pos_05.texture = this.assets.getTexture('pos_05_00');
						pos_05_pos = '0';
					}else{
						pos_05.texture = this.assets.getTexture('pos_05_01');
						pos_05_pos = '1';
					}
				}
				
			}else{
				pos_00.alpha = 1;
				pos_01.alpha = 1;
				pos_02.alpha = 1;
				pos_03.alpha = 1;
				pos_04.alpha = 0;
				pos_05.alpha = 1;
			}
			
			
			
			
			this.addChildAt(pos_00,1);
			this.addChildAt(pos_01,2);
			this.addChildAt(pos_02,3);
			this.addChildAt(pos_03,4);
			this.addChildAt(pos_04,5);
			this.addChildAt(pos_05,6);
			
			CreatePosHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDrips(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarinePowerMain',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarinePowerMain',SaveArray);
			}
			
		}
		

		private function CreatePosHit():void{
			hit_pos_00 = new Shape();
			hit_pos_00.touchable = false;
			hit_pos_00.graphics.beginFill(0x0000ff);
			
			hit_pos_00.graphics.lineTo(66,133);	
			hit_pos_00.graphics.lineTo(100,44);	
			hit_pos_00.graphics.lineTo(226,40);	
			hit_pos_00.graphics.lineTo(227,243);	
			hit_pos_00.graphics.lineTo(99,238);	
			hit_pos_00.graphics.lineTo(75,183);	
			
			hit_pos_00.alpha = 0.0;
			hit_pos_00.graphics.endFill(false);
			hit_pos_00.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_00);
			
			//---------------------------
			hit_pos_01 = new Shape();
			hit_pos_01.touchable = false;
			hit_pos_01.graphics.beginFill(0x0000ff);
			
			hit_pos_01.graphics.lineTo(240,138);	
			hit_pos_01.graphics.lineTo(258,37);	
			hit_pos_01.graphics.lineTo(406,30);	
			hit_pos_01.graphics.lineTo(402,223);	
			hit_pos_01.graphics.lineTo(398,251);	
			hit_pos_01.graphics.lineTo(254,246);	
			hit_pos_01.graphics.lineTo(247,177);	
			
			hit_pos_01.alpha = 0.0;
			hit_pos_01.graphics.endFill(false);
			hit_pos_01.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_01);
			
			//---------------------------
			hit_pos_02 = new Shape();
			hit_pos_02.touchable = false;
			hit_pos_02.graphics.beginFill(0x0000ff);
			
			hit_pos_02.graphics.lineTo(433,133);	
			hit_pos_02.graphics.lineTo(458,21);	
			hit_pos_02.graphics.lineTo(618,13);	
			hit_pos_02.graphics.lineTo(612,254);	
			hit_pos_02.graphics.lineTo(454,250);	

			hit_pos_02.alpha = 0.0;
			hit_pos_02.graphics.endFill(false);
			hit_pos_02.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_02);
			
			//---------------------------
			hit_pos_03 = new Shape();
			hit_pos_03.touchable = false;
			hit_pos_03.graphics.beginFill(0x0000ff);
			
			hit_pos_03.graphics.lineTo(69,320);	
			hit_pos_03.graphics.lineTo(80,257);	
			hit_pos_03.graphics.lineTo(113,243);	
			hit_pos_03.graphics.lineTo(228,248);	
			hit_pos_03.graphics.lineTo(220,437);	
			hit_pos_03.graphics.lineTo(91,428);	
			
			hit_pos_03.alpha = 0.0;
			hit_pos_03.graphics.endFill(false);
			hit_pos_03.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_03);
			
			//---------------------------
			hit_pos_04 = new Shape();
			hit_pos_04.touchable = false;
			hit_pos_04.graphics.beginFill(0x0000ff);
			
			hit_pos_04.graphics.lineTo(254,250);	
			hit_pos_04.graphics.lineTo(406,254);	
			hit_pos_04.graphics.lineTo(397,462);	
			hit_pos_04.graphics.lineTo(243,444);	
			hit_pos_04.graphics.lineTo(247,340);	

			hit_pos_04.alpha = 0.0;
			hit_pos_04.graphics.endFill(false);
			hit_pos_04.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_04);
			
			//---------------------------
			hit_pos_05 = new Shape();
			hit_pos_05.touchable = false;
			hit_pos_05.graphics.beginFill(0x0000ff);
			
			hit_pos_05.graphics.lineTo(456,254);	
			hit_pos_05.graphics.lineTo(612,257);	
			hit_pos_05.graphics.lineTo(608,433);	
			hit_pos_05.graphics.lineTo(586,483);	
			hit_pos_05.graphics.lineTo(455,468);	
			hit_pos_05.graphics.lineTo(438,357);	

			hit_pos_05.alpha = 0.0;
			hit_pos_05.graphics.endFill(false);
			hit_pos_05.graphics.precisionHitTest = true;	
			this.addChild(hit_pos_05);
			
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.BEGAN) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((SubmarineLowerLevel as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineLowerLevelObj,true
						);
					}else if(Solved === false){
						
						if(hit_pos_00.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HandFlag = "pos_00";
							MousePrevAngle = touches[0].globalY;
						}else if(hit_pos_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HandFlag = "pos_01";		
							MousePrevAngle = touches[0].globalY;
						}else if(hit_pos_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HandFlag = "pos_02";	
							MousePrevAngle = touches[0].globalY;
						}else if(hit_pos_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HandFlag = "pos_03";	
							MousePrevAngle = touches[0].globalY;
						}else if(hit_pos_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(LeverAttached === true){
								HandFlag = "pos_04";
								MousePrevAngle = touches[0].globalY;	
							}else{
								LeverHandler();
							}			
						}else if(hit_pos_05.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HandFlag = "pos_05";		
							MousePrevAngle = touches[0].globalY;
						}
					}else{
						
						if(hit_pos_00.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PostSolveHitHandler();
						}else if(hit_pos_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PostSolveHitHandler();
						}else if(hit_pos_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PostSolveHitHandler();
						}else if(hit_pos_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PostSolveHitHandler();
						}else if(hit_pos_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PostSolveHitHandler();	
						}else if(hit_pos_05.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PostSolveHitHandler();
						}
					}
				}else if(touches[0].phase == TouchPhase.ENDED){
					if(Solved === false){
						if(HandFlag != null){
							HandHandler();
						}
					}
					
				}
			}
		}
		
		private function PostSolveHitHandler():void{
			(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Probably should leave this alone now that I have the power on.");
		}
		
		private function LeverHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Lever)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();
				pos_04.alpha = 1;
				LeverAttached = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain;
				}
				SaveArray['Lever'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarinePowerMain',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Lever,
						"item_Lever"
					);
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("One of the levers is missing.");
			}
			
		}
		//
					
		
		private function HandHandler():void{
			MouseCurrentAngle = touches[0].globalY;
			if(MousePrevAngle > MouseCurrentAngle){
				
				if(this[(HandFlag+"_pos")] == '0'){
				
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawSlideOpen();
					this[(HandFlag)].texture = this.assets.getTexture(HandFlag+'_01');
					this[(HandFlag+"_pos")] = '1';
				}else if(this[(HandFlag+"_pos")] == '1'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawSlideOpen();
					this[(HandFlag)].texture = this.assets.getTexture(HandFlag+'_02');
					this[(HandFlag+"_pos")] = '2';
				}else if(this[(HandFlag+"_pos")] == '2'){
					
				}
			}else if(MousePrevAngle < MouseCurrentAngle){
				if(this[(HandFlag+"_pos")] == '0'){
					
				}else if(this[(HandFlag+"_pos")] == '1'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawSlideClosed();
					this[(HandFlag)].texture = this.assets.getTexture(HandFlag+'_00');
					this[(HandFlag+"_pos")] = '0';	
				}else if(this[(HandFlag+"_pos")] == '2'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawSlideClosed();
					this[(HandFlag)].texture = this.assets.getTexture(HandFlag+'_01');
					this[(HandFlag+"_pos")] = '1';	
				}
			}
			SaveHandVal(HandFlag);	
			HandFlag = null;
			
			Solve();
		}
		
		private function SaveHandVal(HandFlagVal:String):void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain;
			}
			SaveArray[HandFlagVal] = this[(HandFlagVal+"_pos")];
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarinePowerMain',SaveArray);
		}
		
		
		private function Solve():void{

			
			if(pos_00_pos == '0'){
				if(pos_01_pos == '1'){
					if(pos_02_pos == '2'){
						if(pos_03_pos == '2'){
							if(pos_04_pos == '2'){
								if(pos_05_pos == '0'){
									trace("Solved");
									trace("SOLVE!!!!");
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_PowerUp();
									Animating = true;
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
									(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDrips",0,0.5,'stop');
									trace("Solved");
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SubmarinePowerMain;
									}
									SaveArray['Solved'] = 'Yes'; 
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SubmarinePowerMain',SaveArray);	
									delayedcall = new DelayedCall(function():void{
										
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_EnergyPulse();
										Animating = false;
										FadeOut(SubmarineLowerLevel,(stage.getChildAt(0) as Object).screenGamePlayHandler.SubmarineLowerLevelObj,true)
									},2);
									
								
									
									
									Starling.juggler.add(delayedcall);
								}else{
									trace("Not Solved");
								}
							}else{
								trace("Not Solved");
							}
						}else{
							trace("Not Solved");
						}
					}else{
						trace("Not Solved");
					}
					
				}else{
					trace("Not Solved");
				}
			}else{
				trace("Not Solved");
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
			
			
			this.assets.removeTexture("SubmarinePowerMain_Sprite_02",true);
			this.assets.removeTexture("SubmarinePowerMain_Sprite",true);
			this.assets.removeTextureAtlas("SubmarinePowerMain_Sprite_02",true);
			this.assets.removeTextureAtlas("SubmarinePowerMain_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("submarinePowerMain_01");
			(stage.getChildAt(0) as Object).falseAsset("submarinePowerMain_02");
			(stage.getChildAt(0) as Object).falseAsset("submarinePowerMain_03");
			(stage.getChildAt(0) as Object).falseAsset("submarinePowerMain_04");
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