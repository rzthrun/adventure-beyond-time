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
	
	
	public class MountainDig extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var supply_lid:Image;
		private var supply_trowel:Image;
		private var excavate_dragonball:Image;
		private var excavate_hominid:Image;
		
		
		private var hit_excavate:Shape;
		private var hit_supply:Shape;
		
		private var hit_sediment:Shape;
		private var hit_topWood:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function MountainDig(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('mountainDig_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDig/mountainDig_bg.jpg'));
				game.TrackAssets('mountainDig_01');
			}
			if(game.CheckAsset('mountainDig_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDig/MountainDig_Sprite.png'));
				game.TrackAssets('mountainDig_02');
			}
			if(game.CheckAsset('mountainDig_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/MountainDig/MountainDig_Sprite.xml'));
				game.TrackAssets('mountainDig_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("MountainDig","MountainDigObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('mountainDig_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			supply_trowel = new Image(this.assets.getTexture('supply_trowel'));
			supply_trowel.touchable = false;
			supply_trowel.x = 485;
			supply_trowel.y = 210;
			
			
			supply_lid = new Image(this.assets.getTexture('supply_boxLid'));
			supply_lid.touchable = false;
			supply_lid.x = 351;
			supply_lid.y = 180;
			
			
			excavate_dragonball = new Image(this.assets.getTexture('excavate_dragonball_full'));
			excavate_dragonball.touchable = false;
			excavate_dragonball.x = 213;
			excavate_dragonball.y = 149;
			
			
			
			excavate_hominid = new Image(this.assets.getTexture('excavate_hominid_full'));
			excavate_hominid.touchable = false;
			excavate_hominid.x = 90;
			excavate_hominid.y = 63;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Trowel'] == 'PickedUp'){
					supply_trowel.alpha = 0;
				}else{
					supply_trowel.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigSupply['Lid'] == 'Open'){
					supply_lid.alpha = 0;
				}else{
					supply_lid.alpha = 1;
				}
			}else{
				supply_trowel.alpha = 1;
				supply_lid.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'PickedUp'){
					excavate_hominid.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'Opened'){
					excavate_hominid.texture = this.assets.getTexture('excavate_hominid_half')
					excavate_hominid.alpha = 1;
				}else{
					excavate_hominid.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
					excavate_dragonball.alpha = 0;
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'Opened'){
					excavate_dragonball.texture = this.assets.getTexture('excavate_dragonball_out')
					excavate_dragonball.alpha = 1;
				}else{
					excavate_dragonball.alpha = 1;
				}
			}else{
				excavate_dragonball.alpha = 1;
				excavate_hominid.alpha = 1;
			}
			
			
			
			
			
			this.addChildAt(supply_trowel,1);
			this.addChildAt(supply_lid,2);
			this.addChildAt(excavate_dragonball,3);
			this.addChildAt(excavate_hominid,4);
			
			CreateTopWoodHit();
			CreateSedimentHit();
			CreateSupplyHit();
			CreateExcavateHit();
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
		//	(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("CaveDrips",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
			},0.7);
		}
		
		private function CreateTopWoodHit():void{
			hit_topWood = new Shape();
			hit_topWood.touchable = false;
			hit_topWood.graphics.beginFill(0xff0000);
			
			hit_topWood.graphics.lineTo(52,0);				
			hit_topWood.graphics.lineTo(653,0);	
			hit_topWood.graphics.lineTo(683,103);
			hit_topWood.graphics.lineTo(516,67);	
			hit_topWood.graphics.lineTo(391,85);				
						
							
			
			hit_topWood.graphics.endFill(false);
			
			hit_topWood.alpha = 0.0;
			
			hit_topWood.graphics.precisionHitTest = true;	
			this.addChild(hit_topWood);
		}
		
		private function CreateSedimentHit():void{
			hit_sediment = new Shape();
			hit_sediment.touchable = false;
			hit_sediment.graphics.beginFill(0xff0000);
			
			hit_sediment.graphics.lineTo(60,243);				
			hit_sediment.graphics.lineTo(342,260);				
			hit_sediment.graphics.lineTo(569,288);				
			hit_sediment.graphics.lineTo(571,394);				
			hit_sediment.graphics.lineTo(336,341);				
			hit_sediment.graphics.lineTo(53,357);				
		
			hit_sediment.graphics.endFill(false);
			
			hit_sediment.alpha = 0.0;
			
			hit_sediment.graphics.precisionHitTest = true;	
			this.addChild(hit_sediment);
		}
		
		
		private function CreateSupplyHit():void{
			hit_supply = new Shape();
			hit_supply.touchable = false;
			hit_supply.graphics.beginFill(0xff0000);
			
			hit_supply.graphics.lineTo(356,179);				
			hit_supply.graphics.lineTo(408,94);				
			hit_supply.graphics.lineTo(511,78);				
			hit_supply.graphics.lineTo(670,112);				
			hit_supply.graphics.lineTo(672,238);				
			hit_supply.graphics.lineTo(567,282);				
			hit_supply.graphics.lineTo(355,242);				
			
			hit_supply.graphics.endFill(false);
			
			hit_supply.alpha = 0.0;
			
			hit_supply.graphics.precisionHitTest = true;	
			this.addChild(hit_supply);
		}
		
		private function CreateExcavateHit():void{
			hit_excavate = new Shape();
			hit_excavate.touchable = false;
			hit_excavate.graphics.beginFill(0xff0000);
			
			hit_excavate.graphics.lineTo(76,23);				
			hit_excavate.graphics.lineTo(322,92);				
			hit_excavate.graphics.lineTo(324,234);				
			hit_excavate.graphics.lineTo(259,257);				
			hit_excavate.graphics.lineTo(67,226);				
			
			
			hit_excavate.graphics.endFill(false);
			
			hit_excavate.alpha = 0.0;
			
			hit_excavate.graphics.precisionHitTest = true;	
			this.addChild(hit_excavate);
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
					}else if(hit_excavate.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((MountainDigExcavate as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainDigExcavateObj,true
						);
						
					}else if(hit_supply.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((MountainDigSupply as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainDigSupplyObj,true
						);
						
					}else if(hit_sediment.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Long planks of wood hold the layers of sediment in place.");
						
					}else if(hit_topWood.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The wooden structure is supporting tons of weight.");
						
					}
					
					/*
					private var hit_sediment:Shape;
					private var hit_topWood:Shape;
					
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
			
			
			this.assets.removeTexture("mountainDig_bg",true);
			this.assets.removeTexture("MountainDig_Sprite",true);
			this.assets.removeTextureAtlas("MountainDig_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("mountainDig_01");
			(stage.getChildAt(0) as Object).falseAsset("mountainDig_02");
			(stage.getChildAt(0) as Object).falseAsset("mountainDig_03");
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
