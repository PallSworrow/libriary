package Swarrow.models.screenManager.stuff {
	import Swarrow.models.Globals;
	/**
	 * ...
	 * @author pall
	 */
	public class NavigatorCommand 
	{
		
		public function NavigatorCommand(departLocation:Object,destLocation:Object, dispParams:Object, data:Object) 
		{
			departure = departLocation;
			destination = destLocation;
			displayParams = dispParams;
			loadData = data;
		}
		public var departure:Object;
		public var destination:Object;
		public var displayParams:Object;
		public var loadData:Object;
		
	}

}