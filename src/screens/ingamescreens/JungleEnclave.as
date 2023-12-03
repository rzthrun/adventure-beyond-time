package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import events.ImageLoadEvent;
	
	import screens.hud.GoBackButton;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	public class JungleEnclave extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var rock_lid_on:Image;
		private var rock_lid_off:Image;
		private var rock_seal:Image;
		private var wall_dragonball:Image;
		private var wall_arm:Image;
		
		private var hit_wallMessage:Shape;
		private var hit_rock:Shape;
		private var hit_wallLedge:Shape;
		
		private var hit_roots:Shape;
		private var hit_ground:Shape;
		private var hit_plants:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function JungleEnclave(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleEnclave_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclave/jungleEnclave_bg.jpg'));
				game.TrackAssets('jungleEnclave_01');
			}
			if(game.CheckAsset('jungleEnclave_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclave/jungleEnclave_Sprite.png'));
				game.TrackAssets('jungleEnclave_02');
			}
			if(game.CheckAsset('jungleEnclave_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleEnclave/jungleEnclave_Sprite.xml'));
				game.TrackAssets('jungleEnclave_03');
			}
			//jungleEnclave_Sprite
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleEnclave","JungleEnclaveObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleEnclave_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			rock_lid_on = new Image(this.assets.getTexture('rock_closed'));
			rock_lid_on.touchable = false;
			rock_lid_on.x = 119;
			rock_lid_on.y = 224;

			rock_lid_off = new Image(this.assets.getTexture('rock_open'));
			rock_lid_off.touchable = false;
			rock_lid_off.x = 199;
			rock_lid_off.y = 284;
	
			rock_seal = new Image(this.assets.getTexture('rock_seal'));
			rock_seal.touchable = false;
			rock_seal.x = 121;
			rock_seal.y = 262;
		
			wall_dragonball = new Image(this.assets.getTexture('wall_dragonball'));
			wall_dragonball.touchable = false;
			wall_dragonball.x = 417;
			wall_dragonball.y = 215;

			wall_arm = new Image(this.assets.getTexture('wall_arm'));
			wall_arm.touchable = false;
			wall_arm.x = 527;
			wall_arm.y = 137;
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall['Dragonball'] == 'PickedUp'){
					wall_dragonball.alpha = 0;
				}else{
					wall_dragonball.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveWall['Arm'] == 'PickedUp'){
					wall_arm.alpha = 0;
				}else{
					wall_arm.alpha = 1;
				}
			}else{
				wall_arm.alpha = 1;
				wall_dragonball.alpha = 1;
			}

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Lid'] == 'Open'){
					rock_lid_on.alpha = 0;
					rock_lid_off.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleEnclaveRock['Seal'] == 'PickedUp'){
						rock_seal.alpha = 0;
					}else{
						rock_seal.alpha = 1;
					}
				}else{
					rock_lid_on.alpha = 1;
					rock_lid_off.alpha = 0;
					rock_seal.alpha = 0;
				}
			}else{
				rock_lid_on.alpha = 1;
				rock_lid_off.alpha = 0;
				rock_seal.alpha = 0;
			}

			this.addChildAt(rock_lid_on,1);
			this.addChildAt(rock_lid_off,2);
			this.addChildAt(rock_seal,3);
			this.addChildAt(wall_dragonball,4);
			this.addChildAt(wall_arm,5);
			
			CreateHitGround();
			CreateHitPlants();
			CreateHitRoots();
			
			CreateHitWallMessage();
			CreateHitRock();
			CreateHitWallLedge();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Jungle_01';
			},0.7);
		}
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(272,279);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_ground.graphics.lineTo(516,324);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_ground.graphics.lineTo(624,506);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_ground.graphics.lineTo(358,506);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
	
			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitPlants():void{
			hit_plants = new Shape();
			hit_plants.touchable = false;
			hit_plants.graphics.beginFill(0xff0000);
			
			hit_plants.graphics.lineTo(629,296);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_plants.graphics.lineTo(659,122);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_plants.graphics.lineTo(789,117);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_plants.graphics.lineTo(796,380);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_plants.graphics.lineTo(676,378);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
	
			hit_plants.graphics.endFill(false);
			hit_plants.alpha = 0.0;
			
			hit_plants.graphics.precisionHitTest = true;	
			this.addChild(hit_plants);
		}
		
		
		private function CreateHitRoots():void{
			hit_roots = new Shape();
			hit_roots.touchable = false;
			hit_roots.graphics.beginFill(0xff0000);
			
			hit_roots.graphics.lineTo(352,0);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_roots.graphics.lineTo(641,0);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_roots.graphics.lineTo(615,94);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_roots.graphics.lineTo(523,135);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_roots.graphics.lineTo(380,126);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			hit_roots.graphics.lineTo(352,53);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					
			
			hit_roots.graphics.endFill(false);
			hit_roots.alpha = 0.0;
			
			hit_roots.graphics.precisionHitTest = true;	
			this.addChild(hit_roots);
		}
		
		private function CreateHitWallLedge():void{
			hit_wallLedge = new Shape();
			hit_wallLedge.touchable = false;
			hit_wallLedge.graphics.beginFill(0xff0000);
			
			hit_wallLedge.graphics.lineTo(330,183);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(363,142);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(533,144);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(619,103);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(656,140);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(640,200);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(563,273);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(464,305);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(390,284);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
			hit_wallLedge.graphics.lineTo(310,225);																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
			
			hit_wallLedge.graphics.endFill(false);
			hit_wallLedge.alpha = 0.0;
			
			hit_wallLedge.graphics.precisionHitTest = true;	
			this.addChild(hit_wallLedge);
		}
		
		private function CreateHitWallMessage():void{
			hit_wallMessage = new Shape();
			hit_wallMessage.touchable = false;
			hit_wallMessage.graphics.beginFill(0xff0000);
			
			hit_wallMessage.graphics.lineTo(143,0);																																																																																																																																																																																																																																																																																																																																																																																							
			hit_wallMessage.graphics.lineTo(321,0);																																																																																																																																																																																																																																																																																																																																																																																							
			hit_wallMessage.graphics.lineTo(316,141);																																																																																																																																																																																																																																																																																																																																																																																							
			hit_wallMessage.graphics.lineTo(275,165);																																																																																																																																																																																																																																																																																																																																																																																							
			hit_wallMessage.graphics.lineTo(123,123);																																																																																																																																																																																																																																																																																																																																																																																							
			
			hit_wallMessage.graphics.endFill(false);
			hit_wallMessage.alpha = 0.0;
			
			hit_wallMessage.graphics.precisionHitTest = true;	
			this.addChild(hit_wallMessage);
		}
		
		private function CreateHitRock():void{
			hit_rock = new Shape();
			hit_rock.touchable = false;
			hit_rock.graphics.beginFill(0xff0000);
			
			hit_rock.graphics.lineTo(53,182);																																																																																																																														
			hit_rock.graphics.lineTo(122,154);																																																																																																																														
			hit_rock.graphics.lineTo(245,213);																																																																																																																														
			hit_rock.graphics.lineTo(276,348);																																																																																																																														
			hit_rock.graphics.lineTo(199,401);																																																																																																																														
			hit_rock.graphics.lineTo(67,378);																																																																																																																														
			hit_rock.graphics.lineTo(35,294);																																																																																																																																																																																																																																																											
																																																																																																																														
			hit_rock.graphics.endFill(false);
			hit_rock.alpha = 0.0;
			
			hit_rock.graphics.precisionHitTest = true;	
			this.addChild(hit_rock);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleJunk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleJunkObj,true
						);
					}else if(hit_rock.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleEnclaveRock as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveRockObj,true
						);	
					}
					else if(hit_wallMessage.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleEnclaveMessage as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveMessageObj,true
						);	
					}
					else if(hit_wallLedge.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleEnclaveWall as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEnclaveWallObj,true
						);	
					}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
				
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Roots grow down from above.");
						
					}else if(hit_plants.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Another plant I can't name.");
						
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Moss covers the rocky path.");
						
					}
					/*
					private var hit_roots:Shape;
					private var hit_ground:Shape;
					private var hit_plants:Shape;
					
					*/
				}
			}
		}
		//JungleEnclaveMessage
		
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
			
			
			this.assets.removeTexture("jungleEnclave_bg",true);
			this.assets.removeTexture("jungleEnclave_Sprite",true);
			this.assets.removeTextureAtlas("jungleEnclave_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclave_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclave_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleEnclave_03");
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