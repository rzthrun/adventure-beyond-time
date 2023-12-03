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
	
	
	public class CavePirate extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		
		
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var ditch_plank:Image;
		private var ditch_hole:Image;
		private var ditch_jug:Image;
		private var ship_door:Image;
		
		private var deck_powder:Image;
		private var deck_bucket:Image;
		
		private var enclave_barrel_left:Image;
		private var enclave_barrel_right:Image;
		
		private var hit_Enclave:Shape;
		private var hit_PirateDeck:Shape;
		private var hit_Ditch:Shape;
		
		private var hit_mast:Shape;
		private var hit_stream:Shape;
		//private var hit_CoastCaveExterior:Shape;		
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public function CavePirate(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('cavePirate_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirate/cavePirate_bg.jpg'));
				game.TrackAssets('cavePirate_01');
			}
			if(game.CheckAsset('cavePirate_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirate/CavePirate_Sprite.png'));
				game.TrackAssets('cavePirate_02');
			}
			if(game.CheckAsset('cavePirate_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CavePirate/CavePirate_Sprite.xml'));
				game.TrackAssets('cavePirate_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CavePirate","CavePirateObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('cavePirate_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			ditch_hole = new Image(this.assets.getTexture('ditch_mound'));
			ditch_hole.touchable = false;
			ditch_hole.x = 39;
			ditch_hole.y = 326;

			ditch_plank = new Image(this.assets.getTexture('ditch_plank'));
			ditch_plank.touchable = false;
			ditch_plank.x = 15;
			ditch_plank.y = 226;

			ditch_jug = new Image(this.assets.getTexture('ditch_jug'));
			ditch_jug.touchable = false;
			ditch_jug.x = 275;
			ditch_jug.y = 328;
			
			ship_door = new Image(this.assets.getTexture('topdeck_door'));
			ship_door.touchable = false;
			ship_door.x = 540;
			ship_door.y = 122;
			
	
			deck_powder = new Image(this.assets.getTexture('deck_powder'));
			deck_powder.touchable = false;
			deck_powder.x = 540;
			deck_powder.y = 240;
			
			deck_bucket = new Image(this.assets.getTexture('deck_bucket'));
			deck_bucket.touchable = false;
			deck_bucket.x = 568;
			deck_bucket.y = 242;
			
			/*
			
			private var enclave_barrel_left:Image;
			private var enclave_barrel_right:Image;
			
			*/
			
			enclave_barrel_left = new Image(this.assets.getTexture('eclave_barrel_lid_left'));
			enclave_barrel_left.touchable = false;
			enclave_barrel_left.x = 632;
			enclave_barrel_left.y = 282;
			
			enclave_barrel_right = new Image(this.assets.getTexture('eclave_barrel_lid_right'));
			enclave_barrel_right.touchable = false;
			enclave_barrel_right.x = 668;
			enclave_barrel_right.y = 279;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Jug"] == "PickedUp"){
					ditch_jug.alpha = 0;
				}else{
					ditch_jug.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Plank"] == "PickedUp"){
					ditch_plank.alpha = 0;
				}else{
					ditch_plank.alpha = 1;
				}
				
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateDitch["Hole"] == "open"){
					ditch_hole.alpha = 1;
				}else{
					ditch_hole.alpha = 0;
				}
			}else{
				
				ditch_hole.alpha = 0;
				ditch_plank.alpha = 1;
				ditch_jug.alpha = 1;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateTopDeck['Door'] == 'Down'){
					ship_door.alpha = 1;
				}else{
					ship_door.alpha = 0;
				}
			}else{
				ship_door.alpha = 0;
			}

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk['Barrel'] == 'Open'){
					deck_powder.alpha = 1;
				}else{
					deck_powder.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateJunk["Rope"] == "PickedUp"){
					deck_bucket.alpha = 0;
				}else{
					deck_bucket.alpha = 1;
				}
			}else{
				deck_powder.alpha = 0;
				deck_bucket.alpha = 1;

			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Right'] == 'Open'){
					enclave_barrel_right.alpha = 1;
				}else{
					enclave_barrel_right.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirateBarrels['Left'] == 'Open'){
					enclave_barrel_left.alpha = 1;
				}else{
					enclave_barrel_left.alpha = 0;
				}
			}else{
				enclave_barrel_left.alpha = 0;
				enclave_barrel_right.alpha = 0;
			}
			
			this.addChildAt(ditch_hole,1);
			this.addChildAt(ditch_plank,2);	
			this.addChildAt(ditch_jug,3);		
			this.addChildAt(ship_door,4);
			this.addChildAt(deck_powder,5);
			this.addChildAt(deck_bucket,6);
			this.addChildAt(enclave_barrel_left,7);
			this.addChildAt(enclave_barrel_right,8);
			
			/*
			private var ditch_plank:Image;
			private var ditch_hole:Image;
			private var ditch_jug:Image;
			*/
			//FadeOutOcean(1);
			
			
			//CreateHitCoastSkeleton();
			CreateMastHit();
			CreatePirateEnclaveHit();
			CreatePirateDeckHit();
			CreatePirateDitchHit();
			CreateStreamHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDripsStream",0,0.7,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BurningFireOne",0,0.7,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ShipCreaks",0,0.7,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_02(true,999);
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirate['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirate;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirate',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
							
						},1.5);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirate',SaveArray);
					
					Starling.juggler.delayCall(function():void{
				//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
						//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
					},1.5);
				}
			}
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirate['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CavePirate;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirate',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CavePirate',SaveArray);
			}
			
		}
		
	
		
		private function CreateMastHit():void{
			hit_mast = new Shape();
			hit_mast.touchable = false;
			hit_mast.graphics.beginFill(0xff0000);
			
			hit_mast.graphics.lineTo(35,44);	
			hit_mast.graphics.lineTo(293,0);	
			hit_mast.graphics.lineTo(408,8);	
			hit_mast.graphics.lineTo(450,74);	
			hit_mast.graphics.lineTo(399,189);	
			hit_mast.graphics.lineTo(369,211);	
			hit_mast.graphics.lineTo(48,208);	
		
			hit_mast.graphics.endFill(false);
			
			hit_mast.alpha = 0.0;
			
			hit_mast.graphics.precisionHitTest = true;	
			this.addChild(hit_mast);
		}
		
		private function CreateStreamHit():void{
			hit_stream = new Shape();
			hit_stream.touchable = false;
			hit_stream.graphics.beginFill(0xff0000);
			
			hit_stream.graphics.lineTo(273,393);	
			hit_stream.graphics.lineTo(370,373);	
			hit_stream.graphics.lineTo(543,508);	
			hit_stream.graphics.lineTo(283,508);	
			hit_stream.graphics.lineTo(322,445);	
		
			hit_stream.graphics.endFill(false);
			
			hit_stream.alpha = 0.0;
			
			hit_stream.graphics.precisionHitTest = true;	
			this.addChild(hit_stream);
		}
		
		private function CreatePirateEnclaveHit():void{
			hit_Enclave = new Shape();
			hit_Enclave.touchable = false;
			hit_Enclave.graphics.beginFill(0xff0000);
			
			hit_Enclave.graphics.lineTo(588,252);	
			hit_Enclave.graphics.lineTo(643,216);	
			hit_Enclave.graphics.lineTo(721,187);	
			hit_Enclave.graphics.lineTo(775,150);	
			hit_Enclave.graphics.lineTo(788,185);	
			hit_Enclave.graphics.lineTo(763,291);	
			hit_Enclave.graphics.lineTo(764,335);	
			hit_Enclave.graphics.lineTo(649,358);	
			hit_Enclave.graphics.lineTo(613,346);	
			hit_Enclave.graphics.lineTo(584,347);	
			hit_Enclave.graphics.lineTo(588,288);	
			
			hit_Enclave.graphics.endFill(false);
			
			hit_Enclave.alpha = 0.0;
			
			hit_Enclave.graphics.precisionHitTest = true;	
			this.addChild(hit_Enclave);
		}
		
		private function CreatePirateDitchHit():void{
			hit_Ditch = new Shape();
			hit_Ditch.touchable = false;
			hit_Ditch.graphics.beginFill(0xff0000);
			
			hit_Ditch.graphics.lineTo(0,215);	
			hit_Ditch.graphics.lineTo(374,222);	
			hit_Ditch.graphics.lineTo(383,366);	
			hit_Ditch.graphics.lineTo(254,389);	
			hit_Ditch.graphics.lineTo(0,375);	
			
			hit_Ditch.graphics.endFill(false);
			
			hit_Ditch.alpha = 0.0;
			
			hit_Ditch.graphics.precisionHitTest = true;	
			this.addChild(hit_Ditch);
		}
		
		private function CreatePirateDeckHit():void{
			hit_PirateDeck = new Shape();
			hit_PirateDeck.touchable = false;
			hit_PirateDeck.graphics.beginFill(0xff0000);
			
			hit_PirateDeck.graphics.lineTo(411,199);	
			hit_PirateDeck.graphics.lineTo(557,60);	
			hit_PirateDeck.graphics.lineTo(646,76);	
			hit_PirateDeck.graphics.lineTo(642,216);	
			hit_PirateDeck.graphics.lineTo(588,252);	
			hit_PirateDeck.graphics.lineTo(586,293);	
			hit_PirateDeck.graphics.lineTo(471,317);	
			hit_PirateDeck.graphics.lineTo(431,300);	
			hit_PirateDeck.graphics.lineTo(415,263);	
			hit_PirateDeck.graphics.endFill(false);
			hit_PirateDeck.alpha = 0.0;
			
			hit_PirateDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_PirateDeck);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				////CavePirateDitch
				//CavePirateEnclave
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((CaveCorridor as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CaveCorridorObj,false
						);
					}else if(hit_PirateDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((CavePirateDeck as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateDeckObj,true
							);
					}else if(hit_Ditch.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CavePirateDitch as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateDitchObj,true
						);
					}else if(hit_Enclave.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((CavePirateEnclave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CavePirateEnclaveObj,true
						);
					}else if(hit_mast.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The ship's mast and rigging are a rotting mess.");
						
					}else if(hit_stream.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The stream is flowing to the sea.");
						
					}
					
					
					/*
					private var hit_mast:Shape;
					private var hit_stream:Shape;
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
			
			
			this.assets.removeTexture("CavePirate_bg_01",true);
			this.assets.removeTexture("CavePirate_Sprite",true);
			this.assets.removeTextureAtlas("CavePirate_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("cavePirate_01");
			(stage.getChildAt(0) as Object).falseAsset("cavePirate_02");
			(stage.getChildAt(0) as Object).falseAsset("cavePirate_03");
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