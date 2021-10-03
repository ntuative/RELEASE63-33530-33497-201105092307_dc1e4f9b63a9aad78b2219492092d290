package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
   import com.sulake.habbo.catalog.viewer.IGridItem;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.ProductGridItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class ItemGroupCatalogWidget extends ItemGridCatalogWidget implements ICatalogWidget, IItemGrid, IDragAndDropDoneReceiver
   {
       
      
      private var _groupNames:Array;
      
      private var var_199:Array;
      
      private var var_507:int = 0;
      
      private var var_668:int = 0;
      
      public function ItemGroupCatalogWidget(param1:IWindowContainer)
      {
         this._groupNames = new Array();
         this.var_199 = new Array();
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         Logger.log("Init Item Group Catalog Widget (Plasto)");
         this.createOfferGroups();
         var_206 = false;
         if(!super.init())
         {
            return false;
         }
         events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED,this.onWidgetsInitialized);
         events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX,this.onColourIndex);
         return true;
      }
      
      public function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent) : void
      {
         var _loc2_:Offer = this.var_199[this.var_507][this.var_668];
         this.select(_loc2_.productContainer as IGridItem);
      }
      
      override public function select(param1:IGridItem) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return;
         }
         super.select(param1);
         this.var_507 = var_478.getGridItemIndex(param1.view);
         var _loc2_:String = this._groupNames[this.var_507];
         var _loc3_:Array = this.var_199[this.var_507] as Array;
         var _loc4_:Array = new Array();
         for each(_loc5_ in _loc3_)
         {
            _loc6_ = _loc5_.productContainer.firstProduct.furnitureData;
            _loc7_ = _loc6_.colours[_loc6_.colours.length - 1];
            _loc4_.push(_loc7_);
         }
         Logger.log("Show the colors for current selection..." + _loc2_ + " " + _loc4_.length);
         events.dispatchEvent(new CatalogWidgetColoursEvent(_loc4_,"ctlg_clr_40x32_1","ctlg_clr_40x32_2","ctlg_clr_40x32_3",this.var_668));
      }
      
      override public function startDragAndDrop(param1:IGridItem) : Boolean
      {
         var _loc2_:Array = this.var_199[this.var_507] as Array;
         var _loc3_:Offer = _loc2_[this.var_668] as Offer;
         if(_loc3_ != null)
         {
            (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this,_loc3_);
         }
         return true;
      }
      
      override protected function populateItemGrid() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in this.var_199)
         {
            if(this.var_668 < _loc1_.length)
            {
               _loc2_ = _loc1_[this.var_668] as Offer;
               createGridItem(_loc2_);
               loadGraphics(_loc2_);
               _loc2_.productContainer.grid = this;
            }
         }
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         this.var_668 = param1.index;
         var _loc2_:Array = this.var_199[this.var_507] as Array;
         var _loc3_:Offer = _loc2_[this.var_668] as Offer;
         if(_loc3_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc3_));
         }
         this.updateGridWithSelectedColour();
      }
      
      private function updateGridWithSelectedColour() : void
      {
         if(var_215)
         {
            var_215.deActivate();
            var_215 = null;
         }
         var_478.destroyGridItems();
         this.populateItemGrid();
         var _loc1_:Array = this.var_199[this.var_507] as Array;
         var _loc2_:Offer = _loc1_[this.var_668] as Offer;
         var_215 = _loc2_.productContainer as ProductGridItem;
         var_215.activate();
      }
      
      private function createOfferGroups() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         for each(_loc1_ in page.offers)
         {
            if(_loc1_.pricingModel == Offer.const_444 || _loc1_.pricingModel == Offer.const_406)
            {
               _loc3_ = _loc1_.productContainer.firstProduct;
               if(_loc3_ != null)
               {
                  _loc4_ = _loc3_.productClassId;
                  if(_loc3_.productType == ProductTypeEnum.const_66 || _loc3_.productType == ProductTypeEnum.const_78)
                  {
                     if(_loc3_.furnitureData != null)
                     {
                        _loc5_ = _loc3_.furnitureData.name;
                        if(this._groupNames.indexOf(_loc5_) == -1)
                        {
                           this._groupNames.push(_loc5_);
                           this.var_199.push(new Array());
                        }
                        _loc6_ = this._groupNames.indexOf(_loc5_);
                        (this.var_199[_loc6_] as Array).push(_loc1_);
                     }
                  }
               }
            }
         }
         for each(_loc2_ in this.var_199)
         {
            _loc2_.sort(this.sortByColor);
         }
      }
      
      private function debug(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc6_:Number = NaN;
         var _loc2_:* = [];
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.productContainer.firstProduct.furnitureData;
            _loc5_ = uint(_loc4_.colours[_loc4_.colours.length - 1]);
            _loc6_ = this.getIntensity(_loc5_);
            _loc2_.push(_loc6_);
            Logger.log(_loc6_ + " " + _loc5_);
         }
         Logger.log(_loc2_);
      }
      
      private function sortByColor(param1:Offer, param2:Offer) : int
      {
         var _loc3_:IFurnitureData = param1.productContainer.firstProduct.furnitureData;
         var _loc4_:IFurnitureData = param2.productContainer.firstProduct.furnitureData;
         var _loc5_:uint = _loc3_.colours[_loc3_.colours.length - 1];
         var _loc6_:uint = _loc4_.colours[_loc4_.colours.length - 1];
         var _loc7_:Number = this.getIntensity(_loc5_);
         var _loc8_:Number = this.getIntensity(_loc6_);
         if(_loc7_ == 255 || _loc7_ == 0)
         {
            return -1;
         }
         if(_loc8_ == 255 || _loc8_ == 0)
         {
            return 1;
         }
         var _loc9_:Number = this.rgb2hsv(_loc5_);
         var _loc10_:Number = this.rgb2hsv(_loc6_);
         if(_loc9_ > _loc10_)
         {
            return 1;
         }
         if(_loc9_ < _loc10_)
         {
            return -1;
         }
         return 0;
      }
      
      private function rgb2hsv(param1:uint) : uint
      {
         var _loc2_:* = 255;
         var _loc3_:* = 255;
         var _loc4_:* = 255;
         if(param1 >= 0)
         {
            _loc2_ = uint(param1 >> 16 & 255);
            _loc3_ = uint(param1 >> 8 & 255);
            _loc4_ = uint(param1 >> 0 & 255);
         }
         var _loc5_:uint = Math.min(Math.min(_loc2_,_loc3_),_loc4_);
         var _loc6_:uint = Math.max(Math.max(_loc2_,_loc3_),_loc4_);
         if(_loc5_ == _loc6_)
         {
            return 0;
         }
         var _loc7_:* = _loc2_ == _loc5_ ? _loc3_ - _loc4_ : (_loc3_ == _loc5_ ? _loc4_ - _loc2_ : _loc2_ - _loc3_);
         var _loc8_:* = _loc2_ == _loc6_ ? 3 : (_loc3_ == _loc5_ ? 5 : 1);
         return uint(Math.floor((_loc8_ - _loc7_ / (_loc6_ - _loc5_)) * 60) % 360);
      }
      
      private function getIntensity(param1:uint) : Number
      {
         var _loc2_:* = 255;
         var _loc3_:* = 255;
         var _loc4_:* = 255;
         if(param1 >= 0)
         {
            _loc2_ = uint(param1 >> 16 & 255);
            _loc3_ = uint(param1 >> 8 & 255);
            _loc4_ = uint(param1 >> 0 & 255);
         }
         return (_loc2_ + _loc3_ + _loc4_) / 3;
      }
   }
}
