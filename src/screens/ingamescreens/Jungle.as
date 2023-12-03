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
	
	
	public class Jungle extends Sprite
	{
		
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var flower:Image;
		private var door:Image;
		private var ladder:Image;
		
		private var hit_JungleDeep:Shape;
		private var hit_JungleSubmarine:Shape;
		private var hit_JungleFlowers:Shape;
		
		private var hit_tree:Shape;
		private var hit_ground:Shape;
		private var hit_forest:Shape;
		private var hit_roots:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		private var goback:GoBackButton;		
		public function Jungle(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Jungle/jungle_bg.jpg'));
				game.TrackAssets('jungle_01');
			}
			if(game.CheckAsset('jungle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Jungle/Jungle_Sprite.png'));
				game.TrackAssets('jungle_02');
			}
			if(game.CheckAsset('jungle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Jungle/Jungle_Sprite.xml'));
				game.TrackAssets('jungle_03');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Jungle","JungleObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			flower = new Image(this.assets.getTexture('flower'));
			flower.touchable = false;
			flower.x = 330;
			flower.y = 205;
					
			door = new Image(this.assets.getTexture('f_sub_door'));
			door.touchable = false;
			door.x = 609;
			door.y = 185;

			ladder = new Image(this.assets.getTexture('f_sub_ladder'));
			ladder.touchable = false;
			ladder.x = 628;
			ladder.y = 221;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine['Ladder'] == 'Attached'){
				//	LadderAttached = true;
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
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle["Flower"] == "PickedUp"){
					flower.alpha = 0;
				}else{
					flower.alpha = 1;
				}
			}else{
				flower.alpha = 1;
			}
			
			
		//	door.alpha = 1;
		//	ladder.alpha = 1;
			
			this.addChildAt(flower,1);
			this.addChildAt(door,2);
			this.addChildAt(ladder,3);
			
			CreateHitTree();
			CreateHitGround();
			CreateHitRoots();
			CreateHitForest();
			CreateHitDeepJungle();
			CreateHitJungleSubmarine();
			CreateHitJungleFlowers();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		//	SaveArray['FirstTime'] = 'no';
			
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Jungle',SaveArray);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadJungle_01(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Jungle',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadMoonBeams(true,2);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Jungle',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadMoonBeams(true,2);
					},0.5);
				}
			}
			
		}
		
		//hit_roots
		
		private function CreateHitRoots():void{
			hit_roots = new Shape();
			hit_roots.touchable = false;
			hit_roots.graphics.beginFill(0xff0000);
			
			hit_roots.graphics.lineTo(371,163);	
			hit_roots.graphics.lineTo(436,141);	
			hit_roots.graphics.lineTo(470,256);	
			hit_roots.graphics.lineTo(446,271);	
			hit_roots.graphics.lineTo(407,241);	
		
			hit_roots.alpha = 0.0;
			
			hit_roots.graphics.precisionHitTest = true;	
			this.addChild(hit_roots);
		}
		
		
		private function CreateHitForest():void{
			hit_forest = new Shape();
			hit_forest.touchable = false;
			hit_forest.graphics.beginFill(0xff0000);
			
			hit_forest.graphics.lineTo(701,126);	
			hit_forest.graphics.lineTo(795,120);	
			hit_forest.graphics.lineTo(796,361);	
			hit_forest.graphics.lineTo(706,390);	
		
			hit_forest.alpha = 0.0;
			
			hit_forest.graphics.precisionHitTest = true;	
			this.addChild(hit_forest);
		}
		
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(110,325);	
			hit_ground.graphics.lineTo(313,334);	
			hit_ground.graphics.lineTo(472,343);	
			hit_ground.graphics.lineTo(642,409);	
			hit_ground.graphics.lineTo(594,504);	
			hit_ground.graphics.lineTo(173,500);	
			hit_ground.graphics.lineTo(108,412);	
			
			
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitTree():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(219,0);	
			hit_tree.graphics.lineTo(431,0);	
			hit_tree.graphics.lineTo(434,139);	
			hit_tree.graphics.lineTo(323,175);	
			hit_tree.graphics.lineTo(264,170);	
	
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function CreateHitJungleFlowers():void{
			hit_JungleFlowers = new Shape();
			hit_JungleFlowers.touchable = false;
			hit_JungleFlowers.graphics.beginFill(0xff0000);
			
			hit_JungleFlowers.graphics.lineTo(292,256);	
			hit_JungleFlowers.graphics.lineTo(332,185);	
			hit_JungleFlowers.graphics.lineTo(371,196);	
			hit_JungleFlowers.graphics.lineTo(406,247);	
			hit_JungleFlowers.graphics.lineTo(381,334);	
			hit_JungleFlowers.graphics.lineTo(316,331);	

		
			hit_JungleFlowers.alpha = 0.0;
			
			hit_JungleFlowers.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleFlowers);
		}
		
		private function CreateHitJungleSubmarine():void{
			hit_JungleSubmarine = new Shape();
			hit_JungleSubmarine.touchable = false;
			hit_JungleSubmarine.graphics.beginFill(0xff0000);
			
			hit_JungleSubmarine.graphics.lineTo(505,119);	
			hit_JungleSubmarine.graphics.lineTo(539,91);	
			hit_JungleSubmarine.graphics.lineTo(686,109);	
			hit_JungleSubmarine.graphics.lineTo(674,368);	
			hit_JungleSubmarine.graphics.lineTo(638,391);	
			hit_JungleSubmarine.graphics.lineTo(505,327);	
					
			hit_JungleSubmarine.alpha = 0.0;
			
			hit_JungleSubmarine.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleSubmarine);
		}
		
		
		private function CreateHitDeepJungle():void{
			hit_JungleDeep = new Shape();
			hit_JungleDeep.touchable = false;
			hit_JungleDeep.graphics.beginFill(0xff0000);
			
			hit_JungleDeep.graphics.lineTo(75,172);	
			hit_JungleDeep.graphics.lineTo(125,0);	
			hit_JungleDeep.graphics.lineTo(215,0);	
			hit_JungleDeep.graphics.lineTo(270,220);	
			hit_JungleDeep.graphics.lineTo(261,247);	
			hit_JungleDeep.graphics.lineTo(120,309);	
			hit_JungleDeep.graphics.lineTo(81,273);	
		
			
			hit_JungleDeep.alpha = 0.0;
			
			hit_JungleDeep.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleDeep);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleTarPit as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleTarPitObj,true
						);
					}else if(hit_JungleDeep.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleDeep as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleDeepObj,true
						);
					}else if(hit_JungleSubmarine.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((JungleSubmarine as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleSubmarineObj,true
						);	
					}else if(hit_JungleFlowers.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FlowersHandler();
					
					}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The trees grow tall and form a dense canopy high above.");
						
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Drying mud curls around stones and pebbles on the forest floor.");
						
					}else if(hit_forest.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The forest continues for as far as I can see.");

					}else if(hit_roots.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The tree roots cling to rocks. "Life finds a way..."');
						
					}
					/*
					
					private var hit_tree:Shape;
					private var hit_ground:Shape;
					private var hit_forest:Shape;
					*/
					
				}
			}
		}
		
		private function FlowersHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle["Flower"] == "PickedUp"){
					
				}else{
					flower.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Jungle;
					SaveArray['Flower'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Jungle',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Flower,
						'item_Flower',
						'inven_flower_sm'
					);
					
					
				}
			}else{
				flower.alpha = 0;
				SaveArray['Flower'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Jungle',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Flower,
					'item_Flower',
					'inven_flower_sm'
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
			
			
			this.assets.removeTexture("jungle_bg",true);
			this.assets.removeTexture("Jungle_Sprite",true);
			this.assets.removeTextureAtlas("Jungle_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungle_01");
			(stage.getChildAt(0) as Object).falseAsset("jungle_02");
			(stage.getChildAt(0) as Object).falseAsset("jungle_03");
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


