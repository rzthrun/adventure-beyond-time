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
	
	
	
	public class JungleDeep extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var bananas:Image;
		
		private var hit_MountainSide:Shape;
		private var hit_JungleViking:Shape;
		private var hit_JungleCliff:Shape;
		private var hit_Bananas:Shape;
		
		private var hit_rocks:Shape;
		private var hit_tree:Shape;
		private var hit_ground:Shape;
		private var hit_forest:Shape;
		private var hit_groundTwo:Shape;
		private var hit_fern:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;	
		
		public function JungleDeep(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleDeep_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleDeep/jungleDeep_bg.jpg'));
				game.TrackAssets('jungleDeep_01');
			}
			if(game.CheckAsset('jungleDeep_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleDeep/JungleDeep_Sprite.png'));
				game.TrackAssets('jungleDeep_02');
			}
			if(game.CheckAsset('jungleDeep_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleDeep/JungleDeep_Sprite.xml'));
				game.TrackAssets('jungleDeep_03');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleDeep","JungleDeepObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleDeep_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			bananas = new Image(this.assets.getTexture('banana_banana'));
			bananas.touchable = false;
			bananas.x = 427;
			bananas.y = 84;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleBananas['Bananas'] == 'PickedUp'){
					bananas.alpha = 0;
				}
				else{
					bananas.alpha = 1;
				}
			}else{
				bananas.alpha = 1;
			}
			
			this.addChildAt(bananas,1);
			CreateHitForest();
			CreateHitTree();
			CreateHitRocks();
			CreateHitFern();
			CreateHitGroundTwo();
			CreateHitGround();
			CreateHitMountainSide();
			CreateHitJungleViking();
			CreateHitJungleCliff();
			CreateHitBananas();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waterfall",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999,2);
			},0.7);
			(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleDeep != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleDeep['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleDeep;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleDeep',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleDeep',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadPainPitch(true,3);
					},0.5);
				}
			}
			
		}
		// hit_JungleViking
		//hit_JungleCliff
		//hit_rocks
		//hit_ground
		//hit_forest
		//hit_groundTwo
		//hit_fern
		private function CreateHitFern():void{
			hit_fern = new Shape();
			hit_fern.touchable = false;
			hit_fern.graphics.beginFill(0xff0000);
			
			hit_fern.graphics.lineTo(43,238);									
			hit_fern.graphics.lineTo(111,283);									
			hit_fern.graphics.lineTo(136,368);									
			hit_fern.graphics.lineTo(201,384);									
			hit_fern.graphics.lineTo(226,464);									
			hit_fern.graphics.lineTo(96,497);									
		
			hit_fern.alpha = 0.0;
			
			hit_fern.graphics.precisionHitTest = true;	
			this.addChild(hit_fern);
		}
		
		private function CreateHitGroundTwo():void{
			hit_groundTwo = new Shape();
			hit_groundTwo.touchable = false;
			hit_groundTwo.graphics.beginFill(0xff0000);
			
			hit_groundTwo.graphics.lineTo(316,58);									
			hit_groundTwo.graphics.lineTo(313,318);									
			hit_groundTwo.graphics.lineTo(676,352);									
			hit_groundTwo.graphics.lineTo(657,451);									
			hit_groundTwo.graphics.lineTo(322,362);									
			
			hit_groundTwo.alpha = 0.0;
			
			hit_groundTwo.graphics.precisionHitTest = true;	
			this.addChild(hit_groundTwo);
		}
		
		private function CreateHitForest():void{
			hit_forest = new Shape();
			hit_forest.touchable = false;
			hit_forest.graphics.beginFill(0xff0000);
			
			hit_forest.graphics.lineTo(78,0);									
			hit_forest.graphics.lineTo(656,0);									
			hit_forest.graphics.lineTo(712,339);									
			hit_forest.graphics.lineTo(230,282);									
			
			hit_forest.alpha = 0.0;
			
			hit_forest.graphics.precisionHitTest = true;	
			this.addChild(hit_forest);
		}
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(211,389);									
			hit_ground.graphics.lineTo(316,366);									
			hit_ground.graphics.lineTo(575,446);									
			hit_ground.graphics.lineTo(580,506);									
			hit_ground.graphics.lineTo(255,504);									
		
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitTree():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(427,192);									
			hit_tree.graphics.lineTo(498,190);									
			hit_tree.graphics.lineTo(514,328);									
			hit_tree.graphics.lineTo(434,325);									
			
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		
		
		private function CreateHitRocks():void{
			hit_rocks = new Shape();
			hit_rocks.touchable = false;
			hit_rocks.graphics.beginFill(0xff0000);
			
			hit_rocks.graphics.lineTo(125,286);									
			hit_rocks.graphics.lineTo(226,287);									
			hit_rocks.graphics.lineTo(308,314);									
			hit_rocks.graphics.lineTo(323,380);									
			hit_rocks.graphics.lineTo(145,365);									
													
			hit_rocks.alpha = 0.0;
			
			hit_rocks.graphics.precisionHitTest = true;	
			this.addChild(hit_rocks);
		}
		
		
		private function CreateHitBananas():void{
			hit_Bananas = new Shape();
			hit_Bananas.touchable = false;
			hit_Bananas.graphics.beginFill(0xff0000);
			
			hit_Bananas.graphics.lineTo(386,55);									
			hit_Bananas.graphics.lineTo(453,44);									
			hit_Bananas.graphics.lineTo(528,81);									
			hit_Bananas.graphics.lineTo(526,153);									
			hit_Bananas.graphics.lineTo(480,189);									
			hit_Bananas.graphics.lineTo(443,191);									
			hit_Bananas.graphics.lineTo(396,149);									

			hit_Bananas.alpha = 0.0;
			
			hit_Bananas.graphics.precisionHitTest = true;	
			this.addChild(hit_Bananas);
		}
		
		private function CreateHitJungleCliff():void{
			hit_JungleCliff = new Shape();
			hit_JungleCliff.touchable = false;
			hit_JungleCliff.graphics.beginFill(0xff0000);
			
			hit_JungleCliff.graphics.lineTo(571,71);									
			hit_JungleCliff.graphics.lineTo(650,72);									
			hit_JungleCliff.graphics.lineTo(730,122);									
			hit_JungleCliff.graphics.lineTo(756,296);									
			hit_JungleCliff.graphics.lineTo(673,350);									
			hit_JungleCliff.graphics.lineTo(574,332);									
			hit_JungleCliff.graphics.lineTo(570,235);									
			
			hit_JungleCliff.alpha = 0.0;
			
			hit_JungleCliff.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleCliff);
		}
		
		private function CreateHitMountainSide():void{
			hit_MountainSide = new Shape();
			hit_MountainSide.touchable = false;
			hit_MountainSide.graphics.beginFill(0xff0000);
			
			hit_MountainSide.graphics.lineTo(241,100);									
			hit_MountainSide.graphics.lineTo(353,122);									
			hit_MountainSide.graphics.lineTo(356,156);									
			hit_MountainSide.graphics.lineTo(386,172);									
			hit_MountainSide.graphics.lineTo(380,297);									
			hit_MountainSide.graphics.lineTo(370,318);									
			hit_MountainSide.graphics.lineTo(268,315);									
			hit_MountainSide.graphics.lineTo(228,275);									
			hit_MountainSide.graphics.lineTo(242,227);									
		
			
			hit_MountainSide.alpha = 0.0;
			
			hit_MountainSide.graphics.precisionHitTest = true;	
			this.addChild(hit_MountainSide);
		}
		
		private function CreateHitJungleViking():void{
			hit_JungleViking = new Shape();
			hit_JungleViking.touchable = false;
			hit_JungleViking.graphics.beginFill(0xff0000);
			
			hit_JungleViking.graphics.lineTo(65,74);				
			hit_JungleViking.graphics.lineTo(203,70);				
			hit_JungleViking.graphics.lineTo(234,96);				
			hit_JungleViking.graphics.lineTo(239,225);				
			hit_JungleViking.graphics.lineTo(223,278);				
			hit_JungleViking.graphics.lineTo(117,278);				
			hit_JungleViking.graphics.lineTo(48,230);				
		
			hit_JungleViking.alpha = 0.0;
			
			hit_JungleViking.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleViking);
		}
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Jungle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleObj,true
						);
					
					}else if(hit_MountainSide.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleJunk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleJunkObj,true
						);
					}else if(hit_JungleViking.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleViking as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleVikingObj,true
						);
					}else if(hit_JungleCliff.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FarCoastCliff as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastCliffObj,true
						);
					}else if(hit_Bananas.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleBananas as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleBananasObj,true
						);
					}else if(hit_rocks.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These rocks must have rolled down from higher up on the hill.");
					}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleBananas as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleBananasObj,true
						);
						
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The terrain shows evidence of recent mudslides.");
					}else if(hit_groundTwo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Boulders and mud mix amongst the leaves and plants.");
					}else if(hit_fern.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A fern with unusual leaves... another plant I do not recognize");
					}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Tall trees rise upward, forming a dense canopy, blocking out most of the light.");
					}
					
					/*
					hit_groundTwo
					private var hit_rocks:Shape;
					private var hit_tree:Shape;
					private var hit_ground:Shape;
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
			
			
			this.assets.removeTexture("jungleDeep_bg",true);
			this.assets.removeTexture("JungleDeep_Sprite",true);
			this.assets.removeTextureAtlas("JungleDeep_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleDeep_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleDeep_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleDeep_03");
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


