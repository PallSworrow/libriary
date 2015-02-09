package simpleButton.singleBehaviors 
{
	import simpleButton.interfaces.Ibtn;
	import simpleButton.interfaces.IsingleButtonBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class SwitcherBehavior implements IsingleButtonBehavior
	{
		private var curr:Ibtn;
		public function SwitcherBehavior() 
		{
			
		}
		
		/* INTERFACE simpleButton.interfaces.IsingleButtonBehavior */
		
		public function init(btn:Ibtn):void 
		{
			curr = btn;
		}
		
		public function tap():Boolean 
		{
			return !curr.isActive;
		}
		
	}

}