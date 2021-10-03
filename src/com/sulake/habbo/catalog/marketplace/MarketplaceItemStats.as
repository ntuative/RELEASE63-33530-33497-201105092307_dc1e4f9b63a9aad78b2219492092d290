package com.sulake.habbo.catalog.marketplace
{
   public class MarketplaceItemStats
   {
       
      
      private var var_2571:int;
      
      private var var_2681:int;
      
      private var var_2678:int;
      
      private var _dayOffsets:Array;
      
      private var var_2044:Array;
      
      private var var_2043:Array;
      
      private var var_2680:int;
      
      private var var_2679:int;
      
      public function MarketplaceItemStats()
      {
         super();
      }
      
      public function get averagePrice() : int
      {
         return this.var_2571;
      }
      
      public function get offerCount() : int
      {
         return this.var_2681;
      }
      
      public function get historyLength() : int
      {
         return this.var_2678;
      }
      
      public function get dayOffsets() : Array
      {
         return this._dayOffsets;
      }
      
      public function get averagePrices() : Array
      {
         return this.var_2044;
      }
      
      public function get soldAmounts() : Array
      {
         return this.var_2043;
      }
      
      public function get furniTypeId() : int
      {
         return this.var_2680;
      }
      
      public function get furniCategoryId() : int
      {
         return this.var_2679;
      }
      
      public function set averagePrice(param1:int) : void
      {
         this.var_2571 = param1;
      }
      
      public function set offerCount(param1:int) : void
      {
         this.var_2681 = param1;
      }
      
      public function set historyLength(param1:int) : void
      {
         this.var_2678 = param1;
      }
      
      public function set dayOffsets(param1:Array) : void
      {
         this._dayOffsets = param1.slice();
      }
      
      public function set averagePrices(param1:Array) : void
      {
         this.var_2044 = param1.slice();
      }
      
      public function set soldAmounts(param1:Array) : void
      {
         this.var_2043 = param1.slice();
      }
      
      public function set furniTypeId(param1:int) : void
      {
         this.var_2680 = param1;
      }
      
      public function set furniCategoryId(param1:int) : void
      {
         this.var_2679 = param1;
      }
   }
}
