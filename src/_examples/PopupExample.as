package _examples 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import popupManager.controllers.SimplePopupController;
	import popupManager.Popup;
	import popupManager.PopupEngine;
	import popupManager.PopupStage;
	import scrollers.propsObjects.ScrollProperties;
	
	/**
	 * ...
	 * @author 
	 */
	public class PopupExample extends Sprite 
	{
		[Embed(source="../_lib/Penguins.jpg")]
		private var bgAsset:Class;
		
		//layers:
		private var content:Sprite;
		private var popupLayer:Sprite;
		//views:
		private var bg:DisplayObject
		private var popupContent:Sprite;
		private var popup:Popup;
		private var popupStage:PopupStage;
		public function PopupExample() 
		{
			super();
			PopupEngine.init(100, 100, this);
			
			content = new Sprite();
			popupLayer = new Sprite();
			addChild(content);
			addChild(popupLayer);
			
			bg = new bgAsset();
			content.addChild(bg);
			
			popupContent = new Sprite();
			popupContent.graphics.beginFill(0xffffff);
			popupContent.graphics.drawRect(0, 0, 200, 200);
			popupContent.graphics.endFill();
			
			popupStage = PopupEngine.createStage('test', popupLayer);
			popupStage.foggingDuration = 0.4;
			
			popup = new Popup(popupContent,'test');
						
			popup.currentController = new SimplePopupController(content);
			
		
			
		}
		
	}

}