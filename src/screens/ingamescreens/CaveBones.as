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
	
		
	public class CaveBones extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var jaw:Image;
		private var flint:Image;
		
		private var hit_jaw:Shape;
		private var hit_flint:Shape;
		private var hit_trex:Shape;
		private var hit_mammoth:Shape;
		private var hit_bones:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function CaveBones(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('caveBones_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CaveBones/caveBones_bg.jpg'));
				game.TrackAssets('caveBones_01');
			}
			if(game.CheckAsset('caveBones_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CaveBones/CaveBones_Sprite.png'));
				game.TrackAssets('caveBones_02');
			}
			if(game.CheckAsset('caveBones_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CaveBones/CaveBones_Sprite.xml'));
				game.TrackAssets('caveBones_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CaveBones","CaveBonesObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('caveBones_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			jaw = new Image(this.assets.getTexture('jaw'));
			jaw.touchable = false;
			jaw.x = 228;
			jaw.y = 281;
			jaw.alpha = 1;
			this.addChildAt(jaw,1);
			
			flint = new Image(this.assets.getTexture('flint'));
			flint.touchable = false;
			flint.x = 593;
			flint.y = 241;
			

			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones["Flint"] == "PickedUp"){
					flint.alpha = 0;
				}else{
					flint.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones["Jaw"] == "PickedUp"){
					jaw.alpha = 0;
				}else{
					jaw.alpha = 1;
				}
			}else{
				flint.alpha = 1;
				jaw.alpha = 1;
			}
			
			
			
			this.addChildAt(jaw,1);
			this.addChildAt(flint,2);
		
			
				
			CreateJawHit();
			CreateFlintHit();	
			CreateTRexHit();
			CreateMammothHit();
			CreateBonesHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BurningFireOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDripsStream",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadCaveDrips(true,999);
		}
		
		private function CreateBonesHit():void{
			hit_bones = new Shape();
			hit_bones.touchable = false;
			hit_bones.graphics.beginFill(0xff0000);
			
			hit_bones.graphics.lineTo(41,146);	
			hit_bones.graphics.lineTo(366,69);	
			hit_bones.graphics.lineTo(515,95);	
			hit_bones.graphics.lineTo(477,332);	
			hit_bones.graphics.lineTo(80,350);	
			hit_bones.graphics.lineTo(26,248);	
		
			hit_bones.graphics.endFill(false);
			hit_bones.alpha = 0.0;
			
			hit_bones.graphics.precisionHitTest = true;	
			this.addChild(hit_bones);
		}
		
		private function CreateMammothHit():void{
			hit_mammoth = new Shape();
			hit_mammoth.touchable = false;
			hit_mammoth.graphics.beginFill(0xff0000);
			
			hit_mammoth.graphics.lineTo(247,140);	
			hit_mammoth.graphics.lineTo(391,87);	
			hit_mammoth.graphics.lineTo(469,95);	
			hit_mammoth.graphics.lineTo(514,175);	
			hit_mammoth.graphics.lineTo(506,242);	
			hit_mammoth.graphics.lineTo(303,238);	
			hit_mammoth.graphics.lineTo(250,205);	
			
			hit_mammoth.graphics.endFill(false);
			hit_mammoth.alpha = 0.0;
			
			hit_mammoth.graphics.precisionHitTest = true;	
			this.addChild(hit_mammoth);
		}
		
		
		private function CreateTRexHit():void{
			hit_trex = new Shape();
			hit_trex.touchable = false;
			hit_trex.graphics.beginFill(0xff0000);
			
			hit_trex.graphics.lineTo(49,218);	
			hit_trex.graphics.lineTo(60,161);	
			hit_trex.graphics.lineTo(144,151);	
			hit_trex.graphics.lineTo(233,190);	
			hit_trex.graphics.lineTo(228,313);	
			hit_trex.graphics.lineTo(71,267);	
						
			hit_trex.graphics.endFill(false);
			hit_trex.alpha = 0.0;
			
			hit_trex.graphics.precisionHitTest = true;	
			this.addChild(hit_trex);
		}
		
		private function CreateJawHit():void{
			hit_jaw = new Shape();
			hit_jaw.touchable = false;
			hit_jaw.graphics.beginFill(0xff0000);
			
			hit_jaw.graphics.lineTo(253,280);	
			hit_jaw.graphics.lineTo(283,271);	
			hit_jaw.graphics.lineTo(320,304);	
			hit_jaw.graphics.lineTo(438,329);	
			hit_jaw.graphics.lineTo(421,396);	
			hit_jaw.graphics.lineTo(326,392);	
			hit_jaw.graphics.lineTo(228,363);	
			
			hit_jaw.graphics.endFill(false);
			hit_jaw.alpha = 0.0;
			
			hit_jaw.graphics.precisionHitTest = true;	
			this.addChild(hit_jaw);
		}
		
		private function CreateFlintHit():void{
			hit_flint = new Shape();
			hit_flint.touchable = false;
			hit_flint.graphics.beginFill(0xff0000);
			
			hit_flint.graphics.lineTo(579,270);	
			hit_flint.graphics.lineTo(617,222);	
			hit_flint.graphics.lineTo(675,229);	
			hit_flint.graphics.lineTo(687,314);	
			hit_flint.graphics.lineTo(615,362);	
			hit_flint.graphics.lineTo(583,337);	
			
			hit_flint.graphics.endFill(false);
			hit_flint.alpha = 0.0;
			
			hit_flint.graphics.precisionHitTest = true;	
			this.addChild(hit_flint);
		}
		//private var hit_jaw:Shape;
		//private var hit_flint:Shape;
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Cave as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.CaveObj,true
						);
					}else if(hit_flint.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FlintHandler();
					}else if(hit_jaw.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						JawHandler();
					}else if(hit_trex.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That's a dinosaur skull... a big one.");

					}else if(hit_mammoth.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The skull of a mammoth and sabertoothed cat.");

					}else if(hit_bones.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The cave floor is littered with bones and debris.");

					}
					
					/*
					private var hit_trex:Shape;
					private var hit_mammoth:Shape;
					private var hit_bones:Shape;
					*/
					
				}
			}
		}
		
		private function JawHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones["Jaw"] == "PickedUp"){
					
				}else{
					jaw.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones;
					SaveArray['Jaw'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveBones',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Jaw,
						'item_Jaw',
						'inven_jaw_sm'
					);
					
					
				}
			}else{
				jaw.alpha = 0;
				SaveArray['Jaw'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveBones',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Jaw,
					'item_Jaw',
					'inven_jaw_sm'
				);
			}	
		}
		
		
		private function FlintHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones["Flint"] == "PickedUp"){
					
				}else{
					flint.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CaveBones;
					SaveArray['Flint'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveBones',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Flint,
						'item_Flint',
						'inven_flint_sm'
					);
					
					
				}
			}else{
				flint.alpha = 0;
				SaveArray['Flint'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CaveBones',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Flint,
					'item_Flint',
					'inven_flint_sm'
				);
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
			
			
			this.assets.removeTexture("caveBones_bg",true);
			this.assets.removeTexture("CaveBones_Sprite",true);
			this.assets.removeTextureAtlas("CaveBones_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("caveBones_01");
			(stage.getChildAt(0) as Object).falseAsset("caveBones_02");
			(stage.getChildAt(0) as Object).falseAsset("caveBones_03");
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