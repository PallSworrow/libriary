package scrollers 
{
	import com.greensock.TweenMax;
	import flash.events.EventDispatcher;
	import scrollers.events.ScrollerEvent;
	import scrollers.interfaces.IpagedLayout;
	import scrollers.interfaces.Iscroller;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollController extends EventDispatcher
	{
		private var _position:Number = 0;//0-1
		private var _snapHandler:IpagedLayout;
		//private var scrollEvent:ScrollerEvent;
		private var props:ScrollProperties;
		private var singleEvent:ScrollerEvent;
		public function ScrollController() 
		{
			super(this);
			props = new ScrollProperties();
			
			singleEvent = new ScrollerEvent(ScrollerEvent.SCROLL, position, 0);
		}
		//PRIVATE:
		private function _scrollTo(pos:Number, duration:Number, onComplete:Function = null, snapToPage:Boolean = true):void
		{
			if (pos > 1) pos = 1;
			if (pos < 0) pos = 0;
			//scrollEvent = new ScrollerEvent(ScrollerEvent.SCROLL, _position, pos);
			
			if (duration == 0)
			{
				position = pos;
				//scrollEvent = null;
				if (onComplete) onComplete();
			}
			else 
			{
				
				//dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_START, _position, pos));
				TweenMax.to(this, duration, { position:pos, onComplete:onComplete } );
			}
			
			function onScrollComplete():void
			{
				//scrollEvent = null;
				//dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE, _position, pos));
				if(snapToPage)
				snap(onComplete);
				else 
				{
					onComplete();
				}
			}
		}
		public function scrollTo(pos:Number, duration:Object=0, onComplete:Function=null):void
		{
			var d:Number;
			if (duration is Number && duration >=0) d = Number(duration);
			else d = props.scrollDuration;
			
			_scrollTo(pos, d, onComplete,props.snapToPages);
		}
		public function snap(onComplete:Function=null):void
		{
			if (!snapHandler) 
			{
				//error?
				if(onComplete) onComplete();
				return;
			}
			_scrollTo(snapHandler.snap(position), props.snapDuration, onComplete, false);
			
		}
		public function get position():Number 
		{
			return _position;
		}
		public function set position(value:Number):void 
		{
			//var singleEvent:ScrollerEvent;
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			//if (!scrollEvent) 
			//singleEvent = new ScrollerEvent(ScrollerEvent.SCROLL, position, value);
			trace('scroll:', _position, value);
			_position = value;
			/*if(scrollEvent)
			{
				dispatchEvent(scrollEvent);
			}
			else*/ dispatchEvent(singleEvent);
		}
		
		public function get snapHandler():IpagedLayout 
		{
			return _snapHandler;
		}
		
		public function set snapHandler(value:IpagedLayout):void 
		{
			_snapHandler = value;
		}
		
		//EVENTS:
	
		
	}

}