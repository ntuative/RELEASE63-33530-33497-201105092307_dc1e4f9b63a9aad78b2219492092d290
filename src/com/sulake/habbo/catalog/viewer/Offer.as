package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.catalog.IPurchasableOffer;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class Offer implements IPurchasableOffer, IDisposable
   {
      
      public static const const_1755:String = "pricing_model_unknown";
      
      public static const const_444:String = "pricing_model_single";
      
      public static const const_406:String = "pricing_model_multi";
      
      public static const const_561:String = "pricing_model_bundle";
      
      public static const const_1748:String = "price_type_none";
      
      public static const const_960:String = "price_type_credits";
      
      public static const const_1270:String = "price_type_activitypoints";
      
      public static const const_1184:String = "price_type_credits_and_activitypoints";
       
      
      private var var_838:String;
      
      private var var_1292:String;
      
      private var _offerId:int;
      
      private var var_2049:String;
      
      private var var_1291:int;
      
      private var var_1290:int;
      
      private var var_2050:int;
      
      private var var_385:ICatalogPage;
      
      private var var_687:IProductContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_2835:int;
      
      public function Offer(param1:int, param2:String, param3:int, param4:int, param5:int, param6:Array, param7:ICatalogPage)
      {
         super();
         this._offerId = param1;
         this.var_2049 = param2;
         this.var_1291 = param3;
         this.var_1290 = param4;
         this.var_2050 = param5;
         this.var_385 = param7;
         this.analyzePricingModel(param6);
         this.analyzePriceType();
         this.createProductContainer(param6);
      }
      
      public function get page() : ICatalogPage
      {
         return this.var_385;
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
      
      public function get activityPointType() : int
      {
         return this.var_2050;
      }
      
      public function get productContainer() : IProductContainer
      {
         return this.var_687;
      }
      
      public function get pricingModel() : String
      {
         return this.var_838;
      }
      
      public function get priceType() : String
      {
         return this.var_1292;
      }
      
      public function get previewCallbackId() : int
      {
         return this.var_2835;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         this.var_2835 = param1;
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this._disposed = true;
         this._offerId = 0;
         this.var_2049 = "";
         this.var_1291 = 0;
         this.var_1290 = 0;
         this.var_2050 = 0;
         this.var_385 = null;
         if(this.var_687 != null)
         {
            this.var_687.dispose();
            this.var_687 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      private function createProductContainer(param1:Array) : void
      {
         switch(this.var_838)
         {
            case const_444:
               this.var_687 = new SingleProductContainer(this,param1);
               break;
            case const_406:
               this.var_687 = new MultiProductContainer(this,param1);
               break;
            case const_561:
               this.var_687 = new BundleProductContainer(this,param1);
               break;
            default:
               Logger.log("[Offer] Unknown pricing model" + this.var_838);
         }
      }
      
      private function analyzePricingModel(param1:Array) : void
      {
         var _loc2_:* = null;
         if(param1.length == 1)
         {
            _loc2_ = param1[0];
            if(_loc2_.productCount == 1)
            {
               this.var_838 = const_444;
            }
            else
            {
               this.var_838 = const_406;
            }
         }
         else if(param1.length > 1)
         {
            this.var_838 = const_561;
         }
         else
         {
            this.var_838 = const_1755;
         }
      }
      
      private function analyzePriceType() : void
      {
         if(this.var_1291 > 0 && this.var_1290 > 0)
         {
            this.var_1292 = const_1184;
         }
         else if(this.var_1291 > 0)
         {
            this.var_1292 = const_960;
         }
         else if(this.var_1290 > 0)
         {
            this.var_1292 = const_1270;
         }
         else
         {
            this.var_1292 = const_1748;
         }
      }
      
      public function clone() : Offer
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:Array = new Array();
         var _loc2_:IProductData = this.var_385.viewer.catalog.getProductData(this.localizationId);
         for each(_loc3_ in this.var_687.products)
         {
            _loc4_ = this.var_385.viewer.catalog.getFurnitureData(_loc3_.productClassId,_loc3_.productType);
            _loc5_ = new Product(_loc3_.productType,_loc3_.productClassId,_loc3_.extraParam,_loc3_.productCount,_loc3_.expiration,_loc2_,_loc4_);
            _loc1_.push(_loc5_);
         }
         return new Offer(this.offerId,this.localizationId,this.priceInCredits,this.priceInActivityPoints,this.activityPointType,_loc1_,this.page);
      }
   }
}
