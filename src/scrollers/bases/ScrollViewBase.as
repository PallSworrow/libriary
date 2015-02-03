package scrollers.bases 
{
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import layouts.glifs.Glif;
	import layouts.glifs.Layout;
	import layouts.GlifType;
	import scrollers.events.ScrollerEvent;
	import scrollers.interfaces.Iscroller;
	import scrollers.propsObjects.ScrollerViewProperies;
	import scrollers.ScrollController;
	import simpleController.Controller;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollViewBase extends Glif implements Iscroller
	{
		private var _currentTween:TweenMax;
		private var _content:DisplayObject;
		private var maskBox:Sprite;

		private var _isVertical:Boolean = true;
		private var _controller:ScrollController;
		private var _draggable:Boolean=true;
		private var _props:ScrollerViewProperies;
		public function ScrollViewBase(content:DisplayObject) 
		{
			
			props = new ScrollerViewProperies();
			super(GlifType.DYNAMIC);
			_content = content;
			maskBox = new Sprite();
			maskBox.graphics.beginFill(0x000000);
			maskBox.graphics.drawRect(0, 0, width, height);
			maskBox.graphics.endFill();
			
			super.addChild(content);
			//addChild(maskBox);
			//mask = maskBox;
			masked = true;
			
		}
		protected function addElement(element:DisplayObject):void
		{
			super.addChild(element);
		}
		protected function removeElement(element:DisplayObject):void
		{
			super.removeChild(element);
		}
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			throw new Error('this object does not support adding chlidren');
			return null;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			throw new Error('this object does not support adding chlidren');
			return null;
		}
		
		
		
		
		
		/* INTERFACE scrollers.interfaces.Iscroller */
		
		public function get props():ScrollerViewProperies 
		{
			return _props;
		}
		
		public function set props(value:ScrollerViewProperies):void 
		{
			_props = value;
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			maskBox.width = value;
			
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			maskBox.height = value;
		}
		/* INTERFACE scrollers.interfaces.Iscroller */
		public function get position():Number 
		{
			if (_controller) return _controller.position;
			return _position;
		}
		
		public function set position(value:Number):void 
		{
			if (value > 1) value == 1;
			if (value < 0) value = 0;
			if (_controller) _controller.position = value;
			_position = value;
		}
		
		public function set controller(value:ScrollController):void 
		{
			if (_controller) _controller.removeEventListener(ScrollerEvent.SCROLL_START, onControllerStartScroll);
			_controller = value;
			if (_controller) _controller.addEventListener(ScrollerEvent.SCROLL_START, onControllerStartScroll);
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
			throw 'must be overrided';
			return -1;
		}
		
		public function get offset():int 
		{
			if (_controller) return _controller.position * maxOffset;
			return _offset;
		}
		public function get proportion():Number 
		{
			throw 'must be overrided';
			return -1;
		}
		
		public function set offset(value:int):void 
		{
			if (_controller) _controller.scrollTo(value / maxOffset,0,null,this);
			else 
			{
				_offset = value;
			}
		}
		public function scrollTo(targPosition:Number, duration:Number, onComplete:Function = null):void 
		{
			if (targPosition > 1) targPosition = 1;
			if (targPosition < 0) targPosition = 0;
			if (duration < 0) duration = 0;
			var anim:Object;
			if (_controller)
			{
				currentTween = null;
				_controller.scrollTo(targPosition, duration, onComplete, 'controller');
				
			}
			else
			{
				anim = { position:_position };
				currentTween = TweenMax.to(anim, duration, { position:targPosition, onComplete:onComplete,
				onUpdate:function():void
				{
					_position = anim.position;
				}});
			}
		}
		
		
		
		//EVENTS:
		protected function onControllerStartScroll(e:ScrollerEvent):void
		{
			trace(this, e.type, e.from, e.to, e.duration);
			if (_position == e.to) return;
			currentTween = null;
			var from:Number = _position;
			var to:Number = e.to;
			var duration:Number = props.controllerOvertakeDuration;
			if (duration < e.duration)//?
			duration = e.duration;
			
			if (duration == 0 || (e.trigger == this && props.stiffDrag))
			{
				_position = e.to;
				return;
			}
			var anim:Object = { position:from };
			currentTween = TweenMax.to(anim, duration, { position:to,
			onUpdate:function():void
			{
				_position = anim.position;
			}});
		}
		/*protected function onControllerUpdate(e:ScrollerEvent):void
		{	
			
			var anim:Object;
			if(props.controllerOvertakeDuration ==0 || e.trigger == this )
			{
				currentTween = null;
				_position = _controller.position;
			}
			else
			{
				anim = { position:_position };
				
				currentTween = TweenMax.to(anim, props.controllerOvertakeDuration, { position:e.to,
				onUpdate:function():void
				{
					_position = anim.position;
				}});
			}
		}*/
		
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
		
		protected function get currentTween():TweenMax 
		{
			return _currentTween;
		}
		
		protected function set currentTween(value:TweenMax):void 
		{
			if (_currentTween)
			_currentTween.kill();
			_currentTween = value;
		}
		protected function get masked():Boolean 
		{
			if (maskBox.parent) return true;
			else return false
		}
		
		protected function set masked(value:Boolean):void 
		{
			if (value)
			{
				super.addChild(maskBox);
				mask = maskBox;
			}
			else if (masked)
			{
				super.removeChild(maskBox);
				mask = null;
				
			}
		}
		
	
		
	}

}