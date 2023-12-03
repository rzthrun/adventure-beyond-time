package
{
	import flash.net.SharedObject;
	public class Save
	{
		public var SavedGameObj:SharedObject = SharedObject.getLocal("BeyondTime_Save");
		public var SavedSoundObj:SharedObject = SharedObject.getLocal("BeyondTime_Sounds_Save");
		public var SavedHintObj:SharedObject = SharedObject.getLocal("BeyondTime_Hint_Save");
		//public var SavedHintObj:SharedObject = SharedObject.getLocal("FloatingCity_Hint_Save");
		//public var SavedHintObj:SharedObject = SharedObject.getLocal("SavedHints");
		

		public function getRoomData(RoomName):Array{
			return SavedGameObj[RoomName];
		}
		
		public function Save()
		{
			//SavedGameObj.clear();
			if(SavedGameObj.data.DeclareSave === true){
			}
			else{
				SavedGameObj.clear();
				SavedGameObj.data.DeclareSave = false;
				SavedGameObj.flush();				
			}			
		}
		public function ClearSavedGame():void{
			SavedGameObj.clear();
		}
				
		public function DeclareSavedGame():void{
			trace("SAVE DECLARED");
			SavedGameObj.data.DeclareSave = true;
			SavedGameObj.flush();
		}	
		public function SaveCurrentRoom(classval:String,val:String):void{
			
			SavedGameObj.data.CurrentRoomClass = classval;
			SavedGameObj.data.CurrentRoomName = val;
			SavedGameObj.flush();
		}
		public function SaveRoomData(roomName,saveArray):void{
			trace("SavingRoomData");
			SavedGameObj.data[roomName] = saveArray;
			SavedGameObj.flush();
		}		
		public function SaveInventoryData(SaveArray):void{
			SavedGameObj.data.Inventory = SaveArray;
			SavedGameObj.flush();
			trace(SaveArray+ " saved as inventory");
		}	
		
		public function SaveMusicVol(val):void{

			SavedSoundObj.data.MusicVol = val;
			SavedSoundObj.flush();
			trace(val +" saved as Music Vol");
		}		
		
		public function SaveSoundFXVol(val):void{

			SavedSoundObj.data.SoundFXVol = val;
			SavedSoundObj.flush();
			trace(val +" saved as SFX Vol");
		}	
		
		public function SaveAmbientVol(val):void{
			
			SavedSoundObj.data.AmbientVol = val;
			SavedSoundObj.flush();
			trace(val +" saved as Ambient Vol");
		}	
		
		public function SaveHintsToggle(val:Boolean):void{
			
			SavedHintObj.data.Enabled = val;
			SavedHintObj.flush();
			trace(val +" saved as Hint Toggle");
		}		
		
		
	}
}