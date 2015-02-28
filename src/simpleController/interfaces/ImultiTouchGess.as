package simpleController.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface ImultiTouchGess 
	{
		//extension:
		//function get scaleX():Number
		//function get scaleY():Number
		function get scale():Number
		//function get scaleStepX():Number
		//function get scaleStepY():Number
		function get scaleStep():Number
		
		function get rotationStep():Number;
		function get rotation():Number;
		//from Igessture
		function get numTouches():int
		function get lastStepX():Number
		function get lastStepY():Number
		function get trackLength():Number
		function get distance():Number
		function get distanceX():Number
		function get distanceY():Number
		function get vectorDirection():String
		function get duration():int
		function get x():Number
		function get y():Number
	}
	
}