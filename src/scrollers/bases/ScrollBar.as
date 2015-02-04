package scrollers.bases 
{
	import constants.AlignType;
	import constants.Direction;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.security.SignerTrustSettings;
	import scrollers.propsObjects.ScrollerViewProperies;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollBar extends ScrollViewBase 
	{
		
		private var _indicator:InteractiveObject;
		private var _background:DisplayObject;
		private var _proportion:Number=0.3;
		private var dragController:Controller;
		private var tapController:Controller;
		public function ScrollBar(indicatorView:DisplayObject=null,bg:DisplayObject=null) 
		{
			if (!indicatorView) 
			{
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(0x434343);
				sprite.graphics.drawRect(0, 0, 50, 100);
				sprite.graphics.endFill();
				indicatorView = sprite;
			}
			super(indicatorView);
			
			dragController = new Controller();
			dragController.addEventListener(ControllerEvent.GESSTURE_UPDATE, onDragg);
			dragController.addEventListener(ControllerEvent.GESSTURE_COMPLETE, onDraggComplete);
			
			tapController = new Controller(this);
			tapController.addEventListener(ControllerEvent.TAP, onTap);
			tapController.addEventListener(ControllerEvent.SWIPE, onSwipe);
			
			masked = false;
			
			indicator = indicatorView as InteractiveObject;
			background = bg;
			updateMethod();
			
		}
		
		
		//PUBLIC:
		override public function get draggable():Boolean 
		{
			return dragController.enable;
		}
		
		override public function set draggable(value:Boolean):void 
		{
			dragController.enable = value;
			
		}
		override public function get width():Number 
		{
			return super.width;
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			updateMethod();
		}
		override public function set width(value:Number):void 
		{
			super.width = value;
			updateMethod();
		}
		public function get background():DisplayObject 
		{
			return _background;
		}
		
		public function set background(value:DisplayObject):void 
		{
			if (_background) removeElement(_background);
			_background = value;
			//tapController.item = value as InteractiveObject;
			if (value) 
			{
				updateMethod();
				addElement(_background);
				addElement(content);
			}
		}
		public function get indicator():InteractiveObject 
		{
			return _indicator;
		}
		
		public function set indicator(value:InteractiveObject):void 
		{
			if (!value) 
			{
				throw new Error('indicator instance must be not null');
				return;
			}
			if (_indicator) removeElement(_indicator);
			_indicator = value;
			dragController.item = value;
			addElement(indicator);
		}
		//EVENTS:
		
		
		
		private function onDragg(e:ControllerEvent):void 
		{
			var res:int;
			if(isVertical)
			res = offset + e.gessture.lastStepY;
			else
			res = offset + e.gessture.lastStepX;
			if (controller) controller.scrollTo(res / maxOffset, 0, null, this, true);
			else 
			offset = res;
		}
		private function onDraggComplete(e:ControllerEvent):void 
		{
			if (controller)
			{
				if (controller.props.snapToPages)
				controller.snap();
			}
		}
		private function onSwipe(e:ControllerEvent):void 
		{
			
			//trace(this,e.type);
			if (!props.swipeEnabled) return;
			var res:Number;
			if (isVertical)
			{
				if (e.gessture.vectorDirection == Direction.DOWN || e.gessture.vectorDirection == Direction.UP)
				res = (_offset + e.gessture.distanceY)/maxOffset;
			}
			else
			{
				if (e.gessture.vectorDirection == Direction.LEFT || e.gessture.vectorDirection == Direction.RIGHT)
				res = (_offset + e.gessture.distanceX)/maxOffset;
			}
			scrollTo(res, props.swipeOverTakeDuration);
		}
		private function onTap(e:ControllerEvent):void 
		{
			if (!props.interactiveFlor) return;
			var localP:Point = globalToLocal(new Point(e.gessture.x, e.gessture.y));
			if (isVertical)
			{
				if (localP.y > indicator.y+indicator.height) position += props.scrollStep;
				else if (localP.y < indicator.y)  position -= props.scrollStep;
				//else indicator tap?
			}
			else 
			{
				if (localP.x > indicator.x+indicator.width) position += props.scrollStep;
				else if (localP.x < indicator.x)  position -= props.scrollStep;
			}
		}
		
		
		//PRIVATE:
		//main overrides:
		override protected function updateMethod():void 
		{
			var alignX:String = props.alignX;
			var alignY:String = props.alignY;
			var offsetX:int = props.offsetX;
			var offsetY:int = props.offsetY;
			var offsetBegin:int = props.offsetBegin;
			var offsetEnd:int = props.offsetEnd;
			if(isVertical)
			{
				//indicator.width = width;
				indicator.height = (height - offsetX*2 - offsetBegin-offsetEnd) * proportion;
				if (background)
				{
					background.x = background.y = 0;
					background.width = width;
					background.height = height;
				}
				
				switch(alignX)
				{
					case AlignType.LEFT:
						indicator.x = offsetX;
						break;
					case AlignType.CENTER:
						indicator.x = offsetX + (width - indicator.width) / 2;
						break;
					case AlignType.RIGHT:
						indicator.x = offsetX + width - indicator.width;
						break;
				}
				indicator.y = offsetBegin + offsetY+ position * maxOffset;
			}
			else
			{
				indicator.width = (width - offsetY*2 - offsetBegin-offsetEnd) * proportion;
				//indicator.height = height;
				if (background)
				{
					background.x = background.y = 0;
					background.width = width;
					background.height = height;
				}
				
				indicator.x = offsetBegin + offsetX + position * maxOffset;
				switch(alignY)
				{
					case AlignType.TOP:
						indicator.y = offsetY;
						break;
					case AlignType.MIDDLE:
						indicator.y = offsetY + (height - indicator.height) / 2;
						break;
					case AlignType.BOTTOM:
						indicator.y = offsetY + height - indicator.height;
						break;
				}
			}
			
		}
		override protected function get _offset():int 
		{
			if(isVertical)
			return indicator.y-props.offsetY- props.offsetBegin;
			else
			return indicator.x-props.offsetX- - props.offsetBegin;
		}
		
		override protected function set _offset(value:int):void 
		{
			if(isVertical)
			indicator.y = value + props.offsetY + props.offsetBegin;
			else
			indicator.x = value + props.offsetX + props.offsetBegin;
		}
		override public function get maxOffset():int 
		{
			if(isVertical)
			return height - props.offsetY*2 - indicator.height - props.offsetBegin- props.offsetEnd;
			else
			return width - props.offsetX*2 - indicator.width - props.offsetBegin- props.offsetEnd;
		}
		override public function get proportion():Number 
		{
			return _proportion;
		}
		
		public function set proportion(value:Number):void 
		{
			_proportion = value;
			updateMethod();
		}
		
		
		
		
		
		
	}

}