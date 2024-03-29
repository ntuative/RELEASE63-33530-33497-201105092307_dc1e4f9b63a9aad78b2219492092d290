package com.sulake.habbo.room.object.visualization.room.utils
{
   import flash.display.BitmapData;
   
   public class PlaneBitmapData
   {
       
      
      private var _bitmap:BitmapData = null;
      
      private var var_1823:int = 0;
      
      public function PlaneBitmapData(param1:BitmapData, param2:int)
      {
         super();
         this._bitmap = param1;
         this.var_1823 = param2;
      }
      
      public function get bitmap() : BitmapData
      {
         return this._bitmap;
      }
      
      public function get timeStamp() : int
      {
         return this.var_1823;
      }
      
      public function dispose() : void
      {
         this._bitmap = null;
      }
   }
}
