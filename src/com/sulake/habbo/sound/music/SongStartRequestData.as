package com.sulake.habbo.sound.music
{
   import flash.utils.getTimer;
   
   public class SongStartRequestData
   {
       
      
      private var var_1650:int;
      
      private var var_1935:Number;
      
      private var var_2672:Number;
      
      private var var_2670:int;
      
      private var var_2669:Number;
      
      private var var_2671:Number;
      
      public function SongStartRequestData(param1:int, param2:Number, param3:Number, param4:Number = 2.0, param5:Number = 1.0)
      {
         super();
         this.var_1650 = param1;
         this.var_1935 = param2;
         this.var_2672 = param3;
         this.var_2669 = param4;
         this.var_2671 = param5;
         this.var_2670 = getTimer();
      }
      
      public function get songId() : int
      {
         return this.var_1650;
      }
      
      public function get startPos() : Number
      {
         if(this.var_1935 < 0)
         {
            return 0;
         }
         return this.var_1935 + (getTimer() - this.var_2670) / 1000;
      }
      
      public function get playLength() : Number
      {
         return this.var_2672;
      }
      
      public function get fadeInSeconds() : Number
      {
         return this.var_2669;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return this.var_2671;
      }
   }
}
