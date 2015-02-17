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
		private var state:String;
		private var list:Vector.<Gess>;
		private var points:Vector.<Point>;
	
		private var rect:Rectangle;
		private var temprect:Rectangle;
		private var zoom:Number;
		private var summ:Gess;
		//gesstures Summ;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _prevScaleX:Number;
		private var _prevScaleY:Number;
		public function MultiGess(controllerParams:ControllerParams) 
		{
			list = new Vector.<Gess>;
			points = new Vector.<Point>;
			summ = new Gess(controllerParams);
			rect = new Rectangle();
			temprect = new Rectangle();
			//summ = new Gess(gess.x, gess.y, id, controllerParams);
			state = 'disposed';
		}
		public function init():void
		{
			state = 'inited';
			_scaleX = _scaleY = _prevScaleX = _prevScaleY = 1;
			summ.init(0, 0,'internal');
		}
		public function addGess(gess:Gess):void
		{
			var index:int = list.indexOf(gess);
			if (index == -1)
			{
				list.push(gess);
				points.push(new Point(gess.x, gess.y));
			}
			updateRect();
		}
		public function removeGess(gess:Gess):void
		{
			var index:int = list.indexOf(gess);
			if (index != -1)
			{
				list.splice(index, 1);
				points.splice(index, 1);
			}
			updateRect();
		}
		private function updateRect():void
		{
			var l:int = list.length;
			if (l == 0)
			{
				rect.x = 0;
				rect.y = 0;
				rect.width = 0;
				rect.height = 0;
				return;
			}
			var gess:Gess;
			rect.x = list[0].x;
			rect.y = list[0].y;
			rect.width = list[0].x;
			rect.height = list[0].y;
			for (var i:int = l - 1; i >= 1 ; i--) 
			{
				gess = list[i];
				if (gess.x < rect.x) rect.x = gess.x;
				if (gess.y < rect.y) rect.y = gess.y;
				if (gess.x > rect.width) rect.width = gess.x;
				if (gess.y > rect.height) rect.height = gess.y;
				
			}
			rect.width -= rect.x;
			rect.height -= rect.y;
			
			if (rect.width < 1) rect.width =  1;
			if (rect.height < 1) rect.height =  1;
			trace('rect update: ' + rect);
		}
		public function update():void
		{
			state = 'moving';
			var gess:Gess;
			var pt:Point;
			var listLength = list.length;
			
			var deltaX:int=0;
			var deltaY:int = 0;
			temprect.x = list[0].x;
			temprect.y = list[0].y;
			temprect.width = list[0].x;
			temprect.height = list[0].y;
			_prevScaleX = _scaleX;
			_prevScaleY = _scaleY;
			for (var i:int = listLength - 1; i >= 0 ; i--) 
			{
				gess = list[i];
				pt = points[i];
				//calculate move:
				//delta:
				deltaX += gess.x - pt.x;
				deltaY += gess.y - pt.y;
				//save:
				points[i].x = list[i].x;
				points[i].y = list[i].y;
				//calculate zoom:
				//current rect:
				if (gess.x < temprect.x) temprect.x = gess.x;
				if (gess.y < temprect.y) temprect.y = gess.y;
				if (gess.x > temprect.width) temprect.width = gess.x;
				if (gess.y > temprect.height) temprect.height = gess.y;
				
				
			}
			//save rect//zoom:
			temprect.width  -= temprect.x;
			temprect.height -= temprect.y;
			_scaleX = temprect.width / rect.width;
			_scaleY =temprect.height / rect.height;
			trace(this, '\n', 'prev:' + rect + '\n', 'curr:', temprect);
			trace('scale:',_scaleX,_scaleX, scale);
			/*rect.x = temprect.x;
			rect.y = temprect.y;
			rect.width = temprect.width;
			rect.height = temprect.height;
			if (rect.width < 1) rect.width =  1;
			if (rect.height < 1) rect.height =  1;*/
			//save move
			summ.update(summ.x + deltaX/listLength, summ.y + deltaY/listLength);
		}
		public function complete():String//swipe/tap?
		{
			return summ.complete();
		}
		public function dispose():void
		{
			summ.dispose();
			state = 'disposed';
		}
		
		/* INTERFACE simpleController.interfaces.ImultiTouchGess */
		
		public function get scaleX():Number 
		{
			return _scaleX;
		}
		
		public function get scaleY():Number 
		{
			return _scaleY;
		}
		
		public function get scale():Number 
		{
			return (_scaleX+_scaleY)/2;
		}
		
		public function get scaleStepX():Number 
		{
			return 1+_scaleX - _prevScaleX;
		}
		
		public function get scaleStepY():Number 
		{
			return 1+_scaleY - _prevScaleY;
		}
		
		public function get scaleStep():Number 
		{
			return (scaleStepX+scaleStepY)/2;
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
			return rect.x+rect.width/2;
		}
		
		public function get y():int 
		{
			return rect.y + rect.height/2;
		}
	}
	

}