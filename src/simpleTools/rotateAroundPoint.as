package simpleTools 
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public function rotateAroundPoint(object:DisplayObject, angleDegrees:Number, globalPoint:Point) 
	{
		//var x:int = pointX;
		//var y:int = pointY;
		
		 var matrix:Matrix = object.transform.matrix;
		var rect:Rectangle = object.getBounds(object.parent);
		var localPoint:Point;
		if(object.parent) localPoint = object.parent.globalToLocal(globalPoint);
		else localPoint = globalPoint;
		var radianangle:Number = angleDegrees * Math.PI / 180;
			var nowangle:Number = Math.atan2(object.y - localPoint.y, object.x - localPoint.x);
			var nowlength:Number = Point.distance(localPoint, new Point(object.x, object.y));
			var newangle:Number = nowangle + radianangle;
			var newpos:Point = Point.polar(nowlength, newangle);
			
			object.rotation += angleDegrees;
			object.x = localPoint.x + newpos.x;
			object.y = localPoint.y + newpos.y;
	}
		
	

}