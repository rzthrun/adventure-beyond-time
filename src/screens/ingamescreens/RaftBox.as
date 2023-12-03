package screens.ingamescreens
{
	import flash.filesystem.File;
	
	import screens.hud.GoBackButton;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.textures.TextureSmoothing;
	
	
	public class RaftBox extends Sprite
	{
		private var assets:AssetManager;
		private var game:Game;
		public var SaveArray:Array = new Array();
		
		private var bg:Image;
		private var lid:Image;
		private var handle:Image;
		
		private var hit_lid:Shape;
		private var hit_handle:Shape;
		
		private var lidOpen:Boolean = false;
		
		private var touches:Vector.<Touch>;
		private var targ:Object;
		
		private var goback:GoBackButton;
		
		public function RaftBox(_assets:AssetManager,_game:Game)
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
			if(game.CheckAsset('raftBox_01') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RaftBox/raftBox_bg.jpg'));
				game.TrackAssets('raftBox_01');
			}
			if(game.CheckAsset('raftBox_02') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RaftBox/RaftBox_Sprite.atf'));
				game.TrackAssets('raftBox_02');
			}
			if(game.CheckAsset('raftBox_03') === false){
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/graphics/InGame/RaftBox/RaftBox_Sprite.xml'));
				game.TrackAssets('raftBox_03');
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
					(stage.getChildAt(0) as Object).SavedGame.SaveCurrentRoom("RaftBox","RaftBoxObj");
				} 				
			});	
			//	goback = new GoBackButton();
			//	goback.alpha = 0;
		}
		
		private function onLoadAssets():void{
			bg = new Image(this.assets.getTexture('raftBox_bg'));
			bg.touchable = true;
			this.addChild(bg);
			
			lid = new Image(this.assets.getTexture('the_lid_open'));
			lid.smoothing = TextureSmoothing.NONE;;
			lid.touchable = false;
			lid.x = 61;
			lid.y = 0;
			
			
			
			handle = new Image(this.assets.getTexture('handle'));
			handle.smoothing = TextureSmoothing.NONE;;
			handle.touchable = false;
			handle.x = 283;
			handle.y = 165;
			
			
			
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox['Lid'] == 'open'){
					lidOpen = true;
					lid.alpha = 1;
					
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox['Handle'] == 'PickedUp'){
						handle.alpha = 0;
					}else{
						handle.alpha = 1;
					}
					CreateBoxHit(true);
					CreateHandleHitHit();
				}else{
					lid.alpha = 0;
					handle.alpha = 0;
					CreateBoxHit(false);
				}
			}else{
				CreateBoxHit(false);
				handle.alpha = 0;
				lid.alpha = 0;
			}
			this.addChildAt(lid,1);
			this.addChildAt(handle,2);

			//CreateBoxHit(false);
		//	CreateHandleHitHit();
			goback = new GoBackButton(this.assets);
			this.addChild(goback);
			
			
			this.addEventListener(TouchEvent.TOUCH,TouchHandler);
		}
		private function CreateHandleHitHit():void{
			hit_handle = new Shape();
			hit_handle.touchable = false;
			hit_handle.graphics.beginFill(0x0000ff);
			
			hit_handle.graphics.lineTo(280,302);	
			hit_handle.graphics.lineTo(346,240);	
			hit_handle.graphics.lineTo(420,238);	
			hit_handle.graphics.lineTo(538,162);	
			hit_handle.graphics.lineTo(572,183);	
			hit_handle.graphics.lineTo(431,391);	
			hit_handle.graphics.lineTo(385,393);	
			
			hit_handle.graphics.endFill(false);
			hit_handle.alpha = 0.0;
			
			hit_handle.graphics.precisionHitTest = true;	
			this.addChild(hit_handle);
		}
		private function CreateBoxHit(open:Boolean = false):void{
			hit_lid = new Shape();
			this.addChild(hit_lid);
			if(open === false){
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);
				hit_lid.graphics.lineTo(190,59);	
				hit_lid.graphics.lineTo(341,60);	
				hit_lid.graphics.lineTo(364,44);	
				hit_lid.graphics.lineTo(490,41);	
				hit_lid.graphics.lineTo(501,54);	
				hit_lid.graphics.lineTo(672,57);	
				hit_lid.graphics.lineTo(677,397);	
				hit_lid.graphics.lineTo(154,376);	
				
				hit_lid.graphics.endFill(false);
				
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;	
			}else{
				
				hit_lid.x = 0;
				hit_lid.y = 0;
				hit_lid.graphics.beginFill(0x0000FF);		
				hit_lid.graphics.lineTo(63,506);
				hit_lid.graphics.lineTo(158,365);
				hit_lid.graphics.lineTo(678,385);
				hit_lid.graphics.lineTo(682,507);
	
				hit_lid.graphics.endFill(false);
				hit_lid.alpha = 0.0;
				
				hit_lid.graphics.precisionHitTest = true;				
			}
			hit_lid.touchable = false;
			
		}		
		
		private function TouchHandler(e:TouchEvent):void{
			targ = e.target;
			touches = e.getTouches(this);
			if (touches.length > 0){
				if (touches[0].phase == TouchPhase.ENDED) {
					trace(touches[0].globalX+" ,"+touches[0].globalY);
					if(targ == goback.SourceImage){
						(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_Powm();
						FadeOut((Raft as Class), 
							(stage.getChildAt(0) as Object).screenGamePlayHandler.RaftObj,true
						);
					}
					else if(hit_lid.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
						LidHandler();
					}
					else if(lidOpen === true){
						if(hit_handle.graphics.shapeHitTest(touches[0].globalX,touches[0].globalY) === true){
							HandleHandler();
						}
					}
					
				}
			}
		}
		
		private function HandleHandler():void{
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox != undefined){
				
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox["Handle"] == "PickedUp"){
					
				}else{
					handle.alpha = 0;
					SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox;
					SaveArray["Handle"] = "PickedUp";
					(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RaftBox',SaveArray);
					
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
						(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Handle,
						'item_Handle',
						'inven_handle_sm'
					);
					
					
				}
			}else{
				handle.alpha = 0;
				SaveArray["Handle"] = "PickedUp";
				(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RaftBox',SaveArray);
				
				(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.AddItemToInventory(
					(stage.getChildAt(0) as Object).screenGamePlayHandler.InventoryObj.item_Handle,
					'item_Handle',
					'inven_handle_sm'
				);
			}
		}
		
		private function LidHandler():void{
			
			if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox != undefined){
				SaveArray = (stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox;
				if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox['Lid'] == 'open'){
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BoxClose();
					lidOpen = false;
					SaveArray['Lid'] = 'closed';
					lid.alpha = 0;
					removeChild(hit_handle);
					hit_lid.graphics.clear();
					
					CreateBoxHit(false);
					//doorOneOpen = false;
					handle.alpha = 0;
				}else{
					(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BoxOpen();
					lidOpen = true;
					SaveArray['Lid'] = 'open';
					lid.alpha = 1;
					hit_lid.graphics.clear();
					CreateBoxHit(true);
					if((stage.getChildAt(0) as Object).SavedGame.SavedGameObj.data.RaftBox['Handle'] == 'PickedUp'){
						handle.alpha = 0;
					}else{
						handle.alpha = 1;
					}
					CreateHandleHitHit()
				}
			}else{
				(stage.getChildAt(0) as Object).SoundFXObj.PlaySFX_BoxOpen();
				lidOpen = true;
				SaveArray['Lid'] = 'open';
				lid.alpha = 1;
				hit_lid.graphics.clear();
				CreateBoxHit(true);

				handle.alpha = 1;
				
				CreateHandleHitHit()
			}
			(stage.getChildAt(0) as Object).SavedGame.SaveRoomData('RaftBox',SaveArray);	
			
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
			
			
			this.assets.removeTexture("raftBox_bg",true);
			this.assets.removeTexture("RaftBox_Sprite",true);
			this.assets.removeTextureAtlas("RaftBox_Sprite",true);
			(stage.getChildAt(0) as Object).falseAsset("raftBox_01");
			(stage.getChildAt(0) as Object).falseAsset("raftBox_02");
			(stage.getChildAt(0) as Object).falseAsset("raftBox_03");
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