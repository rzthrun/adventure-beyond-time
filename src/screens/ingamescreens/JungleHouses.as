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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class JungleHouses extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var door:Image;
		private var mountainDig_dragonball:Image;
		private var mountainDig_hominid:Image;
		private var roof_sat:Image;
		private var ladder:Image;
		
		private var hit_Dig:Shape;
		private var hit_Lab:Shape;
		private var hit_Roof:Shape;
		private var hit_Temple:Shape;
		private var hit_Ladder:Shape;
		
		private var hit_tree:Shape;
		private var hit_ground:Shape;
		private var hit_burntTree:Shape;
		private var hit_mountain:Shape;
		private var hit_house:Shape;
		
		private var LadderAttached:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public function JungleHouses(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleHouses_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHouses/jungleHouses_bg.jpg'));
				game.TrackAssets('jungleHouses_01');
			}
			if(game.CheckAsset('jungleHouses_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHouses/JungleHouse_Sprite.png'));
				game.TrackAssets('jungleHouses_02');
			}
			if(game.CheckAsset('jungleHouses_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleHouses/JungleHouse_Sprite.xml'));
				game.TrackAssets('jungleHouses_04');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleHouses","JungleHousesObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleHouses_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			door = new Image(this.assets.getTexture('door'));
		//	door.smoothing = TextureSmoothing.NONE;
			door.touchable = false;
			door.x = 459;
			door.y = 299;
			
			
			ladder = new Image(this.assets.getTexture('ladder'));
		//	ladder.smoothing = TextureSmoothing.NONE;
			ladder.touchable = false;
			ladder.x = 595;
			ladder.y = 141;
			
			
			mountainDig_hominid = new Image(this.assets.getTexture('mountain_digsite_hominid'));
		//	mountainDig_hominid.smoothing = TextureSmoothing.NONE;
			mountainDig_hominid.touchable = false;
			mountainDig_hominid.x = 80;
			mountainDig_hominid.y = 244;
		
			
			mountainDig_dragonball = new Image(this.assets.getTexture('mountain_digsite_dragonball'));
		//	mountainDig_dragonball.smoothing = TextureSmoothing.NONE;
			mountainDig_dragonball.touchable = false;
			mountainDig_dragonball.x = 104;
			mountainDig_dragonball.y = 270;
		
			
			roof_sat = new Image(this.assets.getTexture('roof_sat'));
		//	roof_sat.smoothing = TextureSmoothing.NONE;
			roof_sat.touchable = false;
			roof_sat.x = 465;
			roof_sat.y = 175;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses["Door"] == "Open"){
					door.alpha = 1;
				}else{
					door.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses["Ladder"] == "Attached"){
					LadderAttached = true;
					ladder.alpha = 1;
				}else{
					ladder.alpha = 0;
				}
				
			}else{
				door.alpha = 0;
				ladder.alpha = 0;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'PickedUp'){
					mountainDig_hominid.alpha = 0;
				}else{
					mountainDig_hominid.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
					mountainDig_dragonball.alpha = 0;
				}else{
					mountainDig_dragonball.alpha = 1;
				}
			}else{
				mountainDig_dragonball.alpha = 1;
				mountainDig_hominid.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['SatDish'] == 'Attached'){
					roof_sat.alpha = 1;
				}else{
					roof_sat.alpha = 0;
				}
			}else{
				roof_sat.alpha = 0;
			}
			//door.alpha = 0;
	//		ladder.alpha = 1;
	//		mountainDig_hominid.alpha = 1;
	//		mountainDig_dragonball.alpha = 1;
			
			
			this.addChildAt(door,1);
			this.addChildAt(ladder,2);		
			this.addChildAt(mountainDig_hominid,3);		
			this.addChildAt(mountainDig_dragonball,4);	
			this.addChildAt(roof_sat,5);
			
			CreateHitTree();
			CreateHitHouse();
			CreateHitGround();
			CreateHitMountain();
			CreateHitBurnTrees()
			
			CreateHitLadder();
			CreateHitRoof();
			CreateHitLab();
			CreateHitDig();
			CreateHitTemple();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("ElectricHum",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("WindOne",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crickets_01",0,0.5,'stop');

			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'BirdsOne';
			},0.7);
		}
		
		private function CreateHitTree():void{
			hit_tree = new Shape();
			hit_tree.touchable = false;
			hit_tree.graphics.beginFill(0xff0000);
			
			hit_tree.graphics.lineTo(486,156);							
			hit_tree.graphics.lineTo(487,35);							
			hit_tree.graphics.lineTo(541,0);							
			hit_tree.graphics.lineTo(662,0);							
			hit_tree.graphics.lineTo(800,129);							
			hit_tree.graphics.lineTo(800,311);							
			
			hit_tree.graphics.endFill(false);
			hit_tree.alpha = 0.0;
			
			hit_tree.graphics.precisionHitTest = true;	
			this.addChild(hit_tree);
		}
		
		private function CreateHitHouse():void{
			hit_house = new Shape();
			hit_house.touchable = false;
			hit_house.graphics.beginFill(0xff0000);
			
			hit_house.graphics.lineTo(387,276);							
			hit_house.graphics.lineTo(626,229);							
			hit_house.graphics.lineTo(663,392);							
			hit_house.graphics.lineTo(385,432);							
									
			
			hit_house.graphics.endFill(false);
			hit_house.alpha = 0.0;
			
			hit_house.graphics.precisionHitTest = true;	
			this.addChild(hit_house);
		}
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(33,312);							
			hit_ground.graphics.lineTo(375,290);							
			hit_ground.graphics.lineTo(376,477);							
			hit_ground.graphics.lineTo(95,413);							
			
			hit_ground.graphics.endFill(false);
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitMountain():void{
			hit_mountain = new Shape();
			hit_mountain.touchable = false;
			hit_mountain.graphics.beginFill(0xff0000);
			
			hit_mountain.graphics.lineTo(0,81);							
			hit_mountain.graphics.lineTo(181,0);							
			hit_mountain.graphics.lineTo(270,0);							
			hit_mountain.graphics.lineTo(296,55);							
			hit_mountain.graphics.lineTo(236,110);							
			
			hit_mountain.graphics.endFill(false);
			hit_mountain.alpha = 0.0;
			
			hit_mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_mountain);
		}
		
		private function CreateHitBurnTrees():void{
			hit_burntTree = new Shape();
			hit_burntTree.touchable = false;
			hit_burntTree.graphics.beginFill(0xff0000);
			
			hit_burntTree.graphics.lineTo(32,125);							
			hit_burntTree.graphics.lineTo(78,111);							
			hit_burntTree.graphics.lineTo(238,139);							
			hit_burntTree.graphics.lineTo(301,211);							
			hit_burntTree.graphics.lineTo(295,260);							
			hit_burntTree.graphics.lineTo(259,275);							
			hit_burntTree.graphics.lineTo(47,199);							
			
			hit_burntTree.graphics.endFill(false);
			hit_burntTree.alpha = 0.0;
			
			hit_burntTree.graphics.precisionHitTest = true;	
			this.addChild(hit_burntTree);
		}
		
		private function CreateHitTemple():void{
			hit_Temple = new Shape();
			hit_Temple.touchable = false;
			hit_Temple.graphics.beginFill(0xff0000);
			
			hit_Temple.graphics.lineTo(244,121);				
			hit_Temple.graphics.lineTo(319,48);				
			hit_Temple.graphics.lineTo(379,80);				
			hit_Temple.graphics.lineTo(461,161);				
			hit_Temple.graphics.lineTo(458,186);				
			hit_Temple.graphics.lineTo(353,216);				
			hit_Temple.graphics.lineTo(283,203);				
			hit_Temple.graphics.lineTo(246,168);				
			
			hit_Temple.graphics.endFill(false);
			hit_Temple.alpha = 0.0;
			
			hit_Temple.graphics.precisionHitTest = true;	
			this.addChild(hit_Temple);
		}
		
		private function CreateHitRoof():void{
			hit_Roof = new Shape();
			hit_Roof.touchable = false;
			hit_Roof.graphics.beginFill(0xff0000);
				
			hit_Roof.graphics.lineTo(339,255);				
			hit_Roof.graphics.lineTo(359,224);		
			hit_Roof.graphics.lineTo(459,190);		
			hit_Roof.graphics.lineTo(552,120);		
			hit_Roof.graphics.lineTo(695,120);		
		//	hit_Roof.graphics.lineTo(618,147);				
			hit_Roof.graphics.lineTo(696,152);				
			hit_Roof.graphics.lineTo(730,249);				
			hit_Roof.graphics.lineTo(667,236);				
			hit_Roof.graphics.lineTo(633,227);				
			hit_Roof.graphics.lineTo(385,276);				
			hit_Roof.graphics.lineTo(383,263);				
			hit_Roof.graphics.endFill(false);
			hit_Roof.alpha = 0.0;
			
			hit_Roof.graphics.precisionHitTest = true;	
			this.addChild(hit_Roof);
		}
		
		private function CreateHitLadder():void{
			hit_Ladder = new Shape();
			hit_Ladder.touchable = false;
			hit_Ladder.graphics.beginFill(0x00ff00);
			
			hit_Ladder.graphics.lineTo(631,232);				
			hit_Ladder.graphics.lineTo(728,252);				
			hit_Ladder.graphics.lineTo(746,386);				
			hit_Ladder.graphics.lineTo(669,390);				
	
			hit_Ladder.graphics.endFill(false);
			hit_Ladder.alpha = 0.0;
			
			hit_Ladder.graphics.precisionHitTest = true;	
			this.addChild(hit_Ladder);
		}
		
		private function CreateHitDig():void{
			hit_Dig = new Shape();
			hit_Dig.touchable = false;
			hit_Dig.graphics.beginFill(0xff0000);
			
			hit_Dig.graphics.lineTo(55,204);				
			hit_Dig.graphics.lineTo(186,206);				
			hit_Dig.graphics.lineTo(256,240);				
			hit_Dig.graphics.lineTo(255,320);				
			hit_Dig.graphics.lineTo(165,351);				
			hit_Dig.graphics.lineTo(59,332);				
			hit_Dig.graphics.lineTo(46,287);				


			hit_Dig.graphics.endFill(false);
			hit_Dig.alpha = 0.0;
			
			hit_Dig.graphics.precisionHitTest = true;	
			this.addChild(hit_Dig);
		}
		
		private function CreateHitLab():void{
			hit_Lab = new Shape();
			hit_Lab.touchable = false;
			hit_Lab.graphics.beginFill(0xff0000);
			
			hit_Lab.graphics.lineTo(444,296);				
			hit_Lab.graphics.lineTo(539,272);				
			hit_Lab.graphics.lineTo(553,332);				
			hit_Lab.graphics.lineTo(607,378);				
			hit_Lab.graphics.lineTo(570,483);				
			hit_Lab.graphics.lineTo(485,479);				
			hit_Lab.graphics.lineTo(409,409);				
			
			hit_Lab.graphics.endFill(false);
			
			hit_Lab.alpha = 0.0;
			
			hit_Lab.graphics.precisionHitTest = true;	
			this.addChild(hit_Lab);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((JungleRavine as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleRavineObj,true
						);
					}else if(hit_Lab.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LabDoorHandler();
						
					}else if(hit_Dig.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((MountainDig as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainDigObj,true
						);
						
					}else if(hit_Roof.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(LadderAttached === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							FadeOut((RavineRoof as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineRoofObj,true
							);
							
						}else{
							LadderHandler("ROOF");
						}
						
					}else if(hit_Ladder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LadderHandler("SIDE");
					}else if(hit_Temple.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((MountainTemple as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.MountainTempleObj,true
						);
					}else if(hit_house.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The house looks recently constructed from green timber.");
						
					}else if(hit_burntTree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Burnt trees dot the hillside.");
						
					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The hillside shows evidence of recent erosion.");
						
					}else if(hit_mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The precipice towers overhead.");
					}else if(hit_tree.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The nearby jungle screams with life.");
						
					}
					
					
					/*
					private var hit_tree:Shape;
					private var hit_ground:Shape;
					private var hit_burntTree:Shape;
					private var hit_mountain:Shape;
					private var hit_house:Shape;
					*/
				}
			}
		}
		
		private function LadderHandler(ClickOrg:String):void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Ladder)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				LadderAttached = true;
				ladder.alpha = 1;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses;
				}	
				SaveArray['Ladder'] = 'Attached';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHouses',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Ladder,
						"item_Ladder"
					);
			}else{
				if(ClickOrg == 'ROOF'){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I wonder if there's anyway to get onto the roof...");
				}else if(ClickOrg == 'SIDE'){
					if(LadderAttached === false){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hmm... There is a little bit of space beside the structure.");
					}else{
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
						LadderAttached = false;
						ladder.alpha = 0;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses;
						}
						SaveArray['Ladder'] = "NotAttached";
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHouses',SaveArray);
						
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
							(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ladder,
							'item_Ladder',
							'inven_ladder_sm'
						);	
					}
				}
			}
		}
		
		private function LabDoorHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses["Door"] == "Open"){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();
					FadeOut((Lab as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.LabObj,true
					);
				}else{
				
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Knot();
					door.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses;
					}
					SaveArray['Door'] = "Open";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHouses',SaveArray);
					
				}
			}else{
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Knot();
				door.alpha = 1;
				SaveArray['Door'] = "Open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleHouses',SaveArray);
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
			
			
			//	this.removeChild(goback);
			//	goback = null;			
			
			
			this.assets.removeTexture("jungleHouses_bg",true);
			this.assets.removeTexture("JungleHouse_Sprite",true);
			this.assets.removeTextureAtlas("JungleHouse_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleHouses_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleHouses_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleHouses_03");
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