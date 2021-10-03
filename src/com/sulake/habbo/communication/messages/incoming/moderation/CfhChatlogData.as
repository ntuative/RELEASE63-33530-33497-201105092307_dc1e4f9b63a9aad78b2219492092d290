package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CfhChatlogData
   {
       
      
      private var var_1696:int;
      
      private var var_2303:int;
      
      private var var_1491:int;
      
      private var var_2304:int;
      
      private var var_120:RoomChatlogData;
      
      public function CfhChatlogData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1696 = param1.readInteger();
         this.var_2303 = param1.readInteger();
         this.var_1491 = param1.readInteger();
         this.var_2304 = param1.readInteger();
         this.var_120 = new RoomChatlogData(param1);
         Logger.log("READ CFHCHATLOGDATA: callId: " + this.var_1696);
      }
      
      public function get callId() : int
      {
         return this.var_1696;
      }
      
      public function get callerUserId() : int
      {
         return this.var_2303;
      }
      
      public function get reportedUserId() : int
      {
         return this.var_1491;
      }
      
      public function get chatRecordId() : int
      {
         return this.var_2304;
      }
      
      public function get room() : RoomChatlogData
      {
         return this.var_120;
      }
   }
}
