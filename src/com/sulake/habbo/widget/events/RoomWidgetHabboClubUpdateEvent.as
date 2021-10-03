package com.sulake.habbo.widget.events
{
   public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_295:String = "RWBIUE_HABBO_CLUB";
       
      
      private var var_2383:int = 0;
      
      private var var_2384:int = 0;
      
      private var var_2382:int = 0;
      
      private var var_2385:Boolean = false;
      
      private var var_2306:int;
      
      public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:int, param6:Boolean = false, param7:Boolean = false)
      {
         super(const_295,param6,param7);
         this.var_2383 = param1;
         this.var_2384 = param2;
         this.var_2382 = param3;
         this.var_2385 = param4;
         this.var_2306 = param5;
      }
      
      public function get daysLeft() : int
      {
         return this.var_2383;
      }
      
      public function get periodsLeft() : int
      {
         return this.var_2384;
      }
      
      public function get pastPeriods() : int
      {
         return this.var_2382;
      }
      
      public function get allowClubDances() : Boolean
      {
         return this.var_2385;
      }
      
      public function get clubLevel() : int
      {
         return this.var_2306;
      }
   }
}
