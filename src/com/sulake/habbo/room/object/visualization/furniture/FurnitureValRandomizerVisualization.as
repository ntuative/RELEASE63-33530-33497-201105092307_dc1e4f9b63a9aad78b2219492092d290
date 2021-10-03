package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1027:int = 20;
      
      private static const const_662:int = 10;
      
      private static const const_1412:int = 31;
      
      private static const const_1366:int = 32;
      
      private static const const_661:int = 30;
       
      
      private var var_298:Array;
      
      private var var_811:Boolean = false;
      
      public function FurnitureValRandomizerVisualization()
      {
         this.var_298 = new Array();
         super();
         super.setAnimation(const_661);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 0)
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
         if(param1 > 0 && param1 <= const_662)
         {
            if(this.var_811)
            {
               this.var_811 = false;
               this.var_298 = new Array();
               if(direction == 2)
               {
                  this.var_298.push(const_1027 + 5 - param1);
                  this.var_298.push(const_662 + 5 - param1);
               }
               else
               {
                  this.var_298.push(const_1027 + param1);
                  this.var_298.push(const_662 + param1);
               }
               this.var_298.push(const_661);
               return;
            }
            super.setAnimation(const_661);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(11))
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
