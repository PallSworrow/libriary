package _examples 
{
	import scrollers.bases.TestPage;
	import scrollers.events.ScrollerEvent;
	import scrollers.ScrollBar;
	import scrollers.LayoutScroller;
	import constants.AlignType;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodProps;
	import layouts.methods.HorizontalList;
	import layouts.methods.StringLayout;
	import layouts.methods.VerticalList;
	import scrollers.bases.ScrollViewBase;
	import scrollers.ScrollController;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerExample extends Sprite 
	{
		private var scrollBox:LayoutScroller;
		private var sb:ScrollBar;
		private var controller:ScrollController;
		private var index:int = 0;
		public function ScrollerExample() 
		{
			super();
			//Создаем скроллер, скроллбар и контроллер для них:
			controller = new ScrollController();
			scrollBox = new LayoutScroller();
			sb = new ScrollBar();
			
			//нарисуем фон для скроллбара(indicator создается по-умолчанию, но можно добавить свой аналогичным образом):
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x999999);
			bg.graphics.drawRect(0, 0, 100, 100);
			bg.graphics.endFill();
			sb.background = bg;
			
			//задаем размеры и положение:
			scrollBox.width = 400;
			scrollBox.height = 500;
			
			//sb.width = 50;
			//sb.height = 400;
			
			//sb.x = scrollBox.width;
			//добавляем на сцену:
			addChild(scrollBox);
			//addChild(sb);
			
		
			
			//Связываем елементы контроллером
			//sb.controller = controller;
			//scrollBox.controller = controller;
			//sb.proptionController = scrollBox;
			
			
			//добавляем layout-у способ расположения и изменяем его настройки(обновление при изменениях настроек пока неафтоматическое)
			scrollBox.layout.method = new VerticalList();
			scrollBox.layout.method.properties.alignX = AlignType.CENTER;
			scrollBox.props.offsetY = 200;
			scrollBox.layout.method.update();
			
			//просто графика чтобы были видны границы скроллера
			graphics.lineStyle(1, 0x000000);
			graphics.drawRect(scrollBox.x, scrollBox.y, scrollBox.width, scrollBox.height);
			
			//настраиваем контроллер так что бы тот выполнял привязку к странице
			controller.snapHandler = scrollBox;
			
			var obj:DisplayObject;
			for (var i:int = 0; i < 10; i++) 
			{
				obj = glifFactory();
				scrollBox.layout.addChild(obj);
			}
			scrollBox.layout.update();
			scrollBox.update();
			addEventListener(MouseEvent.CLICK, click);
			
			//scrollBox.enabePagesControll(3, 3);
			//линия гду установлен offsetY. для наглядности работы загрузчика
			graphics.lineStyle(1);
			graphics.moveTo(0, 200);
			graphics.lineTo(300, 200);
			//toTheBottom();
		}
		private function toTheTop():void
		{
			scrollBox.scrollTo(0, 1, toTheBottom);
		}
		
		private function toTheBottom():void 
		{
			scrollBox.scrollTo(1, 1, toTheTop);
		}
		
		
		private function click(e:MouseEvent):void 
		{
			
			trace(this, scrollBox.props.offsetY);
			//scrollBox.layout.addChild(glifFactory());
			//scrollBox.layout.update();
		}
		
		
			
		private function glifFactory():Sprite
		{
			var res:Sprite = new TestPage();/*
			res.graphics.beginFill(Math.random() * 0xdddddd,0.6);
			res.graphics.drawRect(0, 0, int(Math.random() * 60) + 100, int(Math.random() * 60) + 100);
			res.graphics.endFill();*/
			return res;
			
		}
	}

}