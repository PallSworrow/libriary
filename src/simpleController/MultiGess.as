package simpleController 
{
	import antares.ServerConnection;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import simpleController.interfaces.ImultiTouchGess;
	/**
	 * ...
	 * @author 
	 */
	public class MultiGess implements ImultiTouchGess
	{
		private var list:Vector.<Gess>;
		private var points:Vector.<Point>;
	
		
		private var summ:Gess;
		//gesstures Summ;
		//private var zoomX:Number;
		//private var zoomY:Number;
		public function MultiGess(gess:Gess, id:String,controllerParams:ControllerParams) 
		{
			list = new Vector.<Gess>;
			points = new Vector.<Point>;
			
			list.push(gess);
			points.push(new Point(gess.x, gess.y));
			
			summ = new Gess(gess.x, gess.y, id, controllerParams);
			//zoomX = zoomY = 1;
		}
		public function addGess(gess):void
		{
			var index:int = list.indexOf(gess);
			if (index == -1)
			{
				list.push(gess);
				points.push(new Point(gess.x, gess.y));
			}
		}
		public function removeGess(gess:Gess):void
		{
			var index:int = list.indexOf(gess);
			if (index != -1)
			{
				list.splice(index, 1);
				points.splice(index, 1);
			}
		}
		public function update():void
		{
			var gess:Gess;
			var pt:Point;
			
			var deltaX:int=0;
			var deltaY:int = 0;
			
			var currRect:Rectangle = new Rectangle();//x-left, width - right, y - top, height - bottom
			var prevRect:Rectangle = new Rectangle();//x-left, width - right, y - top, height - bottom
			for (var i:int = list.length - 1; i >= 0 ; i--) 
			{
				gess = list[i];
				pt = points[i];
				
				deltaX = gess.x - pt.x;
				deltaY = gess.y - pt.y;
				
				if (currRect.x > gess.x) currRect.x = gess.x;
				if (currRect.width < gess.x) currRect.width = gess.x;
				if (currRect.y > gess.y) currRect.y = gess.y;
				if (currRect.height < gess.y) currRect.height = gess.y;
				
				points[i].x = list[i].x;
				points[i].y = list[i].y;
			}
			summ.update(summ.x + deltaX, summ.y + deltaY);
			trace('touches rect: ' + currRect);
		}
		public function complete():void//swipe/tap?
		{
			
		}
		
		/* INTERFACE simpleController.interfaces.ImultiTouchGess */
		
		public function get numTouches():int 
		{
			return list.length;
		}
		
		public function get lastStepX():int 
		{
			return summ.lastStepX;
		}
		
		public function get lastStepY():int 
		{
			return summ.lastStepY;
		}
		
		public function get trackLength():int 
		{
			return summ.trackLength;
		}
		
		public function get distance():int 
		{
			return summ.distance;
		}
		
		public function get distanceX():int 
		{
			return summ.distanceX;
		}
		
		public function get distanceY():int 
		{
			return summ.distanceY;
		}
		
		public function get vectorDirection():String 
		{
			return summ.vectorDirection;
		}
		
		public function get duration():int 
		{
			return summ.duration;
		}
		
		public function get x():int 
		{
			return summ.x;
		}
		
		public function get y():int 
		{
			return summ.y;
		}
	}
	

}