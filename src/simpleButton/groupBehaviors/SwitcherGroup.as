package simpleButton.groupBehaviors 
{
	import simpleButton.interfaces.IbuttonController;
	import simpleButton.interfaces.IbuttonGroupBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class SwitcherGroup implements IbuttonGroupBehavior
	{
		
		public function SwitcherGroup() 
		{
			
		}
		
		/* INTERFACE simpleButton.interfaces.IbuttonGroupBehavior */
		
		public function tap(index:int, list:Array):void 
		{
			var ctrl:IbuttonController;
			for (var i:int = 0; i < list.length; i++) 
			{
				ctrl = list[i].ctrl;
				if (i == index) ctrl.togleActivate();
				else ctrl.togleDesactivate();
			}
		}
		
	}

}