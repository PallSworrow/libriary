package scrollers.bases 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import layouts.glifs.Glif;
	import layouts.glifs.Layout;
	import scrollers.events.ScrollerEvent;
	import scrollers.interfaces.Iscroller;
	import scrollers.ScrollController;
	import simpleController.Controller;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollViewBase extends Glif implements Iscroller
	{
		private var _content:DisplayObject;
		private var maskBox:Sprite;

		private var _isVertical:Boolean = true;
		private var _controller:ScrollController;
		private var _draggable:Boolean=true;
		public function ScrollViewBase(content:DisplayObject) 
		{
			super();
			maskBox = new Sprite();
			maskBox.graphics.beginFill(0x000000);
			maskBox.graphics.drawRect(0, 0, 100, 100);
			maskBox.graphics.endFill();
			_content = content;
			
			addChild(content);
			addChild(maskBox);
			mask = maskBox;
			
			
		}
		
		/* INTERFACE scrollers.interfaces.Iscroller */
		public function get position():Number 
		{
			if (_controller) return _controller.position;
			return _position;
		}
		
		public function set position(value:Number):void 
		{
			if (_controller) _controller.position = value;
			_position = value;
		}
		
		public function set controller(value:ScrollController):void 
		{
			if (_controller) _controller.removeEventListener(ScrollerEvent.SCROLL, onControllerUpdate);
			_controller = value;
			if (_controller) _controller.addEventListener(ScrollerEvent.SCROLL, onControllerUpdate);
		}
		
		public function get draggable():Boolean 
		{
			return _draggable;
		}
		
		public function set draggable(value:Boolean):void 
		{
			_draggable = value;
			
		}
		public function get controller():ScrollController 
		{
			return _controller;
		}
		
		
		
		public function get isVertical():Boolean
		{
			return _isVertical;
		}
		public function get maxOffset():int 
		{
			if (isVertical)
			return content.height - maskBox.height;
			else 
			return content.width - maskBox.width;
		}
		
		public function get offset():int 
		{
			if (_controller) return _controller.position * maxOffset;
			return _offset;
		}
		public function get proportion():Number 
		{
			if(isVertical)
			return content.height / maskBox.height;
			else
			return content.width / maskBox.width;
		}
		
		public function set offset(value:int):void 
		{
			//if (_controller) _controller.scrollTo(value / maxOffset,1);
			if (_controller) _controller.position = value / maxOffset;
			else 
			{
				_offset = value;
			}
		}
		
		
		
		
		//EVENTS:
		private function onControllerUpdate(e:ScrollerEvent):void
		{	
			_position = _controller.position;
		}
		
		//INTERNAL:
		protected function get _offset():int 
		{
			throw 'must be overrided';
			return -1;
		}
		protected function set _offset(value:int):void 
		{
			throw 'must be overrided';
			
		}
		private function get _position():Number
		{
			return  _offset/maxOffset;
		}
		private function set _position(value:Number):void 
		{
			_offset = maxOffset * value;
		}
		
		protected function get content():DisplayObject 
		{
			return _content;
		}
		
		
	}

}