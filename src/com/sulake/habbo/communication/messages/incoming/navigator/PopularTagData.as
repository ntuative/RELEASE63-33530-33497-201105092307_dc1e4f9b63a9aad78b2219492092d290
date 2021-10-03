package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PopularTagData
   {
       
      
      private var var_2457:String;
      
      private var var_2456:int;
      
      public function PopularTagData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2457 = param1.readString();
         this.var_2456 = param1.readInteger();
      }
      
      public function get tagName() : String
      {
         return this.var_2457;
      }
      
      public function get userCount() : int
      {
         return this.var_2456;
      }
   }
}
