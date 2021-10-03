package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class GuestRoomData implements IDisposable
   {
       
      
      private var var_396:int;
      
      private var var_837:Boolean;
      
      private var var_975:String;
      
      private var _ownerName:String;
      
      private var var_2153:int;
      
      private var var_2456:int;
      
      private var var_2554:int;
      
      private var var_1700:String;
      
      private var var_2552:int;
      
      private var var_2550:Boolean;
      
      private var var_788:int;
      
      private var var_1560:int;
      
      private var var_2549:String;
      
      private var var_860:Array;
      
      private var var_2551:RoomThumbnailData;
      
      private var var_2148:Boolean;
      
      private var var_2553:Boolean;
      
      private var _disposed:Boolean;
      
      public function GuestRoomData(param1:IMessageDataWrapper)
      {
         var _loc4_:* = null;
         this.var_860 = new Array();
         super();
         this.var_396 = param1.readInteger();
         this.var_837 = param1.readBoolean();
         this.var_975 = param1.readString();
         this._ownerName = param1.readString();
         this.var_2153 = param1.readInteger();
         this.var_2456 = param1.readInteger();
         this.var_2554 = param1.readInteger();
         this.var_1700 = param1.readString();
         this.var_2552 = param1.readInteger();
         this.var_2550 = param1.readBoolean();
         this.var_788 = param1.readInteger();
         this.var_1560 = param1.readInteger();
         this.var_2549 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readString();
            this.var_860.push(_loc4_);
            _loc3_++;
         }
         this.var_2551 = new RoomThumbnailData(param1);
         this.var_2148 = param1.readBoolean();
         this.var_2553 = param1.readBoolean();
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         this.var_860 = null;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get flatId() : int
      {
         return this.var_396;
      }
      
      public function get event() : Boolean
      {
         return this.var_837;
      }
      
      public function get roomName() : String
      {
         return this.var_975;
      }
      
      public function get ownerName() : String
      {
         return this._ownerName;
      }
      
      public function get doorMode() : int
      {
         return this.var_2153;
      }
      
      public function get userCount() : int
      {
         return this.var_2456;
      }
      
      public function get maxUserCount() : int
      {
         return this.var_2554;
      }
      
      public function get description() : String
      {
         return this.var_1700;
      }
      
      public function get srchSpecPrm() : int
      {
         return this.var_2552;
      }
      
      public function get allowTrading() : Boolean
      {
         return this.var_2550;
      }
      
      public function get score() : int
      {
         return this.var_788;
      }
      
      public function get categoryId() : int
      {
         return this.var_1560;
      }
      
      public function get eventCreationTime() : String
      {
         return this.var_2549;
      }
      
      public function get tags() : Array
      {
         return this.var_860;
      }
      
      public function get thumbnail() : RoomThumbnailData
      {
         return this.var_2551;
      }
      
      public function get allowPets() : Boolean
      {
         return this.var_2148;
      }
      
      public function get displayRoomEntryAd() : Boolean
      {
         return this.var_2553;
      }
   }
}
