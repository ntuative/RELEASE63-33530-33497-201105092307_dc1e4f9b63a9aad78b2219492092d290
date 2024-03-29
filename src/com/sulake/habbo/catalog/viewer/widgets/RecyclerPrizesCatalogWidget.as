package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.catalog.recycler.PrizeContainer;
   import com.sulake.habbo.catalog.recycler.PrizeLevelContainer;
   import com.sulake.habbo.catalog.recycler.PrizeViewer;
   import com.sulake.habbo.catalog.viewer.IGridItem;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import flash.events.TimerEvent;
   
   public class RecyclerPrizesCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid
   {
       
      
      private var var_651:Array;
      
      private var _viewer:PrizeViewer;
      
      private var _itemList:IItemListWindow;
      
      private var var_1920:XML;
      
      private var var_1919:XML;
      
      private var var_215:IGridItem;
      
      public function RecyclerPrizesCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._viewer != null)
         {
            this._viewer.dispose();
            this._viewer = null;
         }
         this.var_651 = null;
         this._itemList = null;
         this.var_1920 = null;
         this.var_1919 = null;
         this.var_215 = null;
      }
      
      override public function init() : Boolean
      {
         var _loc1_:* = null;
         if(!super.init())
         {
            return false;
         }
         this._viewer = new PrizeViewer();
         this.var_651 = this.recycler.getPrizeTable();
         if(this.var_651 == null)
         {
            return false;
         }
         this._itemList = _window.findChildByName("itemList") as IItemListWindow;
         _loc1_ = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         this.var_1920 = _loc1_.content as XML;
         _loc1_ = page.viewer.catalog.assets.getAssetByName("recyclerPrizesWidgetLevelItem") as XmlAsset;
         this.var_1919 = _loc1_.content as XML;
         this.populateItemGrid();
         if(this.var_651.length > 0 && this.var_651[0].prizes.length > 0)
         {
            this.select(this.var_651[0].prizes[0] as IGridItem);
         }
         return true;
      }
      
      private function populateItemGrid(param1:TimerEvent = null) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.var_651.length)
         {
            this.createLevelItem(this.var_651[_loc2_]);
            _loc2_++;
         }
      }
      
      private function createLevelItem(param1:PrizeLevelContainer) : void
      {
         var _loc6_:* = null;
         var _loc2_:IWindowContainer = page.viewer.catalog.windowManager.buildFromXML(this.var_1919) as IWindowContainer;
         this._itemList.addListItem(_loc2_);
         var _loc3_:ITextWindow = _loc2_.findChildByName("headerText") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = page.viewer.catalog.localization.getKey("recycler.prizes.category." + param1.prizeLevelId);
         }
         var _loc4_:IItemGridWindow = _loc2_.findChildByName("itemGrid") as IItemGridWindow;
         var _loc5_:int = 0;
         while(_loc5_ < param1.prizes.length)
         {
            _loc6_ = param1.prizes[_loc5_];
            this.createPrizeItem(_loc6_,_loc4_);
            _loc5_++;
         }
      }
      
      private function createPrizeItem(param1:PrizeContainer, param2:IItemGridWindow) : void
      {
         if(param1 == null || param2 == null || param2.disposed)
         {
            return;
         }
         var _loc3_:IWindowContainer = page.viewer.catalog.windowManager.buildFromXML(this.var_1920) as IWindowContainer;
         param2.addGridItem(_loc3_);
         param2.height = param2.scrollableRegion.height;
         param1.view = _loc3_;
         param1.grid = this;
         param1.setIcon(page.viewer.roomEngine);
      }
      
      public function select(param1:IGridItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.var_215 != null)
         {
            this.var_215.deActivate();
         }
         this.var_215 = param1;
         param1.activate();
         var _loc2_:PrizeContainer = param1 as PrizeContainer;
         var _loc3_:IWindowContainer = window.findChildByName("productView") as IWindowContainer;
         var _loc4_:String = page.viewer.catalog.localization.getKey("recycler.prizes.odds." + _loc2_.oddsLevelId);
         this._viewer.viewProduct(page.viewer.roomEngine,_loc3_,_loc2_.productItemType,_loc2_.productItemTypeId,_loc2_.title,_loc4_);
      }
      
      public function startDragAndDrop(param1:IGridItem) : Boolean
      {
         return false;
      }
      
      private function get recycler() : IRecycler
      {
         return page.viewer.catalog.getRecycler();
      }
   }
}
