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
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	public class TemplePascal extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		
		private var squarebg:Image;
		private var trianglebg:Image;
		//private var fade_01:Image;
		private var fade_02:Image;
		private var fade_03:Image;
		private var BGsHolderSprite:Sprite;
		
		private var TweenSquareBg:Tween;
		private var TweenTriangleBg:Tween;
		private var TweenFade01:Tween;
		private var TweenFade02:Tween;
		private var TweenFade03:Tween;
		
		
		private var combo:Image;
		
		private var clear_triangle:Image;
		private var clear_combo:Image;
		
		private var control_01:Image;
		private var control_02:Image;
		private var control_03:Image;
		private var control_05:Image;
		private var control_07:Image;
			
		private var hit_control_01:Shape;
		private var hit_control_02:Shape;
		private var hit_control_03:Shape;
		private var hit_control_05:Shape;
		private var hit_control_07:Shape;
		
		private var hit_combo:Shape;
		private var hit_clear_combo:Shape;
		private var hit_clear_triangle:Shape;	
		
		private var hit_Chamber:Shape;
		

		private var hit_sq01:Shape;
		
		private var hit_sq02:Shape;
		private var hit_sq03:Shape;

		private var hit_sq04:Shape;
		private var hit_sq05:Shape;
		private var hit_sq06:Shape;
	
		private var hit_sq07:Shape;
		private var hit_sq08:Shape;
		private var hit_sq09:Shape;
		private var hit_sq10:Shape;

		private var hit_sq11:Shape;
		private var hit_sq12:Shape;
		private var hit_sq13:Shape;
		private var hit_sq14:Shape;
		private var hit_sq15:Shape;

		private var hit_sq16:Shape;
		private var hit_sq17:Shape;
		private var hit_sq18:Shape;
		private var hit_sq19:Shape;
		private var hit_sq20:Shape;
		private var hit_sq21:Shape;
		
		private var hit_sq22:Shape;
		private var hit_sq23:Shape;
		private var hit_sq24:Shape;
		private var hit_sq25:Shape;
		private var hit_sq26:Shape;
		private var hit_sq27:Shape;
		private var hit_sq28:Shape;
		
		private var hit_sq29:Shape;
		private var hit_sq30:Shape;
		private var hit_sq31:Shape;
		private var hit_sq32:Shape;
		private var hit_sq33:Shape;
		private var hit_sq34:Shape;
		
		private var sq01:Image;
		private var sq02:Image;
		private var sq03:Image;
		private var sq04:Image;
		private var sq05:Image;
		private var sq06:Image;
		private var sq07:Image;
		private var sq08:Image;
		private var sq09:Image;
		private var sq10:Image;
		private var sq11:Image;
		private var sq12:Image;
		private var sq13:Image;
		private var sq14:Image;
		private var sq15:Image;
		private var sq16:Image;
		private var sq17:Image;
		private var sq18:Image;
		private var sq19:Image;
		private var sq20:Image;
		private var sq21:Image;
		private var sq22:Image;
		private var sq23:Image;
		private var sq24:Image;
		private var sq25:Image;
		private var sq26:Image;
		private var sq27:Image;
		private var sq28:Image;
		private var sq29:Image;
		private var sq30:Image;
		private var sq31:Image;
		private var sq32:Image;
		private var sq33:Image;
		private var sq34:Image;
		
		private var UISprite:Sprite;
		private var UISpriteTween:Tween;
		
		private var highlight:Image;

		private var SQFlag:String = null;
		private var ComboFlag:String = null;
		private var Control01Active:Boolean = false;
		private var Control02Active:Boolean = false;
		private var Control03Active:Boolean = false;
		private var Control05Active:Boolean = false;
		private var Control07Active:Boolean = false;
			
		private var SQArray:Array = new Array();
		
		private var Solved:Boolean = false;		
		public var delayedcall:DelayedCall;
		private var Animating:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;		
		
		public function TemplePascal(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('templePascal_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TemplePascal/templePascal_bg.jpg'));
				game.TrackAssets('templePascal_01');
			}
		//	if(game.CheckAsset('templePascal_02') === false){
		//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TemplePascal/TemplePascal_Sprite_01.png'));
		//		game.TrackAssets('templePascal_02');
		//	}
		//	if(game.CheckAsset('templePascal_03') === false){
		//		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TemplePascal/TemplePascal_Sprite_01.xml'));
		//		game.TrackAssets('templePascal_03');
		//	}
			if(game.CheckAsset('templePascal_04') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TemplePascal/TemplePascal_Sprite_02.png'));
				game.TrackAssets('templePascal_04');
			}
			if(game.CheckAsset('templePascal_05') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/TemplePascal/TemplePascal_Sprite_02.xml'));
				game.TrackAssets('templePascal_05');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("TemplePascal","TemplePascalObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
		//	if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
		//		SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
		//	}
		//	SaveArray['Solved'] = 'no';
		//	(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);
			
			
			
			SQArray['01'] = null;
			SQArray['02'] = null;
			SQArray['03'] = null;
			SQArray['04'] = null;
			SQArray['05'] = null;
			SQArray['06'] = null;
			SQArray['07'] = null;
			SQArray['08'] = null;
			SQArray['09'] = null;
			SQArray['10'] = null;
			SQArray['11'] = null;
			SQArray['12'] = null;
			SQArray['13'] = null;
			SQArray['14'] = null;
			SQArray['15'] = null;
			SQArray['16'] = null;
			SQArray['17'] = null;
			SQArray['18'] = null;
			SQArray['19'] = null;
			SQArray['20'] = null;
			SQArray['21'] = null;
			SQArray['22'] = null;
			SQArray['23'] = null;
			SQArray['24'] = null;
			SQArray['25'] = null;
			SQArray['26'] = null;
			SQArray['27'] = null;
			SQArray['28'] = null;
			SQArray['29'] = null;
			SQArray['30'] = null;
			SQArray['31'] = null;
			SQArray['32'] = null;
			SQArray['33'] = null;
			SQArray['34'] = null;
			
			bg = new Image(this.assets.getTexture('templePascal_bg'));
			bg.touchable = true;
			this.addChildAt(bg,0);
			
			BGsHolderSprite = new Sprite();
			BGsHolderSprite.touchable = false
			BGsHolderSprite.x = 0;
			BGsHolderSprite.y = 0;
			BGsHolderSprite.alpha = 1;
			
			squarebg = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('face_squares'));
			squarebg.smoothing = TextureSmoothing.NONE;

			squarebg.touchable = false;
			squarebg.x = 138;
			squarebg.y = 1;
			
			trianglebg  = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('face_triangle'));
			trianglebg.smoothing = TextureSmoothing.NONE;

			trianglebg.touchable = false;
			trianglebg.x = 138;
			trianglebg.y = 1;
			
		//	fade_01  = new Image(this.assets.getTexture('face_fade_01'));
		//	fade_01.touchable = false;
		//	fade_01.width = 551;
		//	fade_01.height = 491;
		//	fade_01.x = 138;
		//	fade_01.y = 1;
			
			fade_02  = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('face_fade_02'));
			fade_02.smoothing = TextureSmoothing.NONE;

			fade_02.touchable = false;
			fade_02.width = 551;
			fade_02.height = 491;
			fade_02.x = 138;
			fade_02.y = 1;
			
			fade_03  = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('face_fade_03'));
			fade_03.smoothing = TextureSmoothing.NONE;

			fade_03.touchable = false;
			fade_03.width = 551;
			fade_03.height = 491;
			fade_03.x = 138;
			fade_03.y = 1;
			
			
			UISprite = new Sprite();
			UISprite.touchable = false
			UISprite.x = 0;
			UISprite.y = 0;
			UISprite.alpha = 1;
			
			
		
			combo = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('combo_01'));
			combo.smoothing = TextureSmoothing.NONE;

			combo.touchable = false;
			combo.x = 542;
			combo.y = 42;
			
			clear_triangle = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('clear_triangle'));
			clear_triangle.smoothing = TextureSmoothing.NONE;

			clear_triangle.touchable = false;
			clear_triangle.x = 703;
			clear_triangle.y = 247;
			
			clear_combo = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('clear_combo'));
			clear_combo.smoothing = TextureSmoothing.NONE;

			clear_combo.touchable = false;
			clear_combo.x = 654;
			clear_combo.y = 179;
			
			//CreateHitChamber();
			
			control_01 = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('control_01'));
			control_01.smoothing = TextureSmoothing.NONE;

			control_01.touchable = false;
			control_01.x = 73;
			control_01.y = 248;

			control_02 = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('control_02'));
			control_02.smoothing = TextureSmoothing.NONE;

			control_02.touchable = false;
			control_02.x = 159;
			control_02.y = 141;
			
			
			control_03 = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('control_03'));
			control_03.smoothing = TextureSmoothing.NONE;

			control_03.touchable = false;
			control_03.x = 39;
			control_03.y = 138;
			
			
			control_05 = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('control_05'));
			control_05.smoothing = TextureSmoothing.NONE;

			control_05.touchable = false;
			control_05.x = 236;
			control_05.y = 29;
			
			
			control_07 = new Image((stage.getChildAt(0) as Object).TemplePascalImages.assets.getTexture('control_07'));
			control_07.smoothing = TextureSmoothing.NONE;

			control_07.touchable = false;
			control_07.x = 113;
			control_07.y = 9;
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight['BallSeven'] == 'Attached'){
					Control07Active = true;
					control_07.alpha = 1;
				}else{
					control_07.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelRight['BallFive'] == 'Attached'){
					Control05Active = true;
					control_05.alpha = 1;
				}else{
					control_05.alpha = 0;
				}
			}else{
				control_05.alpha = 0;
				control_07.alpha = 0;
			}
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft != undefined){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallThree'] == 'Attached'){
					Control03Active = true;
					control_03.alpha = 1;
				}else{
					control_03.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallTwo'] == 'Attached'){
					Control02Active = true;
					control_02.alpha = 1;
				}else{
					control_02.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TempleTunnelLeft['BallOne'] == 'Attached'){
					Control01Active = true;
					control_01.alpha = 1;
				}else{
					control_01.alpha = 0;
				}
				
			}else{
				control_01.alpha = 0;
				control_02.alpha = 0;
				control_03.alpha = 0;
			}
			
			
			
			
			combo.alpha = 0;
			
			squarebg.alpha = 1;
			trianglebg.alpha = 0;
		//	fade_01.alpha = 0;
			fade_02.alpha = 0;
			fade_03.alpha = 0;
			
		
			
		//	BGsHolderSprite.addChildAt(fade_01,0);
			
			BGsHolderSprite.addChildAt(fade_03,0);
			BGsHolderSprite.addChildAt(fade_02,1);
			BGsHolderSprite.addChildAt(trianglebg,2);
			BGsHolderSprite.addChildAt(squarebg,3);
			
			UISprite.addChildAt(combo,0);			
			UISprite.addChildAt(clear_combo,1);			
			UISprite.addChildAt(clear_triangle,2);			
			UISprite.addChildAt(control_01,3);
			UISprite.addChildAt(control_02,4);			
			UISprite.addChildAt(control_03,5);
			UISprite.addChildAt(control_05,6);			
			UISprite.addChildAt(control_07,7);
			
			CreateSq();
			
			highlight = new Image(this.assets.getTexture('outline'));
			highlight.touchable = false;
			highlight.x = 113;
			highlight.y = 9;
			highlight.alpha = 0;
			UISprite.addChild(highlight);
			
			CreateSQHits();
			CreateControlHits();
			CreateComboHits();
			
			this.addChildAt(BGsHolderSprite,1);
			this.addChildAt(UISprite,2);
			
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			CheckSavedState();
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
			(stage.getChildAt(0) as Object).AmbientObj.soundManager.tweenVolumeComplex("Darkness",0,0.5,'stop');
			(stage.getChildAt(0) as Object).AmbientObj.LoadWindOne(true,999);
		}
		
		private function CheckSavedState():void{
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				trace("BIO PUZZLE EXISTS");
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['SQArray'] != undefined){
					trace("HEXARRAY EXISTS");
					SQArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['SQArray'];
					
					
					for(var i:int = 1; i<35;i++){
						trace("SAVED HEX: "+i);
						if(i < 10){
							trace('hit_hex0'+i);
							//HexArray['hex0']
				//			HexHandler('0'+i, HexArray['hex0'+i],true);
							if(SQArray['0'+i] == null){
								this[('sq0'+i)].alpha = 0;
							}else{
								this[('sq0'+i)].texture = this.assets.getTexture('dot_'+SQArray['0'+i]);
								this[('sq0'+i)].alpha = 1;
							}
								//this[('sq'+SQFlag)].texture = this.assets.getTexture('dot_'+ComboFlag);
								//this[('sq'+SQFlag)].alpha = 1;
						}else{
							if(SQArray[''+i] == null){
								this[('sq'+i)].alpha = 0;
							}else{
								this[('sq'+i)].texture = this.assets.getTexture('dot_'+SQArray[''+i]);
								this[('sq'+i)].alpha = 1;
							}
				//			HexHandler(''+i, HexArray['hex'+i],true);
						}
					}
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['ComboFlag'] != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['ComboFlag'] == 'null'){
						combo.alpha = 0;
					}else{
						ComboFlag = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['ComboFlag'];
						combo.texture = this.assets.getTexture('combo_'+ComboFlag);
						combo.alpha = 1;
					}
				}else{
					combo.alpha = 0;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['SQFlag'] != undefined){
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['SQFlag'] == 'null'){
						//combo.alpha = 0;
					}else{
						SQFlag = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['SQFlag'];
						SqHandler(SQFlag,true);
					}
				}else{
					//combo.alpha = 0;
				}
				
				//SqHandler
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal['Solved'] == 'Yes'){
					Solved = true;
					RunSolve(true);
				}
			}
		}
		
		private function CreateSq():void{
			sq01 = new Image(this.assets.getTexture('dot_01'));
			sq01.touchable = false;
			sq01.x = 371;
			sq01.y = 1;
//-----ROW 2---------//
			sq02 = new Image(this.assets.getTexture('dot_01'));
			sq02.touchable = false;
			sq02.x = 371-(35*1);
			sq02.y = 1+(60*1);

			sq03 = new Image(this.assets.getTexture('dot_01'));
			sq03.touchable = false;
			sq03.x = 371+(35*1);
			sq03.y = 1+(60*1);
//-----ROW 3---------//			
			sq04 = new Image(this.assets.getTexture('dot_01'));
			sq04.touchable = false;
			sq04.x = 371-(35*2);
			sq04.y = 1+(60*2);
			
			sq05 = new Image(this.assets.getTexture('dot_01'));
			sq05.touchable = false;
			sq05.x = 371+(35*0);
			sq05.y = 1+(60*2);
			
			sq06 = new Image(this.assets.getTexture('dot_01'));
			sq06.touchable = false;
			sq06.x = 371+(35*2);
			sq06.y = 1+(60*2);
//-----ROW 4---------//			
			sq07 = new Image(this.assets.getTexture('dot_01'));
			sq07.touchable = false;
			sq07.x = 371-(35*3);
			sq07.y = 1+(60*3);
			
			sq08 = new Image(this.assets.getTexture('dot_01'));
			sq08.touchable = false;
			sq08.x = 371-(35*1);
			sq08.y = 1+(60*3);
			
			sq09 = new Image(this.assets.getTexture('dot_01'));
			sq09.touchable = false;
			sq09.x = 371+(35*1);
			sq09.y = 1+(60*3);
			
			sq10 = new Image(this.assets.getTexture('dot_01'));
			sq10.touchable = false;
			sq10.x = 371+(35*3);
			sq10.y = 1+(60*3);
//-----ROW 5---------//		
			sq11 = new Image(this.assets.getTexture('dot_01'));
			sq11.touchable = false;
			sq11.x = 371-(35*4);
			sq11.y = 1+(60*4);
			
			sq12 = new Image(this.assets.getTexture('dot_01'));
			sq12.touchable = false;
			sq12.x = 371-(35*2);
			sq12.y = 1+(60*4);
			
			sq13 = new Image(this.assets.getTexture('dot_01'));
			sq13.touchable = false;
			sq13.x = 371+(35*0);
			sq13.y = 1+(60*4);
			
			sq14 = new Image(this.assets.getTexture('dot_01'));
			sq14.touchable = false;
			sq14.x = 371+(35*2);
			sq14.y = 1+(60*4);
			
			sq15 = new Image(this.assets.getTexture('dot_01'));
			sq15.touchable = false;
			sq15.x = 371+(35*4);
			sq15.y = 1+(60*4);
//-----ROW 6---------//		
			sq16 = new Image(this.assets.getTexture('dot_01'));
			sq16.touchable = false;
			sq16.x = 371-(35*5);
			sq16.y = 1+(60*5);
			
			sq17 = new Image(this.assets.getTexture('dot_01'));
			sq17.touchable = false;
			sq17.x = 371-(35*3);
			sq17.y = 1+(60*5);
			
			sq18 = new Image(this.assets.getTexture('dot_01'));
			sq18.touchable = false;
			sq18.x = 371-(35*1);
			sq18.y = 1+(60*5);
			
			sq19 = new Image(this.assets.getTexture('dot_01'));
			sq19.touchable = false;
			sq19.x = 371+(35*1);
			sq19.y = 1+(60*5);
			
			sq20 = new Image(this.assets.getTexture('dot_01'));
			sq20.touchable = false;
			sq20.x = 371+(35*3);
			sq20.y = 1+(60*5);
			
			sq21 = new Image(this.assets.getTexture('dot_01'));
			sq21.touchable = false;
			sq21.x = 371+(35*5);
			sq21.y = 1+(60*5);
			
//-----ROW 7---------//		
			
			sq22 = new Image(this.assets.getTexture('dot_01'));
			sq22.touchable = false;
			sq22.x = 371-(35*6);
			sq22.y = 1+(60*6);
			
			sq23 = new Image(this.assets.getTexture('dot_01'));
			sq23.touchable = false;
			sq23.x = 371-(35*4);
			sq23.y = 1+(60*6);
			
			sq24 = new Image(this.assets.getTexture('dot_01'));
			sq24.touchable = false;
			sq24.x = 371-(35*2);
			sq24.y = 1+(60*6);
			
			sq25 = new Image(this.assets.getTexture('dot_01'));
			sq25.touchable = false;
			sq25.x = 371-(35*0);
			sq25.y = 1+(60*6);
			
			sq26 = new Image(this.assets.getTexture('dot_01'));
			sq26.touchable = false;
			sq26.x = 371+(35*2);
			sq26.y = 1+(60*6);
			
			sq27 = new Image(this.assets.getTexture('dot_01'));
			sq27.touchable = false;
			sq27.x = 371+(35*4);
			sq27.y = 1+(60*6);
			
			sq28 = new Image(this.assets.getTexture('dot_01'));
			sq28.touchable = false;
			sq28.x = 371+(35*6);
			sq28.y = 1+(60*6);
			
//-----ROW 8---------//	

			sq29 = new Image(this.assets.getTexture('dot_01'));
			sq29.touchable = false;
			sq29.x = 371-(35*5);
			sq29.y = 1+(60*7);
			
			sq30 = new Image(this.assets.getTexture('dot_01'));
			sq30.touchable = false;
			sq30.x = 371-(35*3);
			sq30.y = 1+(60*7);
			
			sq31 = new Image(this.assets.getTexture('dot_01'));
			sq31.touchable = false;
			sq31.x = 371-(35*1);
			sq31.y = 1+(60*7);
			
			sq32 = new Image(this.assets.getTexture('dot_01'));
			sq32.touchable = false;
			sq32.x = 371+(35*1);
			sq32.y = 1+(60*7);
			
			sq33 = new Image(this.assets.getTexture('dot_01'));
			sq33.touchable = false;
			sq33.x = 371+(35*3);
			sq33.y = 1+(60*7);
			
			sq34 = new Image(this.assets.getTexture('dot_01'));
			sq34.touchable = false;
			sq34.x = 371+(35*5);
			sq34.y = 1+(60*7);
			
			sq01.alpha = 0;
			sq02.alpha = 0;
			sq03.alpha = 0;
			sq04.alpha = 0;
			sq05.alpha = 0;
			sq06.alpha = 0;
			sq07.alpha = 0;
			sq08.alpha = 0;
			sq09.alpha = 0;
			sq10.alpha = 0;
			sq11.alpha = 0;
			sq12.alpha = 0;
			sq13.alpha = 0;
			sq14.alpha = 0;
			sq15.alpha = 0;
			sq16.alpha = 0;
			sq17.alpha = 0;
			sq18.alpha = 0;
			sq19.alpha = 0;
			sq20.alpha = 0;
			sq21.alpha = 0;
			sq22.alpha = 0;
			sq23.alpha = 0;
			sq24.alpha = 0;
			sq25.alpha = 0;
			sq26.alpha = 0;
			sq27.alpha = 0;
			sq28.alpha = 0;
			sq29.alpha = 0;
			sq30.alpha = 0;
			sq31.alpha = 0;
			sq32.alpha = 0;
			sq33.alpha = 0;
			sq34.alpha = 0;
			
			UISprite.addChild(sq01);
			UISprite.addChild(sq02);
			UISprite.addChild(sq03);
			UISprite.addChild(sq04);
			UISprite.addChild(sq05);
			UISprite.addChild(sq06);
			UISprite.addChild(sq07);
			UISprite.addChild(sq08);
			UISprite.addChild(sq09);
			UISprite.addChild(sq10);
			UISprite.addChild(sq11);
			UISprite.addChild(sq12);
			UISprite.addChild(sq13);
			UISprite.addChild(sq14);
			UISprite.addChild(sq15);
			UISprite.addChild(sq16);
			UISprite.addChild(sq17);
			UISprite.addChild(sq18);
			UISprite.addChild(sq19);
			UISprite.addChild(sq20);
			UISprite.addChild(sq21);
			UISprite.addChild(sq22);
			UISprite.addChild(sq23);
			UISprite.addChild(sq24);
			UISprite.addChild(sq25);
			UISprite.addChild(sq26);
			UISprite.addChild(sq27);
			UISprite.addChild(sq28);
			UISprite.addChild(sq29);
			UISprite.addChild(sq30);
			UISprite.addChild(sq31);
			UISprite.addChild(sq32);
			UISprite.addChild(sq33);
			UISprite.addChild(sq34);
			
		}
		
		private function CreateComboHits():void{
			hit_combo = new Shape();
			hit_combo.touchable = false;
			hit_combo.graphics.beginFill(0xff0000);
			
			hit_combo.graphics.lineTo(540,114);		
			hit_combo.graphics.lineTo(535,32);		
			hit_combo.graphics.lineTo(665,42);		
			hit_combo.graphics.lineTo(701,121);		
			hit_combo.graphics.lineTo(589,188);		
			hit_combo.graphics.lineTo(559,154);		
		
			hit_combo.graphics.endFill(false);
			hit_combo.alpha = 0.0;
			
			hit_combo.graphics.precisionHitTest = true;	
			this.addChild(hit_combo);
			
			hit_clear_combo = new Shape();
			hit_clear_combo.touchable = false;
			hit_clear_combo.graphics.beginFill(0xff0000);
			
			hit_clear_combo.graphics.lineTo(622,186);		
			hit_clear_combo.graphics.lineTo(700,143);		
			hit_clear_combo.graphics.lineTo(740,204);		
			hit_clear_combo.graphics.lineTo(648,243);		
			
			hit_clear_combo.graphics.endFill(false);
			hit_clear_combo.alpha = 0.0;
			
			hit_clear_combo.graphics.precisionHitTest = true;	
			this.addChild(hit_clear_combo);
			
			hit_clear_triangle = new Shape();
			hit_clear_triangle.touchable = false;
			hit_clear_triangle.graphics.beginFill(0xff0000);
			
			hit_clear_triangle.graphics.lineTo(665,244);		
			hit_clear_triangle.graphics.lineTo(735,212);		
			hit_clear_triangle.graphics.lineTo(786,220);		
			hit_clear_triangle.graphics.lineTo(783,325);		
			hit_clear_triangle.graphics.lineTo(706,322);		
					
			hit_clear_triangle.graphics.endFill(false);
			hit_clear_triangle.alpha = 0.0;
			
			hit_clear_triangle.graphics.precisionHitTest = true;	
			this.addChild(hit_clear_triangle);
			
			/*
			private var hit_combo:Shape;
			private var hit_clear_combo:Shape;
			private var hit_clear_triangle:Shape;
			
			*/
			
			
		}
		
	
		
		private function CreateControlHits():void{
			hit_control_01 = new Shape();
			hit_control_01.touchable = false;
			hit_control_01.graphics.beginFill(0xff0000);
			
			hit_control_01.graphics.lineTo(25,251);		
			hit_control_01.graphics.lineTo(60,223);		
			hit_control_01.graphics.lineTo(126,226);		
			hit_control_01.graphics.lineTo(131,280);		
			hit_control_01.graphics.lineTo(91,316);		
			hit_control_01.graphics.lineTo(41,300);		
		
			hit_control_01.graphics.endFill(false);
			hit_control_01.alpha = 0.0;
			
			hit_control_01.graphics.precisionHitTest = true;	
			this.addChild(hit_control_01);
			
			hit_control_02 = new Shape();
			hit_control_02.touchable = false;
			hit_control_02.graphics.beginFill(0xff0000);
			
			hit_control_02.graphics.lineTo(138,137);		
			hit_control_02.graphics.lineTo(175,108);		
			hit_control_02.graphics.lineTo(221,120);		
			hit_control_02.graphics.lineTo(232,161);		
			hit_control_02.graphics.lineTo(201,211);		
			hit_control_02.graphics.lineTo(126,200);		
			
			hit_control_02.graphics.endFill(false);
			hit_control_02.alpha = 0.0;
			
			hit_control_02.graphics.precisionHitTest = true;	
			this.addChild(hit_control_02);
			
			
			hit_control_03 = new Shape();
			hit_control_03.touchable = false;
			hit_control_03.graphics.beginFill(0xff0000);
			
			hit_control_03.graphics.lineTo(7,145);		
			hit_control_03.graphics.lineTo(43,101);		
			hit_control_03.graphics.lineTo(113,116);		
			hit_control_03.graphics.lineTo(120,171);		
			hit_control_03.graphics.lineTo(80,213);		
			hit_control_03.graphics.lineTo(18,200);		
		
			hit_control_03.graphics.endFill(false);
			hit_control_03.alpha = 0.0;
			
			hit_control_03.graphics.precisionHitTest = true;	
			this.addChild(hit_control_03);
			
			hit_control_05 = new Shape();
			hit_control_05.touchable = false;
			hit_control_05.graphics.beginFill(0xff0000);
			
			hit_control_05.graphics.lineTo(222,27);		
			hit_control_05.graphics.lineTo(263,5);		
			hit_control_05.graphics.lineTo(314,16);		
			hit_control_05.graphics.lineTo(315,76);		
			hit_control_05.graphics.lineTo(265,107);		
			hit_control_05.graphics.lineTo(222,75);		
			
			hit_control_05.graphics.endFill(false);
			hit_control_05.alpha = 0.0;
			
			hit_control_05.graphics.precisionHitTest = true;	
			this.addChild(hit_control_05);
			
			
			hit_control_07 = new Shape();
			hit_control_07.touchable = false;
			hit_control_07.graphics.beginFill(0xff0000);
			
			hit_control_07.graphics.lineTo(95,30);		
			hit_control_07.graphics.lineTo(126,0);		
			hit_control_07.graphics.lineTo(201,0);		
			hit_control_07.graphics.lineTo(201,66);		
			hit_control_07.graphics.lineTo(153,101);		
			hit_control_07.graphics.lineTo(96,77);		
			
			hit_control_07.graphics.endFill(false);
			hit_control_07.alpha = 0.0;
			
			hit_control_07.graphics.precisionHitTest = true;	
			this.addChild(hit_control_07);
		}
		
		private function CreateSQHits():void{
			
			hit_sq01 = new Shape();
			hit_sq01.touchable = false;
			hit_sq01.graphics.beginFill(0xff0000);
			
			hit_sq01.graphics.lineTo(371,1);		
			hit_sq01.graphics.lineTo(438,1);		
			hit_sq01.graphics.lineTo(438,58);		
			hit_sq01.graphics.lineTo(371,58);		
					
			hit_sq01.graphics.endFill(false);
			hit_sq01.alpha = 0.0;
			
			hit_sq01.graphics.precisionHitTest = true;	
			this.addChild(hit_sq01);
//----------ROW 2-----------------//				
			hit_sq02 = new Shape();
			hit_sq02.touchable = false;
			hit_sq02.graphics.beginFill(0xff0000);
			
			hit_sq02.graphics.lineTo(371-35,1+60);		
			hit_sq02.graphics.lineTo(438-35,1+60);		
			hit_sq02.graphics.lineTo(438-35,58+60);		
			hit_sq02.graphics.lineTo(371-35,58+60);		
			
			hit_sq02.graphics.endFill(false);
			hit_sq02.alpha = 0.0;
			
			hit_sq02.graphics.precisionHitTest = true;	
			this.addChild(hit_sq02);
			
			hit_sq03 = new Shape();
			hit_sq03.touchable = false;
			hit_sq03.graphics.beginFill(0xff0000);

			hit_sq03.graphics.lineTo(371+35,1+60);		
			hit_sq03.graphics.lineTo(438+35,1+60);		
			hit_sq03.graphics.lineTo(438+35,58+60);		
			hit_sq03.graphics.lineTo(371+35,58+60);		
			
			hit_sq03.graphics.endFill(false);
			hit_sq03.alpha = 0.0;
			
			hit_sq03.graphics.precisionHitTest = true;	
			this.addChild(hit_sq03);
//----------ROW 3-----------------//				
			hit_sq04 = new Shape();
			hit_sq04.touchable = false;
			hit_sq04.graphics.beginFill(0xff0000);
			
			hit_sq04.graphics.lineTo(371-35-35,1+60+60);		
			hit_sq04.graphics.lineTo(438-35-35,1+60+60);		
			hit_sq04.graphics.lineTo(438-35-35,58+60+60);		
			hit_sq04.graphics.lineTo(371-35-35,58+60+60);		
			
			hit_sq04.graphics.endFill(false);
			hit_sq04.alpha = 0.0;
			
			hit_sq04.graphics.precisionHitTest = true;	
			this.addChild(hit_sq04);
			
			
			hit_sq05 = new Shape();
			hit_sq05.touchable = false;
			hit_sq05.graphics.beginFill(0xff0000);
			
			hit_sq05.graphics.lineTo(371,1+60+60);		
			hit_sq05.graphics.lineTo(438,1+60+60);		
			hit_sq05.graphics.lineTo(438,58+60+60);		
			hit_sq05.graphics.lineTo(371,58+60+60);		
			
			hit_sq05.graphics.endFill(false);
			hit_sq05.alpha = 0.0;
			
			hit_sq05.graphics.precisionHitTest = true;	
			this.addChild(hit_sq05);
			
			hit_sq06 = new Shape();
			hit_sq06.touchable = false;
			hit_sq06.graphics.beginFill(0xff0000);
			
			hit_sq06.graphics.lineTo(371+35+35,1+60+60);		
			hit_sq06.graphics.lineTo(438+35+35,1+60+60);		
			hit_sq06.graphics.lineTo(438+35+35,58+60+60);		
			hit_sq06.graphics.lineTo(371+35+35,58+60+60);		
			
			hit_sq06.graphics.endFill(false);
			hit_sq06.alpha = 0.0;
			
			hit_sq06.graphics.precisionHitTest = true;	
			this.addChild(hit_sq06);
//----------ROW 4-----------------//			
			hit_sq07 = new Shape();
			hit_sq07.touchable = false;
			hit_sq07.graphics.beginFill(0xff0000);
			
			hit_sq07.graphics.lineTo(371-35-35-35,1+60+60+60);		
			hit_sq07.graphics.lineTo(438-35-35-35,1+60+60+60);		
			hit_sq07.graphics.lineTo(438-35-35-35,58+60+60+60);		
			hit_sq07.graphics.lineTo(371-35-35-35,58+60+60+60);		
			
			hit_sq07.graphics.endFill(false);
			hit_sq07.alpha = 0.0;
			
			hit_sq07.graphics.precisionHitTest = true;	
			this.addChild(hit_sq07);
			
			hit_sq08 = new Shape();
			hit_sq08.touchable = false;
			hit_sq08.graphics.beginFill(0xff0000);
			
			hit_sq08.graphics.lineTo(371-35,1+60+60+60);		
			hit_sq08.graphics.lineTo(438-35,1+60+60+60);		
			hit_sq08.graphics.lineTo(438-35,58+60+60+60);		
			hit_sq08.graphics.lineTo(371-35,58+60+60+60);		
			
			hit_sq08.graphics.endFill(false);
			hit_sq08.alpha = 0.0;
			
			hit_sq08.graphics.precisionHitTest = true;	
			this.addChild(hit_sq08);
			
			hit_sq09 = new Shape();
			hit_sq09.touchable = false;
			hit_sq09.graphics.beginFill(0xff0000);
			
			hit_sq09.graphics.lineTo(371+35,1+60+60+60);		
			hit_sq09.graphics.lineTo(438+35,1+60+60+60);		
			hit_sq09.graphics.lineTo(438+35,58+60+60+60);		
			hit_sq09.graphics.lineTo(371+35,58+60+60+60);		
			
			hit_sq09.graphics.endFill(false);
			hit_sq09.alpha = 0.0;
			
			hit_sq09.graphics.precisionHitTest = true;	
			this.addChild(hit_sq09);
			
			
			hit_sq10 = new Shape();
			hit_sq10.touchable = false;
			hit_sq10.graphics.beginFill(0xff0000);
			
			hit_sq10.graphics.lineTo(371+35+35+35,1+60+60+60);		
			hit_sq10.graphics.lineTo(438+35+35+35,1+60+60+60);		
			hit_sq10.graphics.lineTo(438+35+35+35,58+60+60+60);		
			hit_sq10.graphics.lineTo(371+35+35+35,58+60+60+60);		
			
			hit_sq10.graphics.endFill(false);
			hit_sq10.alpha = 0.0;
			
			hit_sq10.graphics.precisionHitTest = true;	
			this.addChild(hit_sq10);
//----------ROW 5-----------------//				
			
			hit_sq11 = new Shape();
			hit_sq11.touchable = false;
			hit_sq11.graphics.beginFill(0xff0000);
			
			hit_sq11.graphics.lineTo(371-35-35-35-35,1+60+60+60+60);		
			hit_sq11.graphics.lineTo(438-35-35-35-35,1+60+60+60+60);		
			hit_sq11.graphics.lineTo(438-35-35-35-35,58+60+60+60+60);		
			hit_sq11.graphics.lineTo(371-35-35-35-35,58+60+60+60+60);		
			
			hit_sq11.graphics.endFill(false);
			hit_sq11.alpha = 0.0;
			
			hit_sq11.graphics.precisionHitTest = true;	
			this.addChild(hit_sq11);
			
			hit_sq12 = new Shape();
			hit_sq12.touchable = false;
			hit_sq12.graphics.beginFill(0xff0000);
			
			hit_sq12.graphics.lineTo(371-35-35,1+60+60+60+60);		
			hit_sq12.graphics.lineTo(438-35-35,1+60+60+60+60);		
			hit_sq12.graphics.lineTo(438-35-35,58+60+60+60+60);		
			hit_sq12.graphics.lineTo(371-35-35,58+60+60+60+60);		
			
			hit_sq12.graphics.endFill(false);
			hit_sq12.alpha = 0.0;
			
			hit_sq12.graphics.precisionHitTest = true;	
			this.addChild(hit_sq12);
			
			hit_sq13 = new Shape();
			hit_sq13.touchable = false;
			hit_sq13.graphics.beginFill(0xff0000);
			
			hit_sq13.graphics.lineTo(371,1+60+60+60+60);		
			hit_sq13.graphics.lineTo(438,1+60+60+60+60);		
			hit_sq13.graphics.lineTo(438,58+60+60+60+60);		
			hit_sq13.graphics.lineTo(371,58+60+60+60+60);		
			
			hit_sq13.graphics.endFill(false);
			hit_sq13.alpha = 0.0;
			
			hit_sq13.graphics.precisionHitTest = true;	
			this.addChild(hit_sq13);
			
			
			hit_sq14 = new Shape();
			hit_sq14.touchable = false;
			hit_sq14.graphics.beginFill(0xff0000);
			
			hit_sq14.graphics.lineTo(371+35+35,1+60+60+60+60);		
			hit_sq14.graphics.lineTo(438+35+35,1+60+60+60+60);		
			hit_sq14.graphics.lineTo(438+35+35,58+60+60+60+60);		
			hit_sq14.graphics.lineTo(371+35+35,58+60+60+60+60);		
			
			hit_sq14.graphics.endFill(false);
			hit_sq14.alpha = 0.0;
			
			hit_sq14.graphics.precisionHitTest = true;	
			this.addChild(hit_sq14);
			
			hit_sq15 = new Shape();
			hit_sq15.touchable = false;
			hit_sq15.graphics.beginFill(0xff0000);
			
			hit_sq15.graphics.lineTo(371+35+35+35+35,1+60+60+60+60);		
			hit_sq15.graphics.lineTo(438+35+35+35+35,1+60+60+60+60);		
			hit_sq15.graphics.lineTo(438+35+35+35+35,58+60+60+60+60);		
			hit_sq15.graphics.lineTo(371+35+35+35+35,58+60+60+60+60);		
			
			hit_sq15.graphics.endFill(false);
			hit_sq15.alpha = 0.0;
			
			hit_sq15.graphics.precisionHitTest = true;	
			this.addChild(hit_sq15);
			
//----------ROW 6-----------------//	
			
			hit_sq16 = new Shape();
			hit_sq16.touchable = false;
			hit_sq16.graphics.beginFill(0xff0000);
			
			hit_sq16.graphics.lineTo(371-35-35-35-35-35,1+60+60+60+60+60);		
			hit_sq16.graphics.lineTo(438-35-35-35-35-35,1+60+60+60+60+60);		
			hit_sq16.graphics.lineTo(438-35-35-35-35-35,58+60+60+60+60+60);		
			hit_sq16.graphics.lineTo(371-35-35-35-35-35,58+60+60+60+60+60);		
			
			hit_sq16.graphics.endFill(false);
			hit_sq16.alpha = 0.0;
			
			hit_sq16.graphics.precisionHitTest = true;	
			this.addChild(hit_sq16);
			
			hit_sq17 = new Shape();
			hit_sq17.touchable = false;
			hit_sq17.graphics.beginFill(0xff0000);
			
			hit_sq17.graphics.lineTo(371-35-35-35,1+60+60+60+60+60);		
			hit_sq17.graphics.lineTo(438-35-35-35,1+60+60+60+60+60);		
			hit_sq17.graphics.lineTo(438-35-35-35,58+60+60+60+60+60);		
			hit_sq17.graphics.lineTo(371-35-35-35,58+60+60+60+60+60);		
			
			hit_sq17.graphics.endFill(false);
			hit_sq17.alpha = 0.0;
			
			hit_sq17.graphics.precisionHitTest = true;	
			this.addChild(hit_sq17);
			
			
			hit_sq18 = new Shape();
			hit_sq18.touchable = false;
			hit_sq18.graphics.beginFill(0xff0000);
			
			hit_sq18.graphics.lineTo(371-35,1+60+60+60+60+60);		
			hit_sq18.graphics.lineTo(438-35,1+60+60+60+60+60);		
			hit_sq18.graphics.lineTo(438-35,58+60+60+60+60+60);		
			hit_sq18.graphics.lineTo(371-35,58+60+60+60+60+60);		
			
			hit_sq18.graphics.endFill(false);
			hit_sq18.alpha = 0.0;
			
			hit_sq18.graphics.precisionHitTest = true;	
			this.addChild(hit_sq18);
			
			
			hit_sq19 = new Shape();
			hit_sq19.touchable = false;
			hit_sq19.graphics.beginFill(0xff0000);
			
			hit_sq19.graphics.lineTo(371+35,1+60+60+60+60+60);		
			hit_sq19.graphics.lineTo(438+35,1+60+60+60+60+60);		
			hit_sq19.graphics.lineTo(438+35,58+60+60+60+60+60);		
			hit_sq19.graphics.lineTo(371+35,58+60+60+60+60+60);		
			
			hit_sq19.graphics.endFill(false);
			hit_sq19.alpha = 0.0;
			
			hit_sq19.graphics.precisionHitTest = true;	
			this.addChild(hit_sq19);
			
			
			hit_sq20 = new Shape();
			hit_sq20.touchable = false;
			hit_sq20.graphics.beginFill(0xff0000);
			
			hit_sq20.graphics.lineTo(371+35+35+35,1+60+60+60+60+60);		
			hit_sq20.graphics.lineTo(438+35+35+35,1+60+60+60+60+60);		
			hit_sq20.graphics.lineTo(438+35+35+35,58+60+60+60+60+60);		
			hit_sq20.graphics.lineTo(371+35+35+35,58+60+60+60+60+60);		
			
			hit_sq20.graphics.endFill(false);
			hit_sq20.alpha = 0.0;
			
			hit_sq20.graphics.precisionHitTest = true;	
			this.addChild(hit_sq20);
			
			
			hit_sq21 = new Shape();
			hit_sq21.touchable = false;
			hit_sq21.graphics.beginFill(0xff0000);
			
			hit_sq21.graphics.lineTo(371+35+35+35+35+35,1+60+60+60+60+60);		
			hit_sq21.graphics.lineTo(438+35+35+35+35+35,1+60+60+60+60+60);		
			hit_sq21.graphics.lineTo(438+35+35+35+35+35,58+60+60+60+60+60);		
			hit_sq21.graphics.lineTo(371+35+35+35+35+35,58+60+60+60+60+60);		
			
			hit_sq21.graphics.endFill(false);
			hit_sq21.alpha = 0.0;
			
			hit_sq21.graphics.precisionHitTest = true;	
			this.addChild(hit_sq21);
//--------------ROW 7-------------//	
			
			hit_sq22 = new Shape();
			hit_sq22.touchable = false;
			hit_sq22.graphics.beginFill(0xff0000);
			
			hit_sq22.graphics.lineTo(371-(35*6),1+(60*6));		
			hit_sq22.graphics.lineTo(438-(35*6),1+(60*6));		
			hit_sq22.graphics.lineTo(438-(35*6),58+(60*6));		
			hit_sq22.graphics.lineTo(371-(35*6),58+(60*6));		
			
			hit_sq22.graphics.endFill(false);
			hit_sq22.alpha = 0.0;
			
			hit_sq22.graphics.precisionHitTest = true;	
			this.addChild(hit_sq22);
			
			
			hit_sq23 = new Shape();
			hit_sq23.touchable = false;
			hit_sq23.graphics.beginFill(0xff0000);
			
			hit_sq23.graphics.lineTo(371-(35*4),1+(60*6));		
			hit_sq23.graphics.lineTo(438-(35*4),1+(60*6));		
			hit_sq23.graphics.lineTo(438-(35*4),58+(60*6));		
			hit_sq23.graphics.lineTo(371-(35*4),58+(60*6));		
			
			hit_sq23.graphics.endFill(false);
			hit_sq23.alpha = 0.0;
			
			hit_sq23.graphics.precisionHitTest = true;	
			this.addChild(hit_sq23);
			
			hit_sq24 = new Shape();
			hit_sq24.touchable = false;
			hit_sq24.graphics.beginFill(0xff0000);
			
			hit_sq24.graphics.lineTo(371-(35*2),1+(60*6));		
			hit_sq24.graphics.lineTo(438-(35*2),1+(60*6));		
			hit_sq24.graphics.lineTo(438-(35*2),58+(60*6));		
			hit_sq24.graphics.lineTo(371-(35*2),58+(60*6));		
			
			hit_sq24.graphics.endFill(false);
			hit_sq24.alpha = 0.0;
			
			hit_sq24.graphics.precisionHitTest = true;	
			this.addChild(hit_sq24);
			
			hit_sq25 = new Shape();
			hit_sq25.touchable = false;
			hit_sq25.graphics.beginFill(0xff0000);
			
			hit_sq25.graphics.lineTo(371-(35*0),1+(60*6));		
			hit_sq25.graphics.lineTo(438-(35*0),1+(60*6));		
			hit_sq25.graphics.lineTo(438-(35*0),58+(60*6));		
			hit_sq25.graphics.lineTo(371-(35*0),58+(60*6));		
			
			hit_sq25.graphics.endFill(false);
			hit_sq25.alpha = 0.0;
			
			hit_sq25.graphics.precisionHitTest = true;	
			this.addChild(hit_sq25);
			
			
			hit_sq26 = new Shape();
			hit_sq26.touchable = false;
			hit_sq26.graphics.beginFill(0xff0000);
			
			hit_sq26.graphics.lineTo(371+(35*2),1+(60*6));		
			hit_sq26.graphics.lineTo(438+(35*2),1+(60*6));		
			hit_sq26.graphics.lineTo(438+(35*2),58+(60*6));		
			hit_sq26.graphics.lineTo(371+(35*2),58+(60*6));		
			
			hit_sq26.graphics.endFill(false);
			hit_sq26.alpha = 0.0;
			
			hit_sq26.graphics.precisionHitTest = true;	
			this.addChild(hit_sq26);
			
			
			hit_sq27 = new Shape();
			hit_sq27.touchable = false;
			hit_sq27.graphics.beginFill(0xff0000);
			
			hit_sq27.graphics.lineTo(371+(35*4),1+(60*6));		
			hit_sq27.graphics.lineTo(438+(35*4),1+(60*6));		
			hit_sq27.graphics.lineTo(438+(35*4),58+(60*6));		
			hit_sq27.graphics.lineTo(371+(35*4),58+(60*6));		
			
			hit_sq27.graphics.endFill(false);
			hit_sq27.alpha = 0.0;
			
			hit_sq27.graphics.precisionHitTest = true;	
			this.addChild(hit_sq27);
			
			
			hit_sq28 = new Shape();
			hit_sq28.touchable = false;
			hit_sq28.graphics.beginFill(0xff0000);
			
			hit_sq28.graphics.lineTo(371+(35*6),1+(60*6));		
			hit_sq28.graphics.lineTo(438+(35*6),1+(60*6));		
			hit_sq28.graphics.lineTo(438+(35*6),58+(60*6));		
			hit_sq28.graphics.lineTo(371+(35*6),58+(60*6));		
			
			hit_sq28.graphics.endFill(false);
			hit_sq28.alpha = 0.0;
			
			hit_sq28.graphics.precisionHitTest = true;	
			this.addChild(hit_sq28);
//------------ROW 8-----------//			
		
			hit_sq29 = new Shape();
			hit_sq29.touchable = false;
			hit_sq29.graphics.beginFill(0xff0000);
			
			hit_sq29.graphics.lineTo(371-(35*5),1+(60*7));		
			hit_sq29.graphics.lineTo(438-(35*5),1+(60*7));		
			hit_sq29.graphics.lineTo(438-(35*5),58+(60*7));		
			hit_sq29.graphics.lineTo(371-(35*5),58+(60*7));		
			
			hit_sq29.graphics.endFill(false);
			hit_sq29.alpha = 0.0;
			
			hit_sq29.graphics.precisionHitTest = true;	
			this.addChild(hit_sq29);
			
			hit_sq30 = new Shape();
			hit_sq30.touchable = false;
			hit_sq30.graphics.beginFill(0xff0000);
			
			hit_sq30.graphics.lineTo(371-(35*3),1+(60*7));		
			hit_sq30.graphics.lineTo(438-(35*3),1+(60*7));		
			hit_sq30.graphics.lineTo(438-(35*3),58+(60*7));		
			hit_sq30.graphics.lineTo(371-(35*3),58+(60*7));		
			
			hit_sq30.graphics.endFill(false);
			hit_sq30.alpha = 0.0;
			
			hit_sq30.graphics.precisionHitTest = true;	
			this.addChild(hit_sq30);
			
			
			hit_sq31 = new Shape();
			hit_sq31.touchable = false;
			hit_sq31.graphics.beginFill(0xff0000);
			
			hit_sq31.graphics.lineTo(371-(35*1),1+(60*7));		
			hit_sq31.graphics.lineTo(438-(35*1),1+(60*7));		
			hit_sq31.graphics.lineTo(438-(35*1),58+(60*7));		
			hit_sq31.graphics.lineTo(371-(35*1),58+(60*7));		
			
			hit_sq31.graphics.endFill(false);
			hit_sq31.alpha = 0.0;
			
			hit_sq31.graphics.precisionHitTest = true;	
			this.addChild(hit_sq31);
			
			
			hit_sq32 = new Shape();
			hit_sq32.touchable = false;
			hit_sq32.graphics.beginFill(0xff0000);
			
			hit_sq32.graphics.lineTo(371+(35*1),1+(60*7));		
			hit_sq32.graphics.lineTo(438+(35*1),1+(60*7));		
			hit_sq32.graphics.lineTo(438+(35*1),58+(60*7));		
			hit_sq32.graphics.lineTo(371+(35*1),58+(60*7));		
			
			hit_sq32.graphics.endFill(false);
			hit_sq32.alpha = 0.0;
			
			hit_sq32.graphics.precisionHitTest = true;	
			this.addChild(hit_sq32);
			
			
			hit_sq33 = new Shape();
			hit_sq33.touchable = false;
			hit_sq33.graphics.beginFill(0xff0000);
			
			hit_sq33.graphics.lineTo(371+(35*3),1+(60*7));		
			hit_sq33.graphics.lineTo(438+(35*3),1+(60*7));		
			hit_sq33.graphics.lineTo(438+(35*3),58+(60*7));		
			hit_sq33.graphics.lineTo(371+(35*3),58+(60*7));		
			
			hit_sq33.graphics.endFill(false);
			hit_sq33.alpha = 0.0;
			
			hit_sq33.graphics.precisionHitTest = true;	
			this.addChild(hit_sq33);
			
			hit_sq34 = new Shape();
			hit_sq34.touchable = false;
			hit_sq34.graphics.beginFill(0xff0000);
			
			hit_sq34.graphics.lineTo(371+(35*5),1+(60*7));		
			hit_sq34.graphics.lineTo(438+(35*5),1+(60*7));		
			hit_sq34.graphics.lineTo(438+(35*5),58+(60*7));		
			hit_sq34.graphics.lineTo(371+(35*5),58+(60*7));		
			
			hit_sq34.graphics.endFill(false);
			hit_sq34.alpha = 0.0;
			
			hit_sq34.graphics.precisionHitTest = true;	
			this.addChild(hit_sq34);
			
			/*
			private var hit_sq01:Shape;
			
			private var hit_sq02:Shape;
			private var hit_sq03:Shape;
			
			private var hit_sq04:Shape;
			private var hit_sq05:Shape;
			private var hit_sq06:Shape;
			
			private var hit_sq07:Shape;
			private var hit_sq08:Shape;
			private var hit_sq09:Shape;
			private var hit_sq10:Shape;
			
			private var hit_sq11:Shape;
			private var hit_sq12:Shape;
			private var hit_sq13:Shape;
			private var hit_sq14:Shape;
			private var hit_sq15:Shape;
			
			private var hit_sq16:Shape;
			private var hit_sq17:Shape;
			private var hit_sq18:Shape;
			private var hit_sq19:Shape;
			private var hit_sq20:Shape;
			private var hit_sq21:Shape;
			
			private var hit_sq22:Shape;
			private var hit_sq23:Shape;
			private var hit_sq24:Shape;
			private var hit_sq25:Shape;
			private var hit_sq26:Shape;
			private var hit_sq27:Shape;
			private var hit_sq28:Shape;
			
			private var hit_sq29:Shape;
			private var hit_sq30:Shape;
			private var hit_sq31:Shape;
			private var hit_sq32:Shape;
			private var hit_sq33:Shape;
			private var hit_sq34:Shape; 
			*/
				
			
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
							FadeOut((TempleTunnel as Class), 
								(stage.getChildAt(0) as Object).screenGamePlayHandler.TempleTunnelObj,true
							);
					//	}else if(hit_Chamber.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
					//		FadeOut((Chamber as Class), 
					//			(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberObj,true
					//		);	
						}else if(Solved === false){
							if(hit_control_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(Control01Active === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									Control01Handler();
								}else{
									if(Control01Active === true || Control02Active === true || Control03Active === true || Control05Active === true || Control07Active === true ){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This stone remains unlit.");

									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Spherical stones protrude from the cave walls.");

									}

								}
							}else if(hit_control_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(Control02Active === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									Control02Handler();
								}else{
									if(Control01Active === true || Control02Active === true || Control03Active === true || Control05Active === true || Control07Active === true ){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sphere is inactive.");
										
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Defined round shapes emanate from the stone.");
										
									}
								}
							}else if(hit_control_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(Control03Active === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									Control03Handler();
								}else{
									if(Control01Active === true || Control02Active === true || Control03Active === true || Control05Active === true || Control07Active === true ){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Nothing happens when I press on the rock.");
										
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Spherical stones protrude from the cave walls.");
										
									}
								}
							}else if(hit_control_05.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(Control05Active === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									Control05Handler();
								}else{
									if(Control01Active === true || Control02Active === true || Control03Active === true || Control05Active === true || Control07Active === true ){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The sphere is inactive.");
										
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Defined round shapes emanate from the stone.");
										
									}
								}
							}else if(hit_control_07.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								if(Control07Active === true){
									(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakOne();
									Control07Handler();
								}else{
									if(Control01Active === true || Control02Active === true || Control03Active === true || Control05Active === true || Control07Active === true ){
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This stone remains unlit.");
										
									}else{
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("Spherical stones protrude from the cave walls.");
										
									}
								}
							}else if(hit_combo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								
								ComboHandler();
							}else if(hit_clear_combo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
								combo.alpha = 0;
								ComboFlag = null;
								
								if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
									SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
								}
								SaveArray['ComboFlag'] = 'null';	
								(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);	
							}else if(hit_clear_triangle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								ClearAllSQ();
							}else{ 
								/*
								private var Control01Active:Boolean = false;
								private var Control02Active:Boolean = false;
								private var Control03Active:Boolean = false;
								private var Control05Active:Boolean = false;
								private var Control07Active:Boolean = false;
								*/
								if(Control01Active === true || Control02Active === true || Control03Active === true || Control05Active === true || Control07Active === true ){
									for(var i:int = 1; i<35;i++){
										//	trace(i);
											
										if(i < 10){
											if(this[('hit_sq0'+i)].graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
												(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakTwo();
												trace('hit_sq0'+i);
												SqHandler('0'+i);
												//HexHandler('0'+i, ArmedColor);
												return;
											}
										}else{
											if(this[('hit_sq'+i)].graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
												(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakTwo();
												trace('hit_sq'+i);
												SqHandler(''+i);
											//	HexHandler(''+i, ArmedColor);
												return;
											}
										}
									}
								}else{
									for(var i:int = 1; i<35;i++){
										//	trace(i);
										
										if(i < 10){
											if(this[('hit_sq0'+i)].graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
												trace('hit_sq0'+i);
												(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("A triangular stone wall blocks the way deeper into the cave.");

												return;
											}
										}else{
											if(this[('hit_sq'+i)].graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
												trace('hit_sq'+i);
												(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("This structure definitely does not look random.");

												return;
											}
										}
									}
								}
							}
						}else if(Solved === true){
							if(hit_Chamber.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
									FadeOut((Chamber as Class), 
										(stage.getChildAt(0) as Object).screenGamePlayHandler.ChamberObj,true
									);	
							}else if(hit_control_01.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The balls have gone silent.");
								
							}else if(hit_control_02.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The markings have disappeared.");
								
							}else if(hit_control_03.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The spheres have returned to being weird rock formations...");
							}else if(hit_control_05.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The stone is cold.");
							}else if(hit_control_07.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("The markings have disappeared.");
							}else if(hit_combo.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
								(stage.getChildAt(0) as Object).screenGamePlayHandler.ReadOutObj.ToggleReadOut("No longer do the spheres react to my touch.");
							}
						}
					}
				}
			}
		}
		
		private function ClearAllSQ():void{
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Bung();
			for(var i:int = 1; i<35;i++){
				//	trace(i);
				if(i < 10){
					SQArray['0'+i] = null;
					this[('sq0'+i)].alpha = 0;
				}else{
					SQArray[''+i] = null;
					this[('sq'+i)].alpha = 0;
					
				}
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
			}
			SaveArray['SQArray'] = SQArray;
			SaveArray['SQFlag'] = 'null';
			SQFlag = null;
			highlight.alpha = 0;
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);
		//	SaveHexArray();
		}
		
		private function ComboHandler():void{
			if(SQFlag == null){
				
			}else{
				
				
				if(ComboFlag == null){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_ThakThree();
					//SaveArray[''+SQFlag] = '00';
					SQArray[''+SQFlag] = null;
					this[('sq'+SQFlag)].alpha = 0;
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Bung();
					//SaveArray[''+SQFlag] = 'ComboFlag';
					SQArray[''+SQFlag] = ComboFlag;
					this[('sq'+SQFlag)].texture = this.assets.getTexture('dot_'+ComboFlag);
					this[('sq'+SQFlag)].alpha = 1;
				}
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
				}
				SaveArray['SQArray'] = SQArray;
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);
				
				Solve();
			}

			
			
		}
		
		private function Control01Handler():void{
			
			
			if(ComboFlag == null){
				ComboFlag = '01';
				
				combo.texture = this.assets.getTexture('combo_01');
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
			}
			SaveArray['ComboFlag'] = ComboFlag;	
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);	
			combo.alpha = 1;
		}
		
		private function Control02Handler():void{
			
			if(ComboFlag == null){
				
				ComboFlag = '02';
				combo.texture = this.assets.getTexture('combo_02')
			}else if(ComboFlag == '01'){
				
				ComboFlag = '02';
				combo.texture = this.assets.getTexture('combo_02')
			}else if(ComboFlag == '02'){
				
				ComboFlag = '04';
				combo.texture = this.assets.getTexture('combo_04')
			}else if(ComboFlag == '03'){
				
				ComboFlag = '06';
				combo.texture = this.assets.getTexture('combo_06')
			}else if(ComboFlag == '04'){
			//	ComboFlag = '04';
			//	combo.texture = this.assets.getTexture('combo_04')
			}else if(ComboFlag == '05'){
			
				ComboFlag = '10';
				combo.texture = this.assets.getTexture('combo_10')
			}else if(ComboFlag == '06'){
			//	ComboFlag = '06';
			//	combo.texture = this.assets.getTexture('combo_06')
			}else if(ComboFlag == '07'){
			//	ComboFlag = '07';
			//	combo.texture = this.assets.getTexture('combo_07')
			}else if(ComboFlag == '10'){
				
				ComboFlag = '20';
				combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '15'){
			//	ComboFlag = '20';
			//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '20'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '21'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '35'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
			}
			
			SaveArray['ComboFlag'] = ComboFlag;	
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);	
			combo.alpha = 1;
		}
		
		private function Control03Handler():void{
			
			
			if(ComboFlag == null){
				//ComboFlag = '03';
				ComboFlag = '03';
				combo.texture = this.assets.getTexture('combo_03')
			}else if(ComboFlag == '01'){
				ComboFlag = '03';
				combo.texture = this.assets.getTexture('combo_03')
			}else if(ComboFlag == '02'){
				ComboFlag = '06';
				combo.texture = this.assets.getTexture('combo_06')
			}else if(ComboFlag == '03'){
			//	ComboFlag = '06';
			//	combo.texture = this.assets.getTexture('combo_06')
			}else if(ComboFlag == '04'){
				//	ComboFlag = '04';
				//	combo.texture = this.assets.getTexture('combo_04')
			}else if(ComboFlag == '05'){
				ComboFlag = '15';
				combo.texture = this.assets.getTexture('combo_15')
			}else if(ComboFlag == '06'){
				//	ComboFlag = '06';
				//	combo.texture = this.assets.getTexture('combo_06')
			}else if(ComboFlag == '07'){
					ComboFlag = '21';
					combo.texture = this.assets.getTexture('combo_21')
			}else if(ComboFlag == '10'){
				//ComboFlag = '20';
				//combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '15'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '20'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '21'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '35'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
			}
			SaveArray['ComboFlag'] = ComboFlag;	
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);	
			combo.alpha = 1;
		}
		
		private function Control05Handler():void{
			if(ComboFlag == null){
				ComboFlag = '05';
				combo.texture = this.assets.getTexture('combo_05')
			}else if(ComboFlag == '01'){
				ComboFlag = '05';
				combo.texture = this.assets.getTexture('combo_05')
			}else if(ComboFlag == '02'){
				ComboFlag = '10';
				combo.texture = this.assets.getTexture('combo_10')
			}else if(ComboFlag == '03'){
					ComboFlag = '15';
					combo.texture = this.assets.getTexture('combo_15')
			}else if(ComboFlag == '04'){
					ComboFlag = '20';
					combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '05'){
				//ComboFlag = '15';
			//	combo.texture = this.assets.getTexture('combo_15')
			}else if(ComboFlag == '06'){
				//	ComboFlag = '06';
				//	combo.texture = this.assets.getTexture('combo_06')
			}else if(ComboFlag == '07'){
				ComboFlag = '35';
				combo.texture = this.assets.getTexture('combo_35')
			}else if(ComboFlag == '10'){
				//ComboFlag = '20';
				//combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '15'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '20'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '21'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '35'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
			}
			SaveArray['ComboFlag'] = ComboFlag;	
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);	
			combo.alpha = 1;
		}
		
		private function Control07Handler():void{
			if(ComboFlag == null){
				ComboFlag = '07';
				combo.texture = this.assets.getTexture('combo_07')
			}else if(ComboFlag == '01'){
				ComboFlag = '07';
				combo.texture = this.assets.getTexture('combo_07')
			}else if(ComboFlag == '02'){
			//	ComboFlag = '10';
			//	combo.texture = this.assets.getTexture('combo_10')
			}else if(ComboFlag == '03'){
				ComboFlag = '21';
				combo.texture = this.assets.getTexture('combo_21')
			}else if(ComboFlag == '04'){
			//	ComboFlag = '20';
			//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '05'){
				ComboFlag = '35';
				combo.texture = this.assets.getTexture('combo_35')
			}else if(ComboFlag == '06'){
				//	ComboFlag = '06';
				//	combo.texture = this.assets.getTexture('combo_06')
			}else if(ComboFlag == '07'){
	//			ComboFlag = '35';
	//			combo.texture = this.assets.getTexture('combo_35')
			}else if(ComboFlag == '10'){
				//ComboFlag = '20';
				//combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '15'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '20'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '21'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}else if(ComboFlag == '35'){
				//	ComboFlag = '20';
				//	combo.texture = this.assets.getTexture('combo_20')
			}
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
			}
			SaveArray['ComboFlag'] = ComboFlag;	
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);	
			combo.alpha = 1;
		}
		
		
		private function SqHandler(sqNum:String,fromSave:Boolean = false):void{
			SQFlag = sqNum;
			
			
			if(sqNum == '01'){
				highlight.x = 369;
				highlight.y = 0;
			}else if(sqNum == '02'){
				highlight.x = 369-(35*1);
				highlight.y = 0+(60*1);
			}else if(sqNum == '03'){
				highlight.x = 369+(35*1);
				highlight.y = 0+(60*1);
			}else if(sqNum == '04'){
				highlight.x = 369-(35*2);
				highlight.y = 0+(60*2);
			}else if(sqNum == '05'){
				highlight.x = 369+(35*0);
				highlight.y = 0+(60*2);
			}else if(sqNum == '06'){
				highlight.x = 369+(35*2);
				highlight.y = 0+(60*2);
			}else if(sqNum == '07'){
				highlight.x = 369-(35*3);
				highlight.y = 0+(60*3);
			}else if(sqNum == '08'){
				highlight.x = 369-(35*1);
				highlight.y = 0+(60*3);
			}else if(sqNum == '09'){
				highlight.x = 369+(35*1);
				highlight.y = 0+(60*3);
			}else if(sqNum == '10'){
				highlight.x = 369+(35*3);
				highlight.y = 0+(60*3);
			}else if(sqNum == '11'){
				highlight.x = 369-(35*4);
				highlight.y = 0+(60*4);
			}else if(sqNum == '12'){
				highlight.x = 369-(35*2);
				highlight.y = 0+(60*4);
			}else if(sqNum == '13'){
				highlight.x = 369-(35*0);
				highlight.y = 0+(60*4);
			}else if(sqNum == '14'){
				highlight.x = 369+(35*2);
				highlight.y = 0+(60*4);
			}else if(sqNum == '15'){
				highlight.x = 369+(35*4);
				highlight.y = 0+(60*4);
			}else if(sqNum == '16'){
				highlight.x = 369-(35*5);
				highlight.y = 0+(60*5);
			}else if(sqNum == '17'){
				highlight.x = 369-(35*3);
				highlight.y = 0+(60*5);
			}else if(sqNum == '18'){
				highlight.x = 369-(35*1);
				highlight.y = 0+(60*5);
			}else if(sqNum == '19'){
				highlight.x = 369+(35*1);
				highlight.y = 0+(60*5);
			}else if(sqNum == '20'){
				highlight.x = 369+(35*3);
				highlight.y = 0+(60*5);
			}else if(sqNum == '21'){
				highlight.x = 369+(35*5);
				highlight.y = 0+(60*5);
			}else if(sqNum == '22'){
				highlight.x = 369-(35*6);
				highlight.y = 0+(60*6);
			}else if(sqNum == '23'){
				highlight.x = 369-(35*4);
				highlight.y = 0+(60*6);
			}else if(sqNum == '24'){
				highlight.x = 369-(35*2);
				highlight.y = 0+(60*6);
			}else if(sqNum == '25'){
				highlight.x = 369-(35*0);
				highlight.y = 0+(60*6);
			}else if(sqNum == '26'){
				highlight.x = 369+(35*2);
				highlight.y = 0+(60*6);
			}else if(sqNum == '27'){
				highlight.x = 369+(35*4);
				highlight.y = 0+(60*6);
			}else if(sqNum == '28'){
				highlight.x = 369+(35*6);
				highlight.y = 0+(60*6);
			}else if(sqNum == '29'){
				highlight.x = 369-(35*5);
				highlight.y = 0+(60*7);
			}else if(sqNum == '30'){
				highlight.x = 369-(35*3);
				highlight.y = 0+(60*7);
			}else if(sqNum == '31'){
				highlight.x = 369-(35*1);
				highlight.y = 0+(60*7);
			}else if(sqNum == '32'){
				highlight.x = 369+(35*1);
				highlight.y = 0+(60*7);
			}else if(sqNum == '33'){
				highlight.x = 369+(35*3);
				highlight.y = 0+(60*7);
			}else if(sqNum == '34'){
				highlight.x = 369+(35*5);
				highlight.y = 0+(60*7);
			}
			if(fromSave === false){
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
				}
				SaveArray['SQFlag'] = SQFlag;	
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);	
			}
			highlight.alpha = 1;
		}
		
		private function CreateHitChamber():void{
			hit_Chamber = new Shape();
			hit_Chamber.touchable = false;
			hit_Chamber.graphics.beginFill(0xff0000);
			
			hit_Chamber.graphics.lineTo(140,393);									
			hit_Chamber.graphics.lineTo(366,0);									
			hit_Chamber.graphics.lineTo(439,0);									
			hit_Chamber.graphics.lineTo(661,380);									
			hit_Chamber.graphics.lineTo(590,472);									
			hit_Chamber.graphics.lineTo(217,478);									
			
			hit_Chamber.alpha = 0.0;
			
			hit_Chamber.graphics.precisionHitTest = true;	
			this.addChild(hit_Chamber);
		}
		
		private function Solve():void{
			if(SQArray['01'] == '01'){
				if(SQArray['02'] == '01'){
					if(SQArray['03'] == '01'){
						if(SQArray['04'] == '01'){
							if(SQArray['05'] == '02'){
								if(SQArray['06'] == '01'){
									if(SQArray['07'] == '01'){
										if(SQArray['08'] == '03'){
											if(SQArray['09'] == '03'){
												if(SQArray['10'] == '01'){
													if(SQArray['11'] == '01'){
														if(SQArray['12'] == '04'){
															if(SQArray['13'] == '06'){
																if(SQArray['14'] == '04'){
																	if(SQArray['15'] == '01'){
																		if(SQArray['16'] == '01'){
																			if(SQArray['17'] == '05'){
																				if(SQArray['18'] == '10'){
																					if(SQArray['19'] == '10'){
																						if(SQArray['20'] == '05'){
																							if(SQArray['21'] == '01'){
																								if(SQArray['22'] == '01'){
																									if(SQArray['23'] == '06'){
																										if(SQArray['24'] == '15'){
																											if(SQArray['25'] == '20'){
																												if(SQArray['26'] == '15'){
																													if(SQArray['27'] == '06'){
																														if(SQArray['28'] == '01'){
																															if(SQArray['29'] == '07'){
																																if(SQArray['30'] == '21'){
																																	if(SQArray['31'] == '35'){
																																		if(SQArray['32'] == '35'){
																																			if(SQArray['33'] == '21'){
																																				if(SQArray['34'] == '07'){
																																					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_SuccessLow();
																																					(stage.getChildAt(0) as Object).AmbientObj.LoadSpaceHum(true,0);
																																					trace("SOLVED")
																																					Animating = true;
																																					Solved = true;
																																					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal != undefined){
																																						SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.TemplePascal;
																																					}
																																					SaveArray['Solved'] = 'Yes';
																																					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('TemplePascal',SaveArray);
																																					
																																					
																																					
																																					delayedcall = new DelayedCall(RunSolve,2);
																																					Starling.juggler.add(delayedcall);
																																				}else{trace("FAIL ON 34");}
																																			}else{trace("FAIL ON 33");}
																																		}else{trace("FAIL ON 32");}
																																	}else{trace("FAIL ON 31");}
																																}else{trace("FAIL ON 30");}
																															}else{trace("FAIL ON 29");}
																														}else{trace("FAIL ON 28");}
																													}else{trace("FAIL ON 27");}
																												}else{trace("FAIL ON 26");}
																											}else{trace("FAIL ON 25");}
																										}else{trace("FAIL ON 24");  trace(SQArray['24']);}
																									}else{trace("FAIL ON 23");}
																								}else{trace("FAIL ON 22");}
																							}else{trace("FAIL ON 21");}
																						}else{trace("FAIL ON 20");}
																					}else{trace("FAIL ON 19");}
																				}else{trace("FAIL ON 18");}
																			}else{trace("FAIL ON 17");}
																		}else{trace("FAIL ON 16");}
																	}else{trace("FAIL ON 15");}
																}else{trace("FAIL ON 14");}
															}else{trace("FAIL ON 13");}
														}else{trace("FAIL ON 12");}
													}else{trace("FAIL ON 11");}
												}else{trace("FAIL ON 10");}
											}else{trace("FAIL ON 09");}
										}else{trace("FAIL ON 08");}
									}else{trace("FAIL ON 07");}
								}else{trace("FAIL ON 06");}
							}else{trace("FAIL ON 05");}
						}else{trace("FAIL ON 04");}
					}else{trace("FAIL ON 03");}
				}else{trace("FAIL ON 02");}
			}else{trace("FAIL ON 01");}
		}
		
		private function RunSolve(FromSave:Boolean = false):void{
			if(FromSave === false){
				trace("UI ANIMA");
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_EnergyPulse();

				UISpriteTween = new Tween(UISprite, 2.5, Transitions.LINEAR);
				UISpriteTween.fadeTo(0);
				UISpriteTween.onComplete = function():void{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Ohm();
					AnimateFadeSquareBg();
					
					UISpriteTween = null
				}
				Starling.juggler.add(UISpriteTween);
			}else if(FromSave === true){
				ClearHits(true);
				UISprite.alpha = 0;
				BGsHolderSprite.alpha = 0;
			}
		}
		
		private function AnimateFadeSquareBg():void{
			trace("SQUARE ANIMA");
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
			trianglebg.alpha = 1;
			//fade_01.alpha = 1;
			fade_02.alpha = 1;
			fade_03.alpha = 1;
			TweenSquareBg = new Tween(squarebg, 2.5, Transitions.LINEAR);
			TweenSquareBg.fadeTo(0);
			TweenSquareBg.onComplete = function():void{
				AnimateFadeTriangleBg();
				
			}
			Starling.juggler.add(TweenSquareBg);
		}
		private function AnimateFadeTriangleBg():void{
			trace("TRI ANIMA");
			TweenTriangleBg = new Tween(trianglebg, 2.5, Transitions.LINEAR);
			TweenTriangleBg.fadeTo(0);
			TweenTriangleBg.onComplete = function():void{
				AnimateFade02();
				//Animating = false;
			
			}
			Starling.juggler.add(TweenTriangleBg);
		}
	/*	
		private function AnimateFade01():void{
			TweenFade01 = new Tween(fade_01, 1.5, Transitions.LINEAR);
			TweenFade01.fadeTo(0);
			TweenFade01.onComplete = function():void{
				AnimateFade02();
				//Animating = false;
				TweenFade01 = null
			}
			Starling.juggler.add(TweenFade01);
		}
	*/
		private function AnimateFade02():void{
			trace("02 ANIMA");
			(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_OhmTwo();
			
			TweenFade02 = new Tween(fade_02, 2.0, Transitions.LINEAR);
			TweenFade02.fadeTo(0);
			TweenFade02.onComplete = function():void{
				AnimateFade03();
				//Animating = false;
				
			}
			Starling.juggler.add(TweenFade02);
			
		}
		private function AnimateFade03():void{
			(stage.getChildAt(0) as Object).AmbientObj.LoadDarkness(true,0);
			trace("03 ANIMA")
			TweenFade03 = new Tween(fade_03, 2.0, Transitions.LINEAR);
			TweenFade03.fadeTo(0);
			TweenFade03.onComplete = function():void{
				//AnimateFade01();
				//Animating = false;
				ClearHits();
				TweenSquareBg = null;
				TweenTriangleBg = null;
				TweenFade02 = null;
				TweenFade03 = null;
			}
			Starling.juggler.add(TweenFade03);
		}
		
		private function ClearHits(fromSave:Boolean = false):void{
		
			this.removeChild(hit_sq01);
			this.removeChild(hit_sq02);
			this.removeChild(hit_sq03);
			this.removeChild(hit_sq04);
			this.removeChild(hit_sq05);
			this.removeChild(hit_sq06);
			this.removeChild(hit_sq07);
			this.removeChild(hit_sq08);
			this.removeChild(hit_sq09);
			this.removeChild(hit_sq10);
			this.removeChild(hit_sq11);
			this.removeChild(hit_sq12);
			this.removeChild(hit_sq13);
			this.removeChild(hit_sq14);
			this.removeChild(hit_sq15);
			this.removeChild(hit_sq16);
			this.removeChild(hit_sq17);
			this.removeChild(hit_sq18);
			this.removeChild(hit_sq19);
			this.removeChild(hit_sq20);
			this.removeChild(hit_sq21);
			this.removeChild(hit_sq22);
			this.removeChild(hit_sq23);
			this.removeChild(hit_sq24);
			this.removeChild(hit_sq25);
			this.removeChild(hit_sq26);
			this.removeChild(hit_sq27);
			this.removeChild(hit_sq28);
			this.removeChild(hit_sq29);
			this.removeChild(hit_sq30);
			this.removeChild(hit_sq31);
			this.removeChild(hit_sq32);
			this.removeChild(hit_sq33);
			this.removeChild(hit_sq34);
			
			CreateHitChamber();
			Animating = false;
			
			if(fromSave === false){
				if((stage.getChildAt(0) as Object).MusicObj.currentSong == null){
					
					(stage.getChildAt(0) as Object).MusicObj.LoadSubBop(true,1);
					
				}
			}
		}
		/*
		private var squarebg:Image;
		private var trianglebg:Image;
		private var fade_01:Image;
		private var fade_02:Image;
		private var fade_03:Image;
		
		private var TweenSquareBg:Tween;
		private var TweenTriangleBg:Tween;
		private var TweenFade01:Tween;
		private var TweenFade02:Tween;
		private var TweenFade03:Tween;
		*/
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
			
			
			this.assets.removeTexture("templePascal_01",true);
			//this.assets.removeTexture("TemplePascal_Sprite_01",true);
			//this.assets.removeTextureAtlas("TemplePascal_Sprite_01",true);
			this.assets.removeTexture("TemplePascal_Sprite_02",true);
			this.assets.removeTextureAtlas("TemplePascal_Sprite_02",true);
			(stage.getChildAt(0) as Object).falseAsset("templePascal_01");
		//	(stage.getChildAt(0) as Object).falseAsset("templePascal_02");
		//	(stage.getChildAt(0) as Object).falseAsset("templePascal_03");
			(stage.getChildAt(0) as Object).falseAsset("templePascal_04");
			(stage.getChildAt(0) as Object).falseAsset("templePascal_05");
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
