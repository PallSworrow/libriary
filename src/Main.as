package 
{
	import _examples.ButtonExample;
	import _examples.ControllerExample;
	import _examples.PopupExample;
	import _examples.ScrollerExample;
	import antares.BasicFunctional;
	import constants.AlignType;
	import _examples.LayoutExample;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import layouts.glifs.LayoutMethodBase;
	import layouts.glifs.LayoutMethodProps;
	import adobe.utils.CustomActions;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setInterval;
	import layouts.glifs.Glif;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.GlifType;
	import layouts.interfaces.IlayoutMethod;
	import layouts.methods.HorizontalList;
	import layouts.methods.TagsLayout;
	import layouts.methods.VerticalList;
	import popupManager.Popup;
	import popupManager.PopupEngine;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	import simpleController.events.MultitouchEvent;
	import simpleController.MultitouchController;
	import simpleTools.FPScounter;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var example:Sprite;
		public function Main():void 
		{ 
			//addChild(new ButtonExample());
			//addChild(new ScrollerExample());
			addChild(new ControllerExample());
			//addChild(new LayoutExample());
			
			
			addChild(new FPScounter());
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			
		}
		
	}
	
}