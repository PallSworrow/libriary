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
		public function Gess(params:ControllerParams) 
		{
			startPoint = new Point();
			currPoint = new Point();
			lastStep = new Point();
			props = params;
		}
		internal function dispose():void
		{
			_status = 'disposed';
			date = null;
			clearTimeout(swipeTimer);
		}
		public function init(x:int, y:int, id:String):void
		{
			_id = id;
			_status = 'inited';
//			trace(this);
			startPoint.x = x;
			startPoint.y = y;
			currPoint.x = x;
			currPoint.y = y;
			lastStep.x = 0;
			lastStep.y = 0;
			length = 0;
			swipeFailed = false;
			tapFailed = false;
			date = new Date();
			swipeTimer = setTimeout(failSwipe, props.swipeMaxDuration);
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
		
		
		
		//ENGINE:
		private function failSwipe():void
		{
			swipeFailed = true;
		}
		
		/* INTERFACE controller.interfaces.Igessture */
		//GETTERS:
		public function get duration():int 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return (new Date()).getTime() - date.getTime();
		}
		public function get vectorDirection():String 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			var res:String;
			if (distanceX >  distance * 0.7) res = Direction.RIGHT;
			if (distanceX < -distance * 0.7) res = Direction.LEFT;
			if (distanceY >  distance * 0.7) res = Direction.DOWN;
			if (distanceY < -distance * 0.7) res = Direction.UP;
			return res;
		}
		
		public function get distanceX():int 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return currPoint.x - startPoint.x;
		}
		
		public function get distanceY():int 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return currPoint.y - startPoint.y;
		}
		
		public function get isSwipeFailed():Boolean 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return swipeFailed;
		}
		
		public function get isTapFailed():Boolean 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return tapFailed;
		}
		
		public function get lastStepX():int 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return lastStep.x;
		}
		
		public function get lastStepY():int 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return lastStep.y;
		}
		
		public function get trackLength():int 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return length;
		}
		
		public function get distance():int 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return Point.distance(startPoint,currPoint);
		}
		public  function  get x():int
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return currPoint.x;
		}
		public  function  get y():int
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return currPoint.y;
		}
		
		public function get status():String 
		{
			return _status;
		}
		
		public function get id():String 
		{
			if (_status == 'disposed') throw new Error('this gesture has been disposed');
			return _id;
		}
	}

}