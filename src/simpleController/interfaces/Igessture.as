package simpleController.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface Igessture 
	{
		function get id():String
		function get isSwipeFailed():Boolean
		function get isTapFailed():Boolean
		function get lastStepX():Number
		function get lastStepY():Number
		function get trackLength():Number
		function get distance():Number
		function get distanceX():Number
		function get distanceY():Number
		function get vectorDirection():String
		function get duration():Number
		function  get x():Number
		function  get y():Number
		
	}
	
}