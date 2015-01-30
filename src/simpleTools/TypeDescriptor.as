package simpleTools 
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author 
	 */
	public class TypeDescriptor 
	{
		/**
		 * params specification:
			 * typeFilter(null) - Class or array of classes that defines types of variables would be iterated
			 * ignoreAccessors(false) accessors methods won't be iterated as vars
		 */
		public static function iterateVars(obj:Object, handler:Function, params:Object=null):void
		{
			if (!params) params = {};

			var filter:Array;
			var ignoreAccsessros:Boolean = false;
			if (params.typeFilter is Array) filter = params.typeFilter as Array;
			else if(params.typeFilter is Class)
			{
				filter = [params.typeFilter];
			}
			ignoreAccsessros = Boolean(params.ignoreAccesssors);
			
			
			
			var xml:XML = describeType(obj)
			var xmlList:XMLList = xml.variable;
			if (!ignoreAccsessros) xmlList += xml.accessor;
			//trace(xml);
			
			var name:String;
			var type:Class;
			var value:Object;
			
			var flag:Boolean;
			for each(var prop:XML in xmlList)
			{
				name = prop.@name;
				type  = getDefinitionByName(prop.@type) as Class;
				value = obj[prop.@name];
				if (filter)
				flag = checkType(value);
				else 
				flag = true;
				if (!flag) continue;
				
				switch(handler.length)
				{
					case 1:
						handler(name);
						break;
					case 2:
						handler(name,type);
						break;
					case 3:
						handler(name,type,value);
						break;
					case 4:
						handler(name,type,value,obj);
						break;
					default:
						throw new Error('invalid handler params number. allowed 1-4');
						break;
				}
				
			}
			function checkType(val:Object):Boolean
			{
				for (var i:int = 0; i < filter.length; i++) 
				{
					if (val is filter[i]) return true;
				}
				return false;
			}
		}
		
	}

}