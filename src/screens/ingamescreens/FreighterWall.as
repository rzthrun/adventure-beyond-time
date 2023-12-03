package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class FreighterWall extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var wallOpen:Image;
		private var fire_part_00:Image;
		private var fire_part_01:Image;
		private var fire_part_02:Image;
		private var fire_part_03:Image;
		private var fire_part_04:Image;
		
		private var hit_hole_one:Shape;
		private var hit_hole_two:Shape;
		
		private var hit_door:Shape
		private var Animating:Boolean = false;
		private var BlowtorchUsed:Boolean = false;
		private var DoorOpen:Boolean = false;
		private var fireTween:Tween;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function FreighterWall(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('freighterWall_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWall/freighterWall_bg.jpg'));
				game.TrackAssets('freighterWall_01');
			}
			if(game.CheckAsset('freighterWall_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWall/FreighterWall_Sprite_01.png'));
				game.TrackAssets('freighterWall_02');
			}
			if(game.CheckAsset('freighterWall_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWall/FreighterWall_Sprite_01.xml'));
				game.TrackAssets('freighterWall_03');
			}
			if(game.CheckAsset('freighterWall_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWall/FreighterWall_Sprite_02.atf'));
				game.TrackAssets('freighterWall_04');
			}
			if(game.CheckAsset('freighterWall_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/FreighterWall/FreighterWall_Sprite_02.xml'));
				game.TrackAssets('freighterWall_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("FreighterWall","FreighterWallObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		//	SaveArray['BlowTorch'] = 'non';	
		//	SaveArray['Door'] = 'non';	
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterWall',SaveArray);
			
			
			bg = new Image(this.assets.getTexture('freighterWall_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);

			wallOpen = new Image(this.assets.getTexture('wallOpen'));
			wallOpen.smoothing = TextureSmoothing.NONE;
			wallOpen.touchable = false;
			wallOpen.x = 255;
			wallOpen.y = 1;

			fire_part_00 = new Image(this.assets.getTexture('fire_00'));
			fire_part_00.touchable = true;
			fire_part_00.x = 521;
			fire_part_00.y = 204;
	
			fire_part_01 = new Image(this.assets.getTexture('fire_01'));
			fire_part_01.touchable = true;
			fire_part_01.x = 429;
			fire_part_01.y = 34;
	
			fire_part_02 = new Image(this.assets.getTexture('fire_02'));
			fire_part_02.touchable = true;
			fire_part_02.x = 302;
			fire_part_02.y = 23;

			fire_part_03 = new Image(this.assets.getTexture('fire_03'));
			fire_part_03.touchable = true;
			fire_part_03.x = 272;
			fire_part_03.y = 113;

			fire_part_04 = new Image(this.assets.getTexture('fire_04'));
			fire_part_04.touchable = true;
			fire_part_04.x = 258;
			fire_part_04.y = 305;
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall != undefined){
				trace("1");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall['BlowTorch'] == 'Used'){
					trace("2");
					BlowtorchUsed = true;	
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall['Door'] == 'open'){
						trace("3");
						DoorOpen = true;	
						wallOpen.alpha = 1;
						fire_part_00.alpha = 0;
						fire_part_01.alpha = 0;
						fire_part_02.alpha = 0;	
						fire_part_03.alpha = 0;		
						fire_part_04.alpha = 0;
						wallOpen.alpha = 1;
					}else{
						trace("4");
						wallOpen.alpha = 0;
						fire_part_00.alpha = 1;
						fire_part_01.alpha = 1;
						fire_part_02.alpha = 1;	
						fire_part_03.alpha = 1;		
						fire_part_04.alpha = 1;
				}
				}else{
					trace("5");
					wallOpen.alpha = 0;
					fire_part_00.alpha = 0;
					fire_part_01.alpha = 0;
					fire_part_02.alpha = 0;	
					fire_part_03.alpha = 0;		
					fire_part_04.alpha = 0;
				}
			}else{
				trace("6");
				wallOpen.alpha = 0;
				fire_part_00.alpha = 0;
				fire_part_01.alpha = 0;
				fire_part_02.alpha = 0;	
				fire_part_03.alpha = 0;		
				fire_part_04.alpha = 0;
			}
			

			
			this.addChildAt(wallOpen,1);
			this.addChildAt(fire_part_00,2);
			this.addChildAt(fire_part_01,3);
			this.addChildAt(fire_part_02,4);
			this.addChildAt(fire_part_03,5);
			this.addChildAt(fire_part_04,6);
			
			CreateDoorHit();
			CreateHoleOneHit();
			CreateHoleTwoHit();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		//hit_hole_one
		
		private function CreateHoleOneHit():void{
			hit_hole_one = new Shape();
			hit_hole_one.touchable = false;
			hit_hole_one.graphics.beginFill(0xff0000);
			
			hit_hole_one.graphics.lineTo(501,59);	
			hit_hole_one.graphics.lineTo(568,69);	
			hit_hole_one.graphics.lineTo(556,232);	
			hit_hole_one.graphics.lineTo(503,215);	
		
			hit_hole_one.alpha = 0.0;
			hit_hole_one.graphics.endFill(false);
			hit_hole_one.graphics.precisionHitTest = true;	
			this.addChild(hit_hole_one);
			
		}
		
		
		private function CreateHoleTwoHit():void{
			hit_hole_two = new Shape();
			hit_hole_two.touchable = false;
			hit_hole_two.graphics.beginFill(0xff0000);
			hit_hole_two.graphics.lineTo(332,435);	
			hit_hole_two.graphics.lineTo(351,414);	
			hit_hole_two.graphics.lineTo(443,425);	
			hit_hole_two.graphics.lineTo(472,401);	
			hit_hole_two.graphics.lineTo(500,286);	
			hit_hole_two.graphics.lineTo(524,272);	
			hit_hole_two.graphics.lineTo(547,298);	
			hit_hole_two.graphics.lineTo(531,464);	
			hit_hole_two.graphics.lineTo(502,492);	
			hit_hole_two.graphics.lineTo(358,472);	
			
			hit_hole_two.alpha = 0.0;
			hit_hole_two.graphics.endFill(false);
			hit_hole_two.graphics.precisionHitTest = true;	
			this.addChild(hit_hole_two);
		}
		
		private function CreateDoorHit():void{
			hit_door = new Shape();
			hit_door.touchable = false;
			hit_door.graphics.beginFill(0xff0000);
			
			hit_door.graphics.lineTo(313,21);	
			hit_door.graphics.lineTo(551,55);	
			hit_door.graphics.lineTo(506,467);	
			hit_door.graphics.lineTo(253,430);	
			
			hit_door.alpha = 0.0;
			hit_door.graphics.endFill(false);
			hit_door.graphics.precisionHitTest = true;	
			this.addChild(hit_door);
			
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					if(Animating === false){
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((FreighterLower as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.FreighterLowerObj,true
							);
						}else if(hit_hole_one.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BlowtorchUsed === false){
								if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									== 
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.inventoryBarObj
									.item_BlowTorchLit)
									
								{
									TorchHandler();
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Part of the ship's hull has corroded away.");

								}
								
							}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								DoorHandler();
							}
						}else if(hit_hole_two.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BlowtorchUsed === false){
								if((stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.armedItem
									== 
									(stage.getChildAt(0) as Object)
									.screenGamePlayHandler
									.InventoryObj.inventoryBarObj
									.item_BlowTorchLit)
									
								{
									TorchHandler();
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can see through to the outside. There's daylight coming through.");

								}
							}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								DoorHandler();
							}
						}else if(hit_door.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(BlowtorchUsed === false){
								TorchHandler();
							}else{
								if(DoorOpen === false){
									DoorHandler();
								}else{
									FadeOut((RavineCanyonRear as Class), 
										(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineCanyonRearObj,true
									);
								}
							}
							
						}
					}
				
				}
						
			}
		}
		private function TorchHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_BlowTorchLit)
				
			{
				Animating = true
				BlowtorchUsed = true;	
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall;
				}	
				
				SaveArray['BlowTorch'] = 'Used';	
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterWall',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_BlowTorchLit,
						"item_BlowTorchLit"
					);

				
				
				FireTween_Zero();
			}else {
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal in this section of the ship's hull is severely deteriorated.");
			}
		}
		
		private function DoorHandler():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalDropHeavy();
			wallOpen.alpha = 1
			DoorOpen = true;	
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.FreighterWall;
			}	
			Starling.juggler.delayCall(function():void{
				//	Starling.juggler.delayCall(function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_MetalDropLight();
				//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
			},1.5);
			SaveArray['Door'] = 'open';	
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('FreighterWall',SaveArray);	
		}
		
		private function FireTween_Zero():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_FireBall();
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BlowTorch();
			fireTween = new Tween(fire_part_00, 0.75, Transitions.LINEAR);
			fireTween.fadeTo(1);
			fireTween.onComplete = function():void{
				FireTween_One();
				
			};
			
			Starling.juggler.add(fireTween);
		}
		
		private function FireTween_One():void{
			Animating = true
			fireTween = new Tween(fire_part_01, 1.5, Transitions.LINEAR);
			fireTween.fadeTo(1);
			fireTween.onComplete = function():void{
				FireTween_Two();
				
			};
			
			Starling.juggler.add(fireTween);
		}
		
		private function FireTween_Two():void{
			Animating = true
			fireTween = new Tween(fire_part_02, 1.5, Transitions.LINEAR);
			fireTween.fadeTo(1);
			fireTween.onComplete = function():void{
				FireTween_Three();
			};
			
			Starling.juggler.add(fireTween);
		}
		private function FireTween_Three():void{
			
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BlowTorch();
			Animating = true
			fireTween = new Tween(fire_part_03, 1.5, Transitions.LINEAR);
			fireTween.fadeTo(1);
			fireTween.onComplete = function():void{
				FireTween_Four()
			};
			
			Starling.juggler.add(fireTween);
		}
		private function FireTween_Four():void{
			Animating = true
			fireTween = new Tween(fire_part_04, 1.5, Transitions.LINEAR);
			fireTween.fadeTo(1);
			fireTween.onComplete = function():void{
				Starling.juggler.purge();
				Animating = false;
			};
			
			Starling.juggler.add(fireTween);
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
			
			
			this.assets.removeTexture("freighterWall_bg",true);
			this.assets.removeTexture("FreighterWall_Sprite_01",true);
			this.assets.removeTextureAtlas("FreighterWall_Sprite_01",true);
			this.assets.removeTexture("FreighterWall_Sprite_02",true);
			this.assets.removeTextureAtlas("FreighterWall_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("freighterWall_01");
			(stage.getChildAt(0) as Object).falseAsset("freighterWall_02");
			(stage.getChildAt(0) as Object).falseAsset("freighterWall_03");
			(stage.getChildAt(0) as Object).falseAsset("freighterWall_04");
			(stage.getChildAt(0) as Object).falseAsset("freighterWall_05");
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