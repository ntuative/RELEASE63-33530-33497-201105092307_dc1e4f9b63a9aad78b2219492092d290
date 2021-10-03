package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FlatCategory
   {
       
      
      private var var_1839:int;
      
      private var var_2538:String;
      
      private var var_294:Boolean;
      
      public function FlatCategory(param1:IMessageDataWrapper)
      {
         super();
         this.var_1839 = param1.readInteger();
         this.var_2538 = param1.readString();
         this.var_294 = param1.readBoolean();
      }
      
      public function get nodeId() : int
      {
         return this.var_1839;
      }
      
      public function get nodeName() : String
      {
         return this.var_2538;
      }
      
      public function get visible() : Boolean
      {
         return this.var_294;
      }
   }
}
