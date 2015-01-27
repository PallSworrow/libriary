package popupManager.controllers 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import popupManager.interfaces.IpopupController;
	import popupManager.Popup;
	import popupManager.PopupEvent;
	/**
	 * ...
	 * @author 
	 */
	public class SimplePopupController implements IpopupController
	{
		/**
		 * Определяет способ открытия/закрытия окна
		 * @param	popup
		 */
		private var item:Popup;
		private var _trigger:InteractiveObject;
		private var popupflow:String;
		
		public function SimplePopupController(triggerObject:InteractiveObject) 
		{
			trigger = triggerObject;
			
		}
		
		
		public function get trigger():InteractiveObject 
		{
			return _trigger;
		}
		
		public function set trigger(value:InteractiveObject):void 
		{
			if(_trigger)
			_trigger.removeEventListener(MouseEvent.CLICK, trigger_click);
			
			_trigger = value;
			if (!value) return;
			_trigger.addEventListener(MouseEvent.CLICK, trigger_click);
		}
		
		private function trigger_click(e:MouseEvent):void 
		{
			if (item)
			{
				trace('trigger_click');
				if(!item.isShown && !item.currentFlow)
				e.stopPropagation();
				item.show(popupflow);
				
			}
		}
		
		private var listenersDelay:uint;
		private function item_displayStart(e:PopupEvent):void 
		{
			listenersDelay = setTimeout(function():void
			{
				listenersDelay = null;
				item.currentStage.stage.addEventListener(MouseEvent.CLICK, stage_click);
				item.source.addEventListener(MouseEvent.CLICK, source_click);
			},100);
		}
		private function item_hideStart(e:PopupEvent):void 
		{
			if (listenersDelay) clearTimeout(listenersDelay);
			else
			{
				item.currentStage.stage.removeEventListener(MouseEvent.CLICK, stage_click);
				item.source.removeEventListener(MouseEvent.CLICK, source_click);
			}
		}
	
		private function source_click(e:MouseEvent):void 
		{
			trace('source_click');
			e.stopPropagation();
		}
		
		private function stage_click(e:MouseEvent):void 
		{
			trace('stage_click');
			item.hide();
		}
		
		/* INTERFACE popups.interfaces.IpopupController */
		
		public function init(popup:Popup):void 
		{
			item = popup;
			item.addEventListener(PopupEvent.DISPLAY, item_displayStart);
			item.addEventListener(PopupEvent.HIDE, item_hideStart);
		}
		
		
		public function dispose():void 
		{
			item = null;
			item.removeEventListener(PopupEvent.DISPLAY, item_displayStart);
			item.removeEventListener(PopupEvent.HIDE, item_hideStart);
		}
		
	}

}