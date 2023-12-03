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
	
	
	public class CoastMoai extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var left_eye:Image;
		private var right_eye:Image;
		private var mouth:Image;
		private var wood_circle:Image;
		private var logs:Image;
		
		private var hit_CoastJungle:Shape;
		private var hit_CoastCaveExterior:Shape;
		private var hit_CoastMoaiEyes:Shape;
		
		private var hit_JungleEdge:Shape;
		private var hit_mountain:Shape;
		private var hit_moai_nose:Shape;
		private var hit_other_moai:Shape;
		private var hit_moai_base:Shape;
		
		private var hit_mouth:Shape;
		private var hit_logs:Shape;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var MouthIsOpen:Boolean = false;
		private var Animating:Boolean = false;
		
		private var goback:GoBackButton;		
		
		public function CoastMoai(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('coastMoai_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastMoai/coastMoai_bg.jpg'));
				game.TrackAssets('coastMoai_01');
			}
			if(game.CheckAsset('coastMoai_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastMoai/CoastMoai_Sprite.png'));
				game.TrackAssets('coastMoai_02');
			}
			if(game.CheckAsset('coastMoai_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/CoastMoai/CoastMoai_Sprite.xml'));
				game.TrackAssets('coastMoai_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("CoastMoai","CoastMoaiObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		/*
		private var left_eye:Image;
		private var right_eye:Image;
		private var mouth:Image;
		private var wood_disc:Image;
		*/
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('coastMoai_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			logs = new Image(this.assets.getTexture('logs'));
			logs.touchable = false;
			logs.x = 110;
			logs.y = 287;
					
			left_eye = new Image(this.assets.getTexture('Moai_leftEye'));
			left_eye.touchable = false;
			left_eye.x = 352;
			left_eye.y = 86;
						
			right_eye = new Image(this.assets.getTexture('Moai_rightEye'));
			right_eye.touchable = false;
			right_eye.x = 426;
			right_eye.y = 77;
			
			mouth = new Image(this.assets.getTexture('mouth'));
			mouth.touchable = false;
			mouth.x = 405;
			mouth.y = 214;
				
			wood_circle = new Image(this.assets.getTexture('wood_circle'));
			wood_circle.touchable = false;
			wood_circle.x = 464;
			wood_circle.y = 268;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['left_eye'] == 'Attached'){
					left_eye.alpha = 1;
					mouth.alpha = 0;
					wood_circle.alpha = 0;
				}else{
					left_eye.alpha = 0;
					mouth.alpha = 0;
					wood_circle.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['right_eye'] == 'Attached'){
					right_eye.alpha = 1;
					mouth.alpha = 0;
					wood_circle.alpha = 0;
				}else{
					right_eye.alpha = 0;
					mouth.alpha = 0;
					wood_circle.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoaiEyes['Solved'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
						
						
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['MusicQue'] == 'Yes'){
							
						}else{
							if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
								SaveArray['MusicQue'] = 'Yes';
								
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);
								
								Starling.juggler.delayCall(function():void{
									(stage.getChildAt(0) as Object).MusicObj.LoadBeatDownOne(true,2);
								},1.5);
							}
						}
						
					
					
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['MouthPopped'] == 'Yes'){
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['Mouth'] == 'open'){
								MouthIsOpen = true;
								mouth.alpha = 1;
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['WoodCircle'] == 'PickedUp'){
									wood_circle.alpha = 0;
								}else{
									wood_circle.alpha = 1;
								}	
							}else{
								mouth.alpha = 0;	
								wood_circle.alpha = 0;
							}
						}else{
							
							mouth.alpha = 0;	
							wood_circle.alpha = 0;
							Animating = true;
							if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
								SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
							}
							SaveArray['Mouth'] = 'open'; 
							SaveArray['MouthPopped'] = 'Yes'; 
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);	
							Starling.juggler.delayCall(openMouthOnSolve,2);
						}
					}else{
						mouth.alpha = 0;	
						wood_circle.alpha = 0;
						Animating = true;
						if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
						}
						SaveArray['Mouth'] = 'open'; 
						SaveArray['MouthPopped'] = 'Yes'; 
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);	
						Starling.juggler.delayCall(openMouthOnSolve,2);
					}
				}
			}else{
				left_eye.alpha = 0;
				right_eye.alpha = 0;
				mouth.alpha = 0;
				wood_circle.alpha = 0;
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['Logs'] == 'PickedUp'){
					logs.alpha = 0;
				}else{
					logs.alpha = 1;
				}
				
			}else{
				logs.alpha = 1;
			}
			
		
			
			
			this.addChildAt(logs,1);
			this.addChildAt(left_eye,2);
			this.addChildAt(right_eye,3);
			this.addChildAt(mouth,4);
			this.addChildAt(wood_circle,5);
			
			
			
			CreateHitCoastJungle();
			CreateHitCoastCaveExterior();
			CreateHitEyes();
			CreateHitMouth();
			CreateHitLogs();
			CreateHitJungleEdge();
			CreateHitOtherMoai();
			CreateHitMoaiBase();
			CreateHitMountain();
			CreateHitMoaiNose();
			//FadeOutOcean(1);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Crickets_01",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWaves_01(true,999);
			
		}
		
		private function openMouthOnSolve():void{
			
		
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();

			MouthIsOpen = true;
			Animating = false;
			mouth.alpha = 1;
			wood_circle.alpha = 1;
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['MusicQue'] == 'Yes'){
						
					}else{
						if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
							SaveArray['MusicQue'] = 'Yes';
							
							(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);
							
							Starling.juggler.delayCall(function():void{
								(stage.getChildAt(0) as Object).MusicObj.LoadBeatDownOne(true,2);
							},1.5);
						}
					}
				}
		}
			
		
		/*
		private var hit_JungleEdge:Shape;
		private var hit_mountain:Shape;
		private var hit_moai_nose:Shape;
		private var hit_other_moai:Shape;
		private var hit_moai_base:Shape;
		*/
		
		private function CreateHitMoaiBase():void{
			hit_moai_base = new Shape();
			hit_moai_base.touchable = false;
			hit_moai_base.graphics.beginFill(0xff0000);
			
			hit_moai_base.graphics.lineTo(358,399);	
			hit_moai_base.graphics.lineTo(395,340);	
			hit_moai_base.graphics.lineTo(490,345);	
			hit_moai_base.graphics.lineTo(551,315);	
			hit_moai_base.graphics.lineTo(605,405);	
			hit_moai_base.graphics.lineTo(581,457);		
			
			hit_moai_base.graphics.endFill(false);
			hit_moai_base.alpha = 0.0;
			
			hit_moai_base.graphics.precisionHitTest = true;	
			this.addChild(hit_moai_base);
		}
		
		private function CreateHitMountain():void{
			hit_mountain = new Shape();
			hit_mountain.touchable = false;
			hit_mountain.graphics.beginFill(0xff0000);
			
			hit_mountain.graphics.lineTo(475,0);	
			hit_mountain.graphics.lineTo(681,0);	
			hit_mountain.graphics.lineTo(685,127);	
			hit_mountain.graphics.lineTo(603,140);	
			hit_mountain.graphics.lineTo(504,80);	
		
			
			hit_mountain.graphics.endFill(false);
			hit_mountain.alpha = 0.0;
			
			hit_mountain.graphics.precisionHitTest = true;	
			this.addChild(hit_mountain);
		}
		
		private function CreateHitMoaiNose():void{
			hit_moai_nose = new Shape();
			hit_moai_nose.touchable = false;
			hit_moai_nose.graphics.beginFill(0xff0000);
			
			hit_moai_nose.graphics.lineTo(342,151);	
			hit_moai_nose.graphics.lineTo(349,138);	
			hit_moai_nose.graphics.lineTo(466,116);	
			hit_moai_nose.graphics.lineTo(506,190);	
			hit_moai_nose.graphics.lineTo(416,207);	
			hit_moai_nose.graphics.lineTo(366,240);	
			hit_moai_nose.graphics.lineTo(339,188);	
			
			hit_moai_nose.graphics.endFill(false);
			hit_moai_nose.alpha = 0.0;
			
			hit_moai_nose.graphics.precisionHitTest = true;	
			this.addChild(hit_moai_nose);
		}
		
		private function CreateHitOtherMoai():void{
			hit_other_moai = new Shape();
			hit_other_moai.touchable = false;
			hit_other_moai.graphics.beginFill(0xff0000);
			
			hit_other_moai.graphics.lineTo(234,309);	
			hit_other_moai.graphics.lineTo(266,258);	
			hit_other_moai.graphics.lineTo(355,279);	
			hit_other_moai.graphics.lineTo(353,360);	
			hit_other_moai.graphics.lineTo(320,365);	
			hit_other_moai.graphics.lineTo(268,343);	

			hit_other_moai.graphics.endFill(false);
			hit_other_moai.alpha = 0.0;
			
			hit_other_moai.graphics.precisionHitTest = true;	
			this.addChild(hit_other_moai);
		}
		
		private function CreateHitJungleEdge():void{
			hit_JungleEdge = new Shape();
			hit_JungleEdge.touchable = false;
			hit_JungleEdge.graphics.beginFill(0xff0000);
			
			hit_JungleEdge.graphics.lineTo(116,95);	
			hit_JungleEdge.graphics.lineTo(300,81);	
			hit_JungleEdge.graphics.lineTo(298,208);	
			hit_JungleEdge.graphics.lineTo(191,203);	
			hit_JungleEdge.graphics.lineTo(135,211);	

			
			hit_JungleEdge.graphics.endFill(false);
			hit_JungleEdge.alpha = 0.0;
			
			hit_JungleEdge.graphics.precisionHitTest = true;	
			this.addChild(hit_JungleEdge);
		}
		
		
		private function CreateHitCoastJungle():void{
			hit_CoastJungle = new Shape();
			hit_CoastJungle.touchable = false;
			hit_CoastJungle.graphics.beginFill(0xff0000);
			
			hit_CoastJungle.graphics.lineTo(0,0);	
			hit_CoastJungle.graphics.lineTo(101,50);	
			hit_CoastJungle.graphics.lineTo(126,223);	
			hit_CoastJungle.graphics.lineTo(108,302);	
			hit_CoastJungle.graphics.lineTo(53,342);	
			hit_CoastJungle.graphics.lineTo(0,369);	

			hit_CoastJungle.graphics.endFill(false);
			hit_CoastJungle.alpha = 0.0;
			
			hit_CoastJungle.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastJungle);
		}
		
		private function CreateHitLogs():void{
			hit_logs = new Shape();
			hit_logs.touchable = false;
			hit_logs.graphics.beginFill(0xff0000);
			
			hit_logs.graphics.lineTo(88,327);	
			hit_logs.graphics.lineTo(175,268);	
			hit_logs.graphics.lineTo(270,353);	
			hit_logs.graphics.lineTo(258,393);	
			hit_logs.graphics.lineTo(151,375);	
			hit_logs.graphics.lineTo(91,352);	

			hit_logs.graphics.endFill(false);
			hit_logs.alpha = 0.0;
			
			hit_logs.graphics.precisionHitTest = true;	
			this.addChild(hit_logs);
		}
		
		private function CreateHitEyes():void{
			hit_CoastMoaiEyes = new Shape();
			hit_CoastMoaiEyes.touchable = false;
			hit_CoastMoaiEyes.graphics.beginFill(0xff0000);
			
			hit_CoastMoaiEyes.graphics.lineTo(305,80);	
			hit_CoastMoaiEyes.graphics.lineTo(323,23);	
			hit_CoastMoaiEyes.graphics.lineTo(408,12);	
			hit_CoastMoaiEyes.graphics.lineTo(430,23);	
			hit_CoastMoaiEyes.graphics.lineTo(465,114);	
			hit_CoastMoaiEyes.graphics.lineTo(348,138);	
			hit_CoastMoaiEyes.graphics.lineTo(313,126);	

			hit_CoastMoaiEyes.graphics.endFill(false);
			hit_CoastMoaiEyes.alpha = 0.0;
			
			hit_CoastMoaiEyes.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastMoaiEyes);
		}
		
	
		
		//hit_CoastCaveExterior
		private function CreateHitCoastCaveExterior():void{
			hit_CoastCaveExterior = new Shape();
			hit_CoastCaveExterior.touchable = false;
			hit_CoastCaveExterior.graphics.beginFill(0xff0000);
			
			hit_CoastCaveExterior.graphics.lineTo(586,223);	
			hit_CoastCaveExterior.graphics.lineTo(793,211);	
			hit_CoastCaveExterior.graphics.lineTo(795,380);	
			hit_CoastCaveExterior.graphics.lineTo(601,504);	
			hit_CoastCaveExterior.graphics.lineTo(620,392);	
			hit_CoastCaveExterior.graphics.endFill(false);
			hit_CoastCaveExterior.alpha = 0.0;
			
			hit_CoastCaveExterior.graphics.precisionHitTest = true;	
			this.addChild(hit_CoastCaveExterior);
		}
		
		
		private function CreateHitMouth():void{
			hit_mouth = new Shape();
			hit_mouth.touchable = false;
			hit_mouth.graphics.beginFill(0xff0000);
			
			hit_mouth.graphics.lineTo(396,239);	
			hit_mouth.graphics.lineTo(421,216);	
			hit_mouth.graphics.lineTo(488,200);	
			hit_mouth.graphics.lineTo(508,219);	
			hit_mouth.graphics.lineTo(549,283);	
			hit_mouth.graphics.lineTo(544,305);	
			hit_mouth.graphics.lineTo(475,327);	
			hit_mouth.graphics.lineTo(410,317);	

			hit_mouth.graphics.endFill(false);
			hit_mouth.alpha = 0.0;
			
			hit_mouth.graphics.precisionHitTest = true;	
			this.addChild(hit_mouth);
		}
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(Animating === false){
						if(targ == goback.SourceImage){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
							FadeOut((CoastCorner as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCornerObj,true
							);
						}else if(hit_CoastJungle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((CoastJungle as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastJungleObj,true
							);
						}else if(hit_JungleEdge.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((JungleEdge as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.JungleEdgeObj,true
							);	
						}else if(hit_mountain.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Where am I ? What is this place ?.");
						}else if(hit_moai_nose.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A Moai... carved from stone thousands of years ago...");
						}else if(hit_other_moai.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Another Moai... nearly completely submerged in the earth.");
						}else if(hit_moai_base.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("These things are tall. There's probably a lot more underground.");
								
							
						}else if(hit_CoastCaveExterior.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((CoastCaveExterior as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastCaveExteriorObj,true
							);
						}else if(hit_CoastMoaiEyes.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							FadeOut((CoastMoaiEyes as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.CoastMoaiEyesObj,true
							);
						}else if(hit_mouth.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							MouthHandler();
						}else if(hit_logs.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							LogsHandler();
						}
					}
				}
			}
		}
		
		private function LogsHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['Logs'] == 'PickedUp'){
					
				}else{
					logs.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
					SaveArray['Logs'] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Logs,
						'item_Logs',
						'inven_logs_sm'
					);
				}
			}else{
				logs.alpha = 0;
				SaveArray['Logs'] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Logs,
					'item_Logs',
					'inven_logs_sm'
				);
			}
		}
		
		private function MouthHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['MouthPopped'] == 'Yes'){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai['WoodCircle'] == 'PickedUp'){
						if(MouthIsOpen === true){
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
							MouthIsOpen = false;
							mouth.alpha = 0;
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
							SaveArray['Mouth'] = 'closed';
							
						}else{
							(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_StoneDrag();
							MouthIsOpen = true;
							mouth.alpha = 1;
							SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
							SaveArray['Mouth'] = 'open';
						}
						(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);	
					}else{
						WoodCircleHandler();
					}
				}else{
					(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can see a small opening around the mouth and lips of the Moai sculpture.");
				}
			}else{
				(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("I can see a small opening around the mouth and lips of the Moai sculpture.");
			}
		}
		
		private function WoodCircleHandler():void{
			wood_circle.alpha = 0;
			SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.CoastMoai;
			SaveArray['WoodCircle'] = "PickedUp";
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('CoastMoai',SaveArray);
			
			(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_WoodCircle,
				'item_WoodCircle',
				'inven_woodCircle_sm'
			);
			
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
			
			
			this.assets.removeTexture("coastMoai_bg",true);
			this.assets.removeTexture("CoastMoai_Sprite",true);
			this.assets.removeTextureAtlas("CoastMoai_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("coastMoai_01");
			(stage.getChildAt(0) as Object).falseAsset("coastMoai_02");
			(stage.getChildAt(0) as Object).falseAsset("coastMoai_03");
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