package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class MountainTemple extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var dragonBall:Image;
		
		private var hit_TempleTunnel:Shape;
		private var hit_Ledge:Shape;
		
		private var hit_rockOne:Shape;
		private var hit_rockTwo:Shape;
		private var hit_sky:Shape;
		private var hit_ground:Shape;
		private var hit_mountain:Shape;
		
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;	
				
		
		public function MountainTemple(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('mountainTemple_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainTemple/mountainTemple_bg.jpg'));
				game.TrackAssets('mountainTemple_01');
			}
			if(game.CheckAsset('mountainTemple_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainTemple/MountainTemple_Sprite.png'));
				game.TrackAssets('mountainTemple_02');
			}
			if(game.CheckAsset('mountainTemple_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainTemple/MountainTemple_Sprite.xml'));
				game.TrackAssets('mountainTemple_03');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("MountainTemple","MountainTempleObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('mountainTemple_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			dragonBall = new Image(this.assets.getTexture('ledge_dragonball'));
			dragonBall.touchable = false;
			dragonBall.x = 668;
			dragonBall.y = 245;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainLedge['DragonBall'] == 'PickedUp'){
					dragonBall.alpha = 0;
				}else{
					dragonBall.alpha = 1;
				}
			}else{
				dragonBall.alpha = 1;
			}
			

			
			
			this.addChildAt(dragonBall,1);
			CreateHitMountain();
			CreateHitGround();
			CreateHitSky();
			CreateHitRockTwo();
			CreateHitRockOne();
			
			
			CreateHitLedge();
			CreateHitTempleTunnel();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,0.5,'stop');

			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			
		}
	//hit_mountain
		
		private function CreateHitMountain():void{
			hit_mountain = new Shape();
			hit_mountain.touchable = false;
			hit_mountain.graphics.beginFill(0xff0000);
			
			hit_mountain.graphics.lineTo(430,202);									
			hit_mountain.graphics.lineTo(476,149);									
			hit_mountain.graphics.lineTo(586,235);									
			hit_mountain.graphics.lineTo(515,309);									
											
		
			hit_mountain.graphics.endFill(false);
			hit_mountain.alpha = 0.0;
			
			hit_mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_mountain);
		}
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(95,360);									
			hit_ground.graphics.lineTo(528,360);									
			hit_ground.graphics.lineTo(558,504);									
			hit_ground.graphics.lineTo(88,502);									
			
			
			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitSky():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(363,0);									
			hit_sky.graphics.lineTo(649,0);									
			hit_sky.graphics.lineTo(800,122);									
			hit_sky.graphics.lineTo(793,271);									
			hit_sky.graphics.lineTo(478,148);									
									
			
			hit_sky.graphics.endFill(false);
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}

		
		private function CreateHitRockTwo():void{
			hit_rockTwo = new Shape();
			hit_rockTwo.touchable = false;
			hit_rockTwo.graphics.beginFill(0xff0000);
			
			hit_rockTwo.graphics.lineTo(0,222);									
			hit_rockTwo.graphics.lineTo(459,268);									
			hit_rockTwo.graphics.lineTo(502,334);									
			hit_rockTwo.graphics.lineTo(438,375);									
			hit_rockTwo.graphics.lineTo(0,336);									
			
			hit_rockTwo.graphics.endFill(false);
			hit_rockTwo.alpha = 0.0;
			
			hit_rockTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_rockTwo);
		}
		
		private function CreateHitRockOne():void{
			hit_rockOne = new Shape();
			hit_rockOne.touchable = false;
			hit_rockOne.graphics.beginFill(0xff0000);
			
			hit_rockOne.graphics.lineTo(0,92);									
			hit_rockOne.graphics.lineTo(143,0);									
			hit_rockOne.graphics.lineTo(329,0);									
			hit_rockOne.graphics.lineTo(419,81);									
			hit_rockOne.graphics.lineTo(436,273);									
			hit_rockOne.graphics.lineTo(436,273);									
			hit_rockOne.graphics.lineTo(0,204);									
									
			hit_rockOne.graphics.endFill(false);
			hit_rockOne.alpha = 0.0;
			
			hit_rockOne.graphics.precisionHitTest = true;	
			this.addChild(hit_rockOne);
		}
		
		private function CreateHitTempleTunnel():void{
			hit_TempleTunnel = new Shape();
			hit_TempleTunnel.touchable = false;
			hit_TempleTunnel.graphics.beginFill(0xff0000);
			
			hit_TempleTunnel.graphics.lineTo(87,255);									
			hit_TempleTunnel.graphics.lineTo(240,124);									
			hit_TempleTunnel.graphics.lineTo(286,138);									
			hit_TempleTunnel.graphics.lineTo(341,318);									
			hit_TempleTunnel.graphics.lineTo(295,376);									
			hit_TempleTunnel.graphics.lineTo(135,366);									
			hit_TempleTunnel.graphics.endFill(false);
			hit_TempleTunnel.alpha = 0.0;
			
			hit_TempleTunnel.graphics.precisionHitTest = true;	
			this.addChild(hit_TempleTunnel);
		}
		
		private function CreateHitLedge():void{
			hit_Ledge = new Shape();
			hit_Ledge.touchable = false;
			hit_Ledge.graphics.beginFill(0xff0000);
			
			hit_Ledge.graphics.lineTo(515,280);									
			hit_Ledge.graphics.lineTo(642,220);									
			hit_Ledge.graphics.lineTo(714,213);									
			hit_Ledge.graphics.lineTo(753,330);									
			hit_Ledge.graphics.lineTo(555,419);									
			hit_Ledge.graphics.endFill(false);
			hit_Ledge.alpha = 0.0;
			
			hit_Ledge.graphics.precisionHitTest = true;	
			this.addChild(hit_Ledge);
		}
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleHouses as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleHousesObj,true
						);
						
					}else if(hit_TempleTunnel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((TempleTunnel as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.TempleTunnelObj,true
						);	
					}else if(hit_Ledge.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((MountainLedge as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainLedgeObj,true
						);	
					}else if(hit_rockOne.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The mouth of the cave is covered in geometric patterns.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shapes spread through the rock as though they were alive.");

						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The site of the cave sends a shiver down my spine.");

						}
					
					}else if(hit_rockTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(PhraseCounter == 0){
							PhraseCounter = 1;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Thousand of round growths surround the cave.");
						}else if(PhraseCounter == 1){
							PhraseCounter = 2;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The round shapes are also composed of stone.");
							
						}else if(PhraseCounter == 2){
							PhraseCounter = 0;
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What is the origin of this thing?");
							
						}
						
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A steady wind pulls at the clouds.");
						
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ground is marked with fissures and burn marks.");
						
					}else if(hit_mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A slope of the mountain rises in the distance.");
						
					}
					/*
					
					private var hit_rockOne:Shape;
					private var hit_rockTwo:Shape;
					private var hit_sky:Shape;
					hit_ground
					*/
					
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
			
			
			this.assets.removeTexture("mountainTemple_bg",true);
			this.assets.removeTexture("MountainTemple_Sprite",true);
			this.assets.removeTextureAtlas("MountainTemple_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("mountainTemple_01");
			(stage.getChildAt(0) as Object).falseAsset("mountainTemple_02");
			(stage.getChildAt(0) as Object).falseAsset("mountainTemple_03");
			// stage.getChildAt(0) as Object).falseAsset("coastSurf_02");
			
			if(blackOut === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.BlackOutRectangleFade(0,0.5);
			}
			(stage.getChildAt(0) as Object).screenGamePlayHandler.
				UnloadScene(
					
				);			
			
			this.dispose();
			
		}
		
	}
}

