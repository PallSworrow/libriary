package scrollers.propsObjects 
{
	/**
	 * ...
	 * @author 
	 */
	public class ScrollProperties 
	{
		public var snapToPages:Boolean = true;//вызывать функцию snap() после каждой прокрутки
		public var snapDuration:Number = 0.4;//время отведенное на метод snap()
		public var scrollDuration:Number = 0.6;//время отведенное на прокутку если параметр duration метода scrollTo не был задан, или при вызове акссессора set position
		public function ScrollProperties() 
		{
			
		}
		
	}

}