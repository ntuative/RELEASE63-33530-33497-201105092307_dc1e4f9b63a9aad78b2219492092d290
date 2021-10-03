package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FriendRequestData
   {
       
      
      private var var_1228:int;
      
      private var var_2160:String;
      
      private var var_2161:int;
      
      public function FriendRequestData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1228 = param1.readInteger();
         this.var_2160 = param1.readString();
         this.var_2161 = int(param1.readString());
      }
      
      public function get requestId() : int
      {
         return this.var_1228;
      }
      
      public function get requesterName() : String
      {
         return this.var_2160;
      }
      
      public function get requesterUserId() : int
      {
         return this.var_2161;
      }
   }
}
