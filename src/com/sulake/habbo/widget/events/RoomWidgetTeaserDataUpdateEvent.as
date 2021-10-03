package com.sulake.habbo.widget.events
{
   public class RoomWidgetTeaserDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_572:String = "RWTDUE_TEASER_DATA";
      
      public static const const_743:String = "RWTDUE_GIFT_DATA";
      
      public static const const_689:String = "RWTDUE_GIFT_RECEIVED";
       
      
      private var var_194:int;
      
      private var _data:String;
      
      private var var_406:int;
      
      private var var_177:String;
      
      private var var_2322:String;
      
      private var var_2321:Boolean;
      
      private var var_1388:int = 0;
      
      private var var_2832:String;
      
      public function RoomWidgetTeaserDataUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function get objectId() : int
      {
         return this.var_194;
      }
      
      public function get data() : String
      {
         return this._data;
      }
      
      public function get status() : int
      {
         return this.var_406;
      }
      
      public function get firstClickUserName() : String
      {
         return this.var_2322;
      }
      
      public function get giftWasReceived() : Boolean
      {
         return this.var_2321;
      }
      
      public function get ownRealName() : String
      {
         return this.var_2832;
      }
      
      public function get itemCategory() : int
      {
         return this.var_1388;
      }
      
      public function set status(param1:int) : void
      {
         this.var_406 = param1;
      }
      
      public function set data(param1:String) : void
      {
         this._data = param1;
      }
      
      public function set firstClickUserName(param1:String) : void
      {
         this.var_2322 = param1;
      }
      
      public function set giftWasReceived(param1:Boolean) : void
      {
         this.var_2321 = param1;
      }
      
      public function set ownRealName(param1:String) : void
      {
         this.var_2832 = param1;
      }
      
      public function set objectId(param1:int) : void
      {
         this.var_194 = param1;
      }
      
      public function get campaignID() : String
      {
         return this.var_177;
      }
      
      public function set campaignID(param1:String) : void
      {
         this.var_177 = param1;
      }
      
      public function set itemCategory(param1:int) : void
      {
         this.var_1388 = param1;
      }
   }
}
