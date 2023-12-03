package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	
	
	public class JungleStumpPuzzle extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var pirateDisc:Image;
		
		private var ring_01:Image;
		private var ring_02:Image;
		private var ring_03:Image;
		private var ring_04:Image;
		
		private var lid:Image;
		
		private var hit_ring_01:Shape
		private var hit_ring_02:Shape
		private var hit_ring_03:Shape
		private var hit_ring_04:Shape
		private var hit_openLid:Shape;
		
		private var Animating:Boolean = false;
		private var RingFlag:String = null; 
		
		private var WindUpPlaying:Boolean = false;
		private var Solved:Boolean = false;
		private var Ring01Attached:Boolean = false;
		private var LidOpen:Boolean = false;
		
		private var delayedcall:DelayedCall;
		
		private var MouseCurrentAngle:Number = 180;
		private var MousePrevAngle:Number = 180;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function JungleStumpPuzzle(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('jungleStumpPuzzle_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStumpPuzzle/jungleStumpPuzzle_bg.jpg'));
				game.TrackAssets('jungleStumpPuzzle_01');
			}
			if(game.CheckAsset('jungleStumpPuzzle_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStumpPuzzle/jungleStumpPuzzle_Sprite.png'));
				game.TrackAssets('jungleStumpPuzzle_02');
			}
			if(game.CheckAsset('jungleStumpPuzzle_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStumpPuzzle/jungleStumpPuzzle_Sprite.xml'));
				game.TrackAssets('jungleStumpPuzzle_03');
			}
			if(game.CheckAsset('jungleStumpPuzzle_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStumpPuzzle/jungleStumpPuzzle_Sprite_02.atf'));
				game.TrackAssets('jungleStumpPuzzle_04');
			}
			if(game.CheckAsset('jungleStumpPuzzle_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/JungleStumpPuzzle/jungleStumpPuzzle_Sprite_02.xml'));
				game.TrackAssets('jungleStumpPuzzle_05');
			}
			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					onLoadAssets();
					//	(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("BirdHouse","BirdHouseObj");;
					//		onLoadAssets();
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("JungleStumpPuzzle","JungleStumpPuzzleObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		
		
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('jungleStumpPuzzle_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);		
			
			pirateDisc = new Image(this.assets.getTexture('pirateDisc'));
			pirateDisc.smoothing = TextureSmoothing.NONE;
			pirateDisc.touchable = false;
			pirateDisc.x = 259;
			pirateDisc.y = 153;
			
			
			ring_04 = new Image(this.assets.getTexture('ringFour'));
			ring_04.touchable = false;			
			ring_04.pivotX = 254.5;
			ring_04.pivotY = 254.5;
			ring_04.x = 150+254.5;
			ring_04.y = 255;
		
			
			ring_03 = new Image(this.assets.getTexture('ringThree'));
			ring_03.touchable = false;			
			ring_03.pivotX = 197;
			ring_03.pivotY = 197;
			ring_03.x = 208+197;
			ring_03.y = 57+197	;
		
			
			ring_02 = new Image(this.assets.getTexture('ringTwo'));
			ring_02.touchable = false;			
			ring_02.pivotX = 133.5;
			ring_02.pivotY = 133.5;
			ring_02.x = 273+133.5;
			ring_02.y = 120+133.5;	
			
			ring_01 = new Image(this.assets.getTexture('ringOne_empty'));
			ring_01.touchable = false;			
			ring_01.pivotX = 67;
			ring_01.pivotY = 67;
			ring_01.x = 340+67;
			ring_01.y = 188+67;	
			
			lid = new Image(this.assets.getTexture('lid_open'));
			lid.touchable = false;			
			lid.x = 0;
			lid.y = 0;	
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['WoodCircle'] == 'Attached'){
					ring_01.texture = this.assets.getTexture('ringOne');
					Ring01Attached = true;
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['Solved'] == 'Yes'){
						Solved = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['Lid'] == 'open'){
							LindHandler(true,true);
							
						}else{
							lid.alpha = 0
							ring_04.alpha = 1;
							ring_03.alpha = 1;
							ring_02.alpha = 1;
							ring_01.alpha = 1;
						}
					}else{
						lid.alpha = 0;
						ring_04.alpha = 1;
						ring_03.alpha = 1;
						ring_02.alpha = 1;
						ring_01.alpha = 1;
					}
				}else{
					lid.alpha = 0;
					ring_04.alpha = 1;
					ring_03.alpha = 1;
					ring_02.alpha = 1;
					ring_01.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_04_pos'] != undefined){
					ring_04.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_04_pos'];
				}else{
					ring_04.rotation = deg2rad(20);
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_03_pos'] != undefined){
					ring_03.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_03_pos'];
				}else{
					ring_03.rotation = deg2rad(100);
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_02_pos'] != undefined){
					ring_02.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_02_pos'];
				}else{
					ring_02.rotation = deg2rad(180);
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_01_pos'] != undefined){
					ring_01.rotation = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['ring_01_pos'];
				}else{
					ring_01.rotation = deg2rad(80);
				}
				
				
				
			}else{
				lid.alpha = 0;
				pirateDisc.alpha = 0;
				ring_04.alpha = 1;
				ring_03.alpha = 1;
				ring_02.alpha = 1;
				ring_01.alpha = 1;
				ring_04.rotation = deg2rad(20);
				ring_03.rotation = deg2rad(100);
				ring_02.rotation = deg2rad(180);
				ring_01.rotation = deg2rad(80);
			}
			
		
			
			this.addChildAt(pirateDisc,1);	
			this.addChildAt(ring_04,2);
			this.addChildAt(ring_03,3);
			this.addChildAt(ring_02,4);
			this.addChildAt(ring_01,5);
			this.addChildAt(lid,6);
			
			//FadeOutOcean(1);
			CreateHitRing04();
			CreateHitRing03();
			CreateHitRing02();
			CreateHitRing01();
			CreateHitOpenLid();
			
			
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.LoadCrickets_01(true,999);
		}
		
		
		
		private function CreateHitRing01():void{
			hit_ring_01 = new Shape();
			hit_ring_01.touchable = false;
			hit_ring_01.graphics.beginFill(0xFF0000);
			
			hit_ring_01.graphics.lineTo(340,251);	
			hit_ring_01.graphics.lineTo(345,226);	
			hit_ring_01.graphics.lineTo(360,200);	
			hit_ring_01.graphics.lineTo(383,190);	
			hit_ring_01.graphics.lineTo(406,186);	
			hit_ring_01.graphics.lineTo(426,190);	
			hit_ring_01.graphics.lineTo(446,201);	
			hit_ring_01.graphics.lineTo(463,220);	
			hit_ring_01.graphics.lineTo(470,242);	
			hit_ring_01.graphics.lineTo(470,239);	
			hit_ring_01.graphics.lineTo(471,261);	
			hit_ring_01.graphics.lineTo(464,282);	
			hit_ring_01.graphics.lineTo(448,304);	
			hit_ring_01.graphics.lineTo(427,315);	
			hit_ring_01.graphics.lineTo(401,320);	
			hit_ring_01.graphics.lineTo(381,314);	
			hit_ring_01.graphics.lineTo(361,302);	
			hit_ring_01.graphics.lineTo(346,281);	
			hit_ring_01.graphics.lineTo(339,256);	
			
			
			hit_ring_01.graphics.endFill(false);
			hit_ring_01.alpha = 0.0;
			
			hit_ring_01.graphics.precisionHitTest = true;	
			this.addChild(hit_ring_01);
		}
		
		private function CreateHitRing02():void{
			hit_ring_02 = new Shape();
			hit_ring_02.touchable = false;
			hit_ring_02.graphics.beginFill(0x0000ff);
			
			hit_ring_02.graphics.lineTo(272,249);
			hit_ring_02.graphics.lineTo(277,213);
			hit_ring_02.graphics.lineTo(296,175);
			hit_ring_02.graphics.lineTo(320,150);
			hit_ring_02.graphics.lineTo(352,131);
			hit_ring_02.graphics.lineTo(395,119);
			hit_ring_02.graphics.lineTo(432,120);
			hit_ring_02.graphics.lineTo(469,133);
			hit_ring_02.graphics.lineTo(498,156);
			hit_ring_02.graphics.lineTo(520,186);
			hit_ring_02.graphics.lineTo(536,222);
			hit_ring_02.graphics.lineTo(537,270);
			hit_ring_02.graphics.lineTo(525,309);
			hit_ring_02.graphics.lineTo(504,339);
			hit_ring_02.graphics.lineTo(478,362);
			hit_ring_02.graphics.lineTo(442,379);
			hit_ring_02.graphics.lineTo(395,384);
			hit_ring_02.graphics.lineTo(338,367);
			hit_ring_02.graphics.lineTo(294,325);
			hit_ring_02.graphics.lineTo(278,291);
			hit_ring_02.graphics.lineTo(278,291);

			
			hit_ring_02.graphics.endFill(false);
			hit_ring_02.alpha = 0.0;
			
			hit_ring_02.graphics.precisionHitTest = true;	
			this.addChild(hit_ring_02);
		}
		
		private function CreateHitRing03():void{
			hit_ring_03 = new Shape();
			hit_ring_03.touchable = false;
			hit_ring_03.graphics.beginFill(0x0000ff);
			
			hit_ring_03.graphics.lineTo(205,264);	
			hit_ring_03.graphics.lineTo(207,222);	
			hit_ring_03.graphics.lineTo(223,176);	
			hit_ring_03.graphics.lineTo(243,140);	
			hit_ring_03.graphics.lineTo(272,108);	
			hit_ring_03.graphics.lineTo(306,81);	
			hit_ring_03.graphics.lineTo(345,64);	
			hit_ring_03.graphics.lineTo(388,56);	
			hit_ring_03.graphics.lineTo(425,56);	
			hit_ring_03.graphics.lineTo(468,66);	
			hit_ring_03.graphics.lineTo(502,81);	
			hit_ring_03.graphics.lineTo(535,107);	
			hit_ring_03.graphics.lineTo(564,136);	
			hit_ring_03.graphics.lineTo(585,172);	
			hit_ring_03.graphics.lineTo(599,213);	
			hit_ring_03.graphics.lineTo(601,256);	
			hit_ring_03.graphics.lineTo(592,310);	
			hit_ring_03.graphics.lineTo(577,347);	
			hit_ring_03.graphics.lineTo(553,382);	
			hit_ring_03.graphics.lineTo(523,409);	
			hit_ring_03.graphics.lineTo(488,430);	
			hit_ring_03.graphics.lineTo(449,444);	
			hit_ring_03.graphics.lineTo(405,449);	
			hit_ring_03.graphics.lineTo(355,443);	
			hit_ring_03.graphics.lineTo(311,426);	
			hit_ring_03.graphics.lineTo(271,398);	
			hit_ring_03.graphics.lineTo(240,363);	
			hit_ring_03.graphics.lineTo(223,327);	
			hit_ring_03.graphics.lineTo(211,286);	
	
			
			hit_ring_03.graphics.endFill(false);
			hit_ring_03.alpha = 0.0;
			
			hit_ring_03.graphics.precisionHitTest = true;	
			this.addChild(hit_ring_03);
		}
		
		private function CreateHitRing04():void{
			hit_ring_04 = new Shape();
			hit_ring_04.touchable = false;
			hit_ring_04.graphics.beginFill(0x0000ff);
			
			hit_ring_04.graphics.lineTo(130,243);	
			hit_ring_04.graphics.lineTo(135,186);	
			hit_ring_04.graphics.lineTo(148,142);	
			hit_ring_04.graphics.lineTo(172,93);	
			hit_ring_04.graphics.lineTo(210,49);	
			hit_ring_04.graphics.lineTo(248,19);	
			hit_ring_04.graphics.lineTo(284,0);	
			hit_ring_04.graphics.lineTo(525,0);	
			hit_ring_04.graphics.lineTo(553,14);	
			hit_ring_04.graphics.lineTo(592,42);	
			hit_ring_04.graphics.lineTo(628,79);	
			hit_ring_04.graphics.lineTo(661,126);	
			hit_ring_04.graphics.lineTo(683,188);	
			hit_ring_04.graphics.lineTo(688,243);	
			hit_ring_04.graphics.lineTo(686,294);	
			hit_ring_04.graphics.lineTo(676,357);	
			hit_ring_04.graphics.lineTo(653,402);	
			hit_ring_04.graphics.lineTo(582,472);	
			hit_ring_04.graphics.lineTo(510,512);	
			hit_ring_04.graphics.lineTo(299,512);	
			hit_ring_04.graphics.lineTo(246,480);	
			hit_ring_04.graphics.lineTo(201,444);	
			hit_ring_04.graphics.lineTo(164,404);	
			hit_ring_04.graphics.lineTo(126,353);	
			//hit_ring_04.graphics.lineTo(131,243);	
			
			hit_ring_04.graphics.endFill(false);
			hit_ring_04.alpha = 0.0;
			
			hit_ring_04.graphics.precisionHitTest = true;	
			this.addChild(hit_ring_04);
		}
		
		private function CreateHitOpenLid():void{
			hit_openLid = new Shape();
			hit_openLid.touchable = false;
			hit_openLid.graphics.beginFill(0x00ff00);
			
			hit_openLid.graphics.lineTo(0,0);	
			hit_openLid.graphics.lineTo(147,0);	
			hit_openLid.graphics.lineTo(147,512);	
			hit_openLid.graphics.lineTo(0,512);	
			
			hit_openLid.graphics.endFill(false);
			hit_openLid.alpha = 0.0;
			
			hit_openLid.graphics.precisionHitTest = true;	
			this.addChild(hit_openLid);
		}
		
		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){	
				if(Solved === false){
					if (touches[0].phase == TouchPhase.BEGAN) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(Animating === false){
							if(targ == goback.SourceImage){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
								FadeOut((JungleStump as Class), 
									(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleStumpObj,true
								);
								
							}else if(hit_ring_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-252, touches[0].globalX-404))
										*180
									)/ Math.PI
								)+180;
								
								if(Ring01Attached === false){
									CenterRingHandler();
								}else{
									trace("ring_01");
									RingFlag = 'ring_01';
								}
							}else if(hit_ring_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-252, touches[0].globalX-404))
										*180
									)/ Math.PI
								)+180;
								
								trace("ring_02");
								RingFlag = 'ring_02';
							}else if(hit_ring_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-252, touches[0].globalX-404))
										*180
									)/ Math.PI
								)+180;
								
								trace("ring_03");
								RingFlag = 'ring_03';
							}else if(hit_ring_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								MousePrevAngle = (
									((Math.atan2(touches[0].globalY-252, touches[0].globalX-404))
										*180
									)/ Math.PI
								)+180;
								
								trace("ring_04");
								RingFlag = 'ring_04';
							}else{
								
								RingFlag = null;
							}
							
							
							
						}
					}
					else if(touches[0].phase == TouchPhase.MOVED){
						DiscMover();
					}
					else if(touches[0].phase == TouchPhase.ENDED){
						if(RingFlag != null){
							SaveRingPositions();
							trace(RingFlag+" rotation: "+rad2deg(this[(RingFlag)].rotation));
						}
						trace("MouseUP");
						WindUpPlaying = false;
						(stage.getChildAt(0) as Object).SoundFXObj.soundManager.stopSound("WindUp");
						if(Solved === false){
							RingFlag = null;
							MousePrevAngle = 180;
							MouseCurrentAngle = 180;
							//SaveHandPositions();
							Solve();
						}else{
							trace("MouseUP on Solve");
						}
					}
				}else{
					if(touches[0].phase == TouchPhase.BEGAN) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((JungleStump as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleStumpObj,true
							);
						}
						if(LidOpen === true){
							if(hit_openLid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								LindHandler(false);
							}else if(hit_ring_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								PirateDiscHandler();
							}
						}else{
							if(hit_ring_04.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								LindHandler(true);
							}
						}
					}
				}
			}
		}
		
		private function PirateDiscHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['PirateDisc'] == 'PickedUp'){
					
				}else{
					pirateDisc.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle;
					SaveArray['PirateDisc'] = 'PickedUp';
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStumpPuzzle',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateDisc,
						'item_PirateDisc',
						'inven_pirateTubeDisc_sm'
					);
				}
				
			}else{
				pirateDisc.alpha = 0;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle;
				}
				SaveArray['PirateDisc'] = 'PickedUp';
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStumpPuzzle',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_PirateDisc,
					'item_PirateDisc',
					'inven_pirateTubeDisc_sm'
				);
			
			}

		}
		
		private function CenterRingHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_WoodCircle)
				
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				
				trace("Wood Armed");
				Ring01Attached = true;
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_WoodCircle,
						"item_WoodCircle"
					);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle;			
				}
				SaveArray['WoodCircle'] = 'Attached';
				ring_01.texture = this.assets.getTexture('ringOne');
				Ring01Attached = true;
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStumpPuzzle',SaveArray);

			}else if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				!= 
				false)
			{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("That item doesn't do anything.");
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("There's an indented circle in the face of the wood.");
			}
		}
		
		private function DiscMover():void{
			//trace("MOUSE MOVED");
			MouseCurrentAngle = (
				((Math.atan2(touches[0].globalY-252, touches[0].globalX-404))
					*180
				)/ Math.PI
			)+180;
		//	if((Math.abs(MouseCurrentAngle-MousePrevAngle)) > 1){
			
				
				if(RingFlag == 'ring_04'){
					if((Math.abs(MouseCurrentAngle-MousePrevAngle)) > 0.1){
						if(WindUpPlaying === false){
							WindUpPlaying = true;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WindUp();
						}
						if(MousePrevAngle > MouseCurrentAngle){
							ring_04.rotation = ring_04.rotation-(deg2rad(0.25));
						}else if(MousePrevAngle < MouseCurrentAngle){
							ring_04.rotation = ring_04.rotation+(deg2rad(0.25));
						}
					}
					
				}
				else if(RingFlag == 'ring_03'){
					if((Math.abs(MouseCurrentAngle-MousePrevAngle)) > 0.2){
						if(WindUpPlaying === false){
							WindUpPlaying = true;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WindUp();
						}
						if(MousePrevAngle > MouseCurrentAngle){
							ring_03.rotation = ring_03.rotation-(deg2rad(0.5));
						}else if(MousePrevAngle < MouseCurrentAngle){
							ring_03.rotation = ring_03.rotation+(deg2rad(0.5));
						}
					}
				}
				else if(RingFlag == 'ring_02'){
					if((Math.abs(MouseCurrentAngle-MousePrevAngle)) > 0.3){
						if(WindUpPlaying === false){
							WindUpPlaying = true;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WindUp();
						}
						if(MousePrevAngle > MouseCurrentAngle){
							ring_02.rotation = ring_02.rotation-(deg2rad(0.75));
						}else if(MousePrevAngle < MouseCurrentAngle){
							ring_02.rotation = ring_02.rotation+(deg2rad(0.75));
						}
					}
					
				}
				else if(RingFlag == 'ring_01'){
					if((Math.abs(MouseCurrentAngle-MousePrevAngle)) > 0.4){
						if(WindUpPlaying === false){
							WindUpPlaying = true;
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_WindUp();
						}
						if(MousePrevAngle > MouseCurrentAngle){
							ring_01.rotation = ring_01.rotation-(deg2rad(1));
						}else if(MousePrevAngle < MouseCurrentAngle){
							ring_01.rotation = ring_01.rotation+(deg2rad(1));
						}
					}
					
				}
				
				
			
		//	}
			MousePrevAngle = MouseCurrentAngle;
		}
		
		private function SaveRingPositions():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle;
			}
			SaveArray[RingFlag+"_pos"] = this[(RingFlag)].rotation;
		//	SaveArray['HourHand'] = hourHandHolder.rotation;
		//	SaveArray['MinuteHand'] = minuteHandHolder.rotation;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStumpPuzzle',SaveArray);
		}
		
		private function Solve():void{
			if(ring_04.rotation > deg2rad(-3.5) && ring_04.rotation < deg2rad(3.5)){
				if(ring_03.rotation > deg2rad(-4.5) && ring_03.rotation < deg2rad(2.5)){
					if(ring_02.rotation > deg2rad(-4.75) && ring_02.rotation < deg2rad(2.25)){
						if(ring_01.rotation > deg2rad(-4.75) && ring_01.rotation < deg2rad(2.25)){
							trace("SOLVED");
							Solved = true;
							Animating = true;
							
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
							
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle;
							}
							SaveArray['Solved'] = 'Yes'; 
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStumpPuzzle',SaveArray);	
							
							delayedcall = new DelayedCall(function():void{
								Animating = false;
								LindHandler(true);
								
								if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
									
										(stage.getChildAt(0) as Object).MusicObj.LoadBeatUpOne(true,2);
									
								}
								
								//FadeOut(CoastMoai,(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastMoaiObj,true)
							},2);
							
							
							Starling.juggler.add(delayedcall);
						}else{
							trace("FAIL RING_01");
						}
					}else{
						trace("FAIL RING_02");
					}
				}else{
					trace("FAIL RING_03");
				}
			}else{
				trace("FAIL RING_04");
			}
				
		}
		
		private function LindHandler(OpenClose:Boolean,fromSave:Boolean = false):void{
			if(OpenClose === true){
				if(fromSave === false){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ChestOpen();
				}
				LidOpen = true;
				lid.alpha = 1;
				ring_04.alpha = 0;
				ring_03.alpha = 0;
				ring_02.alpha = 0;
				ring_01.alpha = 0;
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle['PirateDisc'] == 'PickedUp'){
					pirateDisc.alpha = 0;
				}else{
					pirateDisc.alpha = 1;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle;
				}
				SaveArray['Lid'] = 'open'; 
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStumpPuzzle',SaveArray);	
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BoxOpen();
				LidOpen = false;
				lid.alpha = 0;
				ring_04.alpha = 1;
				ring_03.alpha = 1;
				ring_02.alpha = 1;
				ring_01.alpha = 1;

				pirateDisc.alpha = 0;

				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.JungleStumpPuzzle;
				}
				SaveArray['Lid'] = 'closed'; 
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('JungleStumpPuzzle',SaveArray);	
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
			
			
			this.assets.removeTexture("jungleStumpPuzzle_bg",true);
			this.assets.removeTexture("jungleStumpPuzzle_Sprite",true);
			this.assets.removeTexture("jungleStumpPuzzle_Sprite_02",true);
			this.assets.removeTextureAtlas("jungleStumpPuzzle_Sprite",true);
			this.assets.removeTextureAtlas("jungleStumpPuzzle_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("jungleStumpPuzzle_01");
			(stage.getChildAt(0) as Object).falseAsset("jungleStumpPuzzle_02");
			(stage.getChildAt(0) as Object).falseAsset("jungleStumpPuzzle_03");
			(stage.getChildAt(0) as Object).falseAsset("jungleStumpPuzzle_04");
			(stage.getChildAt(0) as Object).falseAsset("jungleStumpPuzzle_05");
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
