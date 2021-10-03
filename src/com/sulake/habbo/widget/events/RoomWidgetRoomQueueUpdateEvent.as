package com.sulake.habbo.widget.events
{
   public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_404:String = "RWRQUE_VISITOR_QUEUE_STATUS";
      
      public static const const_603:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";
       
      
      private var var_1188:int;
      
      private var var_2818:Boolean;
      
      private var var_398:Boolean;
      
      private var var_1776:Boolean;
      
      public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.var_1188 = param2;
         this.var_2818 = param3;
         this.var_398 = param4;
         this.var_1776 = param5;
      }
      
      public function get position() : int
      {
         return this.var_1188;
      }
      
      public function get hasHabboClub() : Boolean
      {
         return this.var_2818;
      }
      
      public function get isActive() : Boolean
      {
         return this.var_398;
      }
      
      public function get isClubQueue() : Boolean
      {
         return this.var_1776;
      }
   }
}
