package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CatalogPageMessageOfferData
   {
       
      
      private var _offerId:int;
      
      private var var_2049:String;
      
      private var var_1291:int;
      
      private var var_1290:int;
      
      private var var_2050:int;
      
      private var var_1181:Array;
      
      public function CatalogPageMessageOfferData(param1:IMessageDataWrapper)
      {
         super();
         this._offerId = param1.readInteger();
         this.var_2049 = param1.readString();
         this.var_1291 = param1.readInteger();
         this.var_1290 = param1.readInteger();
         this.var_2050 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         this.var_1181 = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1181.push(new CatalogPageMessageProductData(param1));
            _loc3_++;
         }
      }
      
      public function get offerId() : int
      {
         return this._offerId;
      }
      
      public function get localizationId() : String
      {
         return this.var_2049;
      }
      
      public function get priceInCredits() : int
      {
         return this.var_1291;
      }
      
      public function get priceInActivityPoints() : int
      {
         return this.var_1290;
      }
      
      public function get products() : Array
      {
         return this.var_1181;
      }
      
      public function get activityPointType() : int
      {
         return this.var_2050;
      }
   }
}
