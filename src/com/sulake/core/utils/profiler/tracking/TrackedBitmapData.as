package com.sulake.core.utils.profiler.tracking
{
   import flash.display.BitmapData;
   
   public class TrackedBitmapData extends BitmapData
   {
      
      public static const const_2012:int = 16777215;
      
      public static const const_1308:int = 8191;
      
      public static const const_1214:int = 8191;
      
      public static const const_2008:int = 1;
      
      public static const const_1278:int = 1;
      
      public static const const_1161:int = 1;
      
      private static var var_512:uint = 0;
      
      private static var var_513:uint = 0;
       
      
      private var var_469:Object;
      
      private var _disposed:Boolean = false;
      
      public function TrackedBitmapData(param1:*, param2:int, param3:int, param4:Boolean = true, param5:uint = 4.294967295E9)
      {
         if(param2 > const_1308)
         {
            param2 = const_1308;
         }
         else if(param2 < const_1278)
         {
            param2 = const_1278;
         }
         if(param3 > const_1214)
         {
            param3 = const_1214;
         }
         else if(param3 < const_1161)
         {
            param3 = const_1161;
         }
         super(param2,param3,param4,param5);
         ++var_512;
         var_513 += param2 * param3 * 4;
         this.var_469 = param1;
      }
      
      public static function get numInstances() : uint
      {
         return var_512;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_513;
      }
      
      override public function dispose() : void
      {
         if(!this._disposed)
         {
            var_513 -= width * height * 4;
            --var_512;
            this._disposed = true;
            this.var_469 = null;
            super.dispose();
         }
      }
   }
}
