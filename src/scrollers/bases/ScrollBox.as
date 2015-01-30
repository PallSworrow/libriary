package scrollers.bases 
{
	import layouts.glifs.Layout;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollBox extends ScrollViewBase 
	{
		private var dragController:Controller;
		
		public function ScrollBox() 
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
		override public function get maxOffset():int 
		{
			return super.maxOffset;
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
		private function onDragg(e:ControllerEvent):void 
		{
			if(isVertical)
			offset -= e.gessture.lastStepY;
			else
			offset -= e.gessture.lastStepX;
		}
	}

}