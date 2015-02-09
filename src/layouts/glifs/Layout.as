package layouts.glifs 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import layouts.GlifType;
	import layouts.interfaces.IlayoutMethod;
	/**
	 * ...
	 * @author 
	 */
	public class Layout extends Glif 
	{
		private var listenForChildrenChange:Boolean = true;
		private var _updateMethodTrigger:String// Glif event type
		private var _method:IlayoutMethod;
		public function Layout() 
		{
			super(GlifType.DYNAMIC);
		}
		
		//Private
		private function onItemChange(e:GlifEvent):void
		{
			if (!listenForChildrenChange) return;
			//check req event Type. defined by implementer
			if (e.type != updateMethodTrigger) return;
			
			updateMethod();
		}
		private function get updateMethodTrigger():String 
		{
			if (_method)
			return _method.triggerEventType;
			else
			return _updateMethodTrigger;
		}
			
		private function set updateMethodTrigger(value:String):void 
		{
			if (_method) return;
			if (!GlifEvent.validate(value))
			value = null;
			
			_updateMethodTrigger = value;
		}
		override protected function get glifType():String 
		{
			if (_method) return _method.glifType;
			else
			return super.glifType;
		}
		override protected function set glifType(value:String):void 
		{
			if(!method)
			super.glifType = value;
		}
		
		override protected function updateMethod():void 
		{
			callMethod(0);
			
		}
		private function callMethod(from:int, externalCall:Boolean = false ):void
		{
			if (_method)
			{
				listenForChildrenChange = false;
				_method.update(from);
				listenForChildrenChange = true;
				dispatchSizeChange();
			}
		}
		private function attachGlif(child:DisplayObject):void
		{
			child.addEventListener(GlifEvent.WIDTH_CHANGE, onItemChange);
			child.addEventListener(GlifEvent.HEIGHT_CHANGE, onItemChange);
			child.addEventListener(GlifEvent.SIZE_CHANGE, onItemChange);
		}
		private function dettachGlif(child:DisplayObject):void
		{
			child.removeEventListener(GlifEvent.WIDTH_CHANGE, onItemChange);
			child.removeEventListener(GlifEvent.HEIGHT_CHANGE, onItemChange);
			child.removeEventListener(GlifEvent.SIZE_CHANGE, onItemChange);
		}
		//OVERRIDES:
		override public function get width():Number 
		{
			if (_method)
			{
				if (_method.widthGetter)
				return _method.widthGetter();
			}
			return super.width;
		}
		override public function get height():Number 
		{
			if (_method)
			{
				if (_method.heightGetter)
				return _method.heightGetter();
			}
			return super.height;
		}
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
		override public function set height(value:Number):void 
		{
			super.height = value;
		}
		
		//children manipulations:
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			var res:DisplayObject = super.addChild(child);
			callMethod(numChildren - 1);
			attachGlif(child);
			return res;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			var res:DisplayObject =  super.addChildAt(child, index);
			callMethod(index);
			attachGlif(child);
			return res;
		}
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			var index:int = getChildIndex(child);
			var res:DisplayObject = super.removeChild(child);
			callMethod(index);
			dettachGlif(child);
			return res;
		}
		override public function removeChildAt(index:int):DisplayObject 
		{
			var res:DisplayObject = super.removeChildAt(index);
			callMethod(index);
			dettachGlif(res);
			return res;
		}
		override public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void 
		{
			if (endIndex > numChildren) endIndex = numChildren;
			if (beginIndex < 0) beginIndex = 0;
			var item:DisplayObject;
			for (var i:int = endIndex-1; i >=beginIndex ; i--) 
			{
				item = getChildAt(i);
				dettachGlif(item);
				removeChild(item);
			}
			//trace(beginIndex, endIndex,numChildren);
			//super.removeChildren(beginIndex, endIndex);
			callMethod(beginIndex);
		}
		
	
		
		//PUBLIC:
		public function update(e:Event = null):void
		{
			callMethod(0, true);
		}
		public function get method():IlayoutMethod 
		{
			return _method;
		}
		
		public function set method(value:IlayoutMethod):void 
		{
			if (_method) _method.dispose();
			_method = value;
			if (_method) 
			{
				//glifType = _method.type;
				updateMethodTrigger = _method.triggerEventType;
				_method.init(this);
			}
		}
		
	}

}