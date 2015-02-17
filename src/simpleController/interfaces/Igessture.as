package simpleController.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface Igessture 
	{
		function get isSwipeFailed():Boolean
		function get isTapFailed():Boolean
		function get lastStepX():int
		function get lastStepY():int
		function get trackLength():int
		function get distance():int
		function get distanceX():int
		function get distanceY():int
		function get vectorDirection():String
		function get duration():int
		function  get x():int
		function  get y():int
		
	}
	
}