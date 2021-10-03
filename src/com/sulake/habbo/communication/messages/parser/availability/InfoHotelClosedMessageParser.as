package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class InfoHotelClosedMessageParser implements IMessageParser
   {
       
      
      private var _openHour:int;
      
      private var var_1678:int;
      
      private var var_2075:Boolean;
      
      public function InfoHotelClosedMessageParser()
      {
         super();
      }
      
      public function get openHour() : int
      {
         return this._openHour;
      }
      
      public function get openMinute() : int
      {
         return this.var_1678;
      }
      
      public function get userThrownOutAtClose() : Boolean
      {
         return this.var_2075;
      }
      
      public function flush() : Boolean
      {
         this._openHour = 0;
         this.var_1678 = 0;
         this.var_2075 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._openHour = param1.readInteger();
         this.var_1678 = param1.readInteger();
         this.var_2075 = param1.readInteger() > 0;
         return true;
      }
   }
}
