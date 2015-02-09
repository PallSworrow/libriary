package scrollers.bases 
{
	import constants.Direction;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.System;
	import scrollers.events.ScrollerEvent;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ContentScroller extends ScrollViewBase 
	{
		
		private var dragController:Controller;
		private var tapController:Controller;
		private var bg:Sprite;
		private var container:DisplayObjectContainer;
		
		public function ContentScroller(content:DisplayObject) 
		{
			super(content);
			
			/**
			 * Этот контрлер позволяет перетаскивать содержимое с помощью мыши или тача.
			 * для прокрутки контроллера используется вызов метода scrollTo
			 * Если у контроллерер предполагает привязку к страницам(snapToPage), 
			 * то, чтобы избежать постоянных вызовов snap(), в параметры передается флаг,
			 * который блочит привязку для текущей прокрутки. 
			 * И тольк когда drag жест будет завершен выполняется вызов snap(), предварительно проверив, требуется ли он контроллеру.
			 */
			dragController = new Controller(this);
			dragController.addEventListener(ControllerEvent.GESSTURE_UPDATE, onDragg);
			dragController.addEventListener(ControllerEvent.GESSTURE_COMPLETE, onDraggComplete);
			dragController.addEventListener(ControllerEvent.SWIPE, onSwipe);
			
			updateMethod();
		}
		
		
		//PUBLIC:
		
		override public function get width():Number 
		{
			
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
		}
		override public function get draggable():Boolean 
		{
			return dragController.enable;
		}
		
		override public function set draggable(value:Boolean):void 
		{
			dragController.enable = value;
			
		}
		
		//EVENTS:
		private function onSwipe(e:ControllerEvent):void 
		{
			//trace(this,e.type);
			if (!props.swipeEnabled) return;
			var res:Number;
			if (isVertical)
			{
				if (e.gessture.vectorDirection == Direction.DOWN || e.gessture.vectorDirection == Direction.UP)
				res = (_offset - e.gessture.distanceY)/maxOffset;
			}
			else
			{
				if (e.gessture.vectorDirection == Direction.LEFT || e.gessture.vectorDirection == Direction.RIGHT)
				res = (_offset - e.gessture.distanceX)/maxOffset;
			}
			scrollTo(res, props.swipeOverTakeDuration);
		}
	
		
		private function onDragg(e:ControllerEvent):void 
		{
			var res:int;
			if(isVertical)
			res = offset - e.gessture.lastStepY;
			else
			res = offset - e.gessture.lastStepX;
			
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
		//PRIVATE:
		private function updateBg():void
		{
			if (props.interactiveFlor && !bg)
			{
				bg = new Sprite();
				addElement(bg);
				addElement(content);
			}
			if (!props.interactiveFlor && bg)
			{
				removeChild(bg);
				bg = null;
			}
			if (bg)
			{
				if (bg.width == width && bg.height == height) return;
				bg.graphics.clear();
				bg.graphics.beginFill(0x000000, 0);
				bg.graphics.drawRect(0, 0, width, height);
				bg.graphics.endFill();
			}
		}
		override protected function updateMethod():void 
		{
			if (isVertical)
			{
				content.x = props.offsetX;
				content.width = width - props.offsetX * 2;
			}
			else
			{
				content.y = props.offsetY;
				content.height = height - props.offsetY * 2;
			}
			_offset = _offset;
			updateBg();
		}
		override protected function get _offset():int 
		{
			if (isVertical)
			return props.offsetBegin + props.offsetY - content.y;
			else
			return props.offsetBegin + props.offsetX - content.x;
		}
		
		override protected function set _offset(value:int):void 
		{
			//return
			if (value > maxOffset) value = maxOffset;
			if (value < 0) value = 0;
			
			if (isVertical)
			{
				//content.x = 0;
				content.y = props.offsetBegin + props.offsetY - value;
			}
			else
			{
				content.x = props.offsetBegin + props.offsetX - value;
				//content.y = 0;
			}
		}
		
		
		override public function get maxOffset():int 
		{
			if (isVertical)
			return content.height - height + props.offsetEnd + props.offsetBegin + props.offsetY*2;
			else 
			return content.width -  width +  props.offsetEnd + props.offsetBegin + props.offsetX*2;
		}
		override public function get proportion():Number 
		{
			if(isVertical)
			return height/(content.height + props.offsetEnd - props.offsetBegin) ;
			else
			return width/(content.width  + props.offsetEnd - props.offsetBegin);
		}
		
	}

}