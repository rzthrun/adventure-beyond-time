package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	
	public class SpaceShipDoorPuzzle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var disc_00:Image;
		private var disc_01:Image;
		private var disc_02:Image;
		private var disc_03:Image;
		private var disc_04:Image;
		
		private var halo:Image;
		private var hood:Image;
		
		private var hand:Image;
		
		private var hit_disc_00:Shape;
		private var hit_disc_01:Shape;
		private var hit_disc_02:Shape;
		private var hit_disc_03:Shape;
		private var hit_disc_04:Shape;
		private var hit_hand:Shape;
		
		private var HaloTween:Tween;
		private var Disc00Tween:Tween;
		private var Disc01Tween:Tween;
		private var Disc02Tween:Tween;
		private var Disc03Tween:Tween;
		private var Disc04Tween:Tween;
		
		
		private var PrevMouseY:Number = 248;
		private var CurrentMouseY:Number = 248;
		private var DiscFlag:String = null;
		private var HandAttached:Boolean = false;
		private var Animating:Boolean = false;
		private var delayedCall:DelayedCall;
		
		private var PhraseCounter:int = 0;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
	
		
		private var goback:GoBackButton;
		
		public function SpaceShipDoorPuzzle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('spaceShipDoorPuzzle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipDoorPuzzle/deep_bg.jpg'));
				game.TrackAssets('spaceShipDoorPuzzle_01');
			}
			if(game.CheckAsset('spaceShipDoorPuzzle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipDoorPuzzle/SpaceShipDoorPuzzle_Sprite.png'));
				game.TrackAssets('spaceShipDoorPuzzle_02');
			}
			if(game.CheckAsset('spaceShipDoorPuzzle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipDoorPuzzle/SpaceShipDoorPuzzle_Sprite.xml'));
				game.TrackAssets('spaceShipDoorPuzzle_03');
			}
			if(game.CheckAsset('spaceShipDoorPuzzle_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipDoorPuzzle/SpaceShipDoorPuzzle_Sprite_02.atf'));
				game.TrackAssets('spaceShipDoorPuzzle_04');
			}
			if(game.CheckAsset('spaceShipDoorPuzzle_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/SpaceShipDoorPuzzle/SpaceShipDoorPuzzle_Sprite_02.xml'));
				game.TrackAssets('spaceShipDoorPuzzle_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("SpaceShipDoorPuzzle","SpaceShipDoorPuzzleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
	
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('deep_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			disc_00 = new Image(this.assets.getTexture('wheels'));
			disc_00.touchable = true;
			disc_00.pivotX = 402;
			disc_00.pivotY = 402;
			disc_00.x = 432;
			disc_00.y = 251;
		
			disc_01 = new Image(this.assets.getTexture('wheels'));
			disc_01.touchable = true;
			disc_01.pivotX = 402;
			disc_01.pivotY = 402;
			disc_01.x = 532;
			disc_01.y = 251;
						
			disc_02 = new Image(this.assets.getTexture('wheels'));
			disc_02.touchable = true;
			disc_02.pivotX = 402;
			disc_02.pivotY = 402;
			disc_02.x = 632;
			disc_02.y = 251;
				
			disc_03 = new Image(this.assets.getTexture('wheels'));
			disc_03.touchable = true;
			disc_03.pivotX = 402;
			disc_03.pivotY = 402;
			disc_03.x = 732;
			disc_03.y = 251;
			
			
			disc_04 = new Image(this.assets.getTexture('wheels'));
			disc_04.touchable = true;
			disc_04.pivotX = 402;
			disc_04.pivotY = 402;
			disc_04.x = 832;
			disc_04.y = 251;

			halo = new Image(this.assets.getTexture('outline'));
			halo.touchable = true;
			halo.x = 23;
			halo.y = 41;
				
			hood = new Image(this.assets.getTexture('spaceShipDoorPuzzle_bg'));
			hood.touchable = true;
			hood.x = 0;
			hood.y = 0;
			
			hand  = new Image(this.assets.getTexture('hand'));
			hand.touchable = true;
			hand.x = 563;
			hand.y = 65;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['HandAttached'] == 'Yes'){
					HandAttached = true;
					disc_00.alpha = 1;
					disc_01.alpha = 1;
					disc_02.alpha = 1;
					disc_03.alpha = 1;
					disc_04.alpha = 1;
					halo.alpha = 1;
					hand.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_00'] != undefined){
						disc_00.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_00'];
					}else{
						disc_00.rotation = deg2rad(0);
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_01'] != undefined){
						disc_01.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_01'];
					}else{
						disc_01.rotation = deg2rad(69.25);
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_02'] != undefined){
						disc_02.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_02'];
					}else{
						disc_02.rotation = deg2rad(138.5);
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_03'] != undefined){
						disc_03.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_03'];
					}else{
						disc_03.rotation = deg2rad(-69.25);
					}
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_04'] != undefined){
						disc_04.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle['Disc_04'];
					}else{
						disc_04.rotation = deg2rad(-138.5);
					}
					
				}else{
					disc_00.alpha = 0;
					disc_01.alpha = 0;
					disc_02.alpha = 0;
					disc_03.alpha = 0;
					disc_04.alpha = 0;
					halo.alpha = 0;
					hand.alpha = 0;
					
					disc_00.rotation = deg2rad(0);
					disc_01.rotation = deg2rad(69.25);
					disc_02.rotation = deg2rad(138.5);
					disc_03.rotation = deg2rad(-69.25);
					disc_04.rotation = deg2rad(-138.5);
				}
			}else{
				disc_00.alpha = 0;
				disc_01.alpha = 0;
				disc_02.alpha = 0;
				disc_03.alpha = 0;
				disc_04.alpha = 0;
				halo.alpha = 0;
				hand.alpha = 0;
				
				disc_00.rotation = deg2rad(0);
				disc_01.rotation = deg2rad(69.25);
				disc_02.rotation = deg2rad(138.5);
				disc_03.rotation = deg2rad(-69.25);
				disc_04.rotation = deg2rad(-138.5);
			}
			

		
			
		
			
			hood.alpha = 1;
			
			this.addChildAt(disc_00,1);
			this.addChildAt(disc_01,2);
			this.addChildAt(disc_02,3);			
			this.addChildAt(disc_03,4);		
			this.addChildAt(disc_04,5);		
			this.addChildAt(halo,6);			
			this.addChildAt(hood,7);
			this.addChildAt(hand,8);
			
			CreateHandHit();
			CreateDiscHits();
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			
			
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crows",0,0.5,'stop');;
		}
		
		private function CreateHandHit():void{
			hit_hand = new Shape();
			hit_hand.touchable = false;
			hit_hand.graphics.beginFill(0xff0000);
			
			hit_hand.graphics.lineTo(526,213);	
			hit_hand.graphics.lineTo(556,126);	
			hit_hand.graphics.lineTo(596,67);	
			hit_hand.graphics.lineTo(678,72);	
			hit_hand.graphics.lineTo(738,114);	
			hit_hand.graphics.lineTo(766,188);	
			hit_hand.graphics.lineTo(769,296);	
			hit_hand.graphics.lineTo(737,387);	
			hit_hand.graphics.lineTo(654,456);	
			hit_hand.graphics.lineTo(572,397);	
			hit_hand.graphics.lineTo(531,298);	

			
			hit_hand.graphics.endFill(false);
			hit_hand.alpha = 0.0;
			
			hit_hand.graphics.precisionHitTest = true;	
			this.addChild(hit_hand);
		}
		
		private function CreateDiscHits():void{
			hit_disc_00 = new Shape();
			hit_disc_00.touchable = false;
			hit_disc_00.graphics.beginFill(0xff0000);
			
			hit_disc_00.graphics.lineTo(14,202);	
			hit_disc_00.graphics.lineTo(51,82);		
			hit_disc_00.graphics.lineTo(125,117);	
			hit_disc_00.graphics.lineTo(103,204);	
			hit_disc_00.graphics.lineTo(104,295);	

			hit_disc_00.graphics.lineTo(125,384);	
			hit_disc_00.graphics.lineTo(82,410);	
			hit_disc_00.graphics.lineTo(36,410);	
			hit_disc_00.graphics.lineTo(11,307);	
			
			
			hit_disc_00.graphics.endFill(false);
			hit_disc_00.alpha = 0.0;
			
			hit_disc_00.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_00);
			
			
			hit_disc_01 = new Shape();
			hit_disc_01.touchable = false;
			hit_disc_01.graphics.beginFill(0xff0000);
			
			hit_disc_01.graphics.lineTo(116,207);	
			hit_disc_01.graphics.lineTo(153,88);	
			hit_disc_01.graphics.lineTo(226,117);	
			hit_disc_01.graphics.lineTo(204,209);	
			hit_disc_01.graphics.lineTo(204,290);	
			hit_disc_01.graphics.lineTo(228,382);	
			hit_disc_01.graphics.lineTo(145,414);	
			hit_disc_01.graphics.lineTo(118,312);	
			
			hit_disc_01.graphics.endFill(false);
			hit_disc_01.alpha = 0.0;
			
			hit_disc_01.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_01);
			
			hit_disc_02 = new Shape();
			hit_disc_02.touchable = false;
			hit_disc_02.graphics.beginFill(0xff0000);
			
			hit_disc_02.graphics.lineTo(213,203);	
			hit_disc_02.graphics.lineTo(248,85);	
			hit_disc_02.graphics.lineTo(326,115);	
			hit_disc_02.graphics.lineTo(308,205);	
			hit_disc_02.graphics.lineTo(308,291);	
			hit_disc_02.graphics.lineTo(326,391);	
			hit_disc_02.graphics.lineTo(244,415);	
			hit_disc_02.graphics.lineTo(213,305);	
		
			hit_disc_02.graphics.endFill(false);
			hit_disc_02.alpha = 0.0;
			
			hit_disc_02.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_02);
			
			hit_disc_03 = new Shape();
			hit_disc_03.touchable = false;
			hit_disc_03.graphics.beginFill(0xff0000);
			
			hit_disc_03.graphics.lineTo(315,202);	
			hit_disc_03.graphics.lineTo(350,84);	
			hit_disc_03.graphics.lineTo(431,112);	
			hit_disc_03.graphics.lineTo(411,204);	
			hit_disc_03.graphics.lineTo(409,290);	
			hit_disc_03.graphics.lineTo(429,377);	
			hit_disc_03.graphics.lineTo(345,410);	
			hit_disc_03.graphics.lineTo(315,307);	

			hit_disc_03.graphics.endFill(false);
			hit_disc_03.alpha = 0.0;
			
			hit_disc_03.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_03);
			
			
			hit_disc_04 = new Shape();
			hit_disc_04.touchable = false;
			hit_disc_04.graphics.beginFill(0xff0000);
			
			hit_disc_04.graphics.lineTo(413,202);	
			hit_disc_04.graphics.lineTo(448,80);	
			hit_disc_04.graphics.lineTo(532,135);	
			hit_disc_04.graphics.lineTo(513,202);	
			hit_disc_04.graphics.lineTo(515,298);	
			hit_disc_04.graphics.lineTo(540,370);	
			hit_disc_04.graphics.lineTo(453,420);	
			hit_disc_04.graphics.lineTo(412,312);	
			
			hit_disc_04.graphics.endFill(false);
			hit_disc_04.alpha = 0.0;
			
			hit_disc_04.graphics.precisionHitTest = true;	
			this.addChild(hit_disc_04);
		}
		
		/*
		private var HandAttached:Boolean = false;
		private var Animating:Boolean = false;
		*/
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if(HandAttached === false){
						if (touches[0].phase == TouchPhase.ENDED) {
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((RavineSpaceShipDoor as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipDoorObj,true
								);
							}else if(hit_disc_00.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I'm not sure what this is.");								
							}else if(hit_disc_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks like a control panel for the ship.");	
							}else if(hit_disc_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal is like nothing I've ever seen before.");	
							}else if(hit_disc_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("It looks like a control panel for the ship.");
							}else if(hit_disc_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The metal is like nothing I've ever seen before.");	
							}else if(hit_hand.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(HandAttached === false){
									HandHandler();
								}else{
									if(PhraseCounter == 0){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Some sort of magnetic energy force is pulling the bones toward the panel...");				
										PhraseCounter = 1;
									}else if(PhraseCounter == 1){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can’t remove it.");				

										PhraseCounter = 2;
									}else if(PhraseCounter == 2){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Probably should just leave the hand in place.");				

										PhraseCounter = 3;
									}

								}
							}	
							
						}
					}else{				
						if (touches[0].phase == TouchPhase.BEGAN) {
							trace(touches[0].globalX+" ,"+touches[0].globalY);
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((RavineSpaceShipDoor as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipDoorObj,true
								);
							}else if(hit_disc_00.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								PrevMouseY = touches[0].globalY;
								DiscFlag = '00';
								
							}else if(hit_disc_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								PrevMouseY = touches[0].globalY;
								DiscFlag = '01';
								
							}else if(hit_disc_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								PrevMouseY = touches[0].globalY;
								DiscFlag = '02';
								
							}else if(hit_disc_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								PrevMouseY = touches[0].globalY;
								DiscFlag = '03';
								
							}else if(hit_disc_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWindUp();
								PrevMouseY = touches[0].globalY;
								DiscFlag = '04';
								
							}
							
							
						}else if (touches[0].phase == TouchPhase.MOVED) {
							if(DiscFlag == null){
								
							}else{
								CurrentMouseY = touches[0].globalY;
								DiscHandler();
							}
							
						}else if (touches[0].phase == TouchPhase.ENDED) {
						//	if(HandAttached === true){
								(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("CosmicWindUp");
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle;
								}
								
								
								if(DiscFlag == '00'){
									SaveArray['Disc_00'] = disc_00.rotation;
									trace(rad2deg(disc_00.rotation));
								}else if(DiscFlag == '01'){
									SaveArray['Disc_01'] = disc_01.rotation;
									trace(rad2deg(disc_01.rotation));
								}else if(DiscFlag == '02'){
									SaveArray['Disc_02'] = disc_02.rotation;
									trace(rad2deg(disc_02.rotation));
								}else if(DiscFlag == '03'){
									SaveArray['Disc_03'] = disc_03.rotation;
									trace(rad2deg(disc_03.rotation));
								}else if(DiscFlag == '04'){
									SaveArray['Disc_04'] = disc_04.rotation;
									trace(rad2deg(disc_04.rotation));
								}
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipDoorPuzzle',SaveArray);
								
								PrevMouseY = 248;
								CurrentMouseY = 248;
								DiscFlag = null;
								
								Solve();
								
						}
					}
				}
			}
		}
		
		private function HandHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_AlienHand)
			{
				game.SoundFXObj.PlaySFX_Thump();
				game.SoundFXObj.PlaySFX_CosmicWaffle();

				Animating = true;
				HandAttached = true;
				hand.alpha = 1;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle;
				}
				SaveArray['HandAttached'] = 'Yes';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipDoorPuzzle',SaveArray);
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_AlienHand,
						"item_AlienHand"
					);
				
				
				HaloAnimator();
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A larger panel, with an elongated hand projected on it.");				
			}
		}
		

		
		private function HaloAnimator():void{
			game.SoundFXObj.PlaySFX_OhmTwo();
			HaloTween = new Tween(halo, 2.2, Transitions.LINEAR);
			HaloTween.fadeTo(1);
			HaloTween.onComplete = function():void{
				
				
				HaloTween = null;
				Disc04Animator();
			}
			Starling.juggler.add(HaloTween);
		}
		
		private function Disc00Animator():void{
			game.SoundFXObj.PlaySFX_PowerUp();
			Disc00Tween = new Tween(disc_00, 1, Transitions.LINEAR);
			Disc00Tween.fadeTo(1);
			Disc00Tween.onComplete = function():void{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSciFiWhistle(true,1);
					},0.5);
				}
				
				Disc00Tween = null;
				Animating = false;	
				
				
			}
			Starling.juggler.add(Disc00Tween);
		}
		
		private function Disc01Animator():void{
			game.SoundFXObj.PlaySFX_PowerUp();
			Disc01Tween = new Tween(disc_01, 1, Transitions.LINEAR);
			Disc01Tween.fadeTo(1);
			Disc01Tween.onComplete = function():void{
				Disc01Tween = null;
				Disc00Animator();			
			}
			Starling.juggler.add(Disc01Tween);
		}
		
		private function Disc02Animator():void{
			game.SoundFXObj.PlaySFX_PowerUp();
			Disc02Tween = new Tween(disc_02, 1, Transitions.LINEAR);
			Disc02Tween.fadeTo(1);
			Disc02Tween.onComplete = function():void{
				Disc02Tween = null;
				Disc01Animator();
			}
			Starling.juggler.add(Disc02Tween);
		}
		
		private function Disc03Animator():void{
			game.SoundFXObj.PlaySFX_PowerUp();
			Disc03Tween = new Tween(disc_03, 1, Transitions.LINEAR);
			Disc03Tween.fadeTo(1);
			Disc03Tween.onComplete = function():void{
				Disc03Tween = null;
				Disc02Animator();
			}
			Starling.juggler.add(Disc03Tween);
		}
		
		private function Disc04Animator():void{
			game.SoundFXObj.PlaySFX_PowerUp();
			Disc04Tween = new Tween(disc_04, 1, Transitions.LINEAR);
			Disc04Tween.fadeTo(1);
			Disc04Tween.onComplete = function():void{
				
				Disc04Tween = null;
				Disc03Animator();
				
			}
			Starling.juggler.add(Disc04Tween);
		}
		
		private function DiscHandler():void{
			
			if(DiscFlag == '00'){
				if(CurrentMouseY > PrevMouseY){
					
					disc_00.rotation = disc_00.rotation-deg2rad(0.5);
				}else if(CurrentMouseY < PrevMouseY){
					
					disc_00.rotation = disc_00.rotation+deg2rad(0.5);
					
				}else{
					
				}
			}else if(DiscFlag == '01'){
				if(CurrentMouseY > PrevMouseY){
					disc_01.rotation = disc_01.rotation-deg2rad(0.5);
				}else if(CurrentMouseY < PrevMouseY){
					disc_01.rotation = disc_01.rotation+deg2rad(0.5);
					
				}else{
					
				}
			}else if(DiscFlag == '02'){
				if(CurrentMouseY > PrevMouseY){
					disc_02.rotation = disc_02.rotation-deg2rad(0.5);
				}else if(CurrentMouseY < PrevMouseY){
					disc_02.rotation = disc_02.rotation+deg2rad(0.5);
					
				}else{
					
				}
			}else if(DiscFlag == '03'){
				if(CurrentMouseY > PrevMouseY){
					disc_03.rotation = disc_03.rotation-deg2rad(0.5);
				}else if(CurrentMouseY < PrevMouseY){
					disc_03.rotation = disc_03.rotation+deg2rad(0.5);
					
				}else{
					
				}
			}else if(DiscFlag == '04'){
				if(CurrentMouseY > PrevMouseY){
					disc_04.rotation = disc_04.rotation-deg2rad(0.5);
				}else if(CurrentMouseY < PrevMouseY){
					disc_04.rotation = disc_04.rotation+deg2rad(0.5);
					
				}else{
					
				}
			}
			
			PrevMouseY = CurrentMouseY;
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
		
		private function Solve():void{
			if(disc_00.rotation <= deg2rad(129) && disc_00.rotation >= deg2rad(122)){
				if(disc_01.rotation <= deg2rad(-53) && disc_01.rotation >= deg2rad(-60)){
					if(disc_02.rotation <= deg2rad(58) && disc_02.rotation >= deg2rad(50)){
						if(disc_03.rotation <= deg2rad(-120) && disc_03.rotation >= deg2rad(-127)){
							if(disc_04.rotation <= deg2rad(100) && disc_04.rotation >= deg2rad(91)){
								trace("solved");
								Animating = true;
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Click();
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ComputerBeepsTwo();
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_CosmicWaffle();
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.SpaceShipDoorPuzzle;
								}
								SaveArray['Solved'] = 'Yes';
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('SpaceShipDoorPuzzle',SaveArray);
								
								delayedCall = new DelayedCall(function():void{
									
									FadeOut(RavineSpaceShipDoor,
										(stage.getChildAt(0) as Object).screenGamePlayHandler.RavineSpaceShipDoorObj,true
									);
									
								}, 2);
								Starling.juggler.add(delayedCall);
							}
							
						}
						
					}
					
				}
				
			}
		}
		
		public function Exit(blackOut:Boolean = false):void{
			
			
			this.removeChild(goback);
			goback = null;			
			
			
			this.assets.removeTexture("deep_bg",true);
			this.assets.removeTexture("SpaceShipDoorPuzzle_Sprite",true);
			this.assets.removeTexture("SpaceShipDoorPuzzle_Sprite_02",true);
			this.assets.removeTextureAtlas("SpaceShipDoorPuzzle_Sprite",true);
			this.assets.removeTextureAtlas("SpaceShipDoorPuzzle_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("spaceShipDoorPuzzle_01");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipDoorPuzzle_02");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipDoorPuzzle_03");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipDoorPuzzle_04");
			(stage.getChildAt(0) as Object).falseAsset("spaceShipDoorPuzzle_05");
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
