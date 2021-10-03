package com.sulake.habbo.room.object.visualization.furniture
{
   public class ResettingAnimatedFurnitureVisualization extends AnimatedFurnitureVisualization
   {
       
      
      public function ResettingAnimatedFurnitureVisualization()
      {
         super();
      }
      
      override protected function usesAnimationResetting() : Boolean
      {
         return true;
      }
   }
}
