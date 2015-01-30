package scrollers.interfaces 
{
	import scrollers.ScrollController;
	
	/**
	 * ...
	 * @author 
	 */
	public interface Iscroller 
	{
		/*function get maxOffset():int
		function get offset():int
		function get position():Number*/
		function get proportion():Number
		//function set offset(value:int):void
		function set position(value:Number):void
		
		function set controller(value:ScrollController):void
		function get controller():ScrollController
	}
	
}