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
	
	public class JungleRavine extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var spaceShip_door:Image;
		private var dig_skull:Image;
		private var dig_hand:Image;
		private var hominid:Image;
		private var dragonball:Image;
		private var plane_panels:Image;
		private var house_door:Image;
		private var house_sat_dish:Image;
		private var house_ladder:Image;
		
		
		
		private var hit_JungleHouses:Shape;
		private var hit_RavineDig:Shape;
		private var hit_RavineSpaceShip:Shape;
		private var hit_Plane:Shape;
		
		private var hit_plant:Shape;
		private var hit_sky:Shape;
		private var hit_ground:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
	
		private var goback:GoBackButton;
		
		
		public function JungleRavine(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleRavine_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleRavine/jungleRavine_bg.jpg'));
				game.TrackAssets('jungleRavine_01');
			}
			if(game.CheckAsset('jungleRavine_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleRavine/JungleRavine_Sprite.png'));
				game.TrackAssets('jungleRavine_02');
			}
			if(game.CheckAsset('jungleRavine_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleRavine/JungleRavine_Sprite.xml'));
				game.TrackAssets('jungleRavine_03');
			}

			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();

					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleRavine","JungleRavineObj");
				} 				
			});	

		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleRavine_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			spaceShip_door = new Image(this.assets.getTexture('ship_door_open'));
		//	spaceShip_door.smoothing = TextureSmoothing.NONE;
			spaceShip_door.touchable = false;
			spaceShip_door.x = 156;
			spaceShip_door.y = 190;
			
			
			dig_skull = new Image(this.assets.getTexture('dig_skull'));
		//	dig_skull.smoothing = TextureSmoothing.NONE;
			dig_skull.touchable = false;
			dig_skull.x = 338;
			dig_skull.y = 277;
			

			dig_hand = new Image(this.assets.getTexture('dig_hand'));
		//	dig_hand.smoothing = TextureSmoothing.NONE;
			dig_hand.touchable = false;
			dig_hand.x = 384;
			dig_hand.y = 286;
			
				
			hominid = new Image(this.assets.getTexture('mountain_dig_hominid'));
		//	hominid.smoothing = TextureSmoothing.NONE;
			hominid.touchable = false;
			hominid.x = 487;
			hominid.y = 108;
			
				
			dragonball = new Image(this.assets.getTexture('mountain_dig_dragonball'));
		//	dragonball.smoothing = TextureSmoothing.NONE;
			dragonball.touchable = false;
			dragonball.x = 503;
			dragonball.y = 119;
			
				
			plane_panels = new Image(this.assets.getTexture('plane_left_off'));
		//	plane_panels.smoothing = TextureSmoothing.NONE;
			plane_panels.touchable = false;
			plane_panels.x = 108;
			plane_panels.y = 331;
		
			house_door = new Image(this.assets.getTexture('house_door'));
		//	house_door.smoothing = TextureSmoothing.NONE;
			house_door.touchable = false;
			house_door.x = 590;
			house_door.y = 154;
	
			house_sat_dish = new Image(this.assets.getTexture('house_roof_sat'));
		//	house_sat_dish.smoothing = TextureSmoothing.NONE;
			house_sat_dish.touchable = false;
			house_sat_dish.x = 596;
			house_sat_dish.y = 84;
			
			house_ladder = new Image(this.assets.getTexture('house_ladder'));
		//	house_ladder.smoothing = TextureSmoothing.NONE;
			house_ladder.touchable = false;
			house_ladder.x = 617;
			house_ladder.y = 91;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Left'] == 'Open'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Right'] == 'Open'){
						plane_panels.texture = this.assets.getTexture('plane_both_off');
						plane_panels.alpha = 1;					
					}else{
						plane_panels.texture = this.assets.getTexture('plane_left_off');
						plane_panels.alpha = 1;		
					}
				}else{
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavinePlane['Right'] == 'Open'){
						plane_panels.texture = this.assets.getTexture('plane_right_off');
						plane_panels.alpha = 1;					
					}else{
						plane_panels.alpha = 0;
					}
				}
			}else{
				plane_panels.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Skull'] == 'PickedUp'){
					dig_skull.alpha = 0;
				}else{
					dig_skull.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineDig['Hand'] == 'PickedUp'){
					dig_hand.alpha = 0;
				}else{
					dig_hand.alpha = 1;
				}
			}else{
				dig_skull.alpha = 1;
				dig_hand.alpha = 1;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['Hominid'] == 'PickedUp'){
					hominid.alpha = 0;
				}else{
					hominid.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.MountainDigExcavate['DragonBall'] == 'PickedUp'){
					dragonball.alpha = 0;
				}else{
					dragonball.alpha = 1;
				}
			}else{
				hominid.alpha = 1;
				dragonball.alpha = 1;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses != undefined){
				trace("HOUSE : 1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses["Door"] == "Open"){
					house_door.alpha = 0;
				}else{
					house_door.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleHouses["Ladder"] == "Attached"){
					trace("HOUSE : 2");
					house_ladder.alpha = 1;
				}else{
					trace("HOUSE : 3");
					house_ladder.alpha = 0;
				}
			}else{
				trace("HOUSE : 4");
				house_ladder.alpha = 0;
				house_door.alpha = 1;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineRoof['SatDish'] == 'Attached'){
					house_sat_dish.alpha = 1;
				}else{
					house_sat_dish.alpha = 0;
				}
			}else{
				house_sat_dish.alpha = 0;
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RavineSpaceShipDoor['Door'] == 'Open'){
					spaceShip_door.alpha = 1;
				}else{
					spaceShip_door.alpha = 0;
				}
			}else{
				spaceShip_door.alpha = 0;
			}
			
			
			
			this.addChildAt(spaceShip_door,1)
			this.addChildAt(dig_skull,2)			
			this.addChildAt(dig_hand,3)		
			this.addChildAt(hominid,4)			
			this.addChildAt(dragonball,5)			
			this.addChildAt(plane_panels,6)				
			this.addChildAt(house_door,7)			
			this.addChildAt(house_sat_dish,8)		
			this.addChildAt(house_ladder,9)		
			
			CreateHitGround();
			CreateHitSky();
			CreateHitPlant();
			CreateHitJungleHouses();
			CreateHitRavineDig();
			CreateHitRavinesSpaceShip();
			CreateHitPlane();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).AmbientObj.LoadCrows(true,999);
				(stage.getChildAt(0) as Object).AmbientObj.currentAmbient = 'Crows';
			},0.7);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleRavine != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleRavine['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleRavine;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleRavine',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
						},0.5);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleRavine',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
					},0.5);
				}
			}
		}
		//hit_RavineDig
		//hit_RavineSpaceShip
		//hit_ground
		
		private function CreateHitGround():void{
			hit_ground = new Shape();
			hit_ground.touchable = false;
			hit_ground.graphics.beginFill(0xff0000);
			
			hit_ground.graphics.lineTo(307,363);	

			hit_ground.graphics.lineTo(431,320);	
			hit_ground.graphics.lineTo(611,415);	
			hit_ground.graphics.lineTo(545,506);	
			hit_ground.graphics.lineTo(263,504);	
			
			
			hit_ground.alpha = 0.0;
			
			hit_ground.graphics.precisionHitTest = true;	
			this.addChild(hit_ground);
		}
		
		private function CreateHitSky():void{
			hit_sky = new Shape();
			hit_sky.touchable = false;
			hit_sky.graphics.beginFill(0xff0000);
			
			hit_sky.graphics.lineTo(210,38);	
			hit_sky.graphics.lineTo(406,0);	
			hit_sky.graphics.lineTo(511,0);	
			hit_sky.graphics.lineTo(339,108);	
			
			hit_sky.alpha = 0.0;
			
			hit_sky.graphics.precisionHitTest = true;	
			this.addChild(hit_sky);
		}
		
		private function CreateHitPlant():void{
			hit_plant = new Shape();
			hit_plant.touchable = false;
			hit_plant.graphics.beginFill(0xff0000);
			
			hit_plant.graphics.lineTo(562,385);	
			hit_plant.graphics.lineTo(588,272);	
			hit_plant.graphics.lineTo(698,245);	
			hit_plant.graphics.lineTo(748,383);	
			
			hit_plant.alpha = 0.0;
			
			hit_plant.graphics.precisionHitTest = true;	
			this.addChild(hit_plant);
		}
		
		private function CreateHitPlane():void{
			hit_Plane = new Shape();
			hit_Plane.touchable = false;
			hit_Plane.graphics.beginFill(0xff0000);
			
			hit_Plane.graphics.lineTo(61,291);	
			hit_Plane.graphics.lineTo(88,257);	
			hit_Plane.graphics.lineTo(265,335);	
			hit_Plane.graphics.lineTo(304,387);	
			hit_Plane.graphics.lineTo(298,417);	
			hit_Plane.graphics.lineTo(184,471);	
			hit_Plane.graphics.lineTo(54,355);	

			hit_Plane.alpha = 0.0;
			
			hit_Plane.graphics.precisionHitTest = true;	
			this.addChild(hit_Plane);
		}
		
		private function CreateHitRavinesSpaceShip():void{
			hit_RavineSpaceShip = new Shape();
			hit_RavineSpaceShip.touchable = false;
			hit_RavineSpaceShip.graphics.beginFill(0xff0000);
			
			hit_RavineSpaceShip.graphics.lineTo(76,193);	
			hit_RavineSpaceShip.graphics.lineTo(108,96);	
			hit_RavineSpaceShip.graphics.lineTo(206,76);	
			hit_RavineSpaceShip.graphics.lineTo(300,119);	
			hit_RavineSpaceShip.graphics.lineTo(244,305);	
			hit_RavineSpaceShip.graphics.lineTo(120,263);	
						
			hit_RavineSpaceShip.alpha = 0.0;
			
			hit_RavineSpaceShip.graphics.precisionHitTest = true;	
			this.addChild(hit_RavineSpaceShip);
		}
		private function CreateHitRavineDig():void{
			hit_RavineDig = new Shape();
			hit_RavineDig.touchable = false;
			hit_RavineDig.graphics.beginFill(0xff0000);
			
			hit_RavineDig.graphics.lineTo(275,250);	
			hit_RavineDig.graphics.lineTo(319,208);	
			hit_RavineDig.graphics.lineTo(407,209);	
			hit_RavineDig.graphics.lineTo(432,217);	
			hit_RavineDig.graphics.lineTo(460,237);	
			hit_RavineDig.graphics.lineTo(459,266);	
			hit_RavineDig.graphics.lineTo(410,326);	
			hit_RavineDig.graphics.lineTo(319,354);	
			hit_RavineDig.graphics.lineTo(270,334);	
			
			hit_RavineDig.alpha = 0.0;
			
			hit_RavineDig.graphics.precisionHitTest = true;	
			this.addChild(hit_RavineDig);
		}
		
		private function CreateHitJungleHouses():void{
			hit_JungleHouses = new Shape();
			hit_JungleHouses.touchable = false;
			hit_JungleHouses.graphics.beginFill(0xff0000);
			
			hit_JungleHouses.graphics.lineTo(406,135);	
			hit_JungleHouses.graphics.lineTo(443,71);	
			hit_JungleHouses.graphics.lineTo(586,88);	
			hit_JungleHouses.graphics.lineTo(654,77);	
			hit_JungleHouses.graphics.lineTo(704,136);	
			hit_JungleHouses.graphics.lineTo(576,254);	
			hit_JungleHouses.graphics.lineTo(476,233);	
			hit_JungleHouses.graphics.lineTo(410,206);	
			
			hit_JungleHouses.alpha = 0.0;
			
			hit_JungleHouses.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleHouses);
		}

		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((RavineCanyonRear as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonRearObj,true
						);
					}else if(hit_JungleHouses.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((JungleHouses as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleHousesObj,true
						);
					}else if(hit_RavineDig.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineDig as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineDigObj,true
						);
					}else if(hit_RavineSpaceShip.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavineSpaceShip as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipObj,true
						);
					}else if(hit_Plane.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((RavinePlane as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RavinePlaneObj,true
						);
					}else if(hit_plant.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The plant's leaves reach out from the shadows.");

					}else if(hit_sky.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Rolling hills glimmer in the distance.");

					}else if(hit_ground.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Sparse clumps of grass grow amongst the dirt and mud..");
						
					}
					
					/*
					private var hit_plant:Shape;
					private var hit_sky:Shape;
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
			
			
		//	this.removeChild(goback);
		//	goback = null;			
			
			
			this.assets.removeTexture("jungleRavine_bg",true);
			this.assets.removeTexture("JungleRavine_Sprite",true);
			this.assets.removeTextureAtlas("JungleRavine_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleRavine_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleRavine_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleRavine_03");
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
