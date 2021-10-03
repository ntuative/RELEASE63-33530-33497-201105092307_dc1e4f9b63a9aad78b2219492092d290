package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1366:int = 3;
      
      private static const const_1409:int = 2;
      
      private static const const_1408:int = 1;
      
      private static const const_1410:int = 15;
       
      
      private var var_298:Array;
      
      private var var_1151:int;
      
      public function FurnitureQueueTileVisualization()
      {
         this.var_298 = new Array();
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == const_1409)
         {
            this.var_298 = new Array();
            this.var_298.push(const_1408);
            this.var_1151 = const_1410;
         }
         super.setAnimation(param1);
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(this.var_1151 > 0)
         {
            --this.var_1151;
         }
         if(this.var_1151 == 0)
         {
            if(this.var_298.length > 0)
            {
               super.setAnimation(this.var_298.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}
