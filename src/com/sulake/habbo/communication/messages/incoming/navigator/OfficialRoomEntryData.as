package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class OfficialRoomEntryData implements IDisposable
   {
      
      public static const const_1194:int = 1;
      
      public static const const_939:int = 2;
      
      public static const const_749:int = 3;
      
      public static const const_1742:int = 4;
       
      
      private var _index:int;
      
      private var var_2625:String;
      
      private var var_2624:String;
      
      private var var_2626:Boolean;
      
      private var var_2627:String;
      
      private var var_1000:String;
      
      private var var_2628:int;
      
      private var var_2456:int;
      
      private var _type:int;
      
      private var var_2470:String;
      
      private var var_984:GuestRoomData;
      
      private var var_985:PublicRoomData;
      
      private var _open:Boolean;
      
      private var _disposed:Boolean;
      
      public function OfficialRoomEntryData(param1:IMessageDataWrapper)
      {
         super();
         this._index = param1.readInteger();
         this.var_2625 = param1.readString();
         this.var_2624 = param1.readString();
         this.var_2626 = param1.readInteger() == 1;
         this.var_2627 = param1.readString();
         this.var_1000 = param1.readString();
         this.var_2628 = param1.readInteger();
         this.var_2456 = param1.readInteger();
         this._type = param1.readInteger();
         if(this._type == const_1194)
         {
            this.var_2470 = param1.readString();
         }
         else if(this._type == const_749)
         {
            this.var_985 = new PublicRoomData(param1);
         }
         else if(this._type == const_939)
         {
            this.var_984 = new GuestRoomData(param1);
         }
         else
         {
            this._open = param1.readBoolean();
         }
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         if(this.var_984 != null)
         {
            this.var_984.dispose();
            this.var_984 = null;
         }
         if(this.var_985 != null)
         {
            this.var_985.dispose();
            this.var_985 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get popupCaption() : String
      {
         return this.var_2625;
      }
      
      public function get popupDesc() : String
      {
         return this.var_2624;
      }
      
      public function get showDetails() : Boolean
      {
         return this.var_2626;
      }
      
      public function get picText() : String
      {
         return this.var_2627;
      }
      
      public function get picRef() : String
      {
         return this.var_1000;
      }
      
      public function get folderId() : int
      {
         return this.var_2628;
      }
      
      public function get tag() : String
      {
         return this.var_2470;
      }
      
      public function get userCount() : int
      {
         return this.var_2456;
      }
      
      public function get guestRoomData() : GuestRoomData
      {
         return this.var_984;
      }
      
      public function get publicRoomData() : PublicRoomData
      {
         return this.var_985;
      }
      
      public function get open() : Boolean
      {
         return this._open;
      }
      
      public function toggleOpen() : void
      {
         this._open = !this._open;
      }
      
      public function get maxUsers() : int
      {
         if(this.type == const_1194)
         {
            return 0;
         }
         if(this.type == const_939)
         {
            return this.var_984.maxUserCount;
         }
         if(this.type == const_749)
         {
            return this.var_985.maxUsers;
         }
         return 0;
      }
   }
}
