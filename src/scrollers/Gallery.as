package scrollers 
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import layouts.glifs.Glif;
	import scrollers.bases.ScrollBar;
	import scrollers.bases.ScrollContainer;
	
	/**
	 * ...
	 * @author 
	 */
	public class Gallery extends Glif 
	{
		private var container:ScrollContainer;
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