package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class MarketplaceItemStatsParser implements IMessageParser
   {
       
      
      private var var_2571:int;
      
      private var var_2681:int;
      
      private var var_2678:int;
      
      private var _dayOffsets:Array;
      
      private var var_2044:Array;
      
      private var var_2043:Array;
      
      private var var_2680:int;
      
      private var var_2679:int;
      
      public function MarketplaceItemStatsParser()
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
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2571 = param1.readInteger();
         this.var_2681 = param1.readInteger();
         this.var_2678 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         this._dayOffsets = [];
         this.var_2044 = [];
         this.var_2043 = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._dayOffsets.push(param1.readInteger());
            this.var_2044.push(param1.readInteger());
            this.var_2043.push(param1.readInteger());
            _loc3_++;
         }
         this.var_2679 = param1.readInteger();
         this.var_2680 = param1.readInteger();
         return true;
      }
   }
}
