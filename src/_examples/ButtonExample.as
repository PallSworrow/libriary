package _examples 
{
	import flash.display.Sprite;
	import layouts.glifs.Layout;
	import layouts.methods.VerticalList;
	import simpleButton.BtnGroup;
	import simpleButton.BtnPhaze;
	import simpleButton.Button;
	import simpleButton.singleBehaviors.SwitcherBehavior;
	
	/**
	 * ...
	 * @author 
	 */
	public class ButtonExample extends Sprite 
	{
		private var btn:Button;
		public function ButtonExample() 
		{
			super();
			var group:BtnGroup = new BtnGroup('test');
			var layout:Layout = new Layout();
			layout.method = new VerticalList();
			layout.method.properties.intervalY = 5;
			addChild(layout);
			for (var i:int = 0; i < 10; i++) 
			{
				btn = btnFactory();
				btn.group = 'test';
				layout.addChild(btn);
			}
			trace(group.length);
			layout.update();
			//btn.tap();
		}
		private function btnFactory():Button
		{
			var res:Button = new Button();
			res.graphics.beginFill(0x000000);
			res.graphics.drawRect(0, 0, 100, 100);
			res.graphics.endFill(); 
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0x43ff43);
			sprite.graphics.drawRect(0, 0, 100, 100);
			sprite.graphics.endFill(); 
			sprite.alpha = 0;
			res.setHandler(handler, 'helloWorld');
			//btn.behavior = new SwitcherBehavior();
			res.setViewHandler(BtnPhaze.DEFAULT, updateView);
			res.setViewHandler(BtnPhaze.ACTIVE, updateView);
			res.addHandledChild(sprite, 'highlight');
			return res
		}
		private function updateView(elements:Object, phaze:String):void
		{
			trace(phaze);
			switch(phaze)
			{
				case BtnPhaze.ACTIVE:
					elements.highlight.alpha = 1;
					break;
				case BtnPhaze.DEFAULT:
					elements.highlight.alpha = 0;
					break;
			}
		}
		private function handler(params:String):void
		{
			trace(params);
		}
	}

}