package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	
	public class CoastCorner extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var moai_eye_left:Image;
		private var moai_eye_right:Image;
		private var moai_mouth:Image;
		private var moai_disc:Image;
		
		private var hit_CoastMoai:Shape;
		private var hit_CoastCaveExterior:Shape;
		private var hit_CoastBoat:Shape;
		private var hit_Jungle:Shape
		private var hit_Sky:Shape;
		
		private var hit_sand:Shape;
		private var hit_waves:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function CoastCorner(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('CoastCorner_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCorner/coastCorner_bg.jpg'));
				game.TrackAssets('CoastCorner_01');
			}
			if(game.CheckAsset('CoastCorner_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCorner/CoastCorner_Sprite.png'));
				game.TrackAssets('CoastCorner_02');
			}
			if(game.CheckAsset('CoastCorner_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastCorner/CoastCorner_Sprite.xml'));
				game.TrackAssets('CoastCorner_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastCorner","CoastCornerObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastCorner_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			moai_eye_left = new Image(this.assets.getTexture('moai_eye_eye_left'));
			moai_eye_left.touchable = false;
			moai_eye_left.x = 178;
			moai_eye_left.y = 200;
			
			moai_eye_right = new Image(this.assets.getTexture('moai_eye_eye_right'));
			moai_eye_right.touchable = false;
			moai_eye_right.x = 201;
			moai_eye_right.y = 196;
		
			moai_disc = new Image(this.assets.getTexture('moai_disc'));
			moai_disc.touchable = false;
			moai_disc.x = 210;
			moai_disc.y = 262;
			
			
			moai_mouth = new Image(this.assets.getTexture('moai_mouth'));
			moai_mouth.touchable = false;
			moai_mouth.x = 196;
			moai_mouth.y = 249;
			

			
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['left_eye'] == 'Attached'){
					
					moai_eye_left.alpha = 1;
					
				}else{
					moai_eye_left.alpha = 0;
					
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['right_eye'] == 'Attached'){
					moai_eye_right.alpha = 1;
					
				}else{
					moai_eye_right.alpha = 0;
					
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['Solved'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['MouthPopped'] == 'Yes'){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['Mouth'] == 'open'){
							
								moai_mouth.alpha = 0;	
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['WoodCircle'] == 'PickedUp'){
									moai_disc.alpha = 0;
								}else{
									moai_disc.alpha = 1;
								}	
							}else{
								moai_mouth.alpha = 1;	
								moai_disc.alpha = 0;
							}
						}else{
							
							moai_mouth.alpha = 1;	
							moai_disc.alpha = 0;
						
		
						}
					}else{
						moai_mouth.alpha = 1;	
						moai_disc.alpha = 0;

					}
				}else{
					moai_mouth.alpha = 1;	
					moai_disc.alpha = 0;
				}
			}else{
				
				
				moai_eye_left.alpha = 0;
				moai_eye_right.alpha = 0;
				moai_disc.alpha = 0;
				moai_mouth.alpha = 1;
			}
			
			
			
			this.addChildAt(moai_eye_left,1);			
			this.addChildAt(moai_eye_right,2);					
			this.addChildAt(moai_disc,3);			
			this.addChildAt(moai_mouth,4);
			

			CreateHitCoastBoat();
			CreateHitCoastCaveExterior();
			CreateHitCoastMoai();
			CreateHitJungle();
			CreateHitSand();
			CreateHitWaves();
			CreateHitSky();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
		}
		
		
		//hit_CoastCaveExterior
		//hit_CoastBoat
		//hit_waves
		//hit_sand
		//hit_CoastCorner
		
		private function CreateHitSky():void{
			hit_Sky = new Shape();
			hit_Sky.touchable = false;
			hit_Sky.graphics.beginFill(0xff0000);
			
			hit_Sky.graphics.lineTo(86,0);	
			hit_Sky.graphics.lineTo(648,0);	
			hit_Sky.graphics.lineTo(611,145);	
			hit_Sky.graphics.lineTo(540,150);	
			hit_Sky.graphics.lineTo(431,211);	
			hit_Sky.graphics.lineTo(121,96);	
			
			
			hit_Sky.alpha = 0.0;
			
			hit_Sky.graphics.precisionHitTest = true;	
			this.addChild(hit_Sky);
		}
		private function CreateHitWaves():void{
			hit_waves = new Shape();
			hit_waves.touchable = false;
			hit_waves.graphics.beginFill(0xff0000);
			
			hit_waves.graphics.lineTo(330,512);	
			hit_waves.graphics.lineTo(455,383);	
			hit_waves.graphics.lineTo(564,401);	
			hit_waves.graphics.lineTo(666,403);	
			hit_waves.graphics.lineTo(597,512);	

			
			hit_waves.alpha = 0.0;
			
			hit_waves.graphics.precisionHitTest = true;	
			this.addChild(hit_waves);
		}
		
		private function CreateHitSand():void{
			hit_sand = new Shape();
			hit_sand.touchable = false;
			hit_sand.graphics.beginFill(0xff0000);
			
			hit_sand.graphics.lineTo(73,371);	
			hit_sand.graphics.lineTo(174,320);	
			hit_sand.graphics.lineTo(275,337);	
			hit_sand.graphics.lineTo(448,386);	
			hit_sand.graphics.lineTo(323,503);	
			hit_sand.graphics.lineTo(94,503);	
		
			hit_sand.alpha = 0.0;
			
			hit_sand.graphics.precisionHitTest = true;	
			this.addChild(hit_sand);
		}
		
		private function CreateHitJungle():void{
			hit_Jungle = new Shape();
			hit_Jungle.touchable = false;
			hit_Jungle.graphics.beginFill(0xff0000);
			
			hit_Jungle.graphics.lineTo(0,73);	
			hit_Jungle.graphics.lineTo(98,135);	
			hit_Jungle.graphics.lineTo(123,261);	
			hit_Jungle.graphics.lineTo(160,309);	
			hit_Jungle.graphics.lineTo(0,346);	

			hit_Jungle.alpha = 0.0;
			
			hit_Jungle.graphics.precisionHitTest = true;	
			this.addChild(hit_Jungle);
		}
		
		private function CreateHitCoastBoat():void{
			hit_CoastBoat = new Shape();
			hit_CoastBoat.touchable = false;
			hit_CoastBoat.graphics.beginFill(0xff0000);
			
			hit_CoastBoat.graphics.lineTo(521,347);	
			hit_CoastBoat.graphics.lineTo(521,337);	
			hit_CoastBoat.graphics.lineTo(542,297);	
			hit_CoastBoat.graphics.lineTo(535,248);	
			hit_CoastBoat.graphics.lineTo(606,206);	
			hit_CoastBoat.graphics.lineTo(690,249);	
			hit_CoastBoat.graphics.lineTo(763,311);	
			hit_CoastBoat.graphics.lineTo(762,384);	
			hit_CoastBoat.graphics.lineTo(566,396);	

			hit_CoastBoat.alpha = 0.0;
			
			hit_CoastBoat.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastBoat);
		}
		
		private function CreateHitCoastCaveExterior():void{
			hit_CoastCaveExterior = new Shape();
			hit_CoastCaveExterior.touchable = false;
			hit_CoastCaveExterior.graphics.beginFill(0xff0000);
			
			hit_CoastCaveExterior.graphics.lineTo(255,280);	
			hit_CoastCaveExterior.graphics.lineTo(269,195);	
			hit_CoastCaveExterior.graphics.lineTo(410,219);	
			hit_CoastCaveExterior.graphics.lineTo(471,345);	
			hit_CoastCaveExterior.graphics.lineTo(337,352);	
			hit_CoastCaveExterior.graphics.lineTo(269,328);	

			hit_CoastCaveExterior.alpha = 0.0;
			
			hit_CoastCaveExterior.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastCaveExterior);
		}

		
		private function CreateHitCoastMoai():void{
			hit_CoastMoai = new Shape();
			hit_CoastMoai.touchable = false;
			hit_CoastMoai.graphics.beginFill(0xff0000);
			
			hit_CoastMoai.graphics.lineTo(136,157);	
			hit_CoastMoai.graphics.lineTo(221,154);	
			hit_CoastMoai.graphics.lineTo(256,329);	
			hit_CoastMoai.graphics.lineTo(173,317);	

			
			hit_CoastMoai.alpha = 0.0;
			
			hit_CoastMoai.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastMoai);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Coast as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastObj,true
						);
					}else if(hit_sand.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sand is warm to the touch.");
					
					}else if(hit_sand.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The water is clear and cool.");
					}else if(hit_sand.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The air is thick with a wet fog.");

					}else if(hit_CoastMoai.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastMoai as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastMoaiObj,true
						);
					}else if(hit_CoastCaveExterior.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastCaveExterior as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveExteriorObj,true
						);
					}else if(hit_CoastBoat.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((HeroBoat as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.HeroBoatObj,true
						);
					}else if(hit_Jungle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastJungle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastJungleObj,true
						);
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
			
			
			this.assets.removeTexture("coastCorner_bg",true);
			this.assets.removeTexture("CoastCorner_Sprite",true);
			this.assets.removeTextureAtlas("CoastCorner_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("CoastCorner_01");
			(stage.getChildAt(0) as Object).falseAsset("CoastCorner_02");
			(stage.getChildAt(0) as Object).falseAsset("CoastCorner_03");
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