package com.sulake.habbo.communication.messages.incoming.marketplace
{
   public class MarketPlaceOffer
   {
       
      
      private var _offerId:int;
      
      private var _furniId:int;
      
      private var var_2573:int;
      
      private var var_2136:String;
      
      private var var_1645:int;
      
      private var var_406:int;
      
      private var var_2572:int = -1;
      
      private var var_2571:int;
      
      private var var_1870:int;
      
      public function MarketPlaceOffer(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int, param9:int = -1)
      {
         super();
         this._offerId = param1;
         this._furniId = param2;
         this.var_2573 = param3;
         this.var_2136 = param4;
         this.var_1645 = param5;
         this.var_406 = param6;
         this.var_2572 = param7;
         this.var_2571 = param8;
         this.var_1870 = param9;
      }
      
      public function get offerId() : int
      {
         return this._offerId;
      }
      
      public function get furniId() : int
      {
         return this._furniId;
      }
      
      public function get furniType() : int
      {
         return this.var_2573;
      }
      
      public function get stuffData() : String
      {
         return this.var_2136;
      }
      
      public function get price() : int
      {
         return this.var_1645;
      }
      
      public function get status() : int
      {
         return this.var_406;
      }
      
      public function get timeLeftMinutes() : int
      {
         return this.var_2572;
      }
      
      public function get averagePrice() : int
      {
         return this.var_2571;
      }
      
      public function get offerCount() : int
      {
         return this.var_1870;
      }
   }
}
