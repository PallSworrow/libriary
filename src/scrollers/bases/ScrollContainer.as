package scrollers.bases 
{
	import flash.display.DisplayObject;
	import layouts.glifs.Layout;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollContainer extends ScrollViewBase 
	{
		private var dragController:Controller;
		
		public function ScrollContainer() 
		{
			super(new Layout());
			dragController = new Controller(this);
			dragController.addEventListener(ControllerEvent.GESSTURE_UPDATE, onDragg);
		}
		override protected function get _offset():int 
		{
			if (isVertical)
			return - content.y;
			else
			return - content.x;
		}
		
		override protected function set _offset(value:int):void 
		{
			if (value > maxOffset) value = maxOffset;
			if (value < 0) value = 0;
			
			if (isVertical)
			{
				content.x = 0;
				content.y = -value;
			}
			else
			{
				content.x = -value;
				content.y = 0;
			}
		}
		
		private function onDragg(e:ControllerEvent):void 
		{
			if(isVertical)
			offset -= e.gessture.lastStepY;
			else
			offset -= e.gessture.lastStepX;
		}
		
		//PUBLic
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			return layout.addChild(child);
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			return layout.addChildAt(child, index);
		}
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			return layout.removeChild(child);
		}
		override public function removeChildAt(index:int):DisplayObject 
		{
			return layout.removeChildAt(index);
		}
		override public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void 
		{
			layout.removeChildren(beginIndex, endIndex);
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			if (isVertical)
			layout.width = value;
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			if (!isVertical)
			layout.height = value;
		}
		override public function get maxOffset():int 
		{
			if (isVertical)
			return content.height - height;
			else 
			return content.width - width;
		}
		override public function get proportion():Number 
		{
			if(isVertical)
			return content.height / height;
			else
			return content.width / width;
		}
		override public function get draggable():Boolean 
		{
			return dragController.enable;
		}
		
		override public function set draggable(value:Boolean):void 
		{
			dragController.enable = value;
			
		}
		public function get layout():Layout
		{
			return content as Layout;
		}
	}

}