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
	
	public class FreighterOil extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var flow:Image;
		private var cap:Image;
		
		private var hit_barrel_cap:Shape;
		private var hit_barrel_one:Shape;
		private var hit_barrel_two:Shape;
		private var hit_barrel_three:Shape;
		private var hit_ladder:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var flowTween:Tween;
		
		
		private var Animating:Boolean = false;	
		private var CapOff:Boolean = false;
		
		private var goback:GoBackButton;
		
		public function FreighterOil(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterOil_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterOil/freighterOil_bg.jpg'));
				game.TrackAssets('freighterOil_01');
			}
			if(game.CheckAsset('freighterOil_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterOil/FreighterOil_Sprite.png'));
				game.TrackAssets('freighterOil_02');
			}
			if(game.CheckAsset('freighterOil_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterOil/FreighterOil_Sprite.xml'));
				game.TrackAssets('freighterOil_03');
			}
			//FreighterOil_Sprite
			//	if(game.CheckAsset('coast_02') === false){
			//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Coast/Coast_SpriteSheet.xml'));
			//		game.TrackAssets('coast_02');
			//	}
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterOil","FreighterOilObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('freighterOil_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			flow = new Image(this.assets.getTexture('flow'));
			flow.touchable = false;
			flow.x = 499;
			flow.y = 239;
			
			
			cap = new Image(this.assets.getTexture('o_cap'));
			cap.touchable = false;
			cap.x = 504;
			cap.y = 233;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil['Cap'] = 'off'){
					cap.alpha = 0;
					CapOff = true;
				}else{
					cap.alpha = 1;
				}
			}else{
				cap.alpha = 1;
			}
			
			
			flow.alpha = 0;
			
			this.addChildAt(flow,1);
			this.addChildAt(cap,2);
			
			/*
			private var bg:Image;
			private var flow:Image;
			private var cap:Image;
			*/
			CreateHitBarrelThree();
			CreateHitBarrelTwo();
			CreateHitBarrelOne();
			CreateHitLadder();
			CreateHitBarrelCap();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipGroansOne(true,1);
		}
	/*
		private var hit_barrel_cap:Shape;
		private var hit_barrel_one:Shape;
		private var hit_barrel_two:Shape;
		private var hit_barrel_three:Shape;
		private var hit_ladder:Shape;
		*/
		private function CreateHitLadder():void{
			hit_ladder = new Shape();
			hit_ladder.touchable = false;
			hit_ladder.graphics.beginFill(0x00ff00);
			
			hit_ladder.graphics.lineTo(188,339);	
			hit_ladder.graphics.lineTo(468,336);	
			hit_ladder.graphics.lineTo(479,476);	
			hit_ladder.graphics.lineTo(183,477);	
			
			hit_ladder.graphics.endFill(false);
			hit_ladder.alpha = 0.0;
			
			hit_ladder.graphics.precisionHitTest = true;	
			this.addChild(hit_ladder);
			
		}
		private function CreateHitBarrelThree():void{
			hit_barrel_three = new Shape();
			hit_barrel_three.touchable = false;
			hit_barrel_three.graphics.beginFill(0x00ff00);
			
			hit_barrel_three.graphics.lineTo(466,309);	
			hit_barrel_three.graphics.lineTo(545,179);	
			hit_barrel_three.graphics.lineTo(681,192);	
			hit_barrel_three.graphics.lineTo(732,314);	
			hit_barrel_three.graphics.lineTo(605,440);	
			hit_barrel_three.graphics.lineTo(492,367);	
			
			hit_barrel_three.graphics.endFill(false);
			hit_barrel_three.alpha = 0.0;
			
			hit_barrel_three.graphics.precisionHitTest = true;	
			this.addChild(hit_barrel_three);
			
		}
		
		private function CreateHitBarrelTwo():void{
			hit_barrel_two = new Shape();
			hit_barrel_two.touchable = false;
			hit_barrel_two.graphics.beginFill(0x00ff00);
			
			hit_barrel_two.graphics.lineTo(0,154);	
			hit_barrel_two.graphics.lineTo(214,199);	
			hit_barrel_two.graphics.lineTo(266,280);	
			hit_barrel_two.graphics.lineTo(241,360);	
			hit_barrel_two.graphics.lineTo(75,441);	
			hit_barrel_two.graphics.lineTo(0,441);	
			
			hit_barrel_two.graphics.endFill(false);
			hit_barrel_two.alpha = 0.0;
			
			hit_barrel_two.graphics.precisionHitTest = true;	
			this.addChild(hit_barrel_two);
			
		}
		
		private function CreateHitBarrelOne():void{
			hit_barrel_one = new Shape();
			hit_barrel_one.touchable = false;
			hit_barrel_one.graphics.beginFill(0x00ff00);
			
			hit_barrel_one.graphics.lineTo(233,57);	
			hit_barrel_one.graphics.lineTo(436,71);	
			hit_barrel_one.graphics.lineTo(422,360);	
			hit_barrel_one.graphics.lineTo(243,364);	
			
			hit_barrel_one.graphics.endFill(false);
			hit_barrel_one.alpha = 0.0;
			
			hit_barrel_one.graphics.precisionHitTest = true;	
			this.addChild(hit_barrel_one);
			
		}
		
		private function CreateHitBarrelCap():void{
			hit_barrel_cap = new Shape();
			hit_barrel_cap.touchable = false;
			hit_barrel_cap.graphics.beginFill(0x00ff00);
			
			hit_barrel_cap.graphics.lineTo(454,254);	
			hit_barrel_cap.graphics.lineTo(472,215);	
			hit_barrel_cap.graphics.lineTo(568,207);	
			hit_barrel_cap.graphics.lineTo(593,292);	
			hit_barrel_cap.graphics.lineTo(511,332);	

			hit_barrel_cap.graphics.endFill(false);
			hit_barrel_cap.alpha = 0.0;
			
			hit_barrel_cap.graphics.precisionHitTest = true;	
			this.addChild(hit_barrel_cap);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
			
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							
							FadeOut((FreighterLower as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterLowerObj,true
							);
						}else if(hit_barrel_cap.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							BarrelCapHandler();
						}else if(hit_ladder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							
							FadeOut((FreighterLower as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterLowerObj,true
							);;
						}else if(hit_barrel_one.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hancock Gasoline...");
							//	(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BarrelKickLight();
						}else if(hit_barrel_two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The barrel is empty.");
							//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BarrelKickLight();
						}else if(hit_barrel_three.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(CapOff === true){
							//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
							}else{
							//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's something in this barrel...");
							}
						}
						
						/*
						private var hit_barrel_cap:Shape;
						private var hit_barrel_one:Shape;
						private var hit_barrel_two:Shape;
						private var hit_barrel_three:Shape;
						private var hit_ladder:Shape;
						*/
					
					}
				}
			}
		}
		
		private function BarrelCapHandler():void{
			if(CapOff === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterFlow();
				Animating = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil;
				}
				SaveArray['Cap'] = "off";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterOil',SaveArray);
				cap.alpha = 0;
				CapOff = true;
				flowTween = new Tween(flow, 2.5, Transitions.LINEAR);
				flowTween.fadeTo(1);
				flowTween.onComplete = function():void{
					FadeFlowOut();
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
				};
				
				Starling.juggler.add(flowTween);
				
				
				
			}else{
				if((stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.armedItem
					== 
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
					.InventoryObj.inventoryBarObj
					.item_BlowTorch)
					
				{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WaterPour();
					trace("Cannon Torch is Armed");
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.ChangeInventoryItem(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_BlowTorchLit,
						'item_BlowTorchLit',
						'inven_blowtorchLit_sm',
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_BlowTorch,
						'item_BlowTorch'
					);
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterOil;
					}
					SaveArray['BlowTorchLit'] = "Yes";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterOil',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
						//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
					},1.5);
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The barrel is filled with refined gasoline.");
				}
			}
		}
		
		private function FadeFlowOut():void{
			
			flowTween = new Tween(flow, 2.5, Transitions.LINEAR);
			flowTween.fadeTo(0);
			flowTween.onComplete = function():void{
				Starling.juggler.purge();
				Animating = false;
			};
			
			Starling.juggler.add(flowTween);
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
			
			
			this.assets.removeTexture("freighterOil_bg",true);
			this.assets.removeTexture("FreighterOil_Sprite",true);
			this.assets.removeTextureAtlas("FreighterOil_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterOil_01");
			(stage.getChildAt(0) as Object).falseAsset("freighterOil_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterOil_03");
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