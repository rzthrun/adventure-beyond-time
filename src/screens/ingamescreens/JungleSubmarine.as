package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	
	public class JungleSubmarine extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
			
		private var bg:Image;
		
		private var door:Image;
		private var ladder:Image;
		
		private var hit_JungleSubmarineDoor:Shape;
		private var hit_FarCoast:Shape;
		private var hit_FarCoastRight:Shape;
		private var hit_Ladder:Shape;
		
		private var hit_body:Shape;
		private var hit_rocks:Shape;
		private var hit_trees:Shape;
		private var hit_base:Shape;
		
		private var LadderAttached:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;	
				
		
		public function JungleSubmarine(_assets:AssetManager,_game:Game)
		{
			super();
			
			game = _game;
			assets = _assets;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		public function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if(game.CheckAsset('jungleSubmarine_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleSubmarine/jungleSubmarine_bg.jpg'));
				game.TrackAssets('jungleSubmarine_01');
			}
			if(game.CheckAsset('jungleSubmarine_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleSubmarine/JungleSubmarine_Sprite.png'));
				game.TrackAssets('jungleSubmarine_02');
			}
			if(game.CheckAsset('jungleSubmarine_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleSubmarine/JungleSubmarine_Sprite.xml'));
				game.TrackAssets('jungleSubmarine_03');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleSubmarine","JungleSubmarineObj");
				} 				
			});	
			
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleSubmarine_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			ladder = new Image(this.assets.getTexture('ladder'));
			ladder.touchable = false;
			ladder.x = 520;
			ladder.y = 248;
			
			door = new Image(this.assets.getTexture('sub_door'));
			door.touchable = false;
			door.x = 480;
			door.y = 148;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine['Ladder'] == 'Attached'){
					LadderAttached = true;
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
			
			
		
			
			this.addChildAt(ladder,1);
			this.addChildAt(door,2);
			CreateHitBase();
			CreateHitBody();
			CreateHitRocks();
			CreateHitTrees();
			CreateHitSubmarineDoor();
			CreateHitFarCoast();
			CreateHitLadder();
			CreateHitFarCoastRight();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Jungle_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Waves_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("WindOne",0,0.5,'stop');
	//		(stage.getChildAt(0) as Object).MusicObj.soundManager.tweenVolumeComplex("WindOne",0,1.0,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadBirdsOne(true,999);
		}
		//hit_base
		
		private function CreateHitBase():void{
			hit_base = new Shape();
			hit_base.touchable = false;
			hit_base.graphics.beginFill(0xff0000);
			
			hit_base.graphics.lineTo(221,428);									
			hit_base.graphics.lineTo(387,384);									
			hit_base.graphics.lineTo(486,407);									
			hit_base.graphics.lineTo(473,467);									
			hit_base.graphics.lineTo(323,462);									
		
			hit_base.graphics.endFill(false);
			hit_base.alpha = 0.0;
			
			hit_base.graphics.precisionHitTest = true;	
			this.addChild(hit_base);
		}
		
		
		private function CreateHitTrees():void{
			hit_trees = new Shape();
			hit_trees.touchable = false;
			hit_trees.graphics.beginFill(0xff0000);
			
			hit_trees.graphics.lineTo(0,0);									
			hit_trees.graphics.lineTo(288,0);									
			hit_trees.graphics.lineTo(328,48);									
			hit_trees.graphics.lineTo(248,147);									
			hit_trees.graphics.lineTo(240,208);									
			hit_trees.graphics.lineTo(0,135);									
			
			hit_trees.graphics.endFill(false);
			hit_trees.alpha = 0.0;
			
			hit_trees.graphics.precisionHitTest = true;	
			this.addChild(hit_trees);
		}
		
		
		private function CreateHitRocks():void{
			hit_rocks = new Shape();
			hit_rocks.touchable = false;
			hit_rocks.graphics.beginFill(0xff0000);
			
			hit_rocks.graphics.lineTo(3,160);									
			hit_rocks.graphics.lineTo(141,203);									
			hit_rocks.graphics.lineTo(208,261);									
			hit_rocks.graphics.lineTo(173,358);									
			hit_rocks.graphics.lineTo(0,311);									
			
			hit_rocks.graphics.endFill(false);
			hit_rocks.alpha = 0.0;
			
			hit_rocks.graphics.precisionHitTest = true;	
			this.addChild(hit_rocks);
		}
		
		private function CreateHitBody():void{
			hit_body = new Shape();
			hit_body.touchable = false;
			hit_body.graphics.beginFill(0xff0000);
			
			hit_body.graphics.lineTo(385,371);									
			hit_body.graphics.lineTo(410,33);									
			hit_body.graphics.lineTo(441,5);									
			hit_body.graphics.lineTo(513,83);									
			hit_body.graphics.lineTo(491,394);									
										
			hit_body.graphics.endFill(false);
			hit_body.alpha = 0.0;
			
			hit_body.graphics.precisionHitTest = true;	
			this.addChild(hit_body);
		}
		
		private function CreateHitSubmarineDoor():void{
			hit_JungleSubmarineDoor = new Shape();
			hit_JungleSubmarineDoor.touchable = false;
			hit_JungleSubmarineDoor.graphics.beginFill(0xff0000);
			
			hit_JungleSubmarineDoor.graphics.lineTo(458,105);									
			hit_JungleSubmarineDoor.graphics.lineTo(488,105);									
			hit_JungleSubmarineDoor.graphics.lineTo(533,118);									
			hit_JungleSubmarineDoor.graphics.lineTo(633,225);									
			hit_JungleSubmarineDoor.graphics.lineTo(645,274);									
			hit_JungleSubmarineDoor.graphics.lineTo(462,276);									
			hit_JungleSubmarineDoor.graphics.endFill(false);
			hit_JungleSubmarineDoor.alpha = 0.0;
			
			hit_JungleSubmarineDoor.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleSubmarineDoor);
		}
		
		private function CreateHitFarCoast():void{
			hit_FarCoast = new Shape();
			hit_FarCoast.touchable = false;
			hit_FarCoast.graphics.beginFill(0xff0000);
			
			hit_FarCoast.graphics.lineTo(510,288);									
			hit_FarCoast.graphics.lineTo(775,279);									
			hit_FarCoast.graphics.lineTo(782,389);									
			hit_FarCoast.graphics.lineTo(621,411);									
			hit_FarCoast.graphics.lineTo(545,369);									
			hit_FarCoast.graphics.lineTo(501,358);									
			hit_FarCoast.graphics.endFill(false);
			hit_FarCoast.alpha = 0.0;
			
			hit_FarCoast.graphics.precisionHitTest = true;	
			this.addChild(hit_FarCoast);
		}
		//hit_FarCoastRight
		private function CreateHitFarCoastRight():void{
			hit_FarCoastRight = new Shape();
			hit_FarCoastRight.touchable = false;
			hit_FarCoastRight.graphics.beginFill(0xff0000);
			
			hit_FarCoastRight.graphics.lineTo(190,270);									
			hit_FarCoastRight.graphics.lineTo(265,266);									
			hit_FarCoastRight.graphics.lineTo(389,282);									
			hit_FarCoastRight.graphics.lineTo(380,391);									
			hit_FarCoastRight.graphics.lineTo(257,416);									
			hit_FarCoastRight.graphics.lineTo(182,368);									
								
			hit_FarCoastRight.graphics.endFill(false);
			hit_FarCoastRight.alpha = 0.0;
			
			hit_FarCoastRight.graphics.precisionHitTest = true;	
			this.addChild(hit_FarCoastRight);
		}
		
		private function CreateHitLadder():void{
			hit_Ladder = new Shape();
			hit_Ladder.touchable = false;
			hit_Ladder.graphics.beginFill(0xff0000);
			
			hit_Ladder.graphics.lineTo(506,255);									
			hit_Ladder.graphics.lineTo(575,259);																		
			hit_Ladder.graphics.lineTo(609,441);									
			hit_Ladder.graphics.lineTo(495,433);									
								
			hit_Ladder.graphics.endFill(false);
			hit_Ladder.alpha = 0.0;
			
			hit_Ladder.graphics.precisionHitTest = true;	
			this.addChild(hit_Ladder);
		}
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Jungle as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleObj,true
						);
					}else if(hit_Ladder.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LadderHandler();	
					}else if(hit_JungleSubmarineDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						if(LadderAttached === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ladder();
							FadeOut((JungleSubmarineDoor as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleSubmarineDoorObj,true
							);	
						}else{
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
								(stage.getChildAt(0) as Object)
								.screenGamePlayHandler
									.InventoryObj.removeItemFromInventory(
										(stage.getChildAt(0) as Object)
										.screenGamePlayHandler
										.InventoryObj.item_Ladder,
										"item_Ladder"
									);
								
								LadderAttached = true;
								ladder.alpha = 1;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine;			
								}
								SaveArray['Ladder'] = "Attached";
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarine',SaveArray);
								
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't climb up there. It's too high.");
							}
						}
						
					}else if(hit_FarCoast.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FarCoast as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastObj,true
						);	
					}else if(hit_FarCoastRight.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						FadeOut((FarCoast as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastObj,true
						);	
					}else if(hit_body.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The tail of a submarine towers like a monolith out of the earth.');

					}else if(hit_rocks.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('Glacial rocks slope uphill.');

					}else if(hit_trees.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The trees rustle with birds and life.');

					}else if(hit_base.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut('The steel body of the submarine is encased by land.');
						
					}
					
					/*
					
					private var hit_body:Shape;
					private var hit_rocks:Shape;
					private var hit_trees:Shape;
					*/
				}
			}
		}
		
		private function LadderHandler():void{
			if(LadderAttached === true){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				LadderAttached = false;
				ladder.alpha = 0;
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine;
				SaveArray['Ladder'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarine',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Ladder,
					'item_Ladder',
					'inven_ladder_sm'
				);
			}else{
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
					(stage.getChildAt(0) as Object)
					.screenGamePlayHandler
						.InventoryObj.removeItemFromInventory(
							(stage.getChildAt(0) as Object)
							.screenGamePlayHandler
							.InventoryObj.item_Ladder,
							"item_Ladder"
						);
					
					
					LadderAttached = true;
					ladder.alpha = 1;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine != undefined){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleSubmarine;			
					}
					SaveArray['Ladder'] = "Attached";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleSubmarine',SaveArray);

				}else if(hit_JungleSubmarineDoor.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can't climb up there. It's too high.");
				}else if(hit_FarCoast.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
					FadeOut((FarCoast as Class), 
						(stage.getChildAt(0) as Object).screenGamePlayHandler.FarCoastObj,true
					);	
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
			
			
			this.assets.removeTexture("jungleSubmarine_bg",true);
			this.assets.removeTexture("JungleSubmarine_Sprite",true);
			this.assets.removeTextureAtlas("JungleSubmarine_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleSubmarine_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleSubmarine_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleSubmarine_03");
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

