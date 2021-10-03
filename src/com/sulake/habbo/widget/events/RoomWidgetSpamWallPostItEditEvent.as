package com.sulake.habbo.widget.events
{
   public class RoomWidgetSpamWallPostItEditEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_598:String = "RWSWPUE_OPEN_EDITOR";
       
      
      private var var_194:int;
      
      private var var_462:String;
      
      public function RoomWidgetSpamWallPostItEditEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.var_194 = param2;
         this.var_462 = param3;
      }
      
      public function get location() : String
      {
         return this.var_462;
      }
      
      public function get objectId() : int
      {
         return this.var_194;
      }
   }
}
