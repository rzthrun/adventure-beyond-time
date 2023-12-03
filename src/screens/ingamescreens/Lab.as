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
	
	public class Lab extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var computer_screen:Image;
		private var lid:Image;
		private var alcohol:Image;
		private var solder:Image;
		private var mortar:Image;
		private var slide:Image;
		private var hose:Image;
		private var machine_screen:Image;
		private var goo:Image;
		private var crystal:Image;
		private var stone:Image;
		
		private var hit_desk:Shape;;
		private var hit_equipment:Shape;
		
		private var hit_carpet:Shape;
		private var hit_books:Shape;
		private var hit_stool:Shape;
		private var hit_barrel:Shape;
		private var hit_box:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		
		private var goback:GoBackButton;
		public function Lab(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('lab_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Lab/lab_bg.jpg'));
				game.TrackAssets('lab_01');
			}
			if(game.CheckAsset('lab_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Lab/Lab_Sprite.png'));
				game.TrackAssets('lab_02');
			}
			if(game.CheckAsset('lab_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/Lab/Lab_Sprite.xml'));
				game.TrackAssets('lab_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("Lab","LabObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('lab_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			lid = new Image(this.assets.getTexture('desk_lid'));
			lid.touchable = false;
			lid.x = 144;
			lid.y = 41;
			
			
			alcohol = new Image(this.assets.getTexture('desk_alcohol_closed'));
			alcohol.touchable = false;
			alcohol.x = 161;
			alcohol.y = 103;

			
			alcohol = new Image(this.assets.getTexture('desk_alcohol_closed'));
			alcohol.touchable = false;
			alcohol.x = 161;
			alcohol.y = 103;

			
			computer_screen = new Image(this.assets.getTexture('equipment_screen'));
			computer_screen.touchable = false;
			computer_screen.x = 24;
			computer_screen.y = 140;
			
			
			solder = new Image(this.assets.getTexture('desk_solder'));
			solder.touchable = false;
			solder.x = 258;
			solder.y = 241;
			
			
			mortar = new Image(this.assets.getTexture('desk_mortar'));
			mortar.touchable = false;
			mortar.x = 231;
			mortar.y = 235;

			
			slide = new Image(this.assets.getTexture('equipment_slide'));
			slide.touchable = false;
			slide.x = 358;
			slide.y = 215;
			
			
			hose = new Image(this.assets.getTexture('equipment_hose'));
			hose.touchable = false;
			hose.x = 522;
			hose.y = 137;
		
			
			machine_screen = new Image(this.assets.getTexture('equipment_machine_machine_screen'));
			machine_screen.touchable = false;
			machine_screen.x = 458;
			machine_screen.y = 90;
			
			
			goo = new Image(this.assets.getTexture('equipment_printer_goo'));
			goo.touchable = false;
			goo.x = 611;
			goo.y = 213;
			
			
			crystal = new Image(this.assets.getTexture('equipment_printer_crystal'));
			crystal.touchable = false;
			crystal.x = 6245;
			crystal.y = 191;
			
			
			stone = new Image(this.assets.getTexture('equipment_printer_stone'));
			stone.touchable = false;
			stone.x = 674;
			stone.y = 184;
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Solder"] == "PickedUp"){
					solder.alpha = 0;
				}else{
					solder.alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDeskDetail["Mortar"] == "PickedUp"){
					mortar.alpha = 0;
					
				}else{
					mortar.alpha = 1;
				}
			}else{
				solder.alpha = 1;
				mortar.alpha = 1;
			}
			
			
		
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk['Cabinet'] == 'Open'){

					lid.alpha = 0;
					alcohol.texture = this.assets.getTexture('desk_alcohol_open');
				}else{
					lid.alpha = 1;
				}		
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Alcohol"] == "PickedUp"){
					alcohol.alpha = 0;
				}else{
					alcohol.alpha = 1;
				}

				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabDesk["Computer"] == "On"){

					computer_screen.alpha = 1;
				}else{
					computer_screen.alpha = 0;
				}

			}else{
				lid.alpha = 1;
				alcohol.alpha = 1;
				
				computer_screen.alpha = 0;
			}
			
		
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['MachineOn'] == 'Yes'){
					machine_screen.alpha = 1;
				}else{
					machine_screen.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Slide'] == 'Attached'){
					slide.alpha = 1;
				}else{
					slide.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Hose'] == 'Attached'){
					hose.alpha = 1;
				}else{
					hose.alpha = 0;
				}
			}else{
				
				slide.alpha = 0;	
				hose.alpha = 0;		
				machine_screen.alpha = 0;
			}
		
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Stone'] == 'Attached'){
					stone.alpha = 1;
				}else{
					stone.alpha = 0;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Goo'] == 'Attached'){
					goo.alpha = 1;
				}else{
					goo.alpha = 0;
				}
			}else{
				goo.alpha = 0;
				
				stone.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabEquipment['Crystal'] == 'Printed'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter != undefined){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.LabPrinter['Crystal'] == 'PickedUp'){						
							crystal.alpha = 0;
						}else{							
							crystal.alpha = 1;
						}
					}else{
						crystal.alpha = 1;
					}
				}else{
					crystal.alpha = 0;
				}
			}else{
				crystal.alpha = 0;
			}
			
			
			
			this.addChildAt(lid,1);
			this.addChildAt(alcohol,2);			
			this.addChildAt(computer_screen,3);			
			this.addChildAt(solder,4);						
			this.addChildAt(mortar,5);					
			this.addChildAt(slide,6);				
			this.addChildAt(hose,7);							
			this.addChildAt(machine_screen,8);						
			this.addChildAt(goo,9);		
			this.addChildAt(crystal,10);			
			this.addChildAt(stone,11);
			
			CreateHitCrate();
			CreateHitBarrel();
			CreateHitCarpet();
			CreateHitBooks();
			CreateHitStool();
			
			CreateHitEquipment();
			CreateHitDesk();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Lab != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Lab['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Lab;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Lab',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadPianoOne(true,2);
						},0.4);
					}
				}
				
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					SaveArray['FirstTime'] = 'Yes';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Lab',SaveArray);
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadPianoOne(true,2);
					},0.4);
				}
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Lab != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Lab['SeenIt'] == 'Yes'){
					
				}else{
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.Lab;
					SaveArray['SeenIt'] = 'Yes';					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Lab',SaveArray);				
				}				
			}else{
				SaveArray['SeenIt'] = 'Yes';
				
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('Lab',SaveArray);
			}
			
			
		}
		
		private function CreateHitCrate():void{
			hit_box = new Shape();
			hit_box.touchable = false;
			hit_box.graphics.beginFill(0xff0000);
			
			hit_box.graphics.lineTo(601,295);				
			hit_box.graphics.lineTo(790,271);				
			hit_box.graphics.lineTo(791,382);				
			hit_box.graphics.lineTo(696,399);				
			hit_box.graphics.lineTo(626,378);				
		
			hit_box.graphics.endFill(false);
			
			hit_box.alpha = 0.0;
			
			hit_box.graphics.precisionHitTest = true;	
			this.addChild(hit_box);
		}
		
		private function CreateHitBarrel():void{
			hit_barrel = new Shape();
			hit_barrel.touchable = false;
			hit_barrel.graphics.beginFill(0xff0000);
			
			hit_barrel.graphics.lineTo(363,253);				
			hit_barrel.graphics.lineTo(435,284);				
			hit_barrel.graphics.lineTo(423,380);				
			hit_barrel.graphics.lineTo(357,389);				
			hit_barrel.graphics.lineTo(330,309);				
									
			
			hit_barrel.graphics.endFill(false);
			
			hit_barrel.alpha = 0.0;
			
			hit_barrel.graphics.precisionHitTest = true;	
			this.addChild(hit_barrel);
		}
		
		private function CreateHitStool():void{
			hit_stool = new Shape();
			hit_stool.touchable = false;
			hit_stool.graphics.beginFill(0xff0000);
			
			hit_stool.graphics.lineTo(105,366);				
			hit_stool.graphics.lineTo(238,336);				
			hit_stool.graphics.lineTo(275,370);				
			hit_stool.graphics.lineTo(272,506);				
			hit_stool.graphics.lineTo(124,505);										
			
			hit_stool.graphics.endFill(false);
			
			hit_stool.alpha = 0.0;
			
			hit_stool.graphics.precisionHitTest = true;	
			this.addChild(hit_stool);
		}
		private function CreateHitBooks():void{
			hit_books = new Shape();
			hit_books.touchable = false;
			hit_books.graphics.beginFill(0xff0000);
			
			hit_books.graphics.lineTo(140,0);				
			hit_books.graphics.lineTo(388,0);				
			hit_books.graphics.lineTo(486,25);				
			hit_books.graphics.lineTo(678,0);				
			hit_books.graphics.lineTo(668,49);				
			hit_books.graphics.lineTo(449,57);				
			hit_books.graphics.lineTo(405,73);				
			hit_books.graphics.lineTo(105,30);				
			
			hit_books.graphics.endFill(false);
			
			hit_books.alpha = 0.0;
			
			hit_books.graphics.precisionHitTest = true;	
			this.addChild(hit_books);
		}
		private function CreateHitCarpet():void{
			hit_carpet = new Shape();
			hit_carpet.touchable = false;
			hit_carpet.graphics.beginFill(0xff0000);
			
			hit_carpet.graphics.lineTo(178,504);				
			hit_carpet.graphics.lineTo(497,378);				
			hit_carpet.graphics.lineTo(635,408);				
			hit_carpet.graphics.lineTo(605,508);				
		
			hit_carpet.graphics.endFill(false);
			
			hit_carpet.alpha = 0.0;
			
			hit_carpet.graphics.precisionHitTest = true;	
			this.addChild(hit_carpet);
		}
		
		private function CreateHitEquipment():void{
			hit_equipment = new Shape();
			hit_equipment.touchable = false;
			hit_equipment.graphics.beginFill(0xff0000);
			
			hit_equipment.graphics.lineTo(304,132);				
			hit_equipment.graphics.lineTo(452,64);				
			hit_equipment.graphics.lineTo(669,58);				
			hit_equipment.graphics.lineTo(680,96);				
			hit_equipment.graphics.lineTo(781,126);				
			hit_equipment.graphics.lineTo(772,272);				
			hit_equipment.graphics.lineTo(503,305);				
			hit_equipment.graphics.lineTo(310,229);				
			
			
			hit_equipment.graphics.endFill(false);
			
			hit_equipment.alpha = 0.0;
			
			hit_equipment.graphics.precisionHitTest = true;	
			this.addChild(hit_equipment);
		}
		
		private function CreateHitDesk():void{
			hit_desk = new Shape();
			hit_desk.touchable = false;
			hit_desk.graphics.beginFill(0xff0000);
			
			hit_desk.graphics.lineTo(0,101);				
			hit_desk.graphics.lineTo(102,37);				
			hit_desk.graphics.lineTo(231,58);				
			hit_desk.graphics.lineTo(269,149);				
			hit_desk.graphics.lineTo(279,228);				
			hit_desk.graphics.lineTo(358,254);				
			hit_desk.graphics.lineTo(330,304);				
			hit_desk.graphics.lineTo(80,352);				
			hit_desk.graphics.lineTo(0,318);				

			hit_desk.graphics.endFill(false);
			
			hit_desk.alpha = 0.0;
			
			hit_desk.graphics.precisionHitTest = true;	
			this.addChild(hit_desk);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Steps();
						FadeOut((JungleHouses as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleHousesObj,true
						);
					}else if(hit_desk.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((LabDesk as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.LabDeskObj,true
						);
						
					}else if(hit_equipment.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((LabEquipment as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.LabEquipmentObj,true
						);
					}else if(hit_carpet.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("An elegant woven carpet.");						
					}else if(hit_books.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Volumes of books line the ceiling.");						
					}else if(hit_stool.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A simple wooden stool.");						
					}else if(hit_barrel.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The barrel has been converted into a table.");						
					}else if(hit_box.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){							
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Two wooden crates, emptied of supplies.");						
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
			
			
			this.assets.removeTexture("lab_bg",true);
			this.assets.removeTexture("LabSprite",true);
			this.assets.removeTextureAtlas("LabSprite",true);
			(stage.getChildAt(0) as Object).falseAsset("lab_01");
			(stage.getChildAt(0) as Object).falseAsset("lab_02");
			(stage.getChildAt(0) as Object).falseAsset("lab_03");
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