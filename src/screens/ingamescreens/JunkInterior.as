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
	
	public class JunkInterior extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var potatoes:Image;
		private var garden_cabinet_left:Image;
		private var garden_cabinet_right:Image;
		private var garden_cabinet_nub:Image;
		private var garden_cabinet_both_potato:Image;
		private var garden_cabinet_both:Image;
		
		
		private var dragonBall:Image;
		private var dragon_cabinet_lid:Image;
		
		private var hit_JunkDeck:Shape;
		private var hit_GardenCabinetRightDoor:Shape;
		private var hit_GardenCabinetLeftDoor:Shape;
		
		private var hit_dragonCabinet:Shape;
		private var hit_dragonBall:Shape;
		private var hit_potatoLeft:Shape;
		private var hit_potatoRight:Shape;
		private var hit_potatoRight_Two:Shape;
		
		private var hit_vase:Shape;
		private var hit_statue:Shape;
		private var hit_painting:Shape;
		
		private var GardenLeftOpen:Boolean = false;
		private var GardenRightOpen:Boolean = false;
		private var PotatoesPickedUp:Boolean = false;
		private var PotatosShown:Boolean = false;
		private var DragonCabinetOpen:Boolean = false;
		private var JunkPuzzleSolved:Boolean = false;
		
		private var Animating:Boolean = false
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		public function JunkInterior(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('junkInterior_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkInterior/junkInterior_bg.jpg'));
				game.TrackAssets('junkInterior_01');
			}
			
			if(game.CheckAsset('junkInterior_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkInterior/junkInterior_spriteSheet.png'));
				game.TrackAssets('junkInterior_02');
			}
			if(game.CheckAsset('junkInterior_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JunkInterior/junkInterior_spriteSheet.xml'));
				game.TrackAssets('junkInterior_03');
			}
			

			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();

					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JunkInterior","JunkInteriorObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('junkInterior_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			
			
			
			potatoes = new Image(this.assets.getTexture('potatos'));
			potatoes.touchable = false;
			potatoes.x = 566;
			potatoes.y = 312;
			
			
			
			

			garden_cabinet_left = new Image(this.assets.getTexture('garden_cabinet_left'));
			garden_cabinet_left.touchable = false;
			garden_cabinet_left.x = 450;
			garden_cabinet_left.y = 80;
		
			
			garden_cabinet_right = new Image(this.assets.getTexture('garden_cabinet_right'));
			garden_cabinet_right.touchable = false;
			garden_cabinet_right.x = 544;
			garden_cabinet_right.y = 106;
			
			
			garden_cabinet_nub  = new Image(this.assets.getTexture('garden_cabinet_nub'));
			garden_cabinet_nub.touchable = false;
			garden_cabinet_nub.x = 424;
			garden_cabinet_nub.y = 302;
			

			dragonBall = new Image(this.assets.getTexture('dragon_ball'));
			dragonBall.touchable = false;
			dragonBall.x = 140;
			dragonBall.y = 134;
			
			
			dragon_cabinet_lid = new Image(this.assets.getTexture('dragon_cabinet_lid'));
			dragon_cabinet_lid.touchable = false;
			dragon_cabinet_lid.x = 77;
			dragon_cabinet_lid.y = 39;
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior['GardenCabinetLeft'] == 'open'){
					garden_cabinet_left.alpha = 0;
					GardenLeftOpen = true;
					CreatePotatoLeftHit();
				}else{
					garden_cabinet_left.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior['GardenCabinetRight'] == 'open'){
					garden_cabinet_right.alpha = 0;
					garden_cabinet_nub.alpha = 0;
					GardenRightOpen = true;
					PotatosShown = true;
					CreatePotatoRightHit();
					CreatePotatoRightTwoHit();
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior["Potatoes"] == "PickedUp"){
						PotatoesPickedUp = true;
						potatoes.alpha = 0;
					}else{
						potatoes.alpha = 1;
					}	
					
				}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior['GardenCabinetRight'] == 'closed'){	
					garden_cabinet_right.alpha = 1;
					garden_cabinet_nub.alpha = 0;
					potatoes.alpha = 0;
					PotatoesPickedUp = true;
					PotatosShown = true;
					CreatePotatoRightTwoHit();
					
					
					
				}else{
					garden_cabinet_right.alpha = 1;
					garden_cabinet_nub.alpha = 1;
					potatoes.alpha = 0;
				}
				
				
				
				
			}else{
				potatoes.alpha = 0;
				garden_cabinet_left.alpha = 1;
				garden_cabinet_right.alpha = 1;
				garden_cabinet_nub.alpha = 1;
				
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle != undefined){
				trace("1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkPuzzle['Solved'] == 'Yes'){
					trace("2");
					JunkPuzzleSolved = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
						trace("3");
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior['DragonCabinet'] == 'open'){
							trace("4");
							CreateDragonBallHit();
							DragonCabinetOpen = true;
						//
							dragon_cabinet_lid.alpha = 0;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior['DragonBall'] == 'PickedUp'){
								dragonBall.alpha = 0;
							}else{
								dragonBall.alpha = 1;
							}
							
							
						}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior['DragonCabinet'] == 'closed'){
							trace("5");
							dragonBall.alpha = 0;
							dragon_cabinet_lid.alpha = 1;
						}else{
							CreateDragonBallHit();
							trace("6");
							DragonCabinetOpen = true;
							Animating = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
							}
							SaveArray['DragonCabinet'] = 'open'; 
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);	
							Starling.juggler.delayCall(OpenDragonCabinetOnSolve,2)
						}
					}else{
						trace("7");
						dragonBall.alpha = 0;
						dragon_cabinet_lid.alpha = 1;
					}
				}else{
					trace("8");
					dragonBall.alpha = 0;
					dragon_cabinet_lid.alpha = 1;
				}
			}else{
				trace("9");
				dragonBall.alpha = 0;
				dragon_cabinet_lid.alpha = 1;
			}
		
			
			this.addChildAt(potatoes,1);
			this.addChildAt(garden_cabinet_left,2);			
			this.addChildAt(garden_cabinet_right,3);	
			this.addChildAt(garden_cabinet_nub,4);			
			this.addChildAt(dragonBall,5);			
			this.addChildAt(dragon_cabinet_lid,6);
			
			CreateVaseHit();
			CreateStatueHit();
			CreateStatuePainting();
			CreateJunkDeckHit();
			CreateGardenCabinetLeftDoorHit(GardenLeftOpen);
			CreateGardenCabinetRightDoorHit(GardenRightOpen);
			CreateDragonCabinetHit(DragonCabinetOpen);
			//FadeOutOcean(1);
			
		//	goback = new GoBackButton(this.assets);
		//	this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("BirdsOne",0,0.5,'stop');
			//(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("TVStatic",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadShipCreaks(true,999);
	//		(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolume("ShipCreaks",((stage.getChildAt(0) as Object).MusicObj.globalVol),1.0);
			
		
			
		}
		
		private function OpenDragonCabinetOnSolve():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyDoorTwo();
			Animating = false;
			dragonBall.alpha = 1;
			dragon_cabinet_lid.alpha = 0;
			
			Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					(stage.getChildAt(0) as Object).MusicObj.LoadTenseOut(true,1);
					
				}
			},1.5);
			
		}
		
		
		private function CreateStatuePainting():void{
			hit_painting = new Shape();
			hit_painting.touchable = false;
			hit_painting.graphics.beginFill(0x00FF00);
			
			hit_painting.graphics.lineTo(552,360);	
			hit_painting.graphics.lineTo(745,382);	
			hit_painting.graphics.lineTo(693,505);	
			hit_painting.graphics.lineTo(526,436);	
						
			hit_painting.graphics.endFill(false);
			hit_painting.alpha = 0.0;
			hit_painting.graphics.precisionHitTest = true;	
			this.addChild(hit_painting);
			
		}
		
		private function CreateStatueHit():void{
			hit_statue = new Shape();
			hit_statue.touchable = false;
			hit_statue.graphics.beginFill(0x00FF00);
			
			hit_statue.graphics.lineTo(244,81);	
			hit_statue.graphics.lineTo(344,77);	
			hit_statue.graphics.lineTo(380,106);	
			hit_statue.graphics.lineTo(343,281);	
			hit_statue.graphics.lineTo(292,251);	
						
			hit_statue.graphics.endFill(false);
			hit_statue.alpha = 0.0;
			hit_statue.graphics.precisionHitTest = true;	
			this.addChild(hit_statue);
			
		}
		
		private function CreateVaseHit():void{
			hit_vase = new Shape();
			hit_vase.touchable = false;
			hit_vase.graphics.beginFill(0x00FF00);
			
			hit_vase.graphics.lineTo(13,359);	
			hit_vase.graphics.lineTo(36,281);	
			hit_vase.graphics.lineTo(300,280);	
			hit_vase.graphics.lineTo(356,354);	
			hit_vase.graphics.lineTo(335,410);	
			hit_vase.graphics.lineTo(148,489);	
				
			
			hit_vase.graphics.endFill(false);
			hit_vase.alpha = 0.0;
			hit_vase.graphics.precisionHitTest = true;	
			this.addChild(hit_vase);
			
		}
		private function CreateDragonBallHit():void{
			hit_dragonBall = new Shape();
			hit_dragonBall.touchable = false;
			hit_dragonBall.graphics.beginFill(0x00FF00);
			hit_dragonBall.graphics.lineTo(118,116);	
			hit_dragonBall.graphics.lineTo(203,120);	
			hit_dragonBall.graphics.lineTo(214,192);	
			hit_dragonBall.graphics.lineTo(129,201);	

			hit_dragonBall.graphics.endFill(false);
			hit_dragonBall.alpha = 0.0;
			hit_dragonBall.graphics.precisionHitTest = true;	
			this.addChild(hit_dragonBall);
			
		}
		
		private function CreateJunkDeckHit():void{
			hit_JunkDeck = new Shape();
			hit_JunkDeck.touchable = false;
			hit_JunkDeck.graphics.beginFill(0x00FF00);
			hit_JunkDeck.graphics.lineTo(291,0);	
			hit_JunkDeck.graphics.lineTo(478,0);	
			hit_JunkDeck.graphics.lineTo(513,83);	
			hit_JunkDeck.graphics.lineTo(465,100);	
			hit_JunkDeck.graphics.lineTo(440,208);	
			hit_JunkDeck.graphics.lineTo(413,330);	
			hit_JunkDeck.graphics.lineTo(349,298);	
			hit_JunkDeck.graphics.lineTo(375,180);	
			hit_JunkDeck.graphics.lineTo(390,88);
			hit_JunkDeck.graphics.lineTo(358,65);	
			
			hit_JunkDeck.graphics.endFill(false);
			hit_JunkDeck.alpha = 0.0;
			hit_JunkDeck.graphics.precisionHitTest = true;	
			this.addChild(hit_JunkDeck);

		}
		
		private function CreateDragonCabinetHit(open:Boolean = false):void{
			
			
			hit_dragonCabinet = new Shape();
			hit_dragonCabinet.touchable = false
			
			
			if(open === false){
				hit_dragonCabinet.x = 0;
				hit_dragonCabinet.y = 0;
				
				hit_dragonCabinet.graphics.beginFill(0x00FF00);
				hit_dragonCabinet.graphics.lineTo(85,42);	
				hit_dragonCabinet.graphics.lineTo(231,65);	
				hit_dragonCabinet.graphics.lineTo(290,254);	
				hit_dragonCabinet.graphics.lineTo(131,265);	
				
				hit_dragonCabinet.graphics.endFill(false);
				hit_dragonCabinet.alpha = 0.0;
				hit_dragonCabinet.graphics.precisionHitTest = true;
			}else{
				hit_dragonCabinet.x = 0;
				hit_dragonCabinet.y = 0;
				
				hit_dragonCabinet.graphics.beginFill(0x00FF00);
				hit_dragonCabinet.graphics.lineTo(213,71);	
				hit_dragonCabinet.graphics.lineTo(283,30);	
				hit_dragonCabinet.graphics.lineTo(294,38);	
				hit_dragonCabinet.graphics.lineTo(340,128);	
				hit_dragonCabinet.graphics.lineTo(354,231);	
				hit_dragonCabinet.graphics.lineTo(279,265);	
				
				hit_dragonCabinet.graphics.endFill(false);
				hit_dragonCabinet.alpha = 0.0;
				hit_dragonCabinet.graphics.precisionHitTest = true;	
			}
			addChild(hit_dragonCabinet);
		}
		
		
		private function CreateGardenCabinetRightDoorHit(open:Boolean = false):void{
			
			
			hit_GardenCabinetRightDoor = new Shape();
			hit_GardenCabinetRightDoor.touchable = false
			
			
			if(open === false){
				hit_GardenCabinetRightDoor.x = 0;
				hit_GardenCabinetRightDoor.y = 0;
				
				hit_GardenCabinetRightDoor.graphics.beginFill(0x00FF00);
				hit_GardenCabinetRightDoor.graphics.lineTo(546,297);	
				hit_GardenCabinetRightDoor.graphics.lineTo(631,115);	
				hit_GardenCabinetRightDoor.graphics.lineTo(734,144);	
				hit_GardenCabinetRightDoor.graphics.lineTo(640,339);	
				
				hit_GardenCabinetRightDoor.graphics.endFill(false);
				hit_GardenCabinetRightDoor.alpha = 0.0;
				hit_GardenCabinetRightDoor.graphics.precisionHitTest = true;
			}else{
				hit_GardenCabinetRightDoor.x = 0;
				hit_GardenCabinetRightDoor.y = 0;
				
				hit_GardenCabinetRightDoor.graphics.beginFill(0x00FF00);
				hit_GardenCabinetRightDoor.graphics.lineTo(724,145);	
				hit_GardenCabinetRightDoor.graphics.lineTo(766,101);	
				hit_GardenCabinetRightDoor.graphics.lineTo(780,114);	
				hit_GardenCabinetRightDoor.graphics.lineTo(673,354);	
				hit_GardenCabinetRightDoor.graphics.lineTo(635,335);	
				
				hit_GardenCabinetRightDoor.graphics.endFill(false);
				hit_GardenCabinetRightDoor.alpha = 0.0;
				hit_GardenCabinetRightDoor.graphics.precisionHitTest = true;	
			}
			addChild(hit_GardenCabinetRightDoor);
		}
		
		private function CreateGardenCabinetLeftDoorHit(open:Boolean = false):void{
			
			
			
			hit_GardenCabinetLeftDoor = new Shape();
			hit_GardenCabinetLeftDoor.touchable = false
			
			if(open === false){
				hit_GardenCabinetLeftDoor.x = 0;
				hit_GardenCabinetLeftDoor.y = 0;
				
				hit_GardenCabinetLeftDoor.graphics.beginFill(0x00FF00);
				hit_GardenCabinetLeftDoor.graphics.lineTo(483,266);
				hit_GardenCabinetLeftDoor.graphics.lineTo(560,115);
				hit_GardenCabinetLeftDoor.graphics.lineTo(627,113);
				hit_GardenCabinetLeftDoor.graphics.lineTo(543,301);
				hit_GardenCabinetLeftDoor.graphics.endFill(false);
				hit_GardenCabinetLeftDoor.alpha = 0.0;
				hit_GardenCabinetLeftDoor.graphics.precisionHitTest = true;
			}else{
				hit_GardenCabinetLeftDoor.x = 0;
				hit_GardenCabinetLeftDoor.y = 0;
				
				hit_GardenCabinetLeftDoor.graphics.beginFill(0x00FF00);
				hit_GardenCabinetLeftDoor.graphics.lineTo(448,248);	
				hit_GardenCabinetLeftDoor.graphics.lineTo(538,69);	
				hit_GardenCabinetLeftDoor.graphics.lineTo(549,69);	
				hit_GardenCabinetLeftDoor.graphics.lineTo(565,115);	
				hit_GardenCabinetLeftDoor.graphics.lineTo(486,275);	
				
				hit_GardenCabinetLeftDoor.graphics.endFill(false);
				hit_GardenCabinetLeftDoor.alpha = 0.0;
				hit_GardenCabinetLeftDoor.graphics.precisionHitTest = true;	
			}
			
			addChild(hit_GardenCabinetLeftDoor);
		}
		
		
		
		//hit_JunkDeck
		
		private function CreatePotatoLeftHit():void{
			hit_potatoLeft = new Shape();
			hit_potatoLeft.touchable = false;
			
			hit_potatoLeft.graphics.beginFill(0x00FF00);
			hit_potatoLeft.graphics.lineTo(490,274);	
			hit_potatoLeft.graphics.lineTo(540,177);	
			hit_potatoLeft.graphics.lineTo(591,196);	
			hit_potatoLeft.graphics.lineTo(542,292);	

			
			hit_potatoLeft.graphics.endFill(false);
			hit_potatoLeft.alpha = 0.0;
			hit_potatoLeft.graphics.precisionHitTest = true;	
			
			this.addChild(hit_potatoLeft);
		}

		private function CreatePotatoRightHit():void{
			hit_potatoRight = new Shape();
			hit_potatoRight.touchable = false;

			hit_potatoRight.graphics.beginFill(0x00FF00);
			
			hit_potatoRight.graphics.lineTo(593,194);	
			hit_potatoRight.graphics.lineTo(680,224);	
			hit_potatoRight.graphics.lineTo(631,329);	
			hit_potatoRight.graphics.lineTo(543,295);	

			hit_potatoRight.graphics.endFill(false);
			hit_potatoRight.alpha = 0.0;
			hit_potatoRight.graphics.precisionHitTest = true;	
			
			this.addChild(hit_potatoRight);
			
			
			
		}
		private function CreatePotatoRightTwoHit(MakeIt:Boolean = false):void{
			if(MakeIt === false){
				hit_potatoRight_Two = new Shape();
				hit_potatoRight_Two.touchable = false;
				
				hit_potatoRight_Two.graphics.beginFill(0x00FF00);
				
				hit_potatoRight_Two.graphics.lineTo(564,308);	
				hit_potatoRight_Two.graphics.lineTo(636,337);	
				hit_potatoRight_Two.graphics.lineTo(657,373);	
				hit_potatoRight_Two.graphics.lineTo(627,371);	
				hit_potatoRight_Two.graphics.lineTo(552,357);	
				hit_potatoRight_Two.graphics.lineTo(528,410);	
				hit_potatoRight_Two.graphics.lineTo(457,417);	
				hit_potatoRight_Two.graphics.lineTo(439,399);	
				hit_potatoRight_Two.graphics.lineTo(440,352);	
				hit_potatoRight_Two.graphics.lineTo(556,325);	
				hit_potatoRight_Two.graphics.lineTo(565,307);	
				
				hit_potatoRight_Two.graphics.endFill(false);
				hit_potatoRight_Two.alpha = 0.0;
				hit_potatoRight_Two.graphics.precisionHitTest = true;	
				
				this.addChild(hit_potatoRight_Two);
			}else{
				
			}
		}
		
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(hit_JunkDeck.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
						FadeOut((JunkDeck as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkDeckObj,true
						);
						
					}else if(hit_GardenCabinetLeftDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						GardernCabinetLeftHandler();
						return;
					}else if(hit_GardenCabinetRightDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						GardernCabinetRightHandler();
						return;
					}else if(hit_dragonCabinet.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(JunkPuzzleSolved === false){
							FadeOut((JunkPuzzle as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JunkPuzzleObj,true
							);
						}else{
							DragonCabinetHandler();
						}
					}else if(hit_vase.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Sacks of grain, wooden debris and pieces of shattered porcelain cover the floor.");
					}else if(hit_statue.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A metal statue of a fearsome figure on horseback.");
					}else if(hit_painting.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A porcelain vase and woodblock print.");
					}
					
					/*
					private var hit_vase:Shape;
					private var hit_statue:Shape;
					private var hit_painting:Shape;
					*/
					
					
					if(GardenLeftOpen === true){
						if(hit_potatoLeft.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							return;
						}
					}
					if(GardenRightOpen === true){
						if(hit_potatoRight.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PotatoHandler();
							
							return;
						}
					}
					if(PotatosShown === true){
						if(hit_potatoRight_Two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							PotatoHandler();
							
							return;
						}
					}
					if(DragonCabinetOpen === true){
						if(hit_dragonBall.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							DragonBallHandler();
							
							return;
						}
					}
					
					
					//GardernCabinetRightHandler
				}
			}
		}

		private function DragonCabinetHandler():void{
			if(DragonCabinetOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyOpen();
				DragonCabinetOpen = true;
				dragon_cabinet_lid.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior['DragonBall'] == 'PickedUp'){
						dragonBall.alpha = 0;
					}else{
						dragonBall.alpha = 1;
					}
				}else{
					dragonBall.alpha = 1;
				}
				
				hit_dragonCabinet.graphics.clear();
				CreateDragonCabinetHit(true);
		
				CreateDragonBallHit();
				
				SaveArray['DragonCabinet'] = 'open'; 
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CreakyClose();

				DragonCabinetOpen = false;
				dragonBall.alpha = 0;
				dragon_cabinet_lid.alpha = 1;
				hit_dragonCabinet.graphics.clear();
				CreateDragonCabinetHit(false);
				
				this.removeChild(hit_dragonBall);
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
				}
				SaveArray['DragonCabinet'] = 'closed'; 
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
				
			}
		}
		//DragonCabinetOpen
		
		private function DragonBallHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior["DragonBall"] == "PickedUp"){
					
				}else{
					
					trace("Dragon BALL HIT 1");
					dragonBall.alpha = 0;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
					}
					SaveArray["DragonBall"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallThree,
						'item_DragonBallThree',
						'inven_dragonBallThree_sm'
					);
			
				}
			}else{
				trace("Dragon BALL HIT 2");
				
				dragonBall.alpha = 0;
				PotatoesPickedUp = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
				}
				SaveArray["DragonBall"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_DragonBallThree,
					'item_DragonBallThree',
					'inven_dragonBallThree_sm'
				);
				
			}
		}
		
		private function PotatoHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior["Potatoes"] == "PickedUp"){
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I don't need any more potatoes.");
						
					
				}else{
					
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
					
					potatoes.alpha = 0;
					PotatoesPickedUp = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
					}
					SaveArray["Potatoes"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Potatoes,
						'item_Potatoes',
						'inven_potatoes_sm'
					);
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				potatoes.alpha = 0;
				PotatoesPickedUp = true;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
				}
				SaveArray["Potatoes"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Potatoes,
					'item_Potatoes',
					'inven_potatoes_sm'
				);
			}
		}
		
		
		private function GardernCabinetLeftHandler():void{
			if(GardenLeftOpen === false){
				
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
				GardenLeftOpen = true;
				garden_cabinet_left.alpha = 0;
				
				hit_GardenCabinetLeftDoor.graphics.clear()
				CreateGardenCabinetLeftDoorHit(true);
				
				CreatePotatoLeftHit();
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
				}
				SaveArray["GardenCabinetLeft"] = "open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
				
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
				GardenLeftOpen = false;
				garden_cabinet_left.alpha = 1;
				
				hit_GardenCabinetLeftDoor.graphics.clear()
				CreateGardenCabinetLeftDoorHit(false);
				
				this.removeChild(hit_potatoLeft);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
				}
				SaveArray["GardenCabinetLeft"] = "closed";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
			}
		}
		
		private function GardernCabinetRightHandler():void{
			if(GardenRightOpen === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerOpen();
				GardenRightOpen = true;
				garden_cabinet_right.alpha = 0;
				garden_cabinet_nub.alpha = 0;
				
				if(PotatoesPickedUp === true){
					potatoes.alpha = 0;
				}else{
					potatoes.alpha = 1;
				}
				hit_GardenCabinetRightDoor.graphics.clear()
				CreateGardenCabinetRightDoorHit(true);
				
				CreatePotatoRightHit();
				CreatePotatoRightTwoHit(PotatosShown);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
				}
				SaveArray["GardenCabinetRight"] = "open";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);
				
				
			}else{
				if(PotatoesPickedUp === true){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_DrawerClose();
					GardenRightOpen = false;
					garden_cabinet_right.alpha = 1;
					garden_cabinet_nub.alpha = 0;
					
					hit_GardenCabinetRightDoor.graphics.clear()
					CreateGardenCabinetRightDoorHit(false);
					
					PotatosShown = true; 
					
					this.removeChild(hit_potatoRight)
						
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JunkInterior;
					}
					SaveArray["GardenCabinetRight"] = "closed";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JunkInterior',SaveArray);	
						
					//this.removeChild(hit_potatoRight_Two)
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There are too many potatoes. I need to pick some up to close the door.");
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
			
			
			this.assets.removeTexture("junkInterior_bg",true);
			this.assets.removeTexture("junkInterior_spriteSheet",true);
			this.assets.removeTextureAtlas("junkInterior_spriteSheet",true);
			(stage.getChildAt(0) as Object).falseAsset("junkInterior_01");
			(stage.getChildAt(0) as Object).falseAsset("junkInterior_02");
			(stage.getChildAt(0) as Object).falseAsset("junkInterior_03");
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
