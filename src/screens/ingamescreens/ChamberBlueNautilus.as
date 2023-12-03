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

	public class ChamberBlueNautilus extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var shell:Image;
		
		private var posSprite:Sprite;
		private var pos0:Image;
		private var pos1:Image;
		private var pos2:Image;
		private var pos3:Image;
		private var pos4:Image;
		private var pos5:Image;
		
		private var hit_shell:Shape;
		private var hit_pos0:Shape;
		private var hit_pos1:Shape;
		private var hit_pos2:Shape;
		private var hit_pos3:Shape;
		private var hit_pos4:Shape;
		private var hit_pos5:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var Animating:Boolean = false;
		private var ItIsLit:Boolean = false;
		private var ShellAttached:Boolean = false;
		private var PosTween:Tween;
		private var Solved:Boolean = false;
		public var delayedCall:DelayedCall;
		
		private var goback:GoBackButton;
		
		private var pos0Color:int = 0;
		private var pos1Color:int = 0;
		private var pos2Color:int = 0;
		private var pos3Color:int = 0;
		private var pos4Color:int = 0;
		private var pos5Color:int = 0;
		
		public function ChamberBlueNautilus(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('chamberBlueNautilus_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlueNautilus/ChamberBlueNautilus_Sprite_03.jpg'));
				game.TrackAssets('chamberBlueNautilus_01');
			}
			if(game.CheckAsset('chamberBlueNautilus_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlueNautilus/ChamberBlueNautilus_Sprite_03.xml'));
				game.TrackAssets('chamberBlueNautilus_02');
			}
			if(game.CheckAsset('chamberBlueNautilus_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlueNautilus/ChamberBlueNautilus_Sprite_02.png'));
				game.TrackAssets('chamberBlueNautilus_03');
			}
			if(game.CheckAsset('chamberBlueNautilus_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/ChamberBlueNautilus/ChamberBlueNautilus_Sprite_02.xml'));
				game.TrackAssets('chamberBlueNautilus_04');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("ChamberBlueNautilus","ChamberBlueNautilusObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['Blue'] == 'Attached'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 3){
						ItIsLit = true;
					}else if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 4){
						ItIsLit = true;			
					}
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['White'] == 'Attached'){
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberPrism['MirrorPos'] == 2){
							ItIsLit = true;
						}
					}
				}
			}
			
			if(ItIsLit === false){
				bg = new Image(this.assets.getTexture('chamberBlueNautilus_bg'));
				shell = new Image(this.assets.getTexture('shell_white'));
			}else{
				bg = new Image(this.assets.getTexture('chamberBlueNautilus_bg_lit'));
				shell = new Image(this.assets.getTexture('shell_blue'));
			}			
		
			bg.touchable = true;
			this.addChildAt(bg,0);

			MakePosSprite();
			
			shell.touchable = false;
			shell.x = 298;
			shell.y = 186;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['Solved'] == 'Yes'){
					Solved = true;
				}
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['Shell'] == 'Attached'){
					shell.alpha = 1;
					ShellAttached = true;
					if(ItIsLit === true){
	
						posSprite.alpha = 1;
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos0'] != undefined){
							pos0Color = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos0'];
							pos0.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos0c'+pos0Color)
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos1'] != undefined){
							pos1Color = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos1'];
							pos1.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos1c'+pos1Color)
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos2'] != undefined){
							pos2Color = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos2'];
							pos2.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos2c'+pos2Color)
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos3'] != undefined){
							pos3Color = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos3'];
							pos3.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos3c'+pos3Color)
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos4'] != undefined){
							pos4Color = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos4'];
							pos4.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos4c'+pos4Color)
						}
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos5'] != undefined){
							pos5Color = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['pos5'];
							pos5.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos5c'+pos5Color)
						}
						
					}else{
						posSprite.alpha = 0;
					}
					
					
				}else{
					posSprite.alpha = 0;
					shell.alpha = 0;
				}
				
				
				
			}else{
				posSprite.alpha = 0;
				shell.alpha = 0;
			}
			
			
			
			this.addChildAt(shell,1);
			
			CreateHitNautilus();
			CreatePosHits();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,999);
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus['FirstTime'] == 'Yes'){
					
				}else{
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus;
						SaveArray['FirstTime'] = 'Yes';
						
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlueNautilus',SaveArray);
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,2);
							
						},1.5);
					}
				}
			}else{
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					SaveArray['FirstTime'] = 'Yes';
					
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlueNautilus',SaveArray);
					
					Starling.juggler.delayCall(function():void{
						//	Starling.juggler.delayCall(function():void{
						(stage.getChildAt(0) as Object).MusicObj.LoadSpeedDial(true,2);
						//(stage.getChildAt(0) as Object).MusicObj.LoadMountainViolin(true,1);
					},1.5);
				}
			}
			
		}
		
		
		private function CreateHitNautilus():void{
			hit_shell = new Shape();
			hit_shell.touchable = false;
			hit_shell.graphics.beginFill(0x00ff00);
			
			hit_shell.graphics.lineTo(290,249);												
			hit_shell.graphics.lineTo(291,219);												
			hit_shell.graphics.lineTo(308,193);												
			hit_shell.graphics.lineTo(338,179);												
			hit_shell.graphics.lineTo(364,183);												
			hit_shell.graphics.lineTo(385,198);												
			hit_shell.graphics.lineTo(390,221);												
			hit_shell.graphics.lineTo(364,250);												
			hit_shell.graphics.lineTo(354,263);												
			hit_shell.graphics.lineTo(355,288);												
			hit_shell.graphics.lineTo(356,312);												
			hit_shell.graphics.lineTo(313,286);												
			hit_shell.graphics.lineTo(294,260);												
		
			hit_shell.graphics.endFill(false);
			hit_shell.alpha = 0.0;
			
			hit_shell.graphics.precisionHitTest = true;	
			this.addChild(hit_shell);
		}
		
		
		private function CreatePosHits():void{
			hit_pos0 = new Shape();
			hit_pos0.touchable = false;
			hit_pos0.graphics.beginFill(0xff0000);
			
			hit_pos0.graphics.lineTo(362,261);												
			hit_pos0.graphics.lineTo(365,258);												
			hit_pos0.graphics.lineTo(392,234);												
			hit_pos0.graphics.lineTo(396,216);												
			hit_pos0.graphics.lineTo(428,227);												
			hit_pos0.graphics.lineTo(453,211);												
			hit_pos0.graphics.lineTo(470,181);												
			hit_pos0.graphics.lineTo(470,240);												
			hit_pos0.graphics.lineTo(441,291);												
			hit_pos0.graphics.lineTo(395,315);												
			hit_pos0.graphics.lineTo(359,288);												
		
			hit_pos0.graphics.endFill(false);
			hit_pos0.alpha = 0.0;
			
			hit_pos0.graphics.precisionHitTest = true;	
			this.addChild(hit_pos0);
			
			
			
			hit_pos1 = new Shape();
			hit_pos1.touchable = false;
			hit_pos1.graphics.beginFill(0xff0000);
			
			hit_pos1.graphics.lineTo(298,74);												
			hit_pos1.graphics.lineTo(363,73);												
			hit_pos1.graphics.lineTo(428,108);												
			hit_pos1.graphics.lineTo(465,158);												
			hit_pos1.graphics.lineTo(468,179);												
			hit_pos1.graphics.lineTo(450,208);												
			hit_pos1.graphics.lineTo(426,223);												
			hit_pos1.graphics.lineTo(395,210);												
			hit_pos1.graphics.lineTo(386,195);												
			hit_pos1.graphics.lineTo(366,180);												
			hit_pos1.graphics.lineTo(341,178);																							
			hit_pos1.graphics.lineTo(356,144);																							
			hit_pos1.graphics.lineTo(348,113);												

			hit_pos1.graphics.endFill(false);
			hit_pos1.alpha = 0.0;
			
			hit_pos1.graphics.precisionHitTest = true;	
			this.addChild(hit_pos1);
			
			
			hit_pos2 = new Shape();
			hit_pos2.touchable = false;
			hit_pos2.graphics.beginFill(0xff0000);
			
			hit_pos2.graphics.lineTo(151,287);												
			hit_pos2.graphics.lineTo(168,176);												
			hit_pos2.graphics.lineTo(223,106);												
			hit_pos2.graphics.lineTo(291,76);												
			hit_pos2.graphics.lineTo(329,98);												
			hit_pos2.graphics.lineTo(344,112);												
			hit_pos2.graphics.lineTo(351,137);												
			hit_pos2.graphics.lineTo(340,172);												
			hit_pos2.graphics.lineTo(336,177);												
			hit_pos2.graphics.lineTo(303,197);												
			hit_pos2.graphics.lineTo(289,225);												
			hit_pos2.graphics.lineTo(289,256);												
			hit_pos2.graphics.lineTo(257,230);												
			hit_pos2.graphics.lineTo(215,228);												
			hit_pos2.graphics.lineTo(173,255);												

			hit_pos2.graphics.endFill(false);
			hit_pos2.alpha = 0.0;
			
			hit_pos2.graphics.precisionHitTest = true;	
			this.addChild(hit_pos2);
			
			
			
			hit_pos3 = new Shape();
			hit_pos3.touchable = false;
			hit_pos3.graphics.beginFill(0xff0000);
			
			hit_pos3.graphics.lineTo(149,289);												
			hit_pos3.graphics.lineTo(178,252);												
			hit_pos3.graphics.lineTo(217,230);												
			hit_pos3.graphics.lineTo(255,232);												
			hit_pos3.graphics.lineTo(289,259);												
			hit_pos3.graphics.lineTo(313,294);												
			hit_pos3.graphics.lineTo(356,316);												
			hit_pos3.graphics.lineTo(395,318);												
			hit_pos3.graphics.lineTo(367,355);												
			hit_pos3.graphics.lineTo(365,405);												
			hit_pos3.graphics.lineTo(391,446);												
			hit_pos3.graphics.lineTo(442,480);												
			hit_pos3.graphics.lineTo(361,490);												
			hit_pos3.graphics.lineTo(246,453);												
			hit_pos3.graphics.lineTo(183,389);												
			hit_pos3.graphics.lineTo(153,318);												

			hit_pos3.graphics.endFill(false);
			hit_pos3.alpha = 0.0;
			
			hit_pos3.graphics.precisionHitTest = true;	
			this.addChild(hit_pos3);
			
			
			
			hit_pos4 = new Shape();
			hit_pos4.touchable = false;
			hit_pos4.graphics.beginFill(0xff0000);
			
			hit_pos4.graphics.lineTo(365,398);												
			hit_pos4.graphics.lineTo(367,355);												
			hit_pos4.graphics.lineTo(399,315);												
			hit_pos4.graphics.lineTo(441,292);												
			hit_pos4.graphics.lineTo(471,238);												
			hit_pos4.graphics.lineTo(470,168);												
			hit_pos4.graphics.lineTo(533,197);												
			hit_pos4.graphics.lineTo(603,179);												
			hit_pos4.graphics.lineTo(653,130);												
			hit_pos4.graphics.lineTo(662,220);												
			hit_pos4.graphics.lineTo(632,325);												
			hit_pos4.graphics.lineTo(564,414);												
			hit_pos4.graphics.lineTo(441,476);												
			hit_pos4.graphics.lineTo(388,435);												

			hit_pos4.graphics.endFill(false);
			hit_pos4.alpha = 0.0;
			
			hit_pos4.graphics.precisionHitTest = true;	
			this.addChild(hit_pos4);
			
			
			
			hit_pos5 = new Shape();
			hit_pos5.touchable = false;
			hit_pos5.graphics.beginFill(0xff0000);
			
			hit_pos5.graphics.lineTo(274,64);												
			hit_pos5.graphics.lineTo(305,0);												
			hit_pos5.graphics.lineTo(613,0);												
			hit_pos5.graphics.lineTo(631,44);												
			hit_pos5.graphics.lineTo(651,124);												
			hit_pos5.graphics.lineTo(600,173);												
			hit_pos5.graphics.lineTo(530,189);												
			hit_pos5.graphics.lineTo(471,161);												
			hit_pos5.graphics.lineTo(428,101);												
			hit_pos5.graphics.lineTo(363,65);												
			hit_pos5.graphics.lineTo(296,67);												

			hit_pos5.graphics.endFill(false);
			hit_pos5.alpha = 0.0;
			
			hit_pos5.graphics.precisionHitTest = true;	
			this.addChild(hit_pos5);
			/*
			private var hit_pos0:Shape;
			private var hit_pos1:Shape;
			private var hit_pos2:Shape;
			private var hit_pos3:Shape;
			private var hit_pos4:Shape;
			private var hit_pos5:Shape;
			*/
		}
		
		private function MakePosSprite():void{
			posSprite = new Sprite();
			posSprite.touchable = false;
			posSprite.x =  0;
			posSprite.y = 0
			
			pos0 = new Image((stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos0c0'));
			pos0.touchable = false;
			pos0.x = 363;
			pos0.y = 198;

			pos1 = new Image((stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos1c0'));
			pos1.touchable = false;
			pos1.x = 305;
			pos1.y = 79;
					
			pos2 = new Image((stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos2c0'));
			pos2.touchable = false;
			pos2.x = 161;
			pos2.y = 86;
		
			pos3 = new Image((stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos3c0'));
			pos3.touchable = false;
			pos3.x = 162;
			pos3.y = 234;

			pos4 = new Image((stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos4c0'));
			pos4.touchable = false;
			pos4.x = 371;
			pos4.y = 165;
			
			pos5 = new Image((stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos5c0'));
			pos5.touchable = false;
			pos5.x = 290;
			pos5.y = 1;
			
			pos0.alpha = 1;
			pos1.alpha = 1;
			pos2.alpha = 1;
			pos3.alpha = 1;
			pos4.alpha = 1;
			pos5.alpha = 1;
			
			posSprite.addChildAt(pos0,0);			
			posSprite.addChildAt(pos1,1);	
			posSprite.addChildAt(pos2,2);						
			posSprite.addChildAt(pos3,3);				
			posSprite.addChildAt(pos4,4);
			posSprite.addChildAt(pos5,5);

			posSprite.alpha = 0;
			this.addChild(posSprite);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if(Animating === false){
					if (touches[0].phase == TouchPhase.ENDED) {
						trace(touches[0].globalX+" ,"+touches[0].globalY);
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((ChamberBlue as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberBlueObj,true
							);
						}else if(hit_shell.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							ShellHandler();
						}else if(hit_pos0.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ShellAttached === true){
								if(ItIsLit === true){
									SpiralHandler(0);
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sections first emerge from the center very small.");
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sections first emerge from the center very small.");
							}
						}else if(hit_pos1.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ShellAttached === true){
								if(ItIsLit === true){
									SpiralHandler(1);
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What does it mean...?");
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("What does it mean...?");
							}
						}else if(hit_pos2.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ShellAttached === true){
								if(ItIsLit === true){
									SpiralHandler(2);
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This pattern is visible everywhere in nature, in trees, sea shells, and even people.");
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This pattern is visible everywhere in nature, in trees, sea shells, and even people.");
							}
						}else if(hit_pos3.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ShellAttached === true){
								if(ItIsLit === true){
									SpiralHandler(3);
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I have a sensation of being sucked toward the center, like I'm trapped in a whirlpool.");
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I have a sensation of being sucked toward the center, like I'm trapped in a whirlpool.");
							}
						}else if(hit_pos4.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ShellAttached === true){
								if(ItIsLit === true){
									SpiralHandler(4);
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The area is perfectly flat, I cannot see any bumps or ridges.");
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The area is perfectly flat, I cannot see any bumps or ridges.");
							}
						}else if(hit_pos5.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							if(ShellAttached === true){
								if(ItIsLit === true){
									SpiralHandler(5);
								}else{
									(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Each area gets progressively larger as it moves around the center.");
									
								}
							}else{
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Each area gets progressively larger as it moves around the center.");
						
							}
						}
					}
				}
			}
		}
		
		private function SpiralHandler(pos:int):void{
			if(Solved === false){
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Bung();
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus;
				}
		
				if(pos == 0){
					if(pos0Color == 6){
						pos0Color = 0;
						pos0.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos0c0');
					}else{
						pos0Color = pos0Color+1;
						pos0.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos0c'+pos0Color);
					}
					
					SaveArray['pos0'] = pos0Color;
				}else if(pos == 1){
					if(pos1Color == 6){
						pos1Color = 0;
						pos1.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos1c0');
					}else{
						pos1Color = pos1Color+1;
						pos1.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos1c'+pos1Color);
					}
					SaveArray['pos1'] = pos1Color;
				}else if(pos == 2){
					if(pos2Color == 6){
						pos2Color = 0;
						pos2.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos2c0');
					}else{
						pos2Color = pos2Color+1;
						pos2.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos2c'+pos2Color);
					}
					SaveArray['pos2'] = pos2Color;
				}else if(pos == 3){
					if(pos3Color == 6){
						pos3Color = 0;
						pos3.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos3c0');
					}else{
						pos3Color = pos3Color+1;
						pos3.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos3c'+pos3Color);
					}
					SaveArray['pos3'] = pos3Color;
				}else if(pos == 4){
					if(pos4Color == 6){
						pos4Color = 0;
						pos4.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos4c0');
					}else{
						pos4Color = pos4Color+1;
						pos4.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos4c'+pos4Color);
					}
					SaveArray['pos4'] = pos4Color;
				}else if(pos == 5){
					if(pos5Color == 6){
						pos5Color = 0;
						pos5.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos5c0');
					}else{
						pos5Color = pos5Color+1;
						pos5.texture = (stage.getChildAt(0) as Object).FarCoastDingyImages.assets.getTexture('pos5c'+pos5Color);
					}
					SaveArray['pos5'] = pos5Color;
				}
			
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlueNautilus',SaveArray);
				
				Solve();
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Hmmm... should probably leave this alone for now...");

			}
			
		}
		
		private function ShellHandler():void{
			if((stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.armedItem
				== 
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
				.InventoryObj.inventoryBarObj
				.item_Shell)
			{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Thump();
				shell.alpha = 1;
				ShellAttached = true;
				
				(stage.getChildAt(0) as Object)
				.screenGamePlayHandler
					.InventoryObj.removeItemFromInventory(
						(stage.getChildAt(0) as Object)
						.screenGamePlayHandler
						.InventoryObj.item_Shell,
						"item_Shell"
					);
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus;
				}
				SaveArray['Shell'] = "Attached";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlueNautilus',SaveArray);
				
				
				
				if(ItIsLit === false){
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The shell fits nicely into the groove, but nothing happened.");
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
					Animating = true;
					delayedCall = new DelayedCall(FadeInPos,1.25);
					Starling.juggler.add(delayedCall);
					
					
					if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
						
						Starling.juggler.delayCall(function():void{
							(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,2);
							
						},1.5);
					}
					
				}
				
			}else if(ShellAttached === true){
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The nautilus shell is bound to the spiral. I cannot remove it.");
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The center of the spiral is different from the outer rings...");
			}
		}
		
		private function FadeInPos():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_EnergyPulse();
			PosTween = new Tween(posSprite, 2.5, Transitions.LINEAR);
			PosTween.fadeTo(1);
			PosTween.onComplete = function():void{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Gurgles();
				Animating = false;
				PosTween = null;
			}
			Starling.juggler.add(PosTween);
		}
		
		private function Solve():void{
			if(pos0Color == 1){
				if(pos1Color == 2){
					if(pos2Color == 3){
						if(pos3Color == 4){
							if(pos4Color == 5){
								if(pos5Color == 6){
									(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHum(true,0);
									//(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
									trace("SOLVED!!!!!!!!!");
									Animating = true;
									if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus != undefined){
										SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.ChamberBlueNautilus;
									}
									SaveArray['Solved'] = "Yes";
									(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('ChamberBlueNautilus',SaveArray);
									
									
									delayedCall = new DelayedCall(function():void{
										(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
										FadeOut(ChamberBlue,(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberBlueObj,true);
										Animating = false;
									},2);
									Starling.juggler.add(delayedCall);
									
								}
							}
						}
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
			
			
			this.assets.removeTexture("ChamberBlueNautilus_Sprite_03",true);
			this.assets.removeTextureAtlas("ChamberBlueNautilus_Sprite_03",true);
			this.assets.removeTexture("ChamberBlueNautilus_Sprite_02",true);
			this.assets.removeTextureAtlas("ChamberBlueNautilus_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("chamberBlueNautilus_01");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlueNautilus_02");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlueNautilus_03");
			(stage.getChildAt(0) as Object).falseAsset("chamberBlueNautilus_04");
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