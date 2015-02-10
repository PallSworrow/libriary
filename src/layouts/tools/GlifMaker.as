package layouts.tools 
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import layouts.glifs.*;
	import layouts.interfaces.IglifFactory;
	import layouts.interfaces.IlayoutMethod;
	import layouts.methods.*;
	import layouts.tools.factories.CustomButtonFactory;
	import simpleButton.Button;
	import simpleButton.interfaces.IsingleButtonBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class GlifMaker implements IglifFactory
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
			factories = new Dictionary();
		}
		private var factories:Dictionary;
		//customise:
		public function addFactory(name:String, factory:Function):void
		{
			if (name == CUSTOM_LAYOUT
			|| name == VERTICAL_LAYOUT
			|| name == STRING_LAYOUT
			|| name == HORIZONTAL_LAYOUT
			|| name == TAGGED_LAYOUT
			|| name == GLIF
			|| name == BUTTON)
			throw new Error("It's mposible to use this factory name");
			if (factory.length > 1)
			throw new Error('factory can have no more than one parameter');
			
			factories[name] = factory;
		}
		public function removeFactory(name:String):void
		{
			delete factories[name];
		}
		/* INTERFACE layouts.interfaces.IglifFactory */
		
		public function createDisplayObject(data:Object = null):DisplayObject 
		{
			return createGlif(data);
		}
		public function createGlif(data:Object = null ):Glif
		{
			if(!data)
			return new Glif();
			if (data is Array)
			{
				data = { type:VERTICAL_LAYOUT, list:data };
			}
			var res:Glif;
			var factory:Function;
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
				case BUTTON:
					if (!data.provider) throw new Error('BUTTON glif data must have not-null "provider" parameter: '+data.provider);
					res = createBtn(data.provider, data.handler as Function,data.handlerParams, data.group as String, data.behavior as IsingleButtonBehavior);
					break;
				case GLIF:
					res = createGlif(data);
					break;
				default:
					//check for custom factories
					factory = factories[data.type];
					if (factory is Function)
					{
						switch(factory.length)
						{
							case 0:
								res = factory();
								break;
							case 1:
								res = factory(data);
								break;
						}
					}
					else
					throw new Error('there is no factory with name: ' + data.type);
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
		protected function createBtn(provider:Object, handler:Function, handlerParams:Object,group:String, behavior:IsingleButtonBehavior):Glif
		{
			return CustomButtonFactory.createBtn(provider, group, behavior, handler, handlerParams);
		}
		protected function createGlif(data:Object):Glif
		{
			var res:Glif;
			if (data is Glif)
			{
				res = data as Glif;
			}
			else if (data is DisplayObject)
			{
				res = new Glif();
				res.addChild(data as DisplayObject);
			}
			else
			{
				throw new Error('GLIF must be a Glif or a DisplayObject instance');
			}
			return res;
		}
	}

}