package com.sulake.habbo.room.object.visualization.data
{
   public class LayerData
   {
      
      public static const const_710:String = "";
      
      public static const const_445:int = 0;
      
      public static const const_494:int = 255;
      
      public static const const_968:Boolean = false;
      
      public static const const_526:int = 0;
      
      public static const const_520:int = 0;
      
      public static const const_398:int = 0;
      
      public static const const_1218:int = 1;
      
      public static const const_1152:int = 2;
      
      public static const INK_DARKEN:int = 3;
       
      
      private var var_2470:String = "";
      
      private var var_1712:int = 0;
      
      private var var_2610:int = 255;
      
      private var var_2801:Boolean = false;
      
      private var var_2802:int = 0;
      
      private var var_2803:int = 0;
      
      private var var_2800:Number = 0;
      
      public function LayerData()
      {
         super();
      }
      
      public function set tag(param1:String) : void
      {
         this.var_2470 = param1;
      }
      
      public function get tag() : String
      {
         return this.var_2470;
      }
      
      public function set ink(param1:int) : void
      {
         this.var_1712 = param1;
      }
      
      public function get ink() : int
      {
         return this.var_1712;
      }
      
      public function set alpha(param1:int) : void
      {
         this.var_2610 = param1;
      }
      
      public function get alpha() : int
      {
         return this.var_2610;
      }
      
      public function set ignoreMouse(param1:Boolean) : void
      {
         this.var_2801 = param1;
      }
      
      public function get ignoreMouse() : Boolean
      {
         return this.var_2801;
      }
      
      public function set xOffset(param1:int) : void
      {
         this.var_2802 = param1;
      }
      
      public function get xOffset() : int
      {
         return this.var_2802;
      }
      
      public function set yOffset(param1:int) : void
      {
         this.var_2803 = param1;
      }
      
      public function get yOffset() : int
      {
         return this.var_2803;
      }
      
      public function set zOffset(param1:Number) : void
      {
         this.var_2800 = param1;
      }
      
      public function get zOffset() : Number
      {
         return this.var_2800;
      }
      
      public function copyValues(param1:LayerData) : void
      {
         if(param1 != null)
         {
            this.tag = param1.tag;
            this.ink = param1.ink;
            this.alpha = param1.alpha;
            this.ignoreMouse = param1.ignoreMouse;
            this.xOffset = param1.xOffset;
            this.yOffset = param1.yOffset;
            this.zOffset = param1.zOffset;
         }
      }
   }
}
