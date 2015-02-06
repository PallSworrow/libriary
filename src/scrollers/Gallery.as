package scrollers 
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import layouts.glifs.Glif;
	import scrollers.bases.ScrollBar;
	import scrollers.bases.ScrollContainer;
	
	/**
	 * Функционал gallery:
		 * создает объект scroller и scrollBar связывает их контроллером и привязывает пропорции скролл-бара к скроллеру.
		 * выдает в публичный доступ к скроллеру и скроллбару для настройки и расмещения.
		 * управляет видимостью скроллбара.
		 * обеспечивает добавление/удаление элементов через itemProvider
		 * позволяет связать содержимое с arrayObserver?
		 * позволяет задать ссылки на объекты arrows и пр. на которые вещается доп функционал
		 * диспатчит события контроллера
	 * @author 
	 */
	public class Gallery extends Glif 
	{
		private var container:LayoutScroller;
		private var sb:ScrollBar;
		private var controller:ScrollController;
		
		private var nextArrow:InteractiveObject;
		private var prevArrow:InteractiveObject;
		private var arrow_step:int = 1;
		
		public function Gallery() 
		{
			super();
			
		}
		
	}

}