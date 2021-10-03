package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
   
   public class ClubGiftInfoParser implements IMessageParser
   {
       
      
      private var var_2684:int;
      
      private var var_1513:int;
      
      private var _offers:Array;
      
      private var var_2039:Map;
      
      public function ClubGiftInfoParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this._offers = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         this.var_2684 = param1.readInteger();
         this.var_1513 = param1.readInteger();
         this._offers = new Array();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._offers.push(new CatalogPageMessageOfferData(param1));
            _loc3_++;
         }
         this.var_2039 = new Map();
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ClubGiftData(param1);
            this.var_2039.add(_loc4_.offerId,_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function get daysUntilNextGift() : int
      {
         return this.var_2684;
      }
      
      public function get giftsAvailable() : int
      {
         return this.var_1513;
      }
      
      public function get offers() : Array
      {
         return this._offers;
      }
      
      public function get giftData() : Map
      {
         return this.var_2039;
      }
   }
}
