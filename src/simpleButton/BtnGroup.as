package simpleButton 
{
	import flash.utils.Dictionary;
	import simpleButton.groupBehaviors.SwitcherGroup;
	import simpleButton.interfaces.Ibtn;
	import simpleButton.interfaces.IbuttonController;
	import simpleButton.interfaces.IbuttonGroup;
	import simpleButton.interfaces.IbuttonGroupBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class BtnGroup implements IbuttonGroup
	{
		//static:
		private static const groups:Dictionary = new Dictionary();
		internal static function _getGroup(name:String):BtnGroup
		{
			return groups[name];
		}
		public static function getGroup(name:String):IbuttonGroup
		{
			return _getGroup(name);
		}
		
		//inst:	
		
		private var list:Array;
		private var _method:IbuttonGroupBehavior;
		private var _name:String;
		internal function _addBtn(btn:Button, controller:IbuttonController):void
		{
			list.push( { btn:btn, ctrl:controller } );
		}
		internal function _removeBtn(btn:Button):void
		{
			var index:int = getIndex(btn);
			list.splice(index);
		}
		public function BtnGroup(name:String) 
		{
			if (groups[name]) throw new Error('group already exists');
			groups[name] = this;
			_name = name;
			_method = new SwitcherGroup();
			list = [];
		}
		
		/* INTERFACE simpleButton.interfaces.IbuttonGroup */
		
		public function addBtn(btn:Ibtn):void 
		{
			btn.group = name;
		}
		
		public function removeBtn(selector:Object):void 
		{
			var btn:Ibtn = getBtn(selector);
			if(btn)
			btn.group = null;
			
		}
		
		public function getBtn(selector:Object):Ibtn 
		{
			var res:Ibtn;
			var item:Ibtn;
			for (var i:int = list.length - 1; i >= 0;i-- ) 
			{
				item = list[i].btn;
				if (item == selector || (selector is String && item.name == String(selector)) || (selector is Number &&  selector == i))
				res = item;
			}
			return res;
		}
		public function getIndex(selector:Object):int
		{
			var res:int=-1;
			var item:Ibtn;
			for (var i:int = list.length - 1; i >= 0;i-- ) 
			{
				item = list[i].btn;
				if (item == selector as Ibtn || (selector is String && item.name == String(selector)) || (selector is Number &&  selector == i))
				res = i;
			}
			return res;
		}
		public function get length():int 
		{
			return list.length;
		}
		
		public function tap(selector:Object):void 
		{
			var btn:int = getIndex(selector);
			if (btn >= 0)
			{
				if(method)
				method.tap(btn, list);
				else 
				(list[btn].ctrl as IbuttonController).togleActivate();
			}
		}
		
		public function clear():void 
		{
			for (var i:int = list.length - 1; i>=0; i--) 
			{
				list[i].btn.group = null;
			}
		}
		
		/* INTERFACE simpleButton.interfaces.IbuttonGroup */
		
		public function get method():IbuttonGroupBehavior 
		{
			return _method;
		}
		
		public function set method(value:IbuttonGroupBehavior):void 
		{
			_method = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}

}