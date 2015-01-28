package popupManager.behaviors 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import popupManager.interfaces.IpopupBehavior;
	import popupManager.Popup;
	import popupManager.PopupEvent;
	/**
	 * ...
	 * @author 
	 */
	public class PopupBehaviorBase implements IpopupBehavior
	{
		/**
		 * Определяет способ отображения, появляения/скрытия окна. 
		 * @param	popup
		 */
		
		private var item:Popup;
		public function PopupBehaviorBase() 
		{
			
		}
		//overridable methods:
		protected function placeMethod(glif:DisplayObject, stageWidth:int, stageHeight:int,stage:DisplayObjectContainer):void
		{
			
			glif.x = (stageWidth - glif.width) / 2;
			glif.y = (stageHeight - glif.height) / 2;
		}
		protected function onDisplay():void
		{
			
		}
		protected function onHide():void
		{
			
		}
		protected function onStageUpdate():void
		{
			update();
		}
		
		/* INTERFACE popups.interfaces.IpopupBehavior */
		
		public function init(popup:Popup):void 
		{
			item = popup;
			item.addEventListener(PopupEvent.DISPLAY, item_displayStart);
			item.addEventListener(PopupEvent.HIDE, item_hideStart);
			if (item.isShown)
			{
				update();
				//onDisplay();
			}
		}
		public function dispose():void 
		{
			item.removeEventListener(PopupEvent.DISPLAY, item_displayStart);
			item.removeEventListener(PopupEvent.HIDE, item_hideStart);
			item = null;
		}
		
		//private:
		public final function update(e:Event = null):void
		{
			trace(this, item.currentStage, 'UPDATE');
			if (!item) throw new Error(this, "this behavior hasn't been inited yet");
			if(item.isShown)
			placeMethod(item.source, item.currentStage.width, item.currentStage.height,item.currentStage.stage);
		}
		
		private function item_displayStart(e:PopupEvent):void 
		{
			onDisplay();
			update();
			item.currentStage.addEventListener(Event.CHANGE, currentStage_change);
		}
		
		private function currentStage_change(e:Event):void 
		{
			onStageUpdate();
		}
		private function item_hideStart(e:PopupEvent):void 
		{
			onHide();
			item.currentStage.removeEventListener(Event.CHANGE, currentStage_change);
		}
		public function get isActive():Boolean
		{
			return item.isShown;
		}
		
	}

}