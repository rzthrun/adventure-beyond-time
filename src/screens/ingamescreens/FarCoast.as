package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class FarCoast extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var helmut:Image;
		private var ladder:Image;
		private var door:Image;
		
		
		private var hit_JungleSubmarine:Shape;
		private var hit_FarCoastDingy:Shape;
		private var hit_FarCoastCorner:Shape;
		
		private var hit_mountain:Shape;
		private var hit_water:Shape;
		private var hit_trees:Shape;
		private var hit_sky:Shape;
		private var hit_sand:Shape
		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		//private var goback:GoBackButton;		
		
		public function FarCoast(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('farCoast_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoast/farCoast_bg.jpg'));
				game.TrackAssets('farCoast_01');
			}
			if(game.CheckAsset('farCoast_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoast/FarCoast_Sprite.png'));
				game.TrackAssets('farCoast_02');
			}
			if(game.CheckAsset('farCoast_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FarCoast/FarCoast_Sprite.xml'));
				game.TrackAssets('farCoast_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FarCoast","FarCoastObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('farCoast_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			helmut = new Image(this.assets.getTexture('digny_helmet_led'));
			helmut.touchable = false;
			helmut.x = 403;
			helmut.y = 356;			
			
			ladder = new Image(this.assets.getTexture('submarine_ladder'));
			ladder.touchable = false;
			ladder.x = 50;
			ladder.y = 172;
			
			door = new Image(this.assets.getTexture('submarine_door'));
			door.touchable = false;
			door.x = 71;
			door.y = 112;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine['Ladder'] == 'Attached'){
					
					ladder.alpha = 1;
				}else{
					ladder.alpha = 0;
				}
			}else{
				ladder.alpha = 0;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarineDoor['Door'] == 'open'){
					door.alpha = 1;
				}else{
					door.alpha = 0;
				}
			}else{
				door.alpha = 0;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FarCoastHelmet['Lid'] == 'Open'){
					helmut.alpha = 1;
				}else{
					helmut.alpha = 0;
				}
			}else{
				helmut.alpha = 0;
			}
			
			
			
			this.addChildAt(helmut,1);		
			this.addChildAt(ladder,2);			
			this.addChildAt(door,3);
			
			CreateHitSky();
			CreateHitWater();
			CreateHitMountain();
			CreateHitTrees();
			CreateHitSand();
			CreateHitJungleSubmarine();
			CreateHitFarCoastDingy();
			CreateHitFarCoastCorner();

			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("WindOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waterfall",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(hit_JungleSubmarine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleSubmarine as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleSubmarineObj,true
						);	
					}else if(hit_FarCoastDingy.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FarCoastDingy as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastDingyObj,true
						);	
					}else if(hit_FarCoastCorner.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FarCoastCorner as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastCornerObj,true
						);	
					}else if(hit_mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The mountain looms majestically above.');
					}else if(hit_water.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The ocean ebbs against the shore.');
					}else if(hit_sand.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The sand compacts beneath my feet.');
					}else if(hit_trees.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The trees thin as they approach the coast line.');
					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Cloudy. Still cloudy. Is there always a clear sky beyond the clouds...?');
					}
				
					/*
					
					private var hit_mountain:Shape;
					private var hit_water:Shape;
					private var hit_trees:Shape;
					private var hit_sky:Shape;
					hit_sand
					*/
					
				}
			}
		}
	
		
		
		
		private function CreateHitSand():void{
			hit_sand = new Shape();
			hit_sand.touchable = false;
			hit_sand.graphics.beginFill(0xff0000);
			
			hit_sand.graphics.lineTo(0,319);																																																															
			hit_sand.graphics.lineTo(250,360);																																																															
			hit_sand.graphics.lineTo(311,403);																																																															
			hit_sand.graphics.lineTo(443,431);																																																															
			hit_sand.graphics.lineTo(363,509);																																																															
			hit_sand.graphics.lineTo(0,506);																																																															
																																																															
			
			hit_sand.alpha = 0.0;
			
			hit_sand.graphics.precisionHitTest = true;	
			this.addChild(hit_sand);
		}
		
		private function CreateHitTrees():void{
			hit_trees = new Shape();
			hit_trees.touchable = false;
			hit_trees.graphics.beginFill(0xff0000);
			
			hit_trees.graphics.lineTo(268,92);																																																															
			hit_trees.graphics.lineTo(303,72);																																																															
			hit_trees.graphics.lineTo(515,185);																																																															
			hit_trees.graphics.lineTo(476,266);																																																															
			hit_trees.graphics.lineTo(466,302);																																																															
			hit_trees.graphics.lineTo(356,288);																																																															
			hit_trees.graphics.lineTo(277,248);																																																															
			
			hit_trees.alpha = 0.0;
			
			hit_trees.graphics.precisionHitTest = true;	
			this.addChild(hit_trees);
		}
		
		private function CreateHitSky():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(508,0);																																																															
			hit_sky.graphics.lineTo(800,2);																																																															
			hit_sky.graphics.lineTo(800,178);																																																															
			hit_sky.graphics.lineTo(599,154);																																																															
			
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		private function CreateHitWater():void{
			hit_water = new Shape();
			hit_water.touchable = false;
			hit_water.graphics.beginFill(0xff0000);
			
			hit_water.graphics.lineTo(361,504);																																																															
			hit_water.graphics.lineTo(444,432);																																																															
			hit_water.graphics.lineTo(613,375);																																																															
			hit_water.graphics.lineTo(685,403);																																																															
			hit_water.graphics.lineTo(608,508);																																																															
		
			hit_water.alpha = 0.0;
			
			hit_water.graphics.precisionHitTest = true;	
			this.addChild(hit_water);
		}
		
		private function CreateHitMountain():void{
			hit_mountain = new Shape();
			hit_mountain.touchable = false;
			hit_mountain.graphics.beginFill(0xff0000);
			
			hit_mountain.graphics.lineTo(303,50);																																																															
			hit_mountain.graphics.lineTo(343,0);																																																															
			hit_mountain.graphics.lineTo(406,0);																																																															
			hit_mountain.graphics.lineTo(556,121);																																																															
			hit_mountain.graphics.lineTo(524,157);																																																															
		
			hit_mountain.alpha = 0.0;
			
			hit_mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_mountain);
		}
		
		private function CreateHitFarCoastCorner():void{
			hit_FarCoastCorner = new Shape();
			hit_FarCoastCorner.touchable = false;
			hit_FarCoastCorner.graphics.beginFill(0xff0000);
			
			hit_FarCoastCorner.graphics.lineTo(487,270);																																																															
			hit_FarCoastCorner.graphics.lineTo(525,184);																																																															
			hit_FarCoastCorner.graphics.lineTo(793,232);																																																															
			hit_FarCoastCorner.graphics.lineTo(795,373);																																																															
			hit_FarCoastCorner.graphics.lineTo(668,391);																																																															
			hit_FarCoastCorner.graphics.lineTo(571,359);																																																															
			hit_FarCoastCorner.graphics.lineTo(495,315);																																																															
			
			hit_FarCoastCorner.alpha = 0.0;
			
			hit_FarCoastCorner.graphics.precisionHitTest = true;	
			this.addChild(hit_FarCoastCorner);
		}
		private function CreateHitFarCoastDingy():void{
			hit_FarCoastDingy = new Shape();
			hit_FarCoastDingy.touchable = false;
			hit_FarCoastDingy.graphics.beginFill(0xff0000);
			
			hit_FarCoastDingy.graphics.lineTo(264,364);																																	
			hit_FarCoastDingy.graphics.lineTo(266,279);																																	
			hit_FarCoastDingy.graphics.lineTo(308,284);																																	
			hit_FarCoastDingy.graphics.lineTo(556,361);																																	
			hit_FarCoastDingy.graphics.lineTo(582,424);																																	
			hit_FarCoastDingy.graphics.lineTo(456,427);																																	
			hit_FarCoastDingy.graphics.lineTo(318,400);																																	
			
			hit_FarCoastDingy.alpha = 0.0;
			
			hit_FarCoastDingy.graphics.precisionHitTest = true;	
			this.addChild(hit_FarCoastDingy);
		}
		private function CreateHitJungleSubmarine():void{
			hit_JungleSubmarine = new Shape();
			hit_JungleSubmarine.touchable = false;
			hit_JungleSubmarine.graphics.beginFill(0xff0000);
			
			hit_JungleSubmarine.graphics.lineTo(0,42);																	
			hit_JungleSubmarine.graphics.lineTo(132,30);																	
			hit_JungleSubmarine.graphics.lineTo(257,94);																	
			hit_JungleSubmarine.graphics.lineTo(273,253);																	
			hit_JungleSubmarine.graphics.lineTo(183,275);																	
			hit_JungleSubmarine.graphics.lineTo(0,245);																	
			
			hit_JungleSubmarine.alpha = 0.0;
			
			hit_JungleSubmarine.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleSubmarine);
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
			
			
		//	this.removeChild(goback);
		//	goback = null;			
			
			
			this.assets.removeTexture("farCoast_bg",true);
			this.assets.removeTexture("FarCoast_Sprite",true);
			this.assets.removeTextureAtlas("FarCoast_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("farCoast_01");
			(stage.getChildAt(0) as Object).falseAsset("farCoast_02");
			(stage.getChildAt(0) as Object).falseAsset("farCoast_03");
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