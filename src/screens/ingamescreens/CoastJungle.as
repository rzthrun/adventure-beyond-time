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
	
	
	
	public class CoastJungle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		
		private var hit_CoastMoai:Shape;
		private var hit_Ravine:Shape;
		private var hit_Jungle:Shape;
		private var hit_Buoy:Shape;
		private var hit_ground:Shape;
		private var hit_mountain:Shape;
		
		private var buoyStone:Image;
		private var buoySolarPanels:Image;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;

		
		public function CoastJungle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastJungle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastJungle/coastJungle_bg.jpg'));
				game.TrackAssets('coastJungle_01');
			}
			if(game.CheckAsset('coastJungle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastJungle/CoastJungle_Sprite.png'));
				game.TrackAssets('coastJungle_02');
			}
			if(game.CheckAsset('coastJungle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastJungle/CoastJungle_Sprite.xml'));
				game.TrackAssets('coastJungle_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastJungle","CoastJungle");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastJungle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			buoyStone = new Image(this.assets.getTexture('buoy_redStone'));
			buoyStone.touchable = false;
			buoyStone.x = 471;
			buoyStone.y = 326;	
			
			buoySolarPanels = new Image(this.assets.getTexture('buoy_solarPanels'));
			buoySolarPanels.touchable = false;
			buoySolarPanels.x = 257;
			buoySolarPanels.y = 248;	
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["Stone"] == "PickedUp"){
					buoyStone.alpha = 0;	
				}else{
					buoyStone.alpha = 1;	
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy != undefined){
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["SolarPanels"] == "PickedUp"){
						buoySolarPanels.texture = this.assets.getTexture('buoy_wires');
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastBuoy["Wires"] == "PickedUp"){
							buoySolarPanels.alpha = 0;	
						}else{
							buoySolarPanels.alpha = 1;	
						}
						
					}else{
						buoySolarPanels.alpha = 1;	
						
					}
				}else{
					
					buoySolarPanels.alpha = 1;	
				}
				
			}else{
				buoyStone.alpha = 1;	
				buoySolarPanels.alpha = 1;	
			}
			
			
		
			
			this.addChildAt(buoyStone,1);
			this.addChildAt(buoySolarPanels,2);
			
			CreateHitCoastMoai();

			CreateHitJungle();
			CreateHitBuoy();
			CreateHitRavine();
			CreateHitGround();
			CreateHitMountain();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
		}
		
		//hit_Ravine
		//hit_Jungle
		//hit_Waves
		//hit_mountain
		private function CreateHitMountain():void{
			hit_mountain = new Shape();
			hit_mountain.touchable = false;
			hit_mountain.graphics.beginFill(0xff0000);

			hit_mountain.graphics.lineTo(231,62);	
			hit_mountain.graphics.lineTo(267,0);	
			hit_mountain.graphics.lineTo(448,0);	
			hit_mountain.graphics.lineTo(485,76);	
			hit_mountain.graphics.lineTo(460,87);	
		
			hit_mountain.graphics.endFill(false);
			hit_mountain.alpha = 0.0;
			
			hit_mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_mountain);
		}
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			
			hit_ground.graphics.lineTo(180,391);	
			hit_ground.graphics.lineTo(461,413);	
			hit_ground.graphics.lineTo(558,352);	
			hit_ground.graphics.lineTo(680,398);	
			hit_ground.graphics.lineTo(583,508);	
			hit_ground.graphics.lineTo(134,508);	

			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitJungle():void{
			hit_Jungle = new Shape();
			hit_Jungle.touchable = false;
			hit_Jungle.graphics.beginFill(0xff0000);
			
		
			hit_Jungle.graphics.lineTo(471,101);	
			hit_Jungle.graphics.lineTo(489,84);	
			hit_Jungle.graphics.lineTo(578,86);	
			hit_Jungle.graphics.lineTo(615,111);	
			hit_Jungle.graphics.lineTo(615,234);	
			hit_Jungle.graphics.lineTo(611,266);	
			hit_Jungle.graphics.lineTo(551,283);	
			hit_Jungle.graphics.lineTo(493,241);	
			hit_Jungle.graphics.lineTo(461,211);	
			hit_Jungle.graphics.lineTo(425,195);	
			hit_Jungle.graphics.lineTo(452,156);
			hit_Jungle.graphics.lineTo(478,138);
			hit_Jungle.graphics.endFill(false);
			hit_Jungle.alpha = 0.0;
			
			hit_Jungle.graphics.precisionHitTest = true;	
			this.addChild(hit_Jungle);
		}
		
		private function CreateHitBuoy():void{
			hit_Buoy = new Shape();
			hit_Buoy.touchable = false;
			hit_Buoy.graphics.beginFill(0xff0000);
			
			
			hit_Buoy.graphics.lineTo(275,190);	
			hit_Buoy.graphics.lineTo(307,145);	
			hit_Buoy.graphics.lineTo(346,142);	
			hit_Buoy.graphics.lineTo(376,188);	
			hit_Buoy.graphics.lineTo(393,244);	
			hit_Buoy.graphics.lineTo(495,274);	
			hit_Buoy.graphics.lineTo(538,306);	
			hit_Buoy.graphics.lineTo(541,357);	
			hit_Buoy.graphics.lineTo(459,407);	
			hit_Buoy.graphics.lineTo(253,391);	
			hit_Buoy.graphics.lineTo(253,330);	
			hit_Buoy.graphics.lineTo(273,310);	

			hit_Buoy.graphics.endFill(false);
			hit_Buoy.alpha = 0.0;
			
			hit_Buoy.graphics.precisionHitTest = true;	
			this.addChild(hit_Buoy);
		}
		
//
		
		private function CreateHitRavine():void{
			hit_Ravine = new Shape();
			hit_Ravine.touchable = false;
			hit_Ravine.graphics.beginFill(0xff0000);
			
			hit_Ravine.graphics.lineTo(70,158);	
			hit_Ravine.graphics.lineTo(117,143);	
			hit_Ravine.graphics.lineTo(253,142);	
			hit_Ravine.graphics.lineTo(268,225);	
			hit_Ravine.graphics.lineTo(229,247);	
			hit_Ravine.graphics.lineTo(241,291);	
			hit_Ravine.graphics.lineTo(142,324)
			hit_Ravine.graphics.lineTo(88,324);	
			hit_Ravine.graphics.lineTo(68,2);	
			
			hit_Ravine.alpha = 0.0;
			
			hit_Ravine.graphics.precisionHitTest = true;	
			this.addChild(hit_Ravine);
		}
		

		
		private function CreateHitCoastMoai():void{
			hit_CoastMoai = new Shape();
			hit_CoastMoai.touchable = false;
			hit_CoastMoai.graphics.beginFill(0xff0000);
			
			hit_CoastMoai.graphics.lineTo(635,232);	
			hit_CoastMoai.graphics.lineTo(656,147);	
			hit_CoastMoai.graphics.lineTo(798,150);	
			hit_CoastMoai.graphics.lineTo(793,365);	
			hit_CoastMoai.graphics.lineTo(672,357);	
			hit_CoastMoai.graphics.endFill(false);
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
						//hit_mountain
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ground is soft and spongy.");
					
					}else if(hit_mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's a mountain in the distance.");
						
						
						
					}else if(hit_CoastMoai.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastMoai as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastMoaiObj,true
						);
					}else if(hit_Ravine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineCanyon as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonObj,true
						);
					}else if(hit_Jungle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleEdge as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEdgeObj,true
						);
					}else if(hit_Buoy.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CoastBuoy as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastBuoyObj,true
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
			
			
			this.assets.removeTexture("coastJungle_bg",true);
			this.assets.removeTexture("CoastJungle_Sprite",true);
			this.assets.removeTextureAtlas("CoastJungle_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("coastJungle_01");
			(stage.getChildAt(0) as Object).falseAsset("coastJungle_02");
			(stage.getChildAt(0) as Object).falseAsset("coastJungle_03");
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