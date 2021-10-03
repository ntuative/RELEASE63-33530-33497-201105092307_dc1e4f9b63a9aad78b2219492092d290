package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class BadgeAndPointLimit
   {
       
      
      private var var_304:String;
      
      private var var_2048:int;
      
      public function BadgeAndPointLimit(param1:String, param2:IMessageDataWrapper)
      {
         super();
         this.var_304 = "ACH_" + param1 + param2.readInteger();
         this.var_2048 = param2.readInteger();
      }
      
      public function get badgeId() : String
      {
         return this.var_304;
      }
      
      public function get limit() : int
      {
         return this.var_2048;
      }
   }
}
