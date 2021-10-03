package com.sulake.habbo.room.object
{
   public class RoomPlaneMaskData
   {
       
      
      private var var_2284:Number = 0.0;
      
      private var var_2281:Number = 0.0;
      
      private var var_2282:Number = 0.0;
      
      private var var_2283:Number = 0.0;
      
      public function RoomPlaneMaskData(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         this.var_2284 = param1;
         this.var_2281 = param2;
         this.var_2282 = param3;
         this.var_2283 = param4;
      }
      
      public function get leftSideLoc() : Number
      {
         return this.var_2284;
      }
      
      public function get rightSideLoc() : Number
      {
         return this.var_2281;
      }
      
      public function get leftSideLength() : Number
      {
         return this.var_2282;
      }
      
      public function get rightSideLength() : Number
      {
         return this.var_2283;
      }
   }
}
