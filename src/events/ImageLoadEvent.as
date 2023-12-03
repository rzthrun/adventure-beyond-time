package events
{
	import starling.events.Event;
	
	public class ImageLoadEvent extends Event
	{
		public static const IMAGE_LOAD:String = "imageLoad";
		public var params:Object;
		
		public function ImageLoadEvent(type:String, _params:Object = null, bubbles:Boolean=false)
		{
			super(type, bubbles);
			this.params = _params;
		}
	}
}