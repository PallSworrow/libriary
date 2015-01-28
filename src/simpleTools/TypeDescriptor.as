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
		
		public static function iterateVars(obj:Object, typeFilter:Object,handler:Function):void
		{
			//example in musician profile
			var filter:Array;
			if (typeFilter is Array) filter = typeFilter as Array;
			else if(typeFilter is Class)
			{
				filter = [typeFilter];
			}
			var xmlList:XMLList = describeType(obj).variable;
			//trace(describeType(obj));
			
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