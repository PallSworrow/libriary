package scrollers.propsObjects 
{
	import constants.AlignType;
	/**
	 * ...
	 * @author 
	 */
	public class ScrollerViewProperies 
	{
		//READY TO USE:
		public var alignX:String=AlignType.CENTER;//определяет выравнивание по горизонтали
		public var alignY:String = AlignType.TOP;//определяет выравнивание по вертикали
		public var offsetX:int=0;//определяет смещение по горизонтали
		public var offsetY:int=0;//определяет смещение по вертикали
		public var offsetBegin:int=0;//отступ перед контент-блоком
		public var offsetEnd:int=0;//отступ после контент-блока
		public var interactiveFlor:Boolean = true;//разрешить взаиводействие с фоном
		public var scrollStep:Number = 0.3;//шаг прокрутки. различные вариации использования
		public var controllerOvertakeDuration:Number = 0.4;//время за которое скроллер догоняет значение position своего контроллера
		public var swipeEnabled:Boolean = true;//поддержка свайпа
		public var swipeOverTakeDuration:Number = 0.3;//время за которое будет прокручено расстоняние определенное свайп-жестом
		public var stiffDrag:Boolean = true;//жесткая привязка к указателю при драге. при false - скроллер будет догонять указатель(палец/мышь) так же как догоняет вой контроллер
		
		//IN PROJECT:
		public function ScrollerViewProperies() 
		{
			
		}
		
	}

}