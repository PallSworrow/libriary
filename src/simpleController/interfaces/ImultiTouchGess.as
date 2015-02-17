package simpleController.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface ImultiTouchGess 
	{
		//extension:
		function get scaleX():Number
		function get scaleY():Number
		function get scale():Number
		function get scaleStepX():Number
		function get scaleStepY():Number
		function get scaleStep():Number
		//from Igessture
		function get numTouches():int
		function get lastStepX():int
		function get lastStepY():int
		function get trackLength():int
		function get distance():int
		function get distanceX():int
		function get distanceY():int
		function get vectorDirection():String
		function get duration():int
		function get x():int
		function get y():int
	}
	
}