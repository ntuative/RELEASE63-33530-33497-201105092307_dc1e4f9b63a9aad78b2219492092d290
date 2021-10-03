package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class DoorbellMessageParser implements IMessageParser
   {
       
      
      private var _userName:String;
      
      public function DoorbellMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._userName = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         this._userName = null;
         return true;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
   }
}
