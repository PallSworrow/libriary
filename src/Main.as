package 
{
	import constants.AlignType;
	import examples.LayoutUsage;
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
	import layouts.methods.VertivalList;
	import popupManager.Popup;
	import popupManager.PopupEngine;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	import simpleController.events.MultitouchEvent;
	import simpleController.MultitouchController;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
	
		public function Main():void 
		{ 
			
			addChild(new LayoutUsage());
			
		}
		
		
	}
	
}