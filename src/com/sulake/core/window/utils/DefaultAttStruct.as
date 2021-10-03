package com.sulake.core.window.utils
{
   public class DefaultAttStruct
   {
      
      public static var var_2081:Boolean = false;
       
      
      public var color:uint = 16777215;
      
      public var background:Boolean = false;
      
      public var blend:Number = 1.0;
      
      public var var_2894:uint = 10;
      
      public var width_min:int = -2.147483648E9;
      
      public var width_max:int = 2.147483647E9;
      
      public var height_min:int = -2.147483648E9;
      
      public var height_max:int = 2.147483647E9;
      
      public function DefaultAttStruct()
      {
         super();
      }
      
      public function hasRectLimits() : Boolean
      {
         return var_2081 && (this.width_min > int.MIN_VALUE || this.height_min > int.MIN_VALUE || this.width_max < int.MAX_VALUE || this.height_max < int.MAX_VALUE);
      }
   }
}
