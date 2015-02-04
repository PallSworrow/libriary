package scrollers 
{
	import com.greensock.core.TweenCore;
	import com.greensock.TweenMax;
	import flash.events.EventDispatcher;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import scrollers.events.ScrollerEvent;
	import scrollers.interfaces.IpageSnaper;
	import scrollers.interfaces.Iscroller;
	import scrollers.propsObjects.ScrollProperties;
	import simpleController.events.ControllerEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollController extends EventDispatcher
	{
		private var _position:Object = { value:0 };//0-1
		private var _snapHandler:IpageSnaper;
		private var _props:ScrollProperties;
		private var singleEvent:ScrollerEvent;
		private var currentTween:TweenMax;
		public function ScrollController() 
		{
			super(this);
			props = new ScrollProperties();
			
		}
		//PRIVATE:
		private function _scrollTo(pos:Number, duration:Number, onComplete:Function = null, snapToPage:Boolean = true,trigger:Object = 'external'):void
		{
			
			if (currentTween)
			{
				currentTween.kill();
				currentTween = null;
			}
			if (pos > 1) pos = 1;
			if (pos < 0) pos = 0;
			var from:int = position;
		//
			//trace('Scroll to:', from, pos, trigger);
			if (duration == 0)
			{
				_position.value = pos;
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_START, from, pos,0,trigger));
				//dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL, from, pos,trigger));
				if(snapToPage)
				snap(onComplete);
				else  if (onComplete)
				{
					onComplete();
				}
			}
			else 
			{
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_START, from, pos,duration,trigger));
				currentTween = TweenMax.to(_position, duration, { value:pos, onUpdate:onScroll, onComplete:onScrollComplete } );
			}
			
			function onScroll():void
			{
				//singleEvent = new ScrollerEvent(ScrollerEvent.SCROLL,from,pos,trigger);
				//dispatchEvent(singleEvent);
			}
			function onScrollComplete():void
			{
				
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE, from, pos, duration));
				
			trace('scroll: ', snapToPage);
				if(snapToPage)
				snap(onComplete);
				else  if (onComplete)
				{
					onComplete();
				}
			}
		}
		private var _snapDelay:uint;
		public function get snapDelay():uint 
		{
			return _snapDelay;
		}
		
		public function set snapDelay(value:uint):void 
		{
			if (_snapDelay) clearTimeout(_snapDelay);
			_snapDelay = value;
		}
		//PUBLIC:
		public function scrollTo(pos:Number, duration:Object=0, onComplete:Function=null,trigger:Object = 'external', noSnap:Boolean = false):void
		{
			
			var d:Number;
			if (duration is Number && duration >=0) d = Number(duration);
			else d = props.scrollDuration;
			
			
			_scrollTo(pos, d, onComplete,(props.snapToPages && !noSnap),trigger);
		}
		public function snap(onComplete:Function=null):void
		{
			trace('SNAP');
			if (!snapHandler) 
			{
				//error?
				if(onComplete) onComplete();
				return;
			}
			else
			{
				snapDelay = setTimeout(implementSnap, 100, onComplete);
			}
		}
		private function implementSnap(onComplete:Function):void
		{
			_scrollTo(snapHandler.getNearestPagePosition(), props.snapDuration, onComplete, false);
		}
		public function get position():Number 
		{
			return _position.value;
		}
		public function set position(value:Number):void 
		{
			/*if (currentTween)
			{
				currentTween.kill();
				currentTween = null;
			}
			var from:Number = _position.value;
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			//singleEvent = new ScrollerEvent(ScrollerEvent.SCROLL, position, value);
			_position.value = value;
			
			dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_START, from, value,0));*/
		}
		
		public function get snapHandler():IpageSnaper 
		{
			return _snapHandler;
		}
		
		public function set snapHandler(value:IpageSnaper):void 
		{
			_snapHandler = value;
		}
		
		public function get props():ScrollProperties 
		{
			return _props;
		}
		
		public function set props(value:ScrollProperties):void 
		{
			_props = value;
		}
		
		
		
		//EVENTS:
	
		
	}

}