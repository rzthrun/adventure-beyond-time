package screens
{
	import starling.display.Image;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	
	public class MenuResetDialogue extends Sprite
	{
		public var transbg:Shape;
		public var bg:Image;
		public var dialog:Image;
		
		public var hit_yes:Shape;
		public var hit_no:Shape;
		
		public var confirm:Image;
		
		private var assets:AssetManager;
		public function MenuResetDialogue(textureRef:AssetManager)
		{
			super();
			assets = textureRef;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(e:Event):void{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			bg = new Image(assets.getTexture("Reset_bg"));
			bg.y = 35;
			dialog = new Image(assets.getTexture("Reset_Dialog"));
			dialog.x = 140;
			dialog.y = 122+35;
			trace("HERERE HERE HERE HERE");
			CreateTransBg();
			this.addChild(bg);
			this.addChild(dialog);
			CreateHits();
			
			confirm = new Image(assets.getTexture("Reset_Confim"));
			confirm.x = 225;
			confirm.y = 165;
			confirm.alpha = 0;
			this.addChild(confirm);
		}
		
		public function ResetGame():void{
			(stage.getChildAt(0) as Object).SavedGame.ClearSavedGame();
			confirm.alpha = 1;
			dialog.alpha = 0;
		}
		
		
		public function CreateHits():void{
			hit_yes = new Shape();
			this.addChild(hit_yes);
			hit_yes.graphics.beginFill(0x00FF00);
	//		hit_yes.graphics.lineTo(226,340);	
			hit_yes.graphics.lineTo(119,213);	
			hit_yes.graphics.lineTo(388,214);	
			hit_yes.graphics.lineTo(380,282);	
			hit_yes.graphics.lineTo(114,284);	
			
			hit_yes.touchable = false;
			hit_yes.graphics.endFill(false);
			hit_yes.alpha = 0.0;
			hit_yes.graphics.precisionHitTest = true;	
			
			hit_no = new Shape();
			this.addChild(hit_no);
			hit_no.graphics.beginFill(0x00FF00);
			//		hit_yes.graphics.lineTo(226,340);	
		//	hit_no.graphics.lineTo(258,343);	
			hit_no.graphics.lineTo(400,177+35);	
			hit_no.graphics.lineTo(692,183+35);	
			hit_no.graphics.lineTo(688,258+35);	
			hit_no.graphics.lineTo(394,253+35);	

			hit_no.touchable = false;
			hit_no.graphics.endFill(false);
			hit_no.alpha = 0.0;
			hit_no.graphics.precisionHitTest = true;	
		}
		
		
		
		private function CreateTransBg():void{
			transbg = new Shape();
			this.addChild(transbg);
			transbg.graphics.beginFill(0x000000);
			transbg.graphics.lineTo(0,0);	
			transbg.graphics.lineTo(800,0);	
			transbg.graphics.lineTo(800,512);	
			transbg.graphics.lineTo(0,512);	
		
			
			transbg.touchable = true;
			transbg.graphics.endFill(false);
			transbg.alpha = 0.5;
			//transbg.graphics.precisionHitTest = true;	
		}
	}
}