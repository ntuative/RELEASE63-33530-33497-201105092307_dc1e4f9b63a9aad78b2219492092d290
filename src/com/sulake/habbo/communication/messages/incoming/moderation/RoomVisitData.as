package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class RoomVisitData
   {
       
      
      private var var_2056:Boolean;
      
      private var _roomId:int;
      
      private var var_975:String;
      
      private var var_2331:int;
      
      private var var_2330:int;
      
      public function RoomVisitData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2056 = param1.readBoolean();
         this._roomId = param1.readInteger();
         this.var_975 = param1.readString();
         this.var_2331 = param1.readInteger();
         this.var_2330 = param1.readInteger();
      }
      
      public function get isPublic() : Boolean
      {
         return this.var_2056;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomName() : String
      {
         return this.var_975;
      }
      
      public function get enterHour() : int
      {
         return this.var_2331;
      }
      
      public function get enterMinute() : int
      {
         return this.var_2330;
      }
   }
}
