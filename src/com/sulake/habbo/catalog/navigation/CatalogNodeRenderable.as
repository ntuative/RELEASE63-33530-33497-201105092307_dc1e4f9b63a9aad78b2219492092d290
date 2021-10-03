package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   import com.sulake.habbo.window.enum.HabboIconType;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class CatalogNodeRenderable extends CatalogNode
   {
      
      private static const const_1425:Number = 4285716709;
      
      private static var _listSubItemWindowLayout:XML;
      
      private static var var_1451:XML;
      
      private static var var_1452:XML;
       
      
      private var var_1830:Number = 4.294967295E9;
      
      private var _icon:BitmapData;
      
      private var _window:IWindowContainer;
      
      private var var_2934:IWindowContainer;
      
      private var _list:IItemListWindow;
      
      private var var_1450:Boolean = false;
      
      public function CatalogNodeRenderable(param1:ICatalogNavigator, param2:NodeData, param3:int)
      {
         var _loc4_:* = null;
         super(param1,param2,param3);
         if(_listSubItemWindowLayout == null)
         {
            _loc4_ = param1.catalog.assets.getAssetByName("navigation_list_subitem") as XmlAsset;
            _listSubItemWindowLayout = _loc4_.content as XML;
         }
         if(var_1451 == null)
         {
            _loc4_ = param1.catalog.assets.getAssetByName("navigation_list_item") as XmlAsset;
            var_1451 = _loc4_.content as XML;
         }
         if(var_1452 == null)
         {
            _loc4_ = param1.catalog.assets.getAssetByName("list_item_list") as XmlAsset;
            var_1452 = _loc4_.content as XML;
         }
      }
      
      public function set icon(param1:BitmapData) : void
      {
         this._icon = param1;
      }
      
      public function get window() : IWindowContainer
      {
         return this._window;
      }
      
      override public function get icon() : BitmapData
      {
         return this._icon;
      }
      
      override public function get isOpen() : Boolean
      {
         return this.var_1450;
      }
      
      override public function dispose() : void
      {
         if(this.var_1450)
         {
            this.close();
            this.deActivate();
         }
         this._icon = null;
         this._window = null;
         this.var_2934 = null;
         this._list = null;
         super.dispose();
      }
      
      public function addToList(param1:IItemListWindow) : void
      {
         if(this._window == null)
         {
            this.createWindow();
         }
         param1.addListItem(this._window);
         if(isBranch)
         {
            if(this._list == null)
            {
               this.createList();
            }
            param1.addListItem(this._list);
         }
      }
      
      public function removeFromList(param1:IItemListWindow) : void
      {
         param1.removeListItem(this._window);
         if(isBranch)
         {
            param1.removeListItem(this._list);
         }
      }
      
      override public function activate() : void
      {
         var _loc1_:IWindow = this._window.findChildByTag("SELECTION_COLOR");
         if(_loc1_ != null)
         {
            if(this.var_1830 == 4294967295)
            {
               this.var_1830 = _loc1_.color;
            }
            _loc1_.color = const_1425;
         }
      }
      
      override public function deActivate() : void
      {
         var _loc1_:IWindow = this._window.findChildByTag("SELECTION_COLOR");
         if(_loc1_ != null)
         {
            _loc1_.color = this.var_1830;
         }
      }
      
      override public function open() : void
      {
         var _loc1_:* = null;
         this.showChildren();
         this.var_1450 = true;
         if(isBranch)
         {
            _loc1_ = this._window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = HabboIconType.const_1785;
            }
         }
      }
      
      override public function close() : void
      {
         var _loc1_:* = null;
         this.removeChildren();
         this.var_1450 = false;
         if(isBranch)
         {
            _loc1_ = this._window.findChildByTag("DOWNBTN");
            if(_loc1_ != null)
            {
               _loc1_.style = HabboIconType.const_1817;
            }
         }
      }
      
      private function showChildren() : void
      {
         var _loc1_:* = null;
         if(this._list == null)
         {
            this.createList();
         }
         for each(_loc1_ in children)
         {
            if(_loc1_.isNavigateable)
            {
               (_loc1_ as CatalogNodeRenderable).addToList(this._list);
            }
         }
         if(this._list != null)
         {
            this._list.visible = true;
            this._list.height = this._list.numListItems * 21;
         }
      }
      
      private function removeChildren() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in children)
         {
            if(_loc1_.isNavigateable)
            {
               (_loc1_ as CatalogNodeRenderable).removeFromList(this._list);
            }
         }
         if(this._list != null)
         {
            this._list.height = 0;
            this._list.visible = false;
            this._list.x = 0;
         }
      }
      
      private function createList() : void
      {
         this._list = navigator.catalog.windowManager.buildFromXML(var_1452) as IItemListWindow;
         if(this._list == null)
         {
            throw new Error("Failed to construct list-item-list from XML!");
         }
         this.removeChildren();
      }
      
      private function createWindow() : void
      {
         if(depth == 1)
         {
            this._window = navigator.catalog.windowManager.buildFromXML(var_1451) as IWindowContainer;
         }
         else
         {
            this._window = navigator.catalog.windowManager.buildFromXML(_listSubItemWindowLayout) as IWindowContainer;
         }
         if(this._window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:ITextWindow = this._window.findChildByTag("ITEM_TITLE") as ITextWindow;
         var _loc2_:IWindow = this._window.findChildByTag("DOWNBTN");
         if(_loc1_ != null)
         {
            _loc1_.caption = localization;
         }
         if(isLeaf)
         {
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         this.setElementImage("iconBackgroundBitmap","icon_bg_img",true,color);
         this.initIcon();
         this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onButtonClicked);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onButtonClicked);
         }
      }
      
      private function getLocalizationKey(param1:String, param2:String = "") : String
      {
         var _loc3_:ICoreLocalizationManager = (navigator.catalog as HabboCatalog).localization;
         if(_loc3_ == null)
         {
            return param2;
         }
         return _loc3_.getKey(param1,param2);
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         navigator.activateNode(this);
      }
      
      private function initIcon() : void
      {
         var _loc2_:String = iconName;
         if(_loc2_ == "")
         {
            return;
         }
         if(navigator.catalog.assets.hasAsset(_loc2_))
         {
            this.setElementImage("icon",_loc2_);
         }
         else
         {
            this.retrieveIconImage(_loc2_);
         }
      }
      
      private function setElementImage(param1:String, param2:String, param3:Boolean = true, param4:uint = 0) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:* = null;
         if(this._window == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow = this._window.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc5_ != null)
         {
            _loc6_ = navigator.catalog.assets.getAssetByName(param2) as BitmapDataAsset;
            if(_loc6_ == null)
            {
               return;
            }
            _loc7_ = _loc6_.content as BitmapData;
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            _loc8_ = 0;
            _loc9_ = 0;
            if(param3)
            {
               _loc8_ = (_loc5_.width - _loc7_.width) / 2;
               _loc9_ = (_loc5_.height - _loc7_.height) / 2;
            }
            if(param4 > 0)
            {
               _loc7_ = _loc7_.clone();
               _loc10_ = param4 >> 16 & 255;
               _loc11_ = param4 >> 8 & 255;
               _loc12_ = param4 >> 0 & 255;
               _loc13_ = _loc10_ / 255 * 1;
               _loc14_ = _loc11_ / 255 * 1;
               _loc15_ = _loc12_ / 255 * 1;
               _loc16_ = new ColorTransform(_loc13_,_loc14_,_loc15_);
               _loc7_.colorTransform(_loc7_.rect,_loc16_);
            }
            _loc5_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(_loc8_,_loc9_));
         }
         else
         {
            Logger.log("[CatalogNodeRenderable] Could not find element: " + param1);
         }
      }
      
      private function retrieveIconImage(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         var _loc2_:String = navigator.catalog.configuration.getKey("image.library.catalogue.url");
         var _loc3_:* = _loc2_ + param1 + ".png";
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:AssetLoaderStruct = navigator.catalog.assets.loadAssetFromFile(param1,_loc4_,"image/gif");
         _loc5_.addEventListener(AssetLoaderEvent.const_29,this.onIconImageReady);
      }
      
      private function onIconImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.assetName;
            this.setElementImage("icon",_loc3_);
         }
      }
   }
}
