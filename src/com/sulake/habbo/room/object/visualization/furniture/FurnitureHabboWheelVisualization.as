package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureHabboWheelVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1027:int = 10;
      
      private static const const_662:int = 20;
      
      private static const const_1412:int = 31;
      
      private static const const_1366:int = 32;
       
      
      private var var_298:Array;
      
      private var var_811:Boolean = false;
      
      public function FurnitureHabboWheelVisualization()
      {
         this.var_298 = new Array();
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == -1)
         {
            if(!this.var_811)
            {
               this.var_811 = true;
               this.var_298 = new Array();
               this.var_298.push(const_1412);
               this.var_298.push(const_1366);
               return;
            }
         }
         if(param1 > 0 && param1 <= const_1027)
         {
            if(this.var_811)
            {
               this.var_811 = false;
               this.var_298 = new Array();
               this.var_298.push(const_1027 + param1);
               this.var_298.push(const_662 + param1);
               this.var_298.push(param1);
               return;
            }
            super.setAnimation(param1);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(1) && super.getLastFramePlayed(2) && super.getLastFramePlayed(3))
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
