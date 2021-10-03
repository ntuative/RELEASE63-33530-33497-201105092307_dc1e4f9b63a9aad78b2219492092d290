package com.sulake.habbo.room.object.visualization.data
{
   public class ColorData
   {
      
      public static const const_73:uint = 16777215;
       
      
      private var _colors:Array;
      
      public function ColorData(param1:int)
      {
         this._colors = [];
         super();
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this._colors.push(const_73);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         this._colors = null;
      }
      
      public function setColor(param1:uint, param2:int) : void
      {
         if(param2 < 0 || param2 >= this._colors.length)
         {
            return;
         }
         this._colors[param2] = param1;
      }
      
      public function getColor(param1:int) : uint
      {
         if(param1 < 0 || param1 >= this._colors.length)
         {
            return const_73;
         }
         return this._colors[param1];
      }
   }
}
