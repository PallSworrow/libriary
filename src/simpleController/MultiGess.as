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
		private var _state:String;
		private var list:Vector.<Gess>;
		private var points:Array;
	
		private var rect:Rectangle;
		private var temprect:Rectangle;
		private var zoom:Number;
		private var summ:Gess;
		private var _center:Point;	
		private var diameter:Number;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _prevScaleX:Number;
		private var _prevScaleY:Number;
		private var _scaleStepX:Number;
		private var _scaleStepY:Number;
		
		private var _scale:Number;
		private var _prevScale:Number;
		private var _scaleStep:Number;
		
		
		private var params:ControllerParams
		private var _rotationStep:Number;
		private var _rotation:Number;
		public function MultiGess(controllerParams:ControllerParams) 
		{
			params = controllerParams;
			list = new Vector.<Gess>;
			points = [];
			summ = new Gess(controllerParams);
			rect = new Rectangle();
			temprect = new Rectangle();
			_center = new Point();
			//summ = new Gess(gess.x, gess.y, id, controllerParams);
			_state = 'disposed';
		}
		public function init():void
		{
			_state = 'inited';
			_scaleX = _scaleY = _prevScaleX = _prevScaleY = _scale = _prevScale = 1;
			_rotation = 0;
			_rotationStep = 0;
			_center.x=0;
			_center.y=0;
			summ.init(0, 0,'internal');
		}
		public function addGess(gess:Gess):void
		{
			var index:int = list.indexOf(gess);
			if (index == -1)
			{
				list.push(gess);
				points.push({x:gess.x, y:gess.y});
			}
			updateRect();
			for (var i:int = points.length - 1; i >= 0 ; i--) 
			{
				points[i].angle = getAngle(points[i].x, points[i].y);
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
			updateRect();
			for (var i:int = points.length - 1; i >= 0 ; i--) 
			{
				points[i].angle = getAngle(points[i].x, points[i].y);
			}
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
				_center.x = _center.y = 0;
				diameter = 1;
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
			_center.x = rect.x + rect.width  / 2;
			_center.y = rect.y + rect.height / 2;
			if (rect.width < params.minTouchDistance) rect.width =  params.minTouchDistance;
			if (rect.height < params.minTouchDistance) rect.height =  params.minTouchDistance;
			
			diameter = Math.sqrt(rect.width * rect.width + rect.height * rect.height);
			
		}
		private function getAngle(x:int, y:int):Number
		{
			if (list.length == 1) return 0;
			return 180 * Math.atan2(y -_center.y, x - _center.x) / Math.PI;
		}
		public function update():void
		{
			_state = 'moving';
			var gess:Gess;
			var pt:Object;
			var listLength = list.length;
			
			var deltaX:Number=0;
			var deltaY:Number = 0;
			var newD:Number;//new diameter
			temprect.x = list[0].x;
			temprect.y = list[0].y;
			temprect.width = list[0].x;
			temprect.height = list[0].y;
			_prevScaleX = _scaleX;
			_prevScaleY = _scaleY;
			_prevScale = _scale;
			for (var i:int = listLength - 1; i >= 0 ; i--) 
			{
				gess = list[i];
				pt = points[i];
				//calculate move:
				//delta:
				deltaX += gess.x - pt.x;
				deltaY += gess.y - pt.y;
				//save:
				points[i].x = gess.x;
				points[i].y = gess.y;
				//calculate zoom:
				//current rect:
				if (gess.x < temprect.x) temprect.x = gess.x;
				if (gess.y < temprect.y) temprect.y = gess.y;
				if (gess.x > temprect.width) temprect.width = gess.x;
				if (gess.y > temprect.height) temprect.height = gess.y;
				
				
			}
			//apply zoom
			temprect.width  -= temprect.x;
			temprect.height -= temprect.y;
			
			_center.x = temprect.x + temprect.width  / 2;
			_center.y = temprect.y + temprect.height / 2;
			
			if (temprect.width < params.minTouchDistance) temprect.width =  params.minTouchDistance;
			if (temprect.height < params.minTouchDistance) temprect.height =  params.minTouchDistance;
			
			_scaleStepX = temprect.width / rect.width;
			_scaleX *= _scaleStepX;
			_scaleStepY = temprect.height / rect.height
			_scaleY *= _scaleStepY;
			newD = Math.sqrt(temprect.width * temprect.width + temprect.height * temprect.height);
			
			_scaleStep = newD / diameter;
			_scale *= _scaleStep;
			diameter = newD;
			//save rect(zoom)
			rect.x = temprect.x;
			rect.y = temprect.y;
			rect.width = temprect.width;
			rect.height = temprect.height;
			//apply & save move
			summ.update(summ.x + deltaX / listLength, summ.y + deltaY / listLength);
			
			//caclulate rotation:
			if (listLength < 2) return;
			var angle:Number;
			var delta:Number=0;
			var dif:Number;
			for (var j:int = 0; j < listLength; j++) 
			{
				pt = points[j];
				angle =  getAngle(pt.x, pt.y);
                dif = angle - pt.angle;
                dif += (dif > 180) ? -360 : (dif < -180) ? 360 : 0;
				delta += dif;
				points[j].angle = angle;
			}
			_rotationStep = Math.round(100 * delta / listLength) / 100;
			_rotation += _rotationStep;
		}
		public function complete():String//swipe/tap?
		{
			return summ.complete();
		}
		public function dispose():void
		{
			summ.dispose();
			_state = 'disposed';
		}
		
		/* INTERFACE simpleController.interfaces.ImultiTouchGess */
		
		public function get rotationStep():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _rotationStep;
		}
		
		public function get rotation():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _rotation;
		}
		
		/* INTERFACE simpleController.interfaces.ImultiTouchGess */
		
		public function get scaleX():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleX;
		}
		
		public function get scaleY():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleY;
		}
		
		public function get scale():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scale;
		}
		
		public function get scaleStepX():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleStepX;
		}
		
		public function get scaleStepY():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleStepY;
		}
		
		public function get scaleStep():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleStep;
		}
		/* INTERFACE simpleController.interfaces.ImultiTouchGess */
		
		public function get numTouches():int 
		{
			return list.length;
		}
		
		public function get lastStepX():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.lastStepX;
		}
		
		public function get lastStepY():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.lastStepY;
		}
		
		public function get trackLength():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.trackLength;
		}
		
		public function get distance():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.distance;
		}
		
		public function get distanceX():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.distanceX;
		}
		
		public function get distanceY():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.distanceY;
		}
		
		public function get vectorDirection():String 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.vectorDirection;
		}
		
		public function get duration():int 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return summ.duration;
		}
		
		public function get x():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			
			return _center.x;
		}
		
		public function get y():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			
			return _center.y;
		}
		
		public function get state():String 
		{
			return _state;
		}
	}
	

}