package scrollers 
{
	import com.greensock.core.TweenCore;
	import com.greensock.TweenMax;
	import flash.events.EventDispatcher;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import scrollers.events.ScrollerEvent;
	import scrollers.interfaces.IpageScroller;
	import scrollers.interfaces.Iscroller;
	import scrollers.propsObjects.ScrollProperties;
	import simpleController.events.ControllerEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollController extends EventDispatcher
	{
		//такая форма позовляет не делать публичным свойство и при этом использовать tweenMax
		private var _position:Object = { value:0 };//0-1
		private var _snapHandler:IpageScroller;
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
			
			if (currentTween)//Если контроллер выполняет прокуртку - остановить.
			{
				currentTween.kill();
				currentTween = null;
			}
			if (pos > 1) pos = 1;
			if (pos < 0) pos = 0;
			var from:int = position;
			
			if (duration == 0)//Мгновенная прокрутка без использования tweenMax
			{
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_START, from, pos,0,trigger));
				_position.value = pos;
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE, from, pos, 0, trigger));
				
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
				//события не отправляются чтобы не генерить так много объектов.
			}
			function onScrollComplete():void
			{
				//прокрутка закончена, snap считается отдельной прокруткой и у него будут собственные start|complete события
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE, from, pos, duration,trigger));
				if(snapToPage)
				snap(onComplete);
				else  if (onComplete)
				{
					onComplete();
				}
			}
		}
		
		//Оставшийся с поисков решения способ отложить выполнение snap. подумал оставить и сделать настраиваемым. можно удалить
		private var _snapDelay:uint;
		protected function get snapDelay():uint 
		{
			return _snapDelay;
		}
		
		protected function set snapDelay(value:uint):void 
		{
			if (_snapDelay) clearTimeout(_snapDelay);
			_snapDelay = value;
		}
		//PUBLIC:
		/**
		 * 
		 * @param	pos  - позиция до которой выполнит прокрутку контроллер
		 * @param	duration - время прокуртки 1 - 1sec
		 * @param	onComplete - функция, которая будет вызвана после завершения прокрутки(и после snap())
		 * @param	trigger - объект инициализирующий прокрутку 
		 * @param	noSnap - отменить флаг snapToPages для этой прокрутки
		 */
		public function scrollTo(pos:Number, duration:Object=0, onComplete:Function=null,trigger:Object = 'external', noSnap:Boolean = false):void
		{
			
			var d:Number;
			if (duration is Number && duration >=0) d = Number(duration);
			else d = props.scrollDuration;
			
			
			_scrollTo(pos, d, onComplete,(props.snapToPages && !noSnap),trigger);
		}
		public function snap(onComplete:Function=null):void
		{
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
			_scrollTo(snapHandler.getPagePosition(_snapHandler.currentPage), props.snapDuration, onComplete, false);
		}
		public function get position():Number 
		{
			return _position.value;
		}
		public function set position(value:Number):void 
		{
			_scrollTo(value, props.scrollDuration, null, props.snapDuration);
		}
		
		public function get snapHandler():IpageScroller 
		{
			return _snapHandler;
		}
		
		public function set snapHandler(value:IpageScroller):void 
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