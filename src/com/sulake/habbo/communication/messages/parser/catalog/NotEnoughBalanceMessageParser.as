package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class NotEnoughBalanceMessageParser implements IMessageParser
   {
       
      
      private var var_1796:int = 0;
      
      private var var_1795:int = 0;
      
      private var var_2050:int = 0;
      
      public function NotEnoughBalanceMessageParser()
      {
         super();
      }
      
      public function get notEnoughCredits() : int
      {
         return this.var_1796;
      }
      
      public function get notEnoughActivityPoints() : int
      {
         return this.var_1795;
      }
      
      public function get activityPointType() : int
      {
         return this.var_2050;
      }
      
      public function flush() : Boolean
      {
         this.var_1796 = 0;
         this.var_1795 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1796 = param1.readInteger();
         this.var_1795 = param1.readInteger();
         this.var_2050 = param1.readInteger();
         return true;
      }
   }
}
