package Swarrow.models.screenManager.interfaces 
{
	import Swarrow.models.screenManager.stuff.NavigatorCommand;
	
	/**
	 * ...
	 * @author pall
	 */
	public interface InavigationFilter 
	{
		function navigate(command:NavigatorCommand):NavigatorCommand
		function set enabled(value:Boolean):void
		function get enabled():Boolean
		
	}
	
}