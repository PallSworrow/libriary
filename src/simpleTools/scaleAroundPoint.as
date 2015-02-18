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
	public function scaleAroundPoint(object:DisplayObject, scale:Number, globalPoint:Point) 
	{
		//var x:int = pointX;
		//var y:int = pointY;
		
		 var matrix:Matrix = object.transform.matrix;
		var rect:Rectangle = object.getBounds(object.parent);
		var localPoint:Point;
		//if (object.parent) 
		//localPoint = object.globalToLocal(globalPoint);
		//else 
		localPoint = globalPoint;
		var m:Matrix = object.transform.matrix
		m.translate(-localPoint.x, -localPoint.y);//move the center into (0,0)
		m.scale(scale, scale);//scale relatively to (0,0) (which is where our center is now)
		m.translate(localPoint.x, localPoint.y);//move the center back to its original position
		object.transform.matrix = m;
		//return m.transformPoint(new Point());
	}
		

}