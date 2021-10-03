package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ChangeEmailResultParser implements IMessageParser
   {
       
      
      private var _result:int;
      
      public function ChangeEmailResultParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._result = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return this._result;
      }
   }
}
