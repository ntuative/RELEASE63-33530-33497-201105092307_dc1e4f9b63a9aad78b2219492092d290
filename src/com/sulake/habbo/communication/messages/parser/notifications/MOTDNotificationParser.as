package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class MOTDNotificationParser implements IMessageParser
   {
       
      
      private var var_1575:Array;
      
      public function MOTDNotificationParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_1575 = new Array();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1575.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get messages() : Array
      {
         return this.var_1575;
      }
   }
}
