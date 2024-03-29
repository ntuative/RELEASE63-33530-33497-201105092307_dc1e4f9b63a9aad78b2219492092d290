package com.sulake.habbo.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.widget.enums.RoomWidgetInfostandExtraParamEnum;
   import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetSongUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandSongDiskView extends InfoStandFurniView
   {
       
      
      private var var_1650:int = -1;
      
      public function InfoStandSongDiskView(param1:InfostandWidget, param2:String, param3:IHabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         super.update(param1);
         this.var_1650 = this.getSongIdFromExtraParam(param1.extraParam);
      }
      
      public function updateSongInfo(param1:RoomWidgetSongUpdateEvent) : void
      {
         if(param1.type == RoomWidgetSongUpdateEvent.const_420 && param1.songId == this.var_1650)
         {
            this.trackName = param1.songName;
            this.authorName = param1.songAuthor;
         }
      }
      
      override protected function createWindow(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("songdisk_view") as XmlAsset;
         _window = _widget.windowManager.buildFromXML(_loc2_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_45 = _window.getListItemByName("info_border") as IBorderWindow;
         _buttons = _window.getListItemByName("button_list") as IItemListWindow;
         if(var_45 != null)
         {
            var_51 = var_45.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         _widget.mainContainer.addChild(_window);
         var _loc3_:IWindow = var_45.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onClose);
         }
         if(_buttons != null)
         {
            _loc9_ = 0;
            while(_loc9_ < _buttons.numListItems)
            {
               _loc4_ = _buttons.getListItemAt(_loc9_);
               _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
               _loc9_++;
            }
         }
         var_239 = var_45.findChildByTag("catalog");
         if(var_239 != null)
         {
            var_239.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onCatalogButtonClicked);
         }
         var _loc7_:IBitmapWrapperWindow = var_45.findChildByName("icon_disc") as IBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            _loc5_ = _widget.assets.getAssetByName("jb_icon_disc") as BitmapDataAsset;
            _loc6_ = _loc5_.content as BitmapData;
            _loc7_.bitmap = _loc6_.clone();
         }
         var _loc8_:IBitmapWrapperWindow = var_45.findChildByName("icon_composer") as IBitmapWrapperWindow;
         if(_loc8_ != null)
         {
            _loc5_ = _widget.assets.getAssetByName("jb_icon_composer") as BitmapDataAsset;
            _loc6_ = _loc5_.content as BitmapData;
            _loc8_.bitmap = _loc6_.clone();
         }
      }
      
      private function set trackName(param1:String) : void
      {
         var _loc2_:IWindowContainer = var_51.getListItemByName("trackname_container") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_name_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
         method_1();
      }
      
      private function set authorName(param1:String) : void
      {
         var _loc2_:IWindowContainer = var_51.getListItemByName("creatorname_container") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_creator_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
         method_1();
      }
      
      private function getSongIdFromExtraParam(param1:String) : int
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            _loc2_ = param1.substr(RoomWidgetInfostandExtraParamEnum.const_374.length,param1.length);
            return parseInt(_loc2_);
         }
         return -1;
      }
   }
}
