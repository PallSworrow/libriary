package simpleButton 
{
	import flash.events.EventDispatcher;
	import simpleButton.interfaces.IsingleButtonBehavior;
	import simpleButton.interfaces.Ibtn;
	import simpleButton.interfaces.IbuttonController;
	/**
	 * ...
	 * @author 
	 */
	public class ButtonController extends EventDispatcher implements IbuttonController
	{
		private var current:Ibtn;
		private var handlerAct:Function;
		private var handlerDes:Function;
		private var _method:IsingleButtonBehavior;
		public function ButtonController (btn:Ibtn, activator:Function, desactivator:Function) 
		{
			current = btn;
			handlerAct = activator;
			handlerDes = desactivator;
		}
		
		public function tap():void 
		{
			if(_method)
			{
				if (_method.tap())
				togleActivate();
				else 
				togleDesactivate();
			}
			else
			{
				togleActivate();
				togleDesactivate();
			}
		}
		
		public function togleActivate():void 
		{
			handlerAct();
		}
		public function togleDesactivate():void 
		{
			handlerDes();
		}
		
		public function get method():IsingleButtonBehavior 
		{
			return _method;
		}
		
		public function set method(value:IsingleButtonBehavior):void 
		{
			_method = value;
			_method.init(current);
		}
		
	}

}