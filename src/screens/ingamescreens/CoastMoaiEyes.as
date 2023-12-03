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
	
	
	public class CoastMoaiEyes extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var left_eye:Image;
		private var right_eye:Image;
		
		private var hit_leftEye:Shape;
		private var hit_rightEye:Shape;
		
		private var Animating:Boolean = false;
		public var delayedcall:DelayedCall;
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function CoastMoaiEyes(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastMoaiEyes_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastMoaiEyes/coastMoaiEyes_bg.jpg'));
				game.TrackAssets('coastMoaiEyes_01');
			}
			if(game.CheckAsset('coastMoaiEyes_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastMoaiEyes/CoastMoaiEyes_Sprite.png'));
				game.TrackAssets('coastMoaiEyes_02');
			}
			if(game.CheckAsset('coastMoaiEyes_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastMoaiEyes/CoastMoaiEyes_Sprite.xml'));
				game.TrackAssets('coastMoaiEyes_03');
			}
			//CoastMoaiEyes_Sprite
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastMoaiEyes","CoastMoaiEyesObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastMoaiEyes_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
				
		//	private var left_eye:Image;
		//	private var right_eye:Image;
			
			left_eye = new Image(this.assets.getTexture('left_eye'));
			left_eye.touchable = false;
			left_eye.x = 185;
			left_eye.y = 217;
			
			
			right_eye = new Image(this.assets.getTexture('right_eye'));
			right_eye.touchable = false;
			right_eye.x = 570;
			right_eye.y = 160;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['left_eye'] == 'Attached'){
					left_eye.alpha = 1;
				}else{
					left_eye.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['right_eye'] == 'Attached'){
					right_eye.alpha = 1;
				}else{
					right_eye.alpha = 0;
				}
			}else{
				left_eye.alpha = 0;
				right_eye.alpha = 0;
			}
				
			
			this.addChildAt(left_eye,1);
			this.addChildAt(right_eye,2);
			
			
			CreateHitRightEye();
			CreateHitLeftEye();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
		}
		
		private function CreateHitLeftEye():void{
			hit_leftEye = new Shape();
			hit_leftEye.touchable = false;
			hit_leftEye.graphics.beginFill(0xff0000);
			
			hit_leftEye.graphics.lineTo(99,309);	
			hit_leftEye.graphics.lineTo(113,213);	
			hit_leftEye.graphics.lineTo(258,162);	
			hit_leftEye.graphics.lineTo(351,210);	
			hit_leftEye.graphics.lineTo(361,275);	
			hit_leftEye.graphics.lineTo(325,341);	
			hit_leftEye.graphics.lineTo(190,386);	
			hit_leftEye.graphics.lineTo(132,371);	

			hit_leftEye.graphics.endFill(false);
			hit_leftEye.alpha = 0.0;
			
			hit_leftEye.graphics.precisionHitTest = true;	
			this.addChild(hit_leftEye);
		}
		
		private function CreateHitRightEye():void{
			hit_rightEye = new Shape();
			hit_rightEye.touchable = false;
			hit_rightEye.graphics.beginFill(0xff0000);
			
			hit_rightEye.graphics.lineTo(518,145);	
			hit_rightEye.graphics.lineTo(564,133);	
			hit_rightEye.graphics.lineTo(615,143);	
			hit_rightEye.graphics.lineTo(648,172);	
			hit_rightEye.graphics.lineTo(663,221);	
			hit_rightEye.graphics.lineTo(643,261);	
			hit_rightEye.graphics.lineTo(600,267);	
			hit_rightEye.graphics.lineTo(555,247);	
			hit_rightEye.graphics.lineTo(525,215);	
	
			hit_rightEye.graphics.endFill(false);
			hit_rightEye.alpha = 0.0;
			
			hit_rightEye.graphics.precisionHitTest = true;	
			this.addChild(hit_rightEye);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CoastMoai as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastMoaiObj,true
							);
						}else if(hit_leftEye.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							EyeHandler('left');
						}else if(hit_rightEye.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							EyeHandler('right');
						}
					}
				}
			}
		}
		
		private function EyeHandler(LeftRight:String):void{
			/*LeftRight is left or right*/
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_RedStoneOne)
				
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes[LeftRight+'_eye'] == 'Attached'){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A stone's already been placed in that eye. I should try the other.");
					}else{
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_RedStoneOne,
								"item_RedStoneOne"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes;			
						}
						SaveArray[LeftRight+'_eye'] = 'Attached';
						this[(LeftRight+'_eye')].alpha = 1;
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoaiEyes',SaveArray);
					}
				}else{
					
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_RedStoneOne,
							"item_RedStoneOne"
						);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes;			
					}
					SaveArray[LeftRight+'_eye'] = 'Attached';
					this[(LeftRight+'_eye')].alpha = 1;
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoaiEyes',SaveArray);
				}
			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_RedStoneTwo)
				
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes[LeftRight+'_eye'] == 'Attached'){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A stone's already been placed in that eye. I should try the other.");
					}else{
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
							.InventoryObj.removeItemFromInventory(
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
								.InventoryObj.item_RedStoneTwo,
								"item_RedStoneTwo"
							);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes;			
						}
						SaveArray[LeftRight+'_eye'] = 'Attached';
						this[(LeftRight+'_eye')].alpha = 1;
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoaiEyes',SaveArray);
					}
				}else{
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_RedStoneTwo,
							"item_RedStoneTwo"
						);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes;			
					}
					SaveArray[LeftRight+'_eye'] = 'Attached';
					this[(LeftRight+'_eye')].alpha = 1;
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoaiEyes',SaveArray);
				}
			}else if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					!= 
					false)
			{
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes[LeftRight+'_eye'] == 'Attached'){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A stone which fits has already been placed in the carved eye.");
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't make sense.");
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't fit.");
				}
					
				
			}else{
				if(LeftRight == 'left'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['left_eye'] == 'Attached'){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['right_eye'] == 'Attached'){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The red stones fit snuggly into each eye.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Kinda weird with just one eye... ");
							}
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This eye still needs a pupil... or iris.. not sure.");
						}
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The pupils of the eyes seem to be missing from the face of this stone Moai.");
					}
				}else{
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['right_eye'] == 'Attached'){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['left_eye'] == 'Attached'){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The Moai on Easter Island remain a mystery to anthropologists. I wonder what these are doing here.");
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Kinda weird with just one eye... ");
							}
						}else{
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This eye still needs a pupil... or iris.. not sure.");
						}
					}else{
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are circular holes cut into the eyes of the statue.");
					}
				}
					
				
			}
			Solve();
		}
		
		private function Solve():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['right_eye'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['left_eye'] == 'Attached'){
						Animating = true;
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes;
						}
						SaveArray['Solved'] = 'Yes'; 
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoaiEyes',SaveArray);	
						
						delayedcall = new DelayedCall(function():void{
							Animating = false;
							FadeOut(CoastMoai,(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastMoaiObj,true)
						},2);
						
						
						Starling.juggler.add(delayedcall);
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
			
			
			this.assets.removeTexture("coastMoaiEyes_bg",true);
			this.assets.removeTexture("CoastMoaiEyes_Sprite",true);
			this.assets.removeTextureAtlas("CoastMoaiEyes_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("coastMoaiEyes_01");
			(stage.getChildAt(0) as Object).falseAsset("coastMoaiEyes_02");
			(stage.getChildAt(0) as Object).falseAsset("coastMoaiEyes_03");
			
			
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
