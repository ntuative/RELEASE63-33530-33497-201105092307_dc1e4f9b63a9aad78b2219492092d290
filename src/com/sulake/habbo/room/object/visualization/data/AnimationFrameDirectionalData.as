package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationFrameDirectionalData extends AnimationFrameData
   {
       
      
      private var var_970:DirectionalOffsetData;
      
      public function AnimationFrameDirectionalData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:DirectionalOffsetData, param7:int)
      {
         super(param1,param2,param3,param4,param5,param7);
         this.var_970 = param6;
      }
      
      override public function hasDirectionalOffsets() : Boolean
      {
         return this.var_970 != null;
      }
      
      override public function getX(param1:int) : int
      {
         if(this.var_970 != null)
         {
            return this.var_970.getOffsetX(param1,super.getX(param1));
         }
         return super.getX(param1);
      }
      
      override public function getY(param1:int) : int
      {
         if(this.var_970 != null)
         {
            return this.var_970.getOffsetY(param1,super.getY(param1));
         }
         return super.getY(param1);
      }
   }
}
