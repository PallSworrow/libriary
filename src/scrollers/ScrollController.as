package scrollers 
{
	import com.greensock.core.TweenCore;
	import com.greensock.TweenMax;
	import flash.events.EventDispatcher;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import scrollers.events.ScrollerEvent;
	import scrollers.interfaces.IpageScroller;
	import scrollers.interfaces.IscrollController;
	import scrollers.interfaces.Iscroller;
	import scrollers.propsObjects.ScrollProperties;
	import simpleController.events.ControllerEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollController extends EventDispatcher implements IscrollController
	{
		//такая форма позовляет не делать публичным свойство и при этом использовать tweenMax
		private var _position:Object = { value:0 };//0-1
		private var _snapHandler:IpageScroller;
		private var _props:ScrollProperties;
		private var singleEvent:ScrollerEvent;
		private var currentTween:TweenMax;
		private var _completeDispatcher:uint;
		public function ScrollController() 
		{
			super(this);
			props = new ScrollProperties();
			
		}
		//PRIVATE:
		private function _scrollTo(pos:Number, duration:Number, onComplete:Function = null, snapToPage:Boolean = true,trigger:Object = 'external'):void
		{
			completeDispatcher = null;
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
				//dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE, from, pos, 0, trigger));
				onScrollComplete(from, pos, duration, trigger, snapToPage, onComplete);/*
				completeDispatcher = setTimeout(dispatchComplete,200,from,pos,duration,trigger);
				if(snapToPage)
				snap(onComplete);
				else  if(onComplete)
				{
					onComplete();
				}*/
			}
			else 
			{
				dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_START, from, pos, duration, trigger));
				
				currentTween = TweenMax.to(_position, duration, { overwrite: true, value:pos, onComplete:onScrollComplete,onCompleteParams:[from,pos,duration,trigger,snapToPage,onComplete] } );
			}
			
			
			
		}
		function onScrollComplete(from:Number, to:Number,duration:Number, trigger:Object,snapToPage:Boolean,onComplete:Function):void
		{
			//прокрутка закончена, snap считается отдельной прокруткой и у него будут собственные start|complete события
			//dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE, from, pos, duration,trigger));
			completeDispatcher = setTimeout(dispatchComplete,100,from,to,duration,trigger);
			if(snapToPage)
			snap(onComplete);
			else  if(onComplete)
			{
				onComplete();
			}
		}
		private function dispatchComplete(from:Number, to:Number,duration:Number, trigger:Object):void
		{
			dispatchEvent(new ScrollerEvent(ScrollerEvent.SCROLL_COMPLETE, from, to, duration, trigger));
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
				//snapDelay = setTimeout(implementSnap, 100, onComplete);
				implementSnap(onComplete);
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
		
		protected function get completeDispatcher():uint 
		{
			return _completeDispatcher;
		}
		
		protected function set completeDispatcher(value:uint):void 
		{
			if (_completeDispatcher) clearTimeout(_completeDispatcher);
			_completeDispatcher = value;
		}
		
		
		
		//EVENTS:
	
		
	}

}