package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RequestSpamWallPostItMessageParser implements IMessageParser
   {
       
      
      private var var_1925:int;
      
      private var var_462:String;
      
      public function RequestSpamWallPostItMessageParser()
      {
         super();
      }
      
      public function get itemId() : int
      {
         return this.var_1925;
      }
      
      public function get location() : String
      {
         return this.var_462;
      }
      
      public function flush() : Boolean
      {
         this.var_1925 = -1;
         this.var_462 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this.var_1925 = param1.readInteger();
         this.var_462 = param1.readString();
         return true;
      }
   }
}
