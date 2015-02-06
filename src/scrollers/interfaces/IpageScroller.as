package scrollers.interfaces 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IpageScroller 
	{
		//add/remove items
		//заблокировать все операции с chlid-ами
		function addChild(child:DisplayObject):DisplayObject 
		function addChildAt(child:DisplayObject, index:int):DisplayObject 
		function removeChild(child:DisplayObject):DisplayObject 
		function removeChildAt(index:int):DisplayObject 
		function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void 
		function swapChildren(child1:DisplayObject, child2:DisplayObject):void 
		function swapChildrenAt(index1:int, index2:int):void 
		function getChildAt(index:int):DisplayObject 
		function getChildByName(name:String):DisplayObject 
		function getChildIndex(child:DisplayObject):int 
		function get numChildren():int
		
		function getPagePosition(pageIndex:int):Number
		function getPageOffset(pageIndex:int):int
		function scrollToPage(pageIndex:int,duration:Number=0,onComplete:Function=null):void
		function get currentPage():int
		//memory controll
		
	}
	
}