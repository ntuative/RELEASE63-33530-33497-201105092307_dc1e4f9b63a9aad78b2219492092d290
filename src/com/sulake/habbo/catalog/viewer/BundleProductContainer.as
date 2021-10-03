package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.display.BitmapData;
   
   public class BundleProductContainer extends ProductContainer implements IProductContainer, IItemGrid
   {
      
      private static const const_1505:int = 6;
       
      
      private var var_1516:BitmapData;
      
      public function BundleProductContainer(param1:Offer, param2:Array)
      {
         super(param1,param2);
         var _loc3_:BitmapDataAsset = param1.page.viewer.catalog.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            this.var_1516 = _loc3_.content as BitmapData;
         }
         else
         {
            this.var_1516 = new BitmapData(1,1,true,16777215);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.var_1516 = null;
      }
      
      override public function initProductIcon(param1:IRoomEngine) : void
      {
         setIconImage(this.var_1516.clone());
      }
      
      public function populateItemGrid(param1:IItemGridWindow, param2:IScrollbarWindow, param3:XML) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         for each(_loc5_ in offer.productContainer.products)
         {
            _loc6_ = offer.page.viewer.catalog.windowManager.buildFromXML(param3) as IWindowContainer;
            param1.addGridItem(_loc6_);
            _loc5_.view = _loc6_;
            _loc7_ = _loc5_.initIcon(this);
            if(_loc7_ != null)
            {
               _loc7_.dispose();
            }
            _loc5_.grid = this;
         }
         if(param2 != null)
         {
            param2.visible = offer.productContainer.products.length > const_1505;
         }
      }
      
      public function setBundleCounter(param1:int) : void
      {
         var _loc2_:ITextWindow = _view.findChildByName("bundleCounter") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1 + "";
         }
      }
      
      public function select(param1:IGridItem) : void
      {
         Logger.log("Product Bundle, select item: " + param1);
      }
      
      public function startDragAndDrop(param1:IGridItem) : Boolean
      {
         return false;
      }
   }
}
