package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IPurchasableOffer;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.display.BitmapData;
   
   public class SingleProductContainer extends ProductContainer implements IProductContainer
   {
       
      
      public function SingleProductContainer(param1:Offer, param2:Array)
      {
         super(param1,param2);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function initProductIcon(param1:IRoomEngine) : void
      {
         var _loc2_:IProduct = firstProduct;
         var _loc3_:BitmapData = _loc2_.initIcon(this,this,offer as IPurchasableOffer,_icon,this.onPreviewImageReady);
         this.setIconImage(_loc3_);
         if(_loc3_ != null)
         {
            _loc3_.dispose();
         }
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:* = null;
         if(!disposed && offer.page.viewer.catalog != null)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_ != null)
            {
               (offer.page.viewer.catalog as HabboCatalog).setImageFromAsset(_icon,_loc2_.assetName,null);
            }
         }
      }
   }
}
