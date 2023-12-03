package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class CoastCaveExterior extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var shell:Image;
		private var hit_CoastSkeleton:Shape;
		private var hit_CoastCave:Shape;
		
		private var hit_shore:Shape;
		private var hit_rockCoast:Shape;
		private var hit_tree:Shape;
		private var hit_rockwall:Shape;

		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public function CoastCaveExterior(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastCaveExterior_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveExterior/coastCaveExterior_bg.jpg'));
				game.TrackAssets('coastCaveExterior_01');
			}
			if(game.CheckAsset('coastCaveExterior_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveExterior/CoastCaveExterior_Sprite.png'));
				game.TrackAssets('coastCaveExterior_02');
			}
			if(game.CheckAsset('coastCaveExterior_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCaveExterior/CoastCaveExterior_Sprite.xml'));
				game.TrackAssets('coastCaveExterior_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastCaveExterior","CoastCaveExteriorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastCaveExterior_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			shell  = new Image(this.assets.getTexture('skeleton_shell'));
			shell.touchable = false;
			shell.x = 88;
			shell.y = 299;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton != undefined){			
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastSkeleton["Shell"] == "PickedUp"){
					shell.alpha = 0;
				}else{
					shell.alpha = 1;
				}
			}else{
				shell.alpha = 1;
			}
			
			this.addChildAt(shell,1);
			//FadeOutOcean(1);
			
			
			CreateHitCoastSkeleton();
			CreateHitCoastCave();
			
			CreateHitTrees();
			CreateHitRockWall();
			CreateHitRockCoast();
			CreateHitShore();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BurningFireOne",0,0.5,'stop');
		}
		
		
		
		private function CreateHitShore():void{
			hit_shore = new Shape();
			hit_shore.touchable = false;
			hit_shore.graphics.beginFill(0xff0000);
			
			hit_shore.graphics.lineTo(268,418);	
			hit_shore.graphics.lineTo(343,389);	
			hit_shore.graphics.lineTo(628,414);	
			hit_shore.graphics.lineTo(606,510);	
			hit_shore.graphics.lineTo(370,508);	

			hit_shore.alpha = 0.0;
			
			hit_shore.graphics.precisionHitTest = true;	
			this.addChild(hit_shore);
		}
		
		private function CreateHitRockCoast():void{
			hit_rockCoast = new Shape();
			hit_rockCoast.touchable = false;
			hit_rockCoast.graphics.beginFill(0xff0000);
			
			hit_rockCoast.graphics.lineTo(451,162);	
			hit_rockCoast.graphics.lineTo(552,156);	
			hit_rockCoast.graphics.lineTo(691,279);	
			hit_rockCoast.graphics.lineTo(741,380);	
			hit_rockCoast.graphics.lineTo(526,391);	
			hit_rockCoast.graphics.lineTo(506,264);	
	
			hit_rockCoast.alpha = 0.0;
			
			hit_rockCoast.graphics.precisionHitTest = true;	
			this.addChild(hit_rockCoast);
		}
		
		
		private function CreateHitTrees():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(0,0);	
			hit_tree.graphics.lineTo(415,0);	
			hit_tree.graphics.lineTo(525,72);	
			hit_tree.graphics.lineTo(488,138);	
			hit_tree.graphics.lineTo(232,76);	
			hit_tree.graphics.lineTo(0,61);	
		
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function CreateHitRockWall():void{
			hit_rockwall = new Shape();
			hit_rockwall.touchable = false;
			hit_rockwall.graphics.beginFill(0xff0000);
			
			hit_rockwall.graphics.lineTo(0,89);	
			hit_rockwall.graphics.lineTo(230,89);	
			hit_rockwall.graphics.lineTo(311,138);	
			hit_rockwall.graphics.lineTo(271,212);	
			hit_rockwall.graphics.lineTo(0,207);	

	
			hit_rockwall.alpha = 0.0;
			
			hit_rockwall.graphics.precisionHitTest = true;	
			this.addChild(hit_rockwall);
		}
		private function CreateHitCoastCave():void{
			hit_CoastCave = new Shape();
			hit_CoastCave.touchable = false;
			hit_CoastCave.graphics.beginFill(0xff0000);
			
			hit_CoastCave.graphics.lineTo(256,290);	
			hit_CoastCave.graphics.lineTo(318,152);	
			hit_CoastCave.graphics.lineTo(443,163);	
			hit_CoastCave.graphics.lineTo(494,265);	
			hit_CoastCave.graphics.lineTo(510,360);	
			hit_CoastCave.graphics.lineTo(446,382);	
			hit_CoastCave.graphics.lineTo(330,372);	
			hit_CoastCave.graphics.lineTo(279,343);	

	
			
			hit_CoastCave.alpha = 0.0;
			
			hit_CoastCave.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastCave);
		}
		
		private function CreateHitCoastSkeleton():void{
			hit_CoastSkeleton = new Shape();
			hit_CoastSkeleton.touchable = false;
			hit_CoastSkeleton.graphics.beginFill(0xff0000);
			
			hit_CoastSkeleton.graphics.lineTo(0,244);	
			hit_CoastSkeleton.graphics.lineTo(32,215);	
			hit_CoastSkeleton.graphics.lineTo(196,219);	
			hit_CoastSkeleton.graphics.lineTo(232,262);	
			hit_CoastSkeleton.graphics.lineTo(225,344);	
			hit_CoastSkeleton.graphics.lineTo(131,375);	
			hit_CoastSkeleton.graphics.lineTo(0,314);	

			
			hit_CoastSkeleton.alpha = 0.0;

			hit_CoastSkeleton.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastSkeleton);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CoastCorner as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCornerObj,true
						);
					}else if(hit_CoastSkeleton.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastSkeleton as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastSkeletonObj,true
						);
					}
					else if(hit_CoastCave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastCave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveObj,false
						);
					}
					else if(hit_shore.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sand is coarse with many rocks and pebbles.");

					}	
					else if(hit_rockCoast.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The rocks are steap and wet... I can't go that way.");

					}
					else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The forest continues above the ledge.");

					}
					else if(hit_rockwall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's no way I can climb that.");

					}
					/*
					private var hit_shore:Shape;
					private var hit_rockCoast:Shape;
					private var hit_tree:Shape;
					private var hit_rockwall:Shape;
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
			
			
			this.assets.removeTexture("coastCaveExterior_bg",true);
			this.assets.removeTexture("CoastCaveExterior_Sprite",true);
			this.assets.removeTextureAtlas("CoastSurf_SpriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("coastCaveExterior_01");
			(stage.getChildAt(0) as Object).falseAsset("coastCaveExterior_02");
			(stage.getChildAt(0) as Object).falseAsset("coastCaveExterior_03");
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