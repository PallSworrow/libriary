package scrollers 
{
	import com.greensock.loading.data.ImageLoaderVars;
	import flash.display.DisplayObjectContainer;
	import scrollers.interfaces.Ipage;
	import scrollers.interfaces.IpageScroller;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerMemoryControll 
	{
		public var loadBefore:int=1;
		public var loadAfter:int=1;
		public var enabled:Boolean = false;
		private var targ:IpageScroller;
		public function ScrollerMemoryControll(target:IpageScroller) 
		{
			targ = target;
		}
		public function update():void
		{
			var item:Ipage;
			for (var i:int = targ.numChildren; i>=0 ; i--) 
			{
				item = targ.getChildAt(i) as Ipage;
				if (item)
				{
					if (i<targ.currentPage-loadBefore || i>targ.currentPage+loadAfter)
					{
						if (!item.isLoaded)
						item.load();
						if (i == targ.currentPage && !item.isEnabled)
						item.enable()
						else if (item.isEnabled)
						item.disable();
					}
					else if(item.isLoaded)
					{
						if (item.isEnabled)
						item.disable();
						item.unload();
					}
					
				}
			}
		}
	}

}