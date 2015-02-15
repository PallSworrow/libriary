package simpleController 
{
	import simpleController.ControllerParams;
	import simpleController.events.ControllerEvent;
	import simpleController.interfaces.Igessture;
	import constants.Direction;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author 
	 */
	internal class Gess implements Igessture
	{
		private var startPoint:Point
		private var currPoint:Point
		private var lastStep:Point;
		
		private var length:int;
		private var swipeFailed:Boolean;
		private var tapFailed:Boolean;
	
		private var swipeTimer:uint;
		
		private var date:Date;
		private var props:ControllerParams;
		private var _status:String;
		private var _id:String;
		public function Gess(x:int, y:int, id:String, params:ControllerParams) 
		{
			_id = id;
			_status = 'inited';
			props = params;
//			trace(this);
			startPoint = new Point(x, y);
			currPoint = new Point(x, y);
			lastStep = new Point();
			length = 0;
			swipeFailed = false;
			tapFailed = false;
			date = new Date();
			swipeTimer = setTimeout(failSwipe, props.swipeMaxDuration);
		}
		internal function dispose():void
		{
			props = null;
			date = null;
		}
		public function update(newX:int, newY:int):void 
		{
			_status = 'moving';
			lastStep.x = newX - currPoint.x;
			lastStep.y = newY - currPoint.y;
			
			currPoint.x = newX;
			currPoint.y = newY;
			length += lastStep.length;
			
			
		}
		
		public function complete():String 
		{
			_status = 'complete';
			clearTimeout(swipeTimer);

			if (distance < props.swipeMinDistance) failSwipe();
			if (distance > props.tapMaxdistance) tapFailed = true;
			
			if (!swipeFailed) return ControllerEvent.SWIPE;
			if (!tapFailed) return ControllerEvent.TAP;
			return null;
		}
		
		/* INTERFACE controller.interfaces.Igessture */
		
		public function get duration():int 
		{
			return (new Date()).getTime() - date.getTime();
		}
		//ENGINE:
		private function failSwipe():void
		{
			swipeFailed = true;
		}
		
		//GETTERS:
		public function get vectorDirection():String 
		{
			var res:String;
			if (distanceX >  distance * 0.7) res = Direction.RIGHT;
			if (distanceX < -distance * 0.7) res = Direction.LEFT;
			if (distanceY >  distance * 0.7) res = Direction.DOWN;
			if (distanceY < -distance * 0.7) res = Direction.UP;
			return res;
		}
		
		public function get distanceX():int 
		{
			return currPoint.x - startPoint.x;
		}
		
		public function get distanceY():int 
		{
			return currPoint.y - startPoint.y;
		}
		
		public function get isSwipeFailed():Boolean 
		{
			return swipeFailed;
		}
		
		public function get isTapFailed():Boolean 
		{
			return tapFailed;
		}
		
		public function get lastStepX():int 
		{
			return lastStep.x;
		}
		
		public function get lastStepY():int 
		{
			return lastStep.y;
		}
		
		public function get trackLength():int 
		{
			return length;
		}
		
		public function get distance():int 
		{
			return Point.distance(startPoint,currPoint);
		}
		public  function  get x():int
		{
			return currPoint.x;
		}
		public  function  get y():int
		{
			return currPoint.y;
		}
		
		public function get status():String 
		{
			return _status;
		}
		
		public function get id():String 
		{
			return _id;
		}
	}

}