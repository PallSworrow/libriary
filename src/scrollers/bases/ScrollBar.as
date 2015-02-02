package scrollers.bases 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollBar extends ScrollViewBase 
	{
		private var indicator:InteractiveObject;
		private var bg:DisplayObject;
		private var _proportion:Number=0.3;
		private var dragController:Controller;
		public function ScrollBar(indicatorView:InteractiveObject) 
		{
			super(indicatorView);
			indicator = indicatorView;
			dragController = new Controller(this);
			dragController.addEventListener(ControllerEvent.GESSTURE_UPDATE, onDragg);
			updateMethod();
			
		}
		
		private function onDragg(e:ControllerEvent):void 
		{
			if(isVertical)
			offset += e.gessture.lastStepY;
			else
			offset += e.gessture.lastStepX;
		}
		override public function get draggable():Boolean 
		{
			return dragController.enable;
		}
		
		override public function set draggable(value:Boolean):void 
		{
			dragController.enable = value;
			
		}
		override protected function updateMethod():void 
		{
			if(isVertical)
			{
				indicator.height = height * proportion;
				indicator.y = position * maxOffset;
				indicator.x = 0;
			}
			else
			{
				indicator.width = width * proportion;
				indicator.x = position * maxOffset;
				indicator.y = 0;
			}
			
		}
		
		//main overrides:
		override protected function get _offset():int 
		{
			if(isVertical)
			return indicator.y;
			else
			return indicator.x;
		}
		
		override protected function set _offset(value:int):void 
		{
			if(isVertical)
			indicator.y = value;
			else
			indicator.x = value;
		}
		override public function get maxOffset():int 
		{
			if(isVertical)
			return height - indicator.height;
			else
			return width - indicator.width;
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