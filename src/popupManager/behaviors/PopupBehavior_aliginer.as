package popupManager.behaviors 
{
	import constants.AlignType;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import popupManager.Popup;
	/**
	 * ...
	 * @author 
	 */
	public class PopupBehavior_aliginer extends PopupBehaviorBase
	{
		//params:
		private var enterFrame:Boolean = false;
		private var offsetX:int=0;
		private var offsetY:int = 0;
		private var alignX:String = AlignType.LEFT;//center,right;
		private var alignY:String = AlignType.TOP;//middle, bottom;
		
		private var iterator:Shape;
		
		private var _anchor:Object;
		public function PopupBehavior_aliginer(params:Object=null,anchor:Object = null) 
		{
			if (params) parseParams(params);
			_anchor = anchor;
		}
		override public function init(popup:Popup):void 
		{
			super.init(popup);
			
		}
		override public function dispose():void 
		{
			super.dispose();
		}
		//OVERRIDABLE METHODS:
		override protected function placeMethod(glif:DisplayObject, stageWidth:int, stageHeight:int, stage:DisplayObjectContainer):void 
		{
			var x:int=0;
			var y:int = 0;
			
			
			var box:Object;
			if (anchor)
			{
				if(anchor is DisplayObject)
				box = (anchor as DisplayObject).getBounds(stage);
				else if (anchor is String)
				{
					switch(anchor)
					{
						case 'mouse':
							box = { x:stage.mouseX, y:stage.mouseY, width:0, height:0 };
							break;
					}
				}
					
			}
			
			if(!box) box = {x:0,y:0, width:stageWidth,height:stageHeight };
			
			switch(alignX)
			{
				case AlignType.LEFT:
					x = box.x;
					break;
				case AlignType.CENTER:
					x = box.x + (box.width - glif.width) / 2;
					break;
				case AlignType.RIGHT:
					x = box.x + box.width;
					break;
			}
			switch(alignY)
			{
				case AlignType.TOP:
					y = box.y;
					break;
				case AlignType.MIDDLE:
					y = box.y + (box.height - glif.height) / 2;
					break;
				case AlignType.BOTTOM:
					y = box.y + box.height;
					break;
			}
			
			x += offsetX;
			y += offsetY;
			glif.x = x;
			glif.y = y;
		}
		override protected function onDisplay():void 
		{
			if (enterFrame) 
			{
				iterator = new Shape();
				iterator.addEventListener(Event.ENTER_FRAME, iterator_enterFrame);
				
			}
		}
		override protected function onHide():void 
		{
			if (iterator)
			{
				iterator.removeEventListener(Event.ENTER_FRAME, iterator_enterFrame);
				iterator = null;
			}
		}
		private function iterator_enterFrame(e:Event):void 
		{
			update();
		}
		
		
		
		public function get anchor():Object 
		{
			return _anchor;
		}
		
		public function set anchor(value:Object):void 
		{
			_anchor = value;
			if (isActive)
			update();
		}
		
		private function parseParams(params:Object):void
		{
			if (params.enterFrame is Boolean) enterFrame = Boolean(params.enterFrame);
			if (AlignType.validateHorizontal(params.alignX)) alignX = params.alignX;
			if (AlignType.validateVertical(params.alignY)) alignY = params.alignY;
			if (params.offsetX is Number) offsetX = params.offsetX;
			if (params.offsetY is Number) offsetY = params.offsetY;
		}
		
		
		
	}

}