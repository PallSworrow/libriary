package Swarrow.models.screenManager.bases 
{
	import Swarrow.models.screenManager.interfaces.IscreenHierarchy;
	import Swarrow.models.screenManager.interfaces.Iscreen;
	
	/**
	 * ...
	 * @author pall
	 */
	public class HierarchyBase implements IscreenHierarchy 
	{
		private var hr:Object;
		public function HierarchyBase(hierarchy:Object) 
		{
			hr = hierarchy;
		}
		
		/* INTERFACE PS.models.screenManager.interfaces.IscreenHierarchy */
		
		public function getScreen(location:Object):Iscreen 
		{
			var res:Object;
			if (location is String)
			{
				res = hr[location];
			}
			else if (location is Number)
			{
				var i:int = 0;
				for each(var scr:Object in hr)
				{
					if (i == location)
					{
						res = scr;
						break;
					}
					i++;
				}
			}
			if (res is Function) res = res();
			
			return res as Iscreen;
		}
		
	}

}