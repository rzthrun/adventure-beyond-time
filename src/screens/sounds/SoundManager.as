package screens.sounds
{
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	import starling.animation.DelayedCall;
	import starling.animation.Tween;
	import starling.core.Starling;

	public class SoundManager {
		
		private static var _instance:SoundManager;
		private var _isMuted:Boolean = false;		// When true, every change in volume for ALL sounds is ignored
		
		public var sounds:Dictionary;			// contains all the sounds registered with the Sound Manager
		public var currPlayingSounds:Dictionary;	// contains all the sounds that are currently playing
		
		public var playMusicCallBack:Function = null;
		
		public function SoundManager() {			
			sounds = new Dictionary();
			currPlayingSounds = new Dictionary();
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		public static function getInstance():SoundManager {
			
			if (!_instance)
				_instance = new SoundManager();
			
			return _instance;
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		public function dispose():void {			
			sounds = null;
			currPlayingSounds = null;
		}
		// -------------------------------------------------------------------------------------------------------------------------			
		/** Add sounds to the sound dictionary */
		public function addSound(id:String, sound:Sound):void {
			sounds[id] = sound;
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Remove sounds from the sound manager */
		public function removeSound(id:String):void {
			if (soundIsAdded(id)) {
				delete sounds[id];				
				if (soundIsPlaying(id))
					delete currPlayingSounds[id];
			}
			else {
				throw Error("The sound you are trying to remove is not in the sound manager");
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Check if a sound is in the sound manager */
		public function soundIsAdded(id:String):Boolean {
			return Boolean(sounds[id]);
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Check if a sound is playing */
		public function soundIsPlaying(id:String):Boolean {
			for (var currID:String in currPlayingSounds) {
				if ( currID == id )
					return true;
			}	
			return false;
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Play a sound */
		public function playMusic(id:String, volume:Number = 1.0, repetitions:int = 1, panning:Number = 0,position:Number = 0,callback:Function=null):void {			
			
			if (soundIsAdded(id))
			{
				var soundObject:Sound = sounds[id];
				
				var channel:SoundChannel = new SoundChannel();
				
				channel = soundObject.play(position, repetitions);
				
				if (!channel)
					return;
				playMusicCallBack  = function(e:Event){
					if(callback != null){
						callback();
					}
					
					removeMusicFromDictionary(e);
				}
				
				
				channel.addEventListener(Event.SOUND_COMPLETE, playMusicCallBack);
				
				// if the sound manager is muted, set the sound's volume to zero
				var v:Number = (_isMuted)? 0 : volume;
				var s:SoundTransform = new SoundTransform(v, panning);
				channel.soundTransform = s;
				
				currPlayingSounds[id] = { channel:channel, sound:soundObject, volume:volume, position:Number };
			}
			else
			{
				throw Error("The sound you are trying to play (" + id + ") is not in the Sound Manager. Try adding it to the Sound Manager first.");
			}
		}
		private function removeMusicFromDictionary(e:Event):void {			
			trace("REMOVE FROM DICTIONARY");
			for (var id:String in currPlayingSounds) 
			{
				if (currPlayingSounds[id].channel == e.target)
					delete currPlayingSounds[id];
			}
			e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, playMusicCallBack);
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Play a sound */
		public function ResumeMusic(id:String, volume:Number = 1.0, repetitions:int = 1, panning:Number = 0,position:Number = 0,callback:Function = null):void {			
			trace("currPlayingSounds[id] "+currPlayingSounds[id]);
			if (soundIsAdded(id))
			{
				var soundObject:Sound = sounds[id];
				
				var channel:SoundChannel = new SoundChannel();
				if(currPlayingSounds[id] != undefined){
					trace(1);
					if(currPlayingSounds[id].position != undefined){
						trace(2);
						channel = soundObject.play(position, repetitions);
					}else{
						trace(3)
						channel = soundObject.play(0, repetitions);
					}
				}else{
					trace(4);
					channel = soundObject.play(position, repetitions);
				}
				
				//	channel.position = position;
				if (!channel)
					return;
				/*
				playMusicCallBack  = function(e:Event){
				if(callback != null){
				callback();
				}
				
				removeMusicFromDictionary(e);
				}
				 
				*/
				playMusicCallBack  = function(e:Event){
					if(callback != null){
						callback();
					}
					
					removeMusicFromDictionary(e);
				}
					
					
					
				
					
				channel.addEventListener(Event.SOUND_COMPLETE, playMusicCallBack);
				
				// if the sound manager is muted, set the sound's volume to zero
				var v:Number = (_isMuted)? 0 : volume;
				var s:SoundTransform = new SoundTransform(v, panning);
				channel.soundTransform = s;
				
				currPlayingSounds[id] = { channel:channel, sound:soundObject, volume:volume, position:Number };
			}
			else
			{
				throw Error("The sound you are trying to play (" + id + ") is not in the Sound Manager. Try adding it to the Sound Manager first.");
			}
		}		
		
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Play a sound */
		public function playSound(id:String, volume:Number = 1.0, repetitions:int = 1, panning:Number = 0,position:Number = 0):void {			
			
			if (soundIsAdded(id))
			{
				var soundObject:Sound = sounds[id];
				
				var channel:SoundChannel = new SoundChannel();
				
				channel = soundObject.play(position, repetitions);
				
				if (!channel)
					return;
				
				channel.addEventListener(Event.SOUND_COMPLETE, removeSoundFromDictionary);
				
				// if the sound manager is muted, set the sound's volume to zero
				var v:Number = (_isMuted)? 0 : volume;
				var s:SoundTransform = new SoundTransform(v, panning);
				channel.soundTransform = s;
				
				currPlayingSounds[id] = { channel:channel, sound:soundObject, volume:volume, position:Number };
			}
			else
			{
				throw Error("The sound you are trying to play (" + id + ") is not in the Sound Manager. Try adding it to the Sound Manager first.");
			}
		}
		
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Play a sound */
		public function ResumeSound(id:String, volume:Number = 1.0, repetitions:int = 1, panning:Number = 0,position:Number = 0):void {			
			trace("currPlayingSounds[id] "+currPlayingSounds[id]);
			if (soundIsAdded(id))
			{
				var soundObject:Sound = sounds[id];
				
				var channel:SoundChannel = new SoundChannel();
				if(currPlayingSounds[id] != undefined){
					trace(1);
					if(currPlayingSounds[id].position != undefined){
						trace(2);
						channel = soundObject.play(position, repetitions);
					}else{
						trace(3)
						channel = soundObject.play(0, repetitions);
					}
				}else{
					trace(4);
					channel = soundObject.play(position, repetitions);
				}
				
			//	channel.position = position;
				if (!channel)
					return;
				
				channel.addEventListener(Event.SOUND_COMPLETE, removeSoundFromDictionary);
				
				// if the sound manager is muted, set the sound's volume to zero
				var v:Number = (_isMuted)? 0 : volume;
				var s:SoundTransform = new SoundTransform(v, panning);
				channel.soundTransform = s;
				
				currPlayingSounds[id] = { channel:channel, sound:soundObject, volume:volume, position:Number };
			}
			else
			{
				throw Error("The sound you are trying to play (" + id + ") is not in the Sound Manager. Try adding it to the Sound Manager first.");
			}
		}		
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Remove a sound from the dictionary of the sounds that are currently playing */
		private function removeSoundFromDictionary(e:Event):void {			
			trace("REMOVE FROM DICTIONARY");
			for (var id:String in currPlayingSounds) 
			{
				if (currPlayingSounds[id].channel == e.target)
					delete currPlayingSounds[id];
			}
			e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, removeSoundFromDictionary);
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Stop a sound */
		public function stopSound(id:String):void {			
			if (soundIsPlaying(id))
			{
				SoundChannel(currPlayingSounds[id].channel).stop();				
				delete currPlayingSounds[id];	
				trace("SOUND "+id+" STOPPED");
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------
		/** Stop all sounds that are currently playing */
		public function stopAllSounds():void {
			for (var currID:String in currPlayingSounds) 
				stopSound(currID);
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Set a sound's volume */
		public function setVolume(id:String, volume:Number):void {			
			if (soundIsPlaying(id))
			{
				var s:SoundTransform = new SoundTransform(volume);
				SoundChannel(currPlayingSounds[id].channel).soundTransform = s;
				currPlayingSounds[id].volume = volume;
			}
			else
			{
				throw Error("This sound (id = " + id + " ) is not currently playing");
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------
		/** Tween a sound's volume */
		public function tweenVolume(id:String, volume:Number = 0, tweenDuration:Number = 2):void {
			if (soundIsPlaying(id))
			{
				var s:SoundTransform = new SoundTransform();
				var soundObject:Object = currPlayingSounds[id];
				var c:SoundChannel = currPlayingSounds[id].channel;
				
				
				
				Starling.juggler.tween(soundObject, tweenDuration, {
					volume: volume,
					onUpdate: function():void {
						if (!_isMuted)
						{
							s.volume = soundObject.volume;
							c.soundTransform = s;
						}
						
					
						
					}
				});
				
				
			}
			else
			{
			//	throw Error("This sound (id = " + id + " ) is not currently playing");
			}
		}
		//------------------------------------------------------------------------------------
		/**Custom Vol Tween Func**/
		public function tweenVolumeComplex(id:String, volume:Number = 0, tweenDuration:Number = 2,onCompleteFunction:String = null):void{
			if (soundIsPlaying(id))
			{
				var s:SoundTransform = new SoundTransform();
				var soundObject:Object = currPlayingSounds[id];
				var c:SoundChannel = currPlayingSounds[id].channel;
				
				var soundTween:Tween = new Tween(soundObject,tweenDuration);
				
				Starling.juggler.tween(soundObject, tweenDuration, {
					volume: volume,
					onUpdate: function():void {
						if (!_isMuted)
						{
							s.volume = soundObject.volume;
							c.soundTransform = s;
						}
					}
				});
				
				if(onCompleteFunction != null){
					if(onCompleteFunction == 'stop'){
						var delayedCall:DelayedCall = new DelayedCall(function():void{
							stopSound(id);
						},
						tweenDuration);
						Starling.juggler.add(delayedCall)
						
					}
				}
				
			}
			else
			{
			//	throw Error("This sound (id = " + id + " ) is not currently playing");
			}
		}
		
		
		
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Cross fade two sounds. N.B. The sounds that fades out must be already playing */
		public function crossFade(fadeOutId:String, fadeInId:String, tweenDuration:Number = 2, fadeInVolume:Number = 1, fadeInRepetitions:int = 1):void {			
			
			// If the fade-in sound is not already playing, start playing it
			if (!soundIsPlaying(fadeInId))
				playSound(fadeInId, 0, fadeInRepetitions);
			
			tweenVolume (fadeOutId, 0, tweenDuration);
			tweenVolume (fadeInId, fadeInVolume, tweenDuration);
			
			// If the fade-out sound is playing, stop it when its volume reaches zero
			if (soundIsPlaying(fadeOutId))
				Starling.juggler.delayCall(stopSound, tweenDuration, fadeOutId);
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Sets a new volume for all the sounds currently playing 
		 *  @param volume the new volume value 
		 */
		public function setGlobalVolume(volume:Number):void {
			var s:SoundTransform;
			for (var currID:String in currPlayingSounds) {
				s = new SoundTransform(volume);
				SoundChannel(currPlayingSounds[currID].channel).soundTransform = s;
				currPlayingSounds[currID].volume = volume;
			}
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		/** Mute all sounds currently playing.
		 *  @param mute a Boolean dictating whether all the sounds in the sound manager should be silenced (true) or restored to their original volume (false). 
		 */ 
		public function muteAll(mute:Boolean = true):void {
			
			var s:SoundTransform;
			for (var currID:String in currPlayingSounds) 
			{
				s = new SoundTransform(mute ? 0 : currPlayingSounds[currID].volume);
				SoundChannel(currPlayingSounds[currID].channel).soundTransform = s;
			}
			_isMuted = mute;			
		}
		//-----------------------------------------------------------------------
		public function getPausePos(id:String):Number{
			if(soundIsPlaying(id)){
			//	var Channel:SoundChannel = getSoundChannel(id);
				currPlayingSounds[id].position = SoundChannel(currPlayingSounds[id].channel).position;
				return getSoundChannel(id).position;
				
			}else{
				//currPlayingSounds[id].position = 0;
				return 0;
			}
		}
		
		// -------------------------------------------------------------------------------------------------------------------------		
		public function getSoundChannel(id:String):SoundChannel {			
			if (soundIsPlaying(id))
				return SoundChannel(currPlayingSounds[id].channel);
			
			throw Error("You are trying to get a non-existent soundChannel. Play the sound first in order to assign a channel.");
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		public function getSoundTransform(id:String):SoundTransform {			
			if (soundIsPlaying(id))
				return SoundChannel(currPlayingSounds[id].channel).soundTransform;
			
			throw Error("You are trying to get a non-existent soundTransform. Play the sound first in order to assign a transform.");
		}
		// -------------------------------------------------------------------------------------------------------------------------		
		public function getSoundVolume(id:String):Number {			
			if (soundIsPlaying(id))
				return currPlayingSounds[id].volume;
			
			throw Error("You are trying to get a non-existent volume. Play the sound first in order to assign a volume.");
		}		
		// --------------------------------------------------------------------------------------------------------------------------------------
		// SETTERS & GETTERS
		public function get isMuted():Boolean { return _isMuted; }		
	}
}