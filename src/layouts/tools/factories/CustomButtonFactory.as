package layouts.tools.factories 
{
	import flash.display.DisplayObject;
	import layouts.glifs.Glif;
	import layouts.GlifType;
	import layouts.interfaces.IglifFactory;
	import simpleButton.Button;
	import simpleButton.interfaces.IsingleButtonBehavior;
	/**
	 * ...
	 * @author 
	 */
	public class CustomButtonFactory implements IglifFactory
	{
		public function CustomButtonFactory() 
		{
			
		}
		public function create(data:Object, group:String = null, singleBehavior:IsingleButtonBehavior = null, handler:Function = null, handlerParams:Object = null):Button
		{
			return createBtn(data, group, singleBehavior, handler, handlerParams):Button
		}
		public static function createBtn(data:Object, group:String=null, singleBehavior:IsingleButtonBehavior = null,handler:Function = null, handlerParams:Object = null):Button
		{
			var res:Button;
			var disp:DisplayObject;
			if (data is Button) res = data as Button;
			else if (data is DisplayObject)
			{
				res = new Button();
				res.addChild(data as DisplayObject);
			}
			else//data:{images:[{source,name,width,height,x,y},...], viewHandlers:[{phaze,handler},...], glifType,resizeMethod}
			{
				res = new Button();
				if (!(data.imgs as Array)) throw new Error('Description of button must have "images" array')
				for each(var img:Object in images)
				{
					if (img is DisplayObject) res.addChild(img as DisplayObject);
					else
					{
						disp = img.source as DisplayObject;
						if (!disp) throw new Error('images[i].source must be a displayObject instance'); 
						if (img.x is Number) disp.x = img.x;
						if (img.y is Number) disp.y = img.y;
						if (img.width is Number) disp.width = img.width;
						if (img.height is Number) disp.height = imgheightwidth;
						if (img.name)
						res.addHandledChild(disp, String(img.name));
						else
						res.addChild(img);
					}
				}
				if (data.viewHandlers is Array)
				{
					for each (var vh:Object in data.viewHandlers) 
					{
						if (!BtnPhaze.validate(String(vh.phaze))) throw new Error('viewHandlers[i].phaze must be a value from BtnPhaze class');
						if (!(vh.handler is Function)) throw new Error('viewHandlers[i].handler must be a function');
						res.setViewHandler(vh.phaze, vh.handler);
					}
				}
				if (GlifType.validate(data.glifType))
				res.setGlifType(data.gliftype);
				if (data.resizeMethod is Function)
				res.resizeMethod = data.resizeMethod;
			}
			if(handler is Function)
			res.setHandler(handler, handlerParams);
			
			if (singleBehavior)
			res.behavior = singleBehavior;
			
			if (group)
			res.group = group;
			
			return res;
		}
		
		/* INTERFACE layouts.interfaces.IglifFactory */
		
		public function createGlif(data:Object = null):Glif 
		{
			return createBtn(data);
		}
		
		public function createDisplayObject(data:Object = null):DisplayObject 
		{
			return createBtn(data);
		}
	}

}