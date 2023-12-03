package screens.ingamescreens
{

	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class CoastCaveCombo extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		public var delayedcall:DelayedCall;
		private var bg:Image;
		
		private var Sec0:MovieClip;
		private var Sec1:MovieClip;
		private var Sec2:MovieClip;
		
		private var hit_Sec0_up:Shape;
		private var hit_Sec0_down:Shape;
		private var hit_Sec1_up:Shape;
		private var hit_Sec1_down:Shape;
		private var hit_Sec2_up:Shape;
		private var hit_Sec2_down:Shape;
		
		private var ThirdAttached:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function CoastCaveCombo(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastCaveCombo_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveCombo/coastCaveCombo_bg.jpg'));
				game.TrackAssets('coastCaveCombo_01');
			}
			if(game.CheckAsset('coastCaveCombo_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveCombo/CoastCaveCombo_Sprite.png'));
				game.TrackAssets('coastCaveCombo_02');
			}
			if(game.CheckAsset('coastCaveCombo_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveCombo/CoastCaveCombo_Sprite.xml'));
				game.TrackAssets('coastCaveCombo_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastCaveCombo","CoastCaveComboObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastCaveCombo_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			Sec0 = new MovieClip(this.assets.getTextures('sec_0_pos_'),6);
			//puller_mc.smoothing = TextureSmoothing.NONE;
			Sec0.x = 86;
			Sec0.y = 64;
			Sec0.touchable = false;
			Sec0.loop = true; // default: trueh
			Sec0.stop();
					
			Sec1 = new MovieClip(this.assets.getTextures('sec_1_pos_'),6);
			//puller_mc.smoothing = TextureSmoothing.NONE;
			Sec1.x = 313;
			Sec1.y = 102;
			Sec1.touchable = false;
			Sec1.loop = true; // default: trueh
			Sec1.stop();
			
			
			Sec2 = new MovieClip(this.assets.getTextures('sec_2_pos_'),6);
			//puller_mc.smoothing = TextureSmoothing.NONE;
			Sec2.x = 525;
			Sec2.y = 133;
			Sec2.touchable = false;
			Sec2.loop = true; // default: trueh
			Sec2.stop();
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Sec0'] != undefined){
					Sec0.currentFrame = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Sec0'];
				}else{
					Sec0.currentFrame = 8;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Sec1'] != undefined){
					Sec1.currentFrame = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Sec1'];
				}else{
					Sec1.currentFrame = 6;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Third'] == 'Attached'){
					ThirdAttached = true;
					Sec2.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Sec2'] != undefined){
						Sec2.currentFrame = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo['Sec2'];
					}else{
						Sec2.currentFrame = 4;
					}
				}else{
					Sec2.alpha = 0;
				}
				
			}else{
				
				Sec0.alpha = 1;
				Sec1.alpha = 1;
				Sec2.alpha = 0;
				
				Sec0.currentFrame = 8;
				Sec1.currentFrame = 6;
				Sec2.currentFrame = 4;
			}
			
		//	Sec0.currentFrame = 8;
		//	Sec1.currentFrame = 6;
		//	Sec2.currentFrame = 4;
			
			this.addChildAt(Sec0,1);
			this.addChildAt(Sec1,2);		
			this.addChildAt(Sec2,3);
			
			CreateSecHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCave['Fire'] == 'Lit'){
					(stage.getChildAt(0) as Object).AmbientObj.LoadBurningFireOne(true,999);
				}else{
					(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
				}
			}else{
				(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			}
		}
		
		private function CreateSecHit():void{
			hit_Sec0_up = new Shape();
			hit_Sec0_up.touchable = false;
			hit_Sec0_up.graphics.beginFill(0x00ff00);
			
			hit_Sec0_up.graphics.lineTo(116,40);	
			hit_Sec0_up.graphics.lineTo(280,65);				
			hit_Sec0_up.graphics.lineTo(254,202);	
			hit_Sec0_up.graphics.lineTo(77,177);
			hit_Sec0_up.graphics.endFill(false);
			
			hit_Sec0_up.alpha = 0.0;
			
			hit_Sec0_up.graphics.precisionHitTest = true;	
			this.addChild(hit_Sec0_up);
			//-------------------
			hit_Sec0_down = new Shape();
			hit_Sec0_down.touchable = false;
			hit_Sec0_down.graphics.beginFill(0xff0000);
			
			hit_Sec0_down.graphics.lineTo(77,177);	
			hit_Sec0_down.graphics.lineTo(254,202);	
			hit_Sec0_down.graphics.lineTo(242,345);	
			hit_Sec0_down.graphics.lineTo(73,328);	
			
			hit_Sec0_down.graphics.endFill(false);
			
			hit_Sec0_down.alpha = 0.0;
			
			hit_Sec0_down.graphics.precisionHitTest = true;	
			this.addChild(hit_Sec0_down);
			//-------------------
			hit_Sec1_up = new Shape();
			hit_Sec1_up.touchable = false;
			hit_Sec1_up.graphics.beginFill(0x00ff00);
			
			hit_Sec1_up.graphics.lineTo(337,74);	
			hit_Sec1_up.graphics.lineTo(498,101);	
			hit_Sec1_up.graphics.lineTo(490,236);	
			hit_Sec1_up.graphics.lineTo(308,208);	
			
			hit_Sec1_up.graphics.endFill(false);
			
			hit_Sec1_up.alpha = 0.0;
			
			hit_Sec1_up.graphics.precisionHitTest = true;	
			this.addChild(hit_Sec1_up);
			//-------------------
			hit_Sec1_down = new Shape();
			hit_Sec1_down.touchable = false;
			hit_Sec1_down.graphics.beginFill(0xff0000);
			
			hit_Sec1_down.graphics.lineTo(308,208);
			hit_Sec1_down.graphics.lineTo(490,236);	
			hit_Sec1_down.graphics.lineTo(461,371);	
			hit_Sec1_down.graphics.lineTo(288,347);	
			
			hit_Sec1_down.graphics.endFill(false);
			
			hit_Sec1_down.alpha = 0.0;
			
			hit_Sec1_down.graphics.precisionHitTest = true;	
			this.addChild(hit_Sec1_down);
			//-------------------
			hit_Sec2_up = new Shape();
			hit_Sec2_up.touchable = false;
			hit_Sec2_up.graphics.beginFill(0x00ff00);
			
			hit_Sec2_up.graphics.lineTo(542,106);	
			hit_Sec2_up.graphics.lineTo(705,127);	
			hit_Sec2_up.graphics.lineTo(708,269);	
			hit_Sec2_up.graphics.lineTo(534,246);	
			
			hit_Sec2_up.graphics.endFill(false);
			
			hit_Sec2_up.alpha = 0.0;
			
			hit_Sec2_up.graphics.precisionHitTest = true;	
			this.addChild(hit_Sec2_up);
			//-------------------
			hit_Sec2_down = new Shape();
			hit_Sec2_down.touchable = false;
			hit_Sec2_down.graphics.beginFill(0xff0000);
			
			hit_Sec2_down.graphics.lineTo(534,246);	
			hit_Sec2_down.graphics.lineTo(708,269);	
			hit_Sec2_down.graphics.lineTo(668,397);	
			hit_Sec2_down.graphics.lineTo(506,376);	
			
			hit_Sec2_down.graphics.endFill(false);
			
			hit_Sec2_down.alpha = 0.0;
			
			hit_Sec2_down.graphics.precisionHitTest = true;	
			this.addChild(hit_Sec2_down);
			//-------------------
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
							FadeOut((CoastCaveDoor as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveDoorObj,true
							);
						}else if(hit_Sec0_up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SectionHandler(0,false);
						}else if(hit_Sec0_down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
							SectionHandler(0,true);
						}else if(hit_Sec1_up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							SectionHandler(1,false);
						}else if(hit_Sec1_down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
							SectionHandler(1,true);
						}else if(hit_Sec2_up.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ThirdAttached === true){
								SectionHandler(2,false);
							}else{
								ThirdHandler();
							}
						}else if(hit_Sec2_down.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){	
							if(ThirdAttached === true){
								SectionHandler(2,true);
							}else{
								ThirdHandler();
							}
						}
					}
				}
			}
		}
		
		private function SectionHandler(Sec:int,dir:Boolean):void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
				if(dir === true){
					if(this[('Sec'+Sec)].currentFrame == 0){
						this[('Sec'+Sec)].currentFrame = this[('Sec'+Sec)].numFrames-1;
					}else{
						this[('Sec'+Sec)].currentFrame = this[('Sec'+Sec)].currentFrame-1;
					}
						
				}else{
					if(this[('Sec'+Sec)].currentFrame == this[('Sec'+Sec)].numFrames-1){
						this[('Sec'+Sec)].currentFrame = 0;
					}else{
						this[('Sec'+Sec)].currentFrame = this[('Sec'+Sec)].currentFrame+1;
					}
				}
				trace('Sec'+Sec+':');
				trace(this[('Sec'+Sec)].currentFrame);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo;
				}
				SaveArray['Sec'+Sec] = ((this[('Sec'+Sec)].currentFrame) as int);
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveCombo',SaveArray);
				
				Solve();
		}
		
		private function ThirdHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_PirateDisc)
			{
			
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_PirateDisc,
						"item_PirateDisc"
					);
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();
				Sec2.alpha = 1;
				ThirdAttached = true;
				Sec2.currentFrame = 4;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo
				}
				SaveArray['Third'] = 'Attached';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveCombo',SaveArray);
				
				Solve();
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There is an empty slot for another rotating disc.");
			}
		}
		
		private function Solve():void{
			//Sec0.currentFrame = 8;
			//Sec1.currentFrame = 6;
			//Sec2.currentFrame = 4;
			if(Sec0.currentFrame == 5){
				if(Sec1.currentFrame == 1){
					if(Sec2.currentFrame == 3){
						trace("SOLVE!!!!");
					
						Animating = true;
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
						
						
						trace("Solved");
						delayedcall = new DelayedCall(function():void{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_GearsThree();

							Animating = false;
							FadeOut(CoastCave,(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveObj,true)
						},2);
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastCaveCombo;
						}
						SaveArray['Solved'] = 'Yes'; 
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastCaveCombo',SaveArray);	
						
						
						Starling.juggler.add(delayedcall);

						
					}else{
						trace("FAIL ON SEC 2");
					}
				}else{
					trace("FAIL ON SEC 1");
				}
			}else{
				trace("FAIL ON SEC 0");
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
			
			
			this.assets.removeTexture("coastCaveCombo_bg",true);
			this.assets.removeTexture("CoastCaveCombo_Sprite",true);
			this.assets.removeTextureAtlas("CoastCaveCombo_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("coastCaveCombo_01");
			(stage.getChildAt(0) as Object).falseAsset("coastCaveCombo_02");
			(stage.getChildAt(0) as Object).falseAsset("coastCaveCombo_03");
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