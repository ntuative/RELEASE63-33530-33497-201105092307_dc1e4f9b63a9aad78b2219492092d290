package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IPurchasableOffer;
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import flash.display.BitmapData;
   
   public class Product extends ProductGridItem implements IProduct, IGetImageListener
   {
       
      
      private var var_1440:String;
      
      private var var_1772:int;
      
      private var var_1168:String;
      
      private var var_1439:int;
      
      private var var_1810:int;
      
      private var var_1811:IProductData;
      
      private var _furnitureData:IFurnitureData;
      
      private var _catalog:HabboCatalog;
      
      public function Product(param1:String, param2:int, param3:String, param4:int, param5:int, param6:IProductData, param7:IFurnitureData)
      {
         super();
         this.var_1440 = param1;
         this.var_1772 = param2;
         this.var_1168 = param3;
         this.var_1439 = param4;
         this.var_1810 = param5;
         this.var_1811 = param6;
         this._furnitureData = param7;
      }
      
      public function get productType() : String
      {
         return this.var_1440;
      }
      
      public function get productClassId() : int
      {
         return this.var_1772;
      }
      
      public function set extraParam(param1:String) : void
      {
         this.var_1168 = param1;
      }
      
      public function get extraParam() : String
      {
         return this.var_1168;
      }
      
      public function get productCount() : int
      {
         return this.var_1439;
      }
      
      public function get expiration() : int
      {
         return this.var_1810;
      }
      
      public function get productData() : IProductData
      {
         return this.var_1811;
      }
      
      public function get furnitureData() : IFurnitureData
      {
         return this._furnitureData;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.var_1440 = "";
         this.var_1772 = 0;
         this.var_1168 = "";
         this.var_1439 = 0;
         this.var_1810 = 0;
         this.var_1811 = null;
      }
      
      public function initIcon(param1:IProductContainer, param2:IGetImageListener = null, param3:IPurchasableOffer = null, param4:IBitmapWrapperWindow = null, param5:Function = null) : BitmapData
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(disposed)
         {
            return null;
         }
         var _loc6_:* = null;
         if(param2 == null)
         {
            param2 = {};
         }
         var _loc7_:IRoomEngine = (param1 as ProductContainer).offer.page.viewer.roomEngine;
         this._catalog = (param1 as ProductContainer).offer.page.viewer.catalog as HabboCatalog;
         switch(this.var_1440)
         {
            case ProductTypeEnum.const_78:
               _loc8_ = _loc7_.getFurnitureIcon(this.productClassId,param2);
               break;
            case ProductTypeEnum.const_66:
               if(param3)
               {
                  _loc9_ = "";
                  switch(this._furnitureData.name)
                  {
                     case "floor":
                        _loc9_ = ["th",this._furnitureData.name,param3.productContainer.firstProduct.extraParam].join("_");
                        break;
                     case "wallpaper":
                        _loc9_ = ["th","wall",param3.productContainer.firstProduct.extraParam].join("_");
                        break;
                     case "landscape":
                        _loc9_ = ["th",this._furnitureData.name,param3.productContainer.firstProduct.extraParam.replace(".","_")].join("_");
                        break;
                     default:
                        _loc8_ = _loc7_.getWallItemIcon(this.productClassId,param2,this.var_1168);
                  }
                  this._catalog.setImageFromAsset(param4,_loc9_,param5);
               }
               break;
            case ProductTypeEnum.const_205:
               _loc6_ = this._catalog.getPixelEffectIcon(this.productClassId);
               break;
            case ProductTypeEnum.const_355:
               _loc6_ = this._catalog.getSubscriptionProductIcon(this.productClassId);
               break;
            default:
               Logger.log("[Product] Can not yet handle this type of product: " + this.productType);
         }
         if(_loc8_ != null)
         {
            _loc6_ = _loc8_.data;
            if(param2 == this)
            {
               this.setIconImage(_loc6_);
            }
         }
         return _loc6_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         Logger.log("[Product] Bundle Icon Image Ready!" + param1);
         setIconImage(param2);
      }
      
      override public function set view(param1:IWindowContainer) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!param1)
         {
            return;
         }
         super.view = param1;
         if(this.var_1439 > 1)
         {
            _loc2_ = _view.findChildByName("multiContainer");
            if(_loc2_)
            {
               _loc2_.visible = true;
            }
            _loc3_ = _view.findChildByName("multiCounter") as ITextWindow;
            if(_loc3_)
            {
               _loc3_.text = "x" + this.productCount;
            }
         }
      }
   }
}
