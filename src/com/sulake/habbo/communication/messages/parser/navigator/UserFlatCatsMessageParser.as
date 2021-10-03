package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   
   public class UserFlatCatsMessageParser implements IMessageParser
   {
       
      
      private var var_1510:Array;
      
      public function UserFlatCatsMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1510 = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1510.push(new FlatCategory(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         this.var_1510 = null;
         return true;
      }
      
      public function get nodes() : Array
      {
         return this.var_1510;
      }
   }
}
