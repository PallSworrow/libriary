package layouts.tools 
{
	import layouts.glifs.Glif;
	import layouts.glifs.Layout;
	import layouts.glifs.LayoutMethodProps;
	import layouts.interfaces.IlayoutMethod;
	import layouts.methods.HorizontalList;
	import layouts.methods.StringLayout;
	import layouts.methods.TagsLayout;
	import layouts.methods.VerticalList;
	import simpleTools.TypeDescriptor;
	/**
	 * ...
	 * @author 
	 */
	public class GlifMaker 
	{
		//lists:
		public static const CUSTOM_LAYOUT:String = 'custom_layout';
		public static const VERTICAL_LAYOUT:String = 'vertical_layout';
		public static const STRING_LAYOUT:String = '_layout';
		public static const HORIZONTAL_LAYOUT:String = 'horizontal_layout';
		public static const TAGGED_LAYOUT:String = 'tagged_layout';
		//factories
		public static const GLIF:String = 'glif';
		public static const BUTTON:String = 'button';
		/**
		 * Основаная суть:
		 * Принимает на вход либо array либо {}  и возвращает самодостаточный glif, способный автоматически обновлять свои layout-ы, в зависимости от содержимого
		 * имеет набор фабрик, доступных при указании нужного type в {}.
		 * возможность добавлять собственные именованные фабрики
		 */
		public function GlifMaker() 
		{
			
		}
		public function createGlif(data:Object):Glif
		{
			if (data is Array)
			{
				data = { type:VERTICAL_LAYOUT, list:data };
			}
			var res:Glif;
			var layout:Layout;
			switch(data.type)
			{
				case CUSTOM_LAYOUT:
					if (!(data.method is IlayoutMethod)) data.method = new VerticalList();
					res = createLayout(data.method as IlayoutMethod, data.list as Array, data.params);
					break;
				case VERTICAL_LAYOUT:
					res = createLayout(new VerticalList(), data.list as Array, data.params);
					break;
				case HORIZONTAL_LAYOUT:
					res = createLayout(new HorizontalList(), data.list as Array, data.params);
					break;
				case STRING_LAYOUT:
					res = createLayout(new StringLayout(), data.list as Array, data.params);
					break;
				case TAGGED_LAYOUT:
					res = createLayout(new TagsLayout(data.markers as Array), data.list as Array, data.params);
					break;
				default:
					//check for custom factories
					break
			}
			return res;
		}
		
		//factories:
		protected function createLayout(method:IlayoutMethod, list:Array, props:Object=null):Glif
		{
			var res:Layout = new Layout();
			res.method = method;
			if (props)
			{
				if (prop is LayoutMethodProps)
				res.method.properties = props;
				else
				res.method.properties.parseParams(props);
			}
			
			if (list)
			{
				for (var i:int = 0; i < list.length; i++) 
				{
					res.addChild(createGlif(list[i]));//!!  recursion
				}
			}
			res.update();
			return res;
		}
		protected function createBtn():void
		{
			
		}
		protected function createGlif():void
		{
			
		}
	}

}