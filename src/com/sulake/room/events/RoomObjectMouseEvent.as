package com.sulake.room.events
{
   public class RoomObjectMouseEvent extends RoomObjectEvent
   {
      
      public static const const_156:String = "ROE_MOUSE_CLICK";
      
      public static const const_180:String = "ROE_MOUSE_ENTER";
      
      public static const const_480:String = "ROE_MOUSE_MOVE";
      
      public static const const_177:String = "ROE_MOUSE_LEAVE";
      
      public static const const_2050:String = "ROE_MOUSE_DOUBLE_CLICK";
      
      public static const const_484:String = "ROE_MOUSE_DOWN";
       
      
      private var var_2003:String = "";
      
      private var var_2209:Boolean;
      
      private var var_2208:Boolean;
      
      private var var_2213:Boolean;
      
      private var var_2206:Boolean;
      
      public function RoomObjectMouseEvent(param1:String, param2:String, param3:int, param4:String, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false)
      {
         super(param1,param3,param4,param9,param10);
         this.var_2003 = param2;
         this.var_2209 = param5;
         this.var_2208 = param6;
         this.var_2213 = param7;
         this.var_2206 = param8;
      }
      
      public function get eventId() : String
      {
         return this.var_2003;
      }
      
      public function get altKey() : Boolean
      {
         return this.var_2209;
      }
      
      public function get ctrlKey() : Boolean
      {
         return this.var_2208;
      }
      
      public function get shiftKey() : Boolean
      {
         return this.var_2213;
      }
      
      public function get buttonDown() : Boolean
      {
         return this.var_2206;
      }
   }
}
