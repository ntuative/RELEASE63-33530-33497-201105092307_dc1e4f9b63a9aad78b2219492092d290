package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ChatlineData
   {
       
      
      private var var_2468:int;
      
      private var var_2469:int;
      
      private var var_2466:int;
      
      private var var_2467:String;
      
      private var var_1726:String;
      
      public function ChatlineData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2468 = param1.readInteger();
         this.var_2469 = param1.readInteger();
         this.var_2466 = param1.readInteger();
         this.var_2467 = param1.readString();
         this.var_1726 = param1.readString();
      }
      
      public function get hour() : int
      {
         return this.var_2468;
      }
      
      public function get minute() : int
      {
         return this.var_2469;
      }
      
      public function get chatterId() : int
      {
         return this.var_2466;
      }
      
      public function get chatterName() : String
      {
         return this.var_2467;
      }
      
      public function get msg() : String
      {
         return this.var_1726;
      }
   }
}
