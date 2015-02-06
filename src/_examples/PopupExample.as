package _examples 
{
	import constants.AlignType;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import popupManager.behaviors.PopupBehavior_aliginer;
	import popupManager.controllers.SimplePopupController;
	import popupManager.Popup;
	import popupManager.PopupEngine;
	import popupManager.PopupStage;
	import scrollers.propsObjects.ScrollProperties;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	
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
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			PopupEngine.init(stage.stageWidth, stage.stageHeight, this);
			
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
			popup.currentBehavior = new PopupBehavior_aliginer( { alignX:AlignType.CENTER } );
			
			var ctrl:Controller = new Controller();
			ctrl.addEventListener(ControllerEvent.GESSTURE_UPDATE, ctrl_gesstureUpdate);
			ctrl.item = popupContent;
		}
		
		private function ctrl_gesstureUpdate(e:ControllerEvent):void 
		{
			trace('move');
		}
		
	}

}