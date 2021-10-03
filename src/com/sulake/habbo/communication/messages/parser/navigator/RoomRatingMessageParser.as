package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomRatingMessageParser implements IMessageParser
   {
       
      
      private var var_1992:int;
      
      public function RoomRatingMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1992 = param1.readInteger();
         return true;
      }
      
      public function get rating() : int
      {
         return this.var_1992;
      }
   }
}
