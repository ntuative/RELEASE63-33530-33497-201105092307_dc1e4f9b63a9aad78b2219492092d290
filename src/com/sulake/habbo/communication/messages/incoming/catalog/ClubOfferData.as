package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ClubOfferData
   {
       
      
      private var _offerId:int;
      
      private var var_1640:String;
      
      private var var_1645:int;
      
      private var var_2178:Boolean;
      
      private var var_2180:Boolean;
      
      private var var_2176:int;
      
      private var var_2181:int;
      
      private var var_2183:int;
      
      private var var_2182:int;
      
      private var var_2179:int;
      
      public function ClubOfferData(param1:IMessageDataWrapper)
      {
         super();
         this._offerId = param1.readInteger();
         this.var_1640 = param1.readString();
         this.var_1645 = param1.readInteger();
         this.var_2178 = param1.readBoolean();
         this.var_2180 = param1.readBoolean();
         this.var_2176 = param1.readInteger();
         this.var_2181 = param1.readInteger();
         this.var_2183 = param1.readInteger();
         this.var_2182 = param1.readInteger();
         this.var_2179 = param1.readInteger();
      }
      
      public function get offerId() : int
      {
         return this._offerId;
      }
      
      public function get productCode() : String
      {
         return this.var_1640;
      }
      
      public function get price() : int
      {
         return this.var_1645;
      }
      
      public function get upgrade() : Boolean
      {
         return this.var_2178;
      }
      
      public function get vip() : Boolean
      {
         return this.var_2180;
      }
      
      public function get periods() : int
      {
         return this.var_2176;
      }
      
      public function get daysLeftAfterPurchase() : int
      {
         return this.var_2181;
      }
      
      public function get year() : int
      {
         return this.var_2183;
      }
      
      public function get month() : int
      {
         return this.var_2182;
      }
      
      public function get day() : int
      {
         return this.var_2179;
      }
   }
}
