package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectRoomPlanePropertyUpdateMessage extends RoomObjectUpdateMessage
   {
      
      public static const const_1100:String = "RORPPUM_WALL_THICKNESS";
      
      public static const const_1075:String = "RORPVUM_FLOOR_THICKNESS";
       
      
      private var _type:String = "";
      
      private var var_178:Number = 0.0;
      
      public function RoomObjectRoomPlanePropertyUpdateMessage(param1:String, param2:Number)
      {
         super(null,null);
         this._type = param1;
         this.var_178 = param2;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get value() : Number
      {
         return this.var_178;
      }
   }
}
