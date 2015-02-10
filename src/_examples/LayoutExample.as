package _examples 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import layouts.methods.ColumnsLayout;
	import layouts.methods.StringLayout;
	import layouts.methods.TagsLayout;
	
	//dependencies:
	import constants.AlignType;
	import layouts.glifs.GlifEvent;
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodProps;
	import layouts.interfaces.IlayoutMethod;
	import layouts.methods.HorizontalList;
	import layouts.methods.VerticalList;
	
	/**
	 * ...
	 * @author 
	 */
	public class LayoutExample extends Sprite 
	{
		private var layout:Layout;
		private var methods:Array;
		private var index:int = 0;
		public function LayoutExample() 
		{
			super();
			layout = new Layout();
			addChild(layout);
			
			var obj:DisplayObject;
			for (var i:int = 0; i < 10; i++) 
			{
				obj = glifFactory();
				obj.name = 'test' + i;
				layout.addChild(obj);
			}
			/**
			 * Объект layout делегирует свое поведения специальным объектам повидениям, исполняющим интерфейс IlayoutMethod
			 * сейчас написано всего три варианта. Но они легко создаются через наследование(не обязательно) от класса LayoutMethodBase
			 */
			
			 var tagsLayout:TagsLayout = new TagsLayout();
			 tagsLayout.addMarker('test0', 100, 100);
			 tagsLayout.addMarker('test1', { value:'test0', align:AlignType.AFTER, offset:20 }, 0);
			 
			 var columnsLayout:ColumnsLayout = new ColumnsLayout();
			 columnsLayout.layoutMarkers = ['20%', 20, { paddingLeft:10, width:30, paddingRight:10 }, null, { paddingLeft:'10%', width:'10%', paddingRight:'10%' } ];
			methods = [new VerticalList(), new HorizontalList(), new StringLayout(), tagsLayout,columnsLayout];
			
			/**
			 * Добавление происходит через свойство method. 
			 * поведение определяет способ выравнивания и маштабирования детей объекта. 
			 * Layout является наследником класса Glif.
			 * Все глифы имеют специальное свойство определняющее как именно меняется объект:
				 * vertical  - обьъекту можно задать ширину, но высота определяется изходя из внутреннего содержимого
				 * horizontal  - обьъекту можно задать высоту, но ширина определяется изходя из внутреннего содержимого
				 * static  - объекту нельзя задать высоту и ширину - только прослушивать события об изменениях
				 * dynamic - пока не поддерживается
			 * Если у layout задан метод, то именно он определяет его glifType
			 */
			layout.width = 300;
			layout.method = methods[0];
			
			addEventListener(MouseEvent.CLICK, click);
			return
			
			//* для теста - дети layouta -произвольно меняются.
			setInterval(function():void
			{
				/**
				 * Детьми layout-а могут быть как glif-ы так и любые displayobject-ы.
				 * Но у глифы умеют извещать родительский layout о своих изменениях
				 * В данном случае чтобы не создавать новый класс мы симмулируем поведения glif-а
				 * отправляя все возможные события-оповещения об изменниях.
				 * Какое именно событие ждет layout зависит от его метода
				 */
				var item:Sprite = layout.getChildAt(Math.floor(Math.random()*layout.numChildren)) as Sprite;
				item.graphics.clear();
				item.graphics.beginFill(Math.random() * 0xdddddd);
				item.graphics.drawRect(0, 0, Math.random() * 60 + 60, Math.random() * 60 + 60);
				item.graphics.endFill();
				item.dispatchEvent(new GlifEvent(GlifEvent.HEIGHT_CHANGE));
				item.dispatchEvent(new GlifEvent(GlifEvent.SIZE_CHANGE));
				item.dispatchEvent(new GlifEvent(GlifEvent.WIDTH_CHANGE));
				trace(layout.width);
			},800);//*/
		
			
		}
		
		private function click(e:MouseEvent):void 
		{
			
			var params:LayoutMethodProps = new LayoutMethodProps({intervalX:10});
			params.intervalY = 10;
			params.alignX = AlignType.RIGHT;
			params.parseParams('{"minLineHeight":"100"}');
			params.parseParams({forceSizeIgnoreNonGlifs:false});
			index++;
			if (index == methods.length) index = 0;
			layout.method = methods[index];
			layout.method.properties = params;
			trace('CLICK');
		}
			
		private function glifFactory():Sprite
		{
			var res:Sprite = new Sprite();
			res.graphics.beginFill(Math.random() * 0xdddddd,0.6);
			res.graphics.drawRect(0, 0, Math.random() * 60 + 60, Math.random() * 60 + 60);
			res.graphics.endFill();
			return res;
			
		}
		
	}

}