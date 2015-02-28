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
		private var pointAngDeltas:Array;
	
		private var summ:Gess;
		private var _center:Point;	
		private var tempCenter:Point;
		private var radius:Number;
		
		/*private var _scaleX:Number;
		private var _scaleY:Number;
		private var _prevScaleX:Number;
		private var _prevScaleY:Number;
		private var _scaleStepX:Number;
		private var _scaleStepY:Number;
		*/
		private var _scale:Number;
		private var _prevScale:Number;
		private var _scaleStep:Number;
		
		private var _rotation:Number;
		private var _prevRotation:Number;
		private var _rotationStep:Number;
		
		private var params:ControllerParams
		public function MultiGess(controllerParams:ControllerParams) 
		{
			params = controllerParams;
			list = new Vector.<Gess>;
			pointAngDeltas = [];
			
			summ = new Gess(controllerParams);
			//rect = new Rectangle();
			//temprect = new Rectangle();
			_center = new Point();
			tempCenter = new Point();
			
			//summ = new Gess(gess.x, gess.y, id, controllerParams);
			_state = 'disposed';
		}
		public function init():void
		{
			_state = 'inited';
			
			_scale = _prevScale = 1;
			_rotation = 0;
			_rotationStep = 0;
			summ.init(0, 0,'internal');
		}
		public function addGess(gess:Gess):void
		{
			var index:int = list.indexOf(gess);
			if (index == -1)
			{
				list.push(gess);
				pointAngDeltas.push();
			}
			_update(false);
		}
		public function removeGess(gess:Gess):void
		{
			var index:int = list.indexOf(gess);
			if (index != -1)
			{
				list.splice(index, 1);
				pointAngDeltas.splice(index, 1);
			}
			_update(false);
		}
		private function _update(detectChanges:Boolean):void
		{
			var gess:Gess;
			var pointAngle:Number;
			var listLength:int = list.length;
			
			var deltaX:Number=0;
			var deltaY:Number = 0;
			var delta:Number=0;
			
			var angle:Number;
			var dif:Number;
			var tempRad:Number=0;
			var maxRad:Number=params.minTouchDistance;
			tempCenter.x = 0;
			tempCenter.y = 0;
			
			_prevScale = _scale;
			_prevRotation = _rotation;
			
			//caclulate gess center
			for (var i:int = listLength - 1; i >= 0 ; i--) 
			{
				gess = list[i];
			
				tempCenter.x += gess.x;
				tempCenter.y += gess.y;
			}
			tempCenter.x = tempCenter.x / listLength;
			tempCenter.y = tempCenter.y / listLength;
			
			//caclulate rotation and scale
			for ( i = listLength - 1; i >= 0 ; i--) 
			{
				gess = list[i];
				tempRad = Math.sqrt(Math.pow(gess.x - tempCenter.x, 2) + Math.pow(gess.y - tempCenter.y, 2));
				if (maxRad < tempRad) maxRad = tempRad;
				pointAngle = pointAngDeltas[i];
				
				if (listLength == 1)
				angle = 0;
				else
				angle = 180 * Math.atan2(gess.y -tempCenter.y, gess.x - tempCenter.x) / Math.PI;
				
				if (pointAngle is Number && tempRad>params.minTouchDistance)
				{
					dif = angle - pointAngle;
					dif += (dif > 180) ? -360 : (dif < -180) ? 360 : 0;
					delta += dif;
				}
				pointAngDeltas[i] = angle;
			}
			delta = delta / listLength;
			deltaX = tempCenter.x - _center.x;
			deltaY = tempCenter.y - _center.y;
			
			//apply
			if(detectChanges)
			{
				//move:
				summ.update(summ.x + deltaX, summ.y + deltaY);
				//scale:
				if (radius == 0)
				_scaleStep = 1;
				else 
				_scaleStep = Math.round(100*maxRad / radius)/100;
					
				_scale *= _scaleStep;
				//rotate:
				_rotationStep = Math.round(10*delta) / 10;
				_rotation += _rotationStep;
			}
			//save:
			_center.x = tempCenter.x;
			_center.y = tempCenter.y;
			radius = maxRad;
			//angles are saved in iteration
			
		}
		private function getAngle(x:int, y:int):Number
		{
			if (list.length == 1) return 0;
			return 180 * Math.atan2(y -_center.y, x - _center.x) / Math.PI;
		}
		public function update():void
		{
			_state = 'moving';
			_update(true);
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
		
		/*public function get scaleX():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleX;
		}
		
		public function get scaleY():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleY;
		}*/
		
		public function get scale():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scale;
		}
		
		/*public function get scaleStepX():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleStepX;
		}
		
		public function get scaleStepY():Number 
		{
			if (_state == 'disposed') throw new Error('this gesture has been disposed')
			return _scaleStepY;
		}*/
		
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