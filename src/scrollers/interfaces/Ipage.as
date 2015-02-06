package scrollers.interfaces 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface Ipage 
	{
		function load():void
		function unload():void
		function enable():void
		function disable():void
		function get isLoaded():Boolean
		function get isEnabled():Boolean
	}
	
}