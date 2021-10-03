package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomSettingsSaveErrorMessageParser implements IMessageParser
   {
      
      public static const const_2034:int = 1;
      
      public static const const_2081:int = 2;
      
      public static const const_2018:int = 3;
      
      public static const const_1986:int = 4;
      
      public static const const_1810:int = 5;
      
      public static const const_2102:int = 6;
      
      public static const const_1583:int = 7;
      
      public static const const_1841:int = 8;
      
      public static const const_2106:int = 9;
      
      public static const const_1778:int = 10;
      
      public static const const_1720:int = 11;
      
      public static const const_1798:int = 12;
       
      
      private var _roomId:int;
      
      private var var_1662:int;
      
      private var var_1490:String;
      
      public function RoomSettingsSaveErrorMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._roomId = param1.readInteger();
         this.var_1662 = param1.readInteger();
         this.var_1490 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get errorCode() : int
      {
         return this.var_1662;
      }
      
      public function get info() : String
      {
         return this.var_1490;
      }
   }
}
