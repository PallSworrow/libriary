package scrollers.bases 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author 
	 */
	public class TestPage extends EmptyPage
	{
		
		private var tf1:TextField;
		private var tf2:TextField;
		public function TestPage() 
		{
			tf1 = factory();
			tf2 = factory();
			update();
			tf1.x = tf2.x = tf1.y = 10;
			tf2.y = tf1.y + tf1.height + 10;
			
			graphics.beginFill(Math.random() * 0xdddddd,0.6);
			graphics.drawRect(0, 0, /*int(Math.random() * 60) + */100, /*int(Math.random() * 60) +*/ 100);
			graphics.endFill();
			cacheAsBitmap = true;
			addChild(tf1);
			addChild(tf2);
			function factory():TextField
			{
				var res:TextField = new TextField();
				res.autoSize = 'left';
				res.wordWrap = res.multiline = false;
				return  res;
			}
		}
		private function update()
		{
			trace(isEnabled, isLoaded);
			tf1.text = 'loaded:' + isLoaded;
			tf2.text = 'enabled:' + isEnabled;
		}
		override public function load():void 
		{
			super.load();
			update();
		}
		override public function unload():void 
		{
			super.unload();
			update();
		}
		override public function enable():void 
		{
			super.enable();
			update();
		}
		override public function disable():void 
		{
			super.disable();
			update();
		}
	}

}