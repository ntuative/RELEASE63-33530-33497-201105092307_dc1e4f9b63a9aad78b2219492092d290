package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   
   public class RoomObjectRoomActionEvent extends RoomObjectEvent
   {
      
      public static const const_1729:String = "RORAE_LEAVE_ROOM";
      
      public static const const_488:String = "RORAE_CHANGE_ROOM";
      
      public static const const_587:String = "RORAE_TRY_BUS";
       
      
      private var var_19:int = 0;
      
      public function RoomObjectRoomActionEvent(param1:String, param2:int, param3:int, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param3,param4,param5,param6);
         this.var_19 = param2;
      }
      
      public function get param() : int
      {
         return this.var_19;
      }
   }
}
