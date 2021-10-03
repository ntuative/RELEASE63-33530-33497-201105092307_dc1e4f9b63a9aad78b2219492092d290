package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
   public class LayoutRasterizerData
   {
       
      
      private var var_1778:XMLList;
      
      public function LayoutRasterizerData(param1:XML)
      {
         super();
         this.var_1778 = param1.elements.element;
      }
      
      public function get elementList() : XMLList
      {
         return this.var_1778;
      }
      
      public function dispose() : void
      {
         this.var_1778 = null;
      }
   }
}
