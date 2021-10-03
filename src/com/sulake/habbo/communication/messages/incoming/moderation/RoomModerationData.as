package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomModerationData implements IDisposable
   {
       
      
      private var var_396:int;
      
      private var var_2456:int;
      
      private var var_2831:Boolean;
      
      private var var_2405:int;
      
      private var _ownerName:String;
      
      private var var_120:RoomData;
      
      private var var_837:RoomData;
      
      private var _disposed:Boolean;
      
      public function RoomModerationData(param1:IMessageDataWrapper)
      {
         super();
         this.var_396 = param1.readInteger();
         this.var_2456 = param1.readInteger();
         this.var_2831 = param1.readBoolean();
         this.var_2405 = param1.readInteger();
         this._ownerName = param1.readString();
         this.var_120 = new RoomData(param1);
         this.var_837 = new RoomData(param1);
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         if(this.var_120 != null)
         {
            this.var_120.dispose();
            this.var_120 = null;
         }
         if(this.var_837 != null)
         {
            this.var_837.dispose();
            this.var_837 = null;
         }
      }
      
      public function get flatId() : int
      {
         return this.var_396;
      }
      
      public function get userCount() : int
      {
         return this.var_2456;
      }
      
      public function get ownerInRoom() : Boolean
      {
         return this.var_2831;
      }
      
      public function get ownerId() : int
      {
         return this.var_2405;
      }
      
      public function get ownerName() : String
      {
         return this._ownerName;
      }
      
      public function get room() : RoomData
      {
         return this.var_120;
      }
      
      public function get event() : RoomData
      {
         return this.var_837;
      }
   }
}
