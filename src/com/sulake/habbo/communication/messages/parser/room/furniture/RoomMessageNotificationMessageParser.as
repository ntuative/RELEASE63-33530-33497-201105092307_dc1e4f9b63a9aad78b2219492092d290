package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomMessageNotificationMessageParser implements IMessageParser
   {
       
      
      private var _roomId:int;
      
      private var var_975:String;
      
      private var var_1092:int;
      
      public function RoomMessageNotificationMessageParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomName() : String
      {
         return this.var_975;
      }
      
      public function get messageCount() : int
      {
         return this.var_1092;
      }
      
      public function flush() : Boolean
      {
         this._roomId = -1;
         this.var_975 = "";
         this.var_1092 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._roomId = param1.readInteger();
         this.var_975 = param1.readString();
         this.var_1092 = param1.readInteger();
         return true;
      }
   }
}
