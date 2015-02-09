package scrollers 
{
	import com.greensock.plugins.FrameForwardPlugin;
	import constants.Direction;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import scrollers.bases.ContentScroller;
	import scrollers.events.ScrollerEvent;
	import scrollers.interfaces.IpageScroller;
	import simpleController.Controller;
	import simpleController.events.ControllerEvent;
	/**
	 * Этот scrollerView обеспечивает прокрутку содержимого внутри окна с маской. Чем больше offset тем выше "уезжает" контент.
	 * в качестве конента жестко задан layout, однако к нему есть публичный доступ позволяющий добавлять/удалять елементы, менять свойства и методы расположения.
	 * Кроме того есть два публичных метода обеспечивающих исполнение интерфейсов IpageSnapper. 
	 * (тоесть методы определяющиее ближайший offset|postion) соотвествующий расположению елемента внутри layout-a
	 * @author 
	 */
	public class LayoutScroller extends ContentScroller implements  IpageScroller
	{
		//private var dragController:Controller;
		//private var tapController:Controller;
		private var pagesLoader:ScrollerMemoryControll;
		private var pageControllEnabled:Boolean = false;
		public function LayoutScroller() 
		{
			props
			super(new Layout());
			pagesLoader = new ScrollerMemoryControll(this);
			updateMethod();
			layout.addEventListener(GlifEvent.SIZE_CHANGE, layout_sizeChange);
		}
		override public function get controller():ScrollController 
		{
			return super.controller;
		}
		
		override public function set controller(value:ScrollController):void 
		{
			if(controller) 
			controller.removeEventListener(ScrollerEvent.SCROLL_COMPLETE, controller_scrollComplete);
			super.controller = value;
			if(controller) 
			controller.addEventListener(ScrollerEvent.SCROLL_COMPLETE, controller_scrollComplete);
		}
		private function controller_scrollComplete(e:ScrollerEvent):void 
		{
			if(pageControllEnabled)
			pagesLoader.update();
		}
		public function enabePagesControll(loadBeforCurrent:int, loadAfterCurrent:int):void 
		{
			pagesLoader.loadBefore = loadBeforCurrent;
			pagesLoader.loadAfter = loadAfterCurrent;
			pageControllEnabled = true;
		}
		
		public function disablePagesControll():void 
		{
			pageControllEnabled = false;
		}
		private function layout_sizeChange(e:GlifEvent):void 
		{
			//updateMethod();
			dispatchEvent(new ScrollerEvent(ScrollerEvent.PROPRION_CHANGE, 0, proportion, 0, this));
		}
		
		
			/* INTERFACE scrollers.interfaces.IpageScroller */
		
		public function getPagePosition(pageIndex:int):Number 
		{
			return getPageOffset(pageIndex) / maxOffset;
		}
		
		public function getPageOffset(pageIndex:int):int 
		{
			if (isVertical) return /*props.offsetBegin + props.offsetY + */getChildAt(pageIndex).y;
			//if (isVertical) return  getChildAt(pageIndex).y-(props.offsetBegin + props.offsetY);
			else  return /*props.offsetBegin + props.offsetX + */getChildAt(pageIndex).x;
		}
		
		public function scrollToPage(pageIndex:int, duration:Number = 0, onComplete:Function = null):void 
		{
			scrollTo(getPagePosition(pageIndex), duration, onComplete);
		}
		
		public function get currentPage():int 
		{
			var item:DisplayObject;
			var dist:int;
			var min:int = -1;
			var res:int;
			
			for (var i:int = 0; i < layout.numChildren; i++) 
			{
				dist = Math.abs(offset - getPageOffset(i));
				if (min == -1 ||(min > 0 && dist <= min)) 
				{
					min = dist;
					res = i;
				}
			}
			return res;
		}
		/* INTERFACE scrollers.interfaces.IpageSnaper */
		
	/*	public function getNearestPagePosition():Number 
		{
			return getPagePosition(currentPage);
		}*/
		
		//PUBLIC:
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			return layout.addChild(child);
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			return layout.addChildAt(child, index);
		}
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			return layout.removeChild(child);
		}
		override public function removeChildAt(index:int):DisplayObject 
		{
			return layout.removeChildAt(index);
		}
		override public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void 
		{
			layout.removeChildren(beginIndex, endIndex);
		}
		override public function get numChildren():int 
		{
			return layout.numChildren;
		}
		override public function getChildAt(index:int):DisplayObject 
		{
			return layout.getChildAt(index);
		}
		
		/* INTERFACE scrollers.interfaces.IpageScroller */
		
	
		
		
		public function get layout():Layout
		{
			return content as Layout;
		}
		
		
	}

}