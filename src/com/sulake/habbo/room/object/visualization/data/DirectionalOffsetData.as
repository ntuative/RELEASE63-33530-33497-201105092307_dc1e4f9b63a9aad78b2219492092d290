package com.sulake.habbo.room.object.visualization.data
{
   import flash.utils.Dictionary;
   
   public class DirectionalOffsetData
   {
       
      
      private var _offsetX:Dictionary;
      
      private var var_1105:Dictionary;
      
      public function DirectionalOffsetData()
      {
         this._offsetX = new Dictionary();
         this.var_1105 = new Dictionary();
         super();
      }
      
      public function getOffsetX(param1:int, param2:int) : int
      {
         if(this._offsetX[param1] == null)
         {
            return param2;
         }
         return this._offsetX[param1];
      }
      
      public function getOffsetY(param1:int, param2:int) : int
      {
         if(this.var_1105[param1] == null)
         {
            return param2;
         }
         return this.var_1105[param1];
      }
      
      public function setOffset(param1:int, param2:int, param3:int) : void
      {
         this._offsetX[param1] = param2;
         this.var_1105[param1] = param3;
      }
   }
}
