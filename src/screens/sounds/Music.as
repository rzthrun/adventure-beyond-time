package screens.sounds
{
	import flash.filesystem.File;
	import flash.media.Sound;
	
	import starling.utils.AssetManager;

	public class Music
	{
		public var assets:AssetManager;
		public var soundManager:SoundManager;
		
		public var MUS_MainTheme:Sound;
		
		public var MUS_DeepDrums:Sound;
		
		public var MUS_SciFiWhistle:Sound;

		
		public var MUS_MountainViolin:Sound;
		public var MUS_BeachStrings:Sound;
		public var MUS_PianoOne:Sound;
		public var MUS_MoonBeams:Sound;
		public var MUS_BeatUpOne:Sound;
		public var MUS_BeatDownOne:Sound;
		public var MUS_BeatNowOne:Sound;
		public var MUS_Doom:Sound;
		public var MUS_MountainFluteOne:Sound;
		public var MUS_SunShine:Sound;
		public var MUS_PainPitch:Sound;
		public var MUS_SubBop:Sound;
		public var MUS_TenseOut:Sound;
		public var MUS_MonsterBeat:Sound;
		public var MUS_XFiles:Sound;
		public var MUS_SpeedDial:Sound;
		public var MUS_JamLoop:Sound;
		public var MUS_DeepSpace:Sound;
		public var MUS_LightBeam:Sound;
		
		public var MUS_empty:Sound;
		
		/*
		
		public var MUS_Crickets_01:Sound
		public var MUS_Waves_01:Sound
		public var MUS_Waves_02:Sound
		public var MUS_Jungle_01:Sound
		public var MUS_BurningFireOne:Sound;
		public var MUS_BirdsOne:Sound;
		public var MUS_ShipGroansOne:Sound;
		public var MUS_CaveDrips:Sound;
		public var MUS_CaveDripsStream:Sound;
		public var MUS_ShipCreaks:Sound;
		public var MUS_Waterfall:Sound;
		public var MUS_TVStatic:Sound;
		public var MUS_WindOne:Sound;
		public var MUS_ElectricHum:Sound;
		*/
	//	public var channel:SoundChannel;
	//	public var volumeAdjust:SoundTransform = new SoundTransform();
		
		public var globalVol:Number = 0.5;
		
		public var currentSong:String = null;
		public var currentAmbient:String = null;
		
		public var pauseArr:Array = new Array();
		
		private var paused:Boolean = false;
		
		public function Music()
		{
			this.assets = new AssetManager();
			soundManager = new SoundManager();
		}
		
		public function Null_CurrentSong():void{
			currentSong = null;
		}
		public function Null_CurrentAmbient():void{
			currentAmbient = null;
		}
		
		/*
		public var MUS_SciFiWhistle:Sound;
		public var MUS_MidnightChorus:Sound;
		
		*/
		//MUS_LightBeam
		
		//
		public function LoadEmpty(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//	if(soundManager.soundIsPlaying("LightBeam")){
			
			//	}
			//	else{
			this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/empty.mp3'));			
			this.assets.loadQueue(function(n:Number):void{
				if(n==1){
					ReadyEmpty(p,r,t);
				}
			});
			//	}
		}
		private function ReadyEmpty(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_empty = assets.getSound("empty");
			soundManager.addSound("empty", MUS_empty);
			if(p === true){
				Play_Empty(r,t);
			}
		}
		
		public function Play_Empty(repeatCount:Number = 0,t:Number = 0):void{
		//	trace("Music globalVol :"+globalVol);
		//	currentSong = "LightBeam";
			if(soundManager.soundIsPlaying("empty") === false){
				soundManager.playMusic("empty",0,repeatCount,0,0,Null_CurrentSong);
			}
			//soundManager.setVolume("MainThemeReduced", 0);
		//	soundManager.tweenVolume("empty",globalVol,t);
		}
		
		
		
		public function LoadLightBeam(p:Boolean = false,r:Number = 0,t:Number = 0):void{
		//	if(soundManager.soundIsPlaying("LightBeam")){
				
		//	}
		//	else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/LightBeam.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyLightBeam(p,r,t);
					}
				});
		//	}
		}
		private function ReadyLightBeam(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_LightBeam = assets.getSound("LightBeam");
			soundManager.addSound("LightBeam", MUS_LightBeam);
			if(p === true){
				Play_LightBeam(r,t);
			}
		}
		
		public function Play_LightBeam(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "LightBeam";
			soundManager.playMusic("LightBeam",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("LightBeam",globalVol,t);
		}
		
		
		//
		
		//
		public function LoadDeepSpace(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("DeepSpace")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/DeepSpace.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyDeepSpace(p,r,t);
					}
				});
			}
		}
		private function ReadyDeepSpace(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_DeepSpace = assets.getSound("DeepSpace");
			soundManager.addSound("DeepSpace", MUS_DeepSpace);
			if(p === true){
				Play_DeepSpace(r,t);
			}
		}
		
		public function Play_DeepSpace(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "DeepSpace";
			soundManager.playMusic("DeepSpace",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("DeepSpace",globalVol,t);
		}
		
		
		//
		//
		public function LoadJamLoop(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("JamLoop")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/JamLoop.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyJamLoop(p,r,t);
					}
				});
			}
		}
		private function ReadyJamLoop(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_JamLoop = assets.getSound("JamLoop");
			soundManager.addSound("JamLoop", MUS_JamLoop);
			if(p === true){
				Play_JamLoop(r,t);
			}
		}
		
		public function Play_JamLoop(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "JamLoop";
			soundManager.playMusic("JamLoop",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("JamLoop",globalVol,t);
		}
		
		
		//
		
		//
		public function LoadSpeedDial(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("SpeedDial")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/SpeedDial.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadySpeedDial(p,r,t);
					}
				});
			}
		}
		private function ReadySpeedDial(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_SpeedDial = assets.getSound("SpeedDial");
			soundManager.addSound("SpeedDial", MUS_SpeedDial);
			if(p === true){
				Play_SpeedDial(r,t);
			}
		}
		
		public function Play_SpeedDial(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "SpeedDial";
			soundManager.playMusic("SpeedDial",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("SpeedDial",globalVol,t);
		}
		
		
		//
		//
		public function LoadXFiles(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("XFiles")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/XFiles.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyXFiles(p,r,t);
					}
				});
			}
		}
		private function ReadyXFiles(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_XFiles = assets.getSound("XFiles");
			soundManager.addSound("XFiles", MUS_XFiles);
			if(p === true){
				Play_XFiles(r,t);
			}
		}
		
		public function Play_XFiles(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "XFiles";
			soundManager.playMusic("XFiles",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("XFiles",globalVol,t);
		}
		
		
		//
		//
		public function LoadMonsterBeat(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("MonsterBeat")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/MonsterBeat.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyMonsterBeat(p,r,t);
					}
				});
			}
		}
		private function ReadyMonsterBeat(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_MonsterBeat = assets.getSound("MonsterBeat");
			soundManager.addSound("MonsterBeat", MUS_MonsterBeat);
			if(p === true){
				Play_MonsterBeat(r,t);
			}
		}
		
		public function Play_MonsterBeat(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "MonsterBeat";
			soundManager.playMusic("MonsterBeat",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("MonsterBeat",globalVol,t);
		}
		
		
		//

		
		//
		public function LoadSubBop(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("SubBop")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/SubBop.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadySubBop(p,r,t);
					}
				});
			}
		}
		private function ReadySubBop(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_SubBop = assets.getSound("SubBop");
			soundManager.addSound("SubBop", MUS_SubBop);
			if(p === true){
				Play_SubBop(r,t);
			}
		}
		
		public function Play_SubBop(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "SubBop";
			soundManager.playMusic("SubBop",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("SubBop",globalVol,t);
		}
		
		
		//
		
		//
		public function LoadMountainFluteOne(p:Boolean = false,r:Number = 0,t:Number = 0,onComplete:String = null):void{
			if(soundManager.soundIsPlaying("MountainFluteOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/MountainFluteOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyMountainFluteOne(p,r,t,onComplete);
					}
				});
			}
		}
		private function ReadyMountainFluteOne(p:Boolean = false,r:Number = 0,t:Number = 0,onComplete:String = null):void{
			//soundManager = SoundManager.getInstance();
			MUS_MountainFluteOne = assets.getSound("MountainFluteOne");
			soundManager.addSound("MountainFluteOne", MUS_MountainFluteOne);
			if(p === true){
				Play_MountainFluteOne(r,t,onComplete);
			}
		}
		
		public function Play_MountainFluteOne(repeatCount:Number = 0,t:Number = 0,onComplete:String = null):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "MountainFluteOne";
			soundManager.playMusic("MountainFluteOne",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolumeComplex("MountainFluteOne",globalVol,t,onComplete);
		}
		
		
		//
		/*
		//----------------------------------------------------------------		
		public function LoadMountainViolin(p:Boolean = false,r:Number = 0,t:Number = 0,onComplete:Function = null):void{
		if(soundManager.soundIsPlaying("MountainViolin")){
		
		}
		else{
		this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/MountainViolin_001a005.mp3'));			
		this.assets.loadQueue(function(n:Number):void{
		if(n==1){
		ReadyMountainViolin(p,r,t,onComplete);
		}
		});
		}
		}
		private function ReadyMountainViolin(p:Boolean = false,r:Number = 0,t:Number = 0,onComplete:Function = null):void{
		//soundManager = SoundManager.getInstance();
		MUS_MountainViolin = assets.getSound("MountainViolin_001a005");
		soundManager.addSound("MountainViolin", MUS_MountainViolin);
		if(p === true){
		Play_MountainViolin(r,t,onComplete);
		}
		}
		
		public function Play_MountainViolin(repeatCount:Number = 0,t:Number = 0,onComplete:Function = null):void{
		trace("Music globalVol :"+globalVol);
		currentSong = "MountainViolin";
		soundManager.playMusic("MountainViolin",0,repeatCount,0,0,Null_CurrentSong);
		//soundManager.setVolume("MainThemeReduced", 0);
		soundManager.tweenVolumeComplexFunc("MountainViolin",globalVol,t,onComplete);
		}
		
		//-----------------
		*/
		public function LoadBeatNowOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("BeatDownOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/BeatNowOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyBeatNowOne(p,r,t);
					}
				});
			}
		}
		private function ReadyBeatNowOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_BeatNowOne = assets.getSound("BeatNowOne");
			soundManager.addSound("BeatNowOne", MUS_BeatNowOne);
			if(p === true){
				Play_BeatNowOne(r,t);
			}
		}
		
		public function Play_BeatNowOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "BeatNowOne";
			soundManager.playMusic("BeatNowOne",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("BeatNowOne",globalVol,t);
		}
		
		//
		public function LoadBeatDownOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("BeatDownOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/BeatDownOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyBeatDownOne(p,r,t);
					}
				});
			}
		}
		private function ReadyBeatDownOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_BeatDownOne = assets.getSound("BeatDownOne");
			soundManager.addSound("BeatDownOne", MUS_BeatDownOne);
			if(p === true){
				Play_BeatDownOne(r,t);
			}
		}
		
		public function Play_BeatDownOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "BeatDownOne";
			soundManager.playMusic("BeatDownOne",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("BeatDownOne",globalVol,t);
		}
		
		//
		
		public function LoadBeatUpOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("BeatUpOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/BeatUpOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyBeatUpOne(p,r,t);
					}
				});
			}
		}
		private function ReadyBeatUpOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_BeatUpOne = assets.getSound("BeatUpOne");
			soundManager.addSound("BeatUpOne", MUS_BeatUpOne);
			if(p === true){
				Play_BeatUpOne(r,t);
			}
		}
		
		public function Play_BeatUpOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "BeatUpOne";
			soundManager.playMusic("BeatUpOne",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("BeatUpOne",globalVol,t);
		}
		
		
		//-----------------
		//MUS_Doom
		
		//
		public function LoadDoom(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("Doom")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/Doom.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyDoom(p,r,t);
					}
				});
			}
		}
		private function ReadyDoom(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_Doom = assets.getSound("Doom");
			soundManager.addSound("Doom", MUS_Doom);
			if(p === true){
				Play_Doom(r,t);
			}
		}
		
		public function Play_Doom(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "Doom";
			soundManager.playMusic("Doom",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("Doom",globalVol,t);
		}
		
		
		//-----------------
		//MUS_PainPitch
		
		//
		public function LoadPainPitch(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("PainPitch")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/PainPitch.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyPainPitch(p,r,t);
					}
				});
			}
		}
		private function ReadyPainPitch(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_PainPitch = assets.getSound("PainPitch");
			soundManager.addSound("PainPitch", MUS_PainPitch);
			if(p === true){
				Play_PainPitch(r,t);
			}
		}
		
		public function Play_PainPitch(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "PainPitch";
			soundManager.playMusic("PainPitch",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("PainPitch",globalVol,t);
		}
		
		//-----------------
		//MUS_TenseOut
		//
		public function LoadTenseOut(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("TenseOut")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/TenseOut.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyTenseOut(p,r,t);
					}
				});
			}
		}
		private function ReadyTenseOut(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_TenseOut = assets.getSound("TenseOut");
			soundManager.addSound("TenseOut", MUS_TenseOut);
			if(p === true){
				Play_TenseOut(r,t);
			}
		}
		
		public function Play_TenseOut(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "TenseOut";
			soundManager.playMusic("TenseOut",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("TenseOut",globalVol,t);
		}
		
		//-----------------
		
		//
		public function LoadMoonBeams(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("MoonBeams")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/MoonBeams.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyMoonBeams(p,r,t);
					}
				});
			}
		}
		private function ReadyMoonBeams(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_MoonBeams = assets.getSound("MoonBeams");
			soundManager.addSound("MoonBeams", MUS_MoonBeams);
			if(p === true){
				Play_MoonBeams(r,t);
			}
		}
		
		public function Play_MoonBeams(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "MoonBeams";
			soundManager.playMusic("MoonBeams",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("MoonBeams",globalVol,t);
		}
		
		//-----------------
		
		public function LoadPianoOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("PianoOne")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/PianoOne.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyPianoOne(p,r,t);
					}
				});
			}
		}
		private function ReadyPianoOne(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_PianoOne = assets.getSound("PianoOne");
			soundManager.addSound("PianoOne", MUS_PianoOne);
			if(p === true){
				Play_PianoOne(r,t);
			}
		}
		
		public function Play_PianoOne(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "PianoOne";
			soundManager.playMusic("PianoOne",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("PianoOne",globalVol,t);
		}
		
		//-----------------
		//MUS_SunShine
		//----------------------------------------------------------------		
		public function LoadSunShine(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("SunShine")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/SunShine.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadySunShine(p,r,t);
					}
				});
			}
		}
		private function ReadySunShine(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_SunShine = assets.getSound("SunShine");
			soundManager.addSound("SunShine", MUS_SunShine);
			if(p === true){
				Play_SunShine(r,t);
			}
		}
		
		public function Play_SunShine(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "SunShine";
			soundManager.playMusic("SunShine",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("SunShine",globalVol,t);
		}
		
		//-----------------
		
		
		//----------------------------------------------------------------		
		public function LoadMountainViolin(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("MountainViolin")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/MountainViolin_001a005.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyMountainViolin(p,r,t);
					}
				});
			}
		}
		private function ReadyMountainViolin(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_MountainViolin = assets.getSound("MountainViolin_001a005");
			soundManager.addSound("MountainViolin", MUS_MountainViolin);
			if(p === true){
				Play_MountainViolin(r,t);
			}
		}
		
		public function Play_MountainViolin(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "MountainViolin";
			soundManager.playMusic("MountainViolin",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("MountainViolin",globalVol,t);
		}
		
		//-----------------
	
		//----------------------------------------------------------------		
		public function LoadBeachStrings(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("BeachStrings")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/BeachStrings_01.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyBeachStrings(p,r,t);
					}
				});
			}
		}
		private function ReadyBeachStrings(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_BeachStrings = assets.getSound("BeachStrings_01");
			soundManager.addSound("BeachStrings", MUS_BeachStrings);
			if(p === true){
				Play_BeachStrings(r,t);
			}
		}
		
		public function Play_BeachStrings(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "BeachStrings";
			soundManager.playMusic("BeachStrings",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("BeachStrings",globalVol,t);
		}
		
		//-----------------
		//MUS_ElectricHum
		//
		//
		//
		//
		//
		//
		///
		
		///
		
		
		
		//----------------------------------------------------------------		

		
		
		//----------------------------------------------------------------		
		

		//-----------------
		//
		//
		//
		//
		//
		//
		//
		//
		//
		//----------------------------------------------------------------		
		public function LoadSciFiWhistle(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("SciFiWhistle")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/ScifWhistle_v001a002.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadySciFiWhistle(p,r,t);
					}
				});
			}
		}
		private function ReadySciFiWhistle(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_SciFiWhistle = assets.getSound("ScifWhistle_v001a002");
			soundManager.addSound("SciFiWhistle", MUS_SciFiWhistle);
			if(p === true){
				Play_SciFiWhistle(r,t);
			}
		}
		
		public function Play_SciFiWhistle(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "SciFiWhistle";
			soundManager.playMusic("SciFiWhistle",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("SciFiWhistle",globalVol,t);
		}
		
		//----------------------------------------------------------------
		
		

		
		
		//----------------------------------------------------------------		
		public function LoadDeepDrums(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("DeepDrums")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/DeepDrums_v00a001.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						ReadyDeepDrums(p,r,t);
					}
				});
			}
		}
		private function ReadyDeepDrums(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_DeepDrums = assets.getSound("DeepDrums_v00a001");
			soundManager.addSound("DeepDrums", MUS_DeepDrums);
			if(p === true){
				Play_DeepDrums(r,t);
			}
		}
		
		public function Play_DeepDrums(repeatCount:Number = 0,t:Number = 0):void{
			trace("Music globalVol :"+globalVol);
			currentSong = "DeepDrums";
			soundManager.playMusic("DeepDrums",0,repeatCount,0,0,Null_CurrentSong);
			//soundManager.setVolume("MainThemeReduced", 0);
			soundManager.tweenVolume("DeepDrums",globalVol,t);
		}
		
		//----------------------------------------------------------------
		

		
		
		
//---------------------------------------------------------------		
		public function LoadMainTheme(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			if(soundManager.soundIsPlaying("MainTheme")){
				
			}
			else{
				this.assets.enqueue(File.applicationDirectory.resolvePath('./media/audio/music/MainTheme.mp3'));			
				this.assets.loadQueue(function(n:Number):void{
					if(n==1){
						
						//	soundManager = new SoundManager();
						//					soundManager = SoundManager.getInstance();
						ReadyMainTheme(p,r,t);
					}
				});
			}
		}
		
		private function ReadyMainTheme(p:Boolean = false,r:Number = 0,t:Number = 0):void{
			//soundManager = SoundManager.getInstance();
			MUS_MainTheme = assets.getSound("MainTheme");
			soundManager.addSound("MainTheme", MUS_MainTheme);
			if(p === true){
				Play_MainTheme(r,t);
			}
		}
		
	
		public function Play_MainTheme(repeatCount:Number = 0,t:Number = 0):void{
			if(paused === false){
				currentSong = "MainTheme";
				
				trace("Music globalVol :"+globalVol);
				currentSong = "MainTheme";
				soundManager.playMusic("MainTheme",0,repeatCount,0,0,function():void{Null_CurrentSong()});
				//soundManager.setVolume("MainThemeReduced", 0);
				soundManager.tweenVolume("MainTheme",globalVol,t);
			}else{
				currentSong = "MainTheme";
			}
		}
		
		
		
		//----------------------------------------------------------------		

//------------------------------------------------------------------		
		public function PauseAll():void{
			paused = true;
			if(MUS_MainTheme != null){
				pauseArr['MainTheme'] = soundManager.getPausePos("MainTheme");
				soundManager.stopSound('MainTheme');
			}
			
			if(MUS_MountainViolin != null){
				
				pauseArr['MountainViolin'] =  soundManager.getPausePos("MountainViolin");
				soundManager.stopSound('MountainViolin');
			}
			if(MUS_BeachStrings != null){
				
				pauseArr['BeachStrings'] =  soundManager.getPausePos("BeachStrings");
				soundManager.stopSound('BeachStrings');
			}

			if(MUS_PianoOne != null){
				
				pauseArr['PianoOne'] =  soundManager.getPausePos("PianoOne");
				soundManager.stopSound('PianoOne');
			}
			
			if(MUS_MoonBeams != null){
				
				pauseArr['MoonBeams'] =  soundManager.getPausePos("MoonBeams");
				soundManager.stopSound('MoonBeams');
			}
			if(MUS_BeatUpOne != null){
				
				pauseArr['BeatUpOne'] =  soundManager.getPausePos("BeatUpOne");
				soundManager.stopSound('BeatUpOne');
			}
			if(MUS_BeatDownOne != null){
				
				pauseArr['BeatDownOne'] =  soundManager.getPausePos("BeatDownOne");
				soundManager.stopSound('BeatDownOne');
			}
			if(MUS_Doom != null){
				
				pauseArr['Doom'] =  soundManager.getPausePos("Doom");
				soundManager.stopSound('Doom');
			}
			if(MUS_BeatNowOne != null){
				
				pauseArr['BeatNowOne'] =  soundManager.getPausePos("BeatNowOne");
				soundManager.stopSound('BeatNowOne');
			}
			
			if(MUS_MountainFluteOne != null){
				
				pauseArr['MountainFluteOne'] =  soundManager.getPausePos("MountainFluteOne");
				soundManager.stopSound('MountainFluteOne');
			}
			
			if(MUS_SunShine != null){
				
				pauseArr['SunShine'] =  soundManager.getPausePos("SunShine");
				soundManager.stopSound('SunShine');
			}
			if(MUS_PainPitch != null){
				
				pauseArr['PainPitch'] =  soundManager.getPausePos("PainPitch");
				soundManager.stopSound('PainPitch');
			}
			
			if(MUS_SubBop != null){
				
				pauseArr['SubBop'] =  soundManager.getPausePos("SubBop");
				soundManager.stopSound('SubBop');
			}
			
			if(MUS_TenseOut != null){
				
				pauseArr['TenseOut'] =  soundManager.getPausePos("TenseOut");
				soundManager.stopSound('TenseOut');
			}
			if(MUS_XFiles != null){
				
				pauseArr['XFiles'] =  soundManager.getPausePos("XFiles");
				soundManager.stopSound('XFiles');
			}
			if(MUS_SpeedDial != null){
				
				pauseArr['SpeedDial'] =  soundManager.getPausePos("SpeedDial");
				soundManager.stopSound('SpeedDial');
			}
			if(MUS_JamLoop != null){
				
				pauseArr['JamLoop'] =  soundManager.getPausePos("JamLoop");
				soundManager.stopSound('JamLoop');
			}
			if(MUS_DeepSpace != null){
				
				pauseArr['DeepSpace'] =  soundManager.getPausePos("DeepSpace");
				soundManager.stopSound('DeepSpace');
			}
			if(MUS_LightBeam != null){
				
				pauseArr['LightBeam'] =  soundManager.getPausePos("LightBeam");
				soundManager.stopSound('LightBeam');
			}
			//JamLoop
			
		}
		public function resumeCurrentSong():void{
			paused = false;
			trace("currentSong "+currentSong);
			trace("pauseArr[currentSong] "+pauseArr[currentSong]);
			trace("pauseArr[currentSong]/1000 "+(pauseArr[currentSong]/1000));
			if(currentSong != null){
				var startPos:Number = (pauseArr[currentSong]);
				if(currentSong == 'MainTheme'){
					soundManager.ResumeMusic(currentSong,globalVol,999,0,startPos,Null_CurrentSong);
				}
				else{
					soundManager.ResumeMusic(currentSong,globalVol,0,0,startPos,Null_CurrentSong);
				}
			}
			
			
		}
		
		
		
	}
}