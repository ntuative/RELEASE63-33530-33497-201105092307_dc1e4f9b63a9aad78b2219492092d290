package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   
   public class LogoutController
   {
      
      private static const const_1370:uint = 16777215;
      
      private static const const_1368:uint = 12247545;
      
      private static const const_1367:String = "HELP";
      
      private static const const_1369:String = "ROOMINFO";
       
      
      private var _toolbar:HabboToolbar;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var _events:IEventDispatcher;
      
      private var _config:IHabboConfigurationManager;
      
      private var _window:IWindowContainer;
      
      private var _list:IItemListWindow;
      
      private var var_325:IWindow;
      
      private var var_1669:Boolean;
      
      private var var_590:IWindowContainer;
      
      private const const_511:int = 44;
      
      private const const_531:int = 3;
      
      public function LogoutController(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IEventDispatcher, param5:IHabboConfigurationManager)
      {
         var _loc8_:* = null;
         super();
         this._toolbar = param1;
         this._windowManager = param2;
         this._assets = param3;
         this._events = param4;
         this._config = param5;
         this._window = this.createWindow("logout_xml") as IWindowContainer;
         var _loc6_:IBitmapWrapperWindow = this._window.findChildByName("roominfo_icon") as IBitmapWrapperWindow;
         _loc6_.bitmap = BitmapDataAsset(param3.getAssetByName("roominfo_icon")).content as BitmapData;
         _loc6_.disposesBitmap = false;
         this.insertLocalizations();
         this.var_325 = this._window.findChildByName("roominfo_region");
         this._list = this._window.findChildByName("list") as IItemListWindow;
         var _loc7_:* = [];
         this._list.groupListItemsWithTag("REGION",_loc7_);
         for each(_loc8_ in _loc7_)
         {
            _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onMouseOver);
            _loc8_.addEventListener(WindowMouseEvent.const_25,this.onMouseOut);
         }
         this.hideRoomInfo();
         this.var_1669 = this._config.getKey("roominfo.widget.enabled") == "1";
         if(this.var_1669)
         {
            this._events.addEventListener(HabboToolbarEvent.const_304,this.onRoomView);
            this._events.addEventListener(HabboToolbarEvent.const_357,this.onHotelView);
         }
      }
      
      private function insertLocalizations() : void
      {
         var _loc1_:* = null;
         _loc1_ = this._window.findChildByName("roominfo_text");
         _loc1_.caption = "${" + _loc1_.caption + "}";
         _loc1_ = this._window.findChildByName("help_text");
         _loc1_.caption = "${" + _loc1_.caption + "}";
         _loc1_ = this._window.findChildByName("logout_text");
         _loc1_.caption = "${" + _loc1_.caption + "}";
      }
      
      public function dispose() : void
      {
         this._toolbar = null;
         this._windowManager = null;
         this._assets = null;
         if(this.var_1669)
         {
            this._events.removeEventListener(HabboToolbarEvent.const_304,this.onRoomView);
            this._events.removeEventListener(HabboToolbarEvent.const_357,this.onHotelView);
         }
         this._events = null;
         this._config = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
         if(this.var_590)
         {
            this.var_590.dispose();
            this.var_590 = null;
         }
      }
      
      private function onRoomView(param1:HabboToolbarEvent) : void
      {
         this.showRoomInfo();
      }
      
      private function onHotelView(param1:HabboToolbarEvent) : void
      {
         this.hideRoomInfo();
      }
      
      private function hideRoomInfo() : void
      {
         this._list.removeListItem(this.var_325);
      }
      
      private function showRoomInfo() : void
      {
         this._list.addListItemAt(this.var_325,0);
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = IWindowContainer(param1.window).findChildByTag("TEXT") as ITextWindow;
         _loc2_.textColor = const_1368;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = IWindowContainer(param1.window).findChildByTag("TEXT") as ITextWindow;
         _loc2_.textColor = const_1370;
      }
      
      private function createWindow(param1:String) : IWindow
      {
         var _loc2_:XmlAsset = this._assets.getAssetByName(param1) as XmlAsset;
         var _loc3_:IWindow = this._windowManager.buildFromXML(_loc2_.content as XML);
         _loc3_.procedure = this.onClick;
         var _loc4_:IWindowContainer = _loc3_.desktop;
         _loc3_.x = _loc4_.width - _loc3_.width - this.const_531;
         _loc3_.y = this.const_511;
         return _loc3_;
      }
      
      private function showConfirmation() : void
      {
         if(!this.var_590)
         {
            this.var_590 = this.createWindow("logout_confirmation_xml") as IWindowContainer;
         }
      }
      
      private function closeConfirmation() : void
      {
         if(this.var_590)
         {
            this.var_590.dispose();
            this.var_590 = null;
         }
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "logout_region":
               this.showConfirmation();
               break;
            case "help_region":
               this._toolbar.toggleWindowVisibility(const_1367);
               break;
            case "roominfo_region":
               this._toolbar.toggleWindowVisibility(const_1369);
               break;
            case "confirm":
               if(false)
               {
                  ExternalInterface.call("FlashExternalInterface.logout");
               }
               this.closeConfirmation();
               break;
            case "cancel":
               this.closeConfirmation();
         }
      }
   }
}
