package com.sulake.habbo.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetUserActionMessage;
   import flash.geom.Point;
   
   public class AvatarMenuView extends AvatarInfoView
   {
      
      protected static const const_1331:uint = 0;
      
      protected static const const_366:uint = 1;
      
      protected static const const_984:uint = 2;
      
      protected static var var_1336:uint = const_366;
      
      private static const const_1336:uint = 4281149991;
      
      private static const const_1340:uint = 4283715916;
      
      private static const const_1337:uint = 16777215;
      
      private static const const_1338:uint = 9552639;
      
      private static const const_1339:uint = 16744755;
      
      private static const const_1341:uint = 16756591;
       
      
      protected var _data:AvatarInfoData;
      
      protected var var_331:uint = 1;
      
      protected var var_1315:Boolean;
      
      public function AvatarMenuView(param1:AvatarInfoWidget)
      {
         super(param1);
      }
      
      public static function setup(param1:AvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:AvatarInfoData) : void
      {
         param1._data = param6;
         AvatarInfoView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onMouseHoverEvent);
            _window.removeEventListener(WindowMouseEvent.const_25,this.onMouseHoverEvent);
         }
         this._data = null;
         super.dispose();
      }
      
      override protected function method_1() : void
      {
         var _loc1_:* = null;
         if(!_widget || true || true)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = XmlAsset(_widget.assets.getAssetByName("avatar_menu_widget")).content as XML;
            _window = _widget.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
            if(!_window)
            {
               return;
            }
            setImageAsset(_window.findChildByName("pointer") as IBitmapWrapperWindow,"arrow_down_gray");
            _window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onMouseHoverEvent);
            _window.addEventListener(WindowMouseEvent.const_25,this.onMouseHoverEvent);
            _window.findChildByName("link_moderate").procedure = this.buttonEventProc;
            _window.findChildByName("link_show_actions").procedure = this.buttonEventProc;
            _window.findChildByName("link_more_actions").procedure = this.buttonEventProc;
         }
         _window.findChildByName("name").caption = _userName;
         this.updateButtons();
         _window.visible = false;
      }
      
      protected function updateButtons() : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:Boolean = false;
         var _loc1_:IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
         _loc1_.procedure = this.buttonEventProc;
         _loc1_.autoArrangeItems = false;
         var _loc2_:int = _loc1_.numListItems;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.getListItemAt(_loc3_).visible = false;
            _loc3_++;
         }
         if(!this.var_1315)
         {
            if(this._data.isIgnored)
            {
               this.var_331 = const_984;
            }
            else
            {
               this.var_331 = var_1336;
            }
         }
         if(this.var_331 == const_1331)
         {
            _window.findChildByName("link_moderate").visible = false;
            _window.findChildByName("link_show_actions").visible = false;
            _window.findChildByName("link_more_actions").visible = true;
         }
         if(this.var_331 == const_1331 || this.var_331 == const_366)
         {
            _loc1_.getListItemByName("friend").visible = true;
            if(this._data.canBeAskedAsFriend)
            {
               this.toggleButtonElement(_loc1_.getListItemByName("friend"),true);
            }
            else
            {
               this.toggleButtonElement(_loc1_.getListItemByName("friend"),false);
               this.var_331 = const_366;
            }
         }
         if(this.var_331 == const_366)
         {
            _window.findChildByName("link_moderate").visible = true;
            _window.findChildByName("link_show_actions").visible = false;
            _window.findChildByName("link_more_actions").visible = false;
            _loc4_ = this._data.respectLeft;
            _widget.localizations.registerParameter("infostand.button.respect","count",_loc4_.toString());
            _loc1_.getListItemByName("respect").visible = true;
            if(_loc4_ > 0)
            {
               this.toggleButtonElement(_loc1_.getListItemByName("respect"),true);
            }
            else
            {
               this.toggleButtonElement(_loc1_.getListItemByName("respect"),false);
            }
            _loc1_.getListItemByName("trade").visible = true;
            if(this._data.canTrade)
            {
               this.toggleButtonElement(_loc1_.getListItemByName("trade"),true);
            }
            else
            {
               this.toggleButtonElement(_loc1_.getListItemByName("trade"),false);
            }
            switch(this._data.canTradeReason)
            {
               case RoomWidgetUserInfoUpdateEvent.const_888:
                  _loc5_ = "${infostand.button.trade.tooltip.shutdown}";
                  break;
               case RoomWidgetUserInfoUpdateEvent.const_686:
                  _loc5_ = "${infostand.button.trade.tooltip.tradingroom}";
                  break;
               default:
                  _loc5_ = "";
            }
            IInteractiveWindow(IWindowContainer(_loc1_.getListItemByName("trade")).getChildByName("button")).toolTipCaption = _loc5_;
            _loc1_.getListItemByName("whisper").visible = true;
         }
         if(this.var_331 == const_984)
         {
            _window.findChildByName("link_moderate").visible = false;
            _window.findChildByName("link_show_actions").visible = true;
            _window.findChildByName("link_more_actions").visible = false;
            _loc1_.getListItemByName("ignore").visible = !this._data.isIgnored;
            _loc1_.getListItemByName("unignore").visible = this._data.isIgnored;
            _loc1_.getListItemByName("kick").visible = (this._data.amIOwner || this._data.amIController || this._data.amIAnyRoomController) && this._data.canBeKicked;
            _loc1_.getListItemByName("ban").visible = (this._data.amIOwner || this._data.amIAnyRoomController) && this._data.canBeKicked;
            _loc6_ = false;
            if(false && _widget.configuration.getKey("infostand.report.show","0") == "1")
            {
               _loc6_ = true;
            }
            _loc1_.getListItemByName("report").visible = _loc6_;
            if(this._data.amIOwner)
            {
               _loc1_.getListItemByName("give_rights").visible = !this._data.hasFlatControl;
               _loc1_.getListItemByName("remove_rights").visible = this._data.hasFlatControl;
            }
            else
            {
               _loc1_.getListItemByName("give_rights").visible = false;
               _loc1_.getListItemByName("remove_rights").visible = false;
            }
         }
         _loc1_.autoArrangeItems = true;
         _loc1_.visible = true;
         var_1336 = this.var_331;
         this.var_1315 = false;
      }
      
      private function toggleButtonElement(param1:IWindow, param2:Boolean) : void
      {
         param1.visible = param2;
      }
      
      private function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:Boolean = false;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "whisper":
                     _loc4_ = "null";
                     break;
                  case "friend":
                     param2.disable();
                     this._data.canBeAskedAsFriend = false;
                     _loc4_ = "null";
                     break;
                  case "respect":
                     --this._data.respectLeft;
                     _loc5_ = this._data.respectLeft;
                     _widget.localizations.registerParameter("infostand.button.respect","count",_loc5_.toString());
                     if(this._data.respectLeft > 0)
                     {
                        this.toggleButtonElement(param2.parent,true);
                     }
                     else
                     {
                        this.toggleButtonElement(param2.parent,false);
                     }
                     _loc4_ = "null";
                     if(_loc5_ > 0)
                     {
                        _loc3_ = false;
                     }
                     break;
                  case "ignore":
                     param2.parent.visible = false;
                     _window.findChildByName("unignore").visible = true;
                     this._data.isIgnored = true;
                     _loc4_ = "null";
                     break;
                  case "unignore":
                     param2.parent.visible = false;
                     _window.findChildByName("ignore").visible = true;
                     this._data.isIgnored = false;
                     _loc4_ = "null";
                     break;
                  case "kick":
                     _loc4_ = "null";
                     break;
                  case "ban":
                     _loc4_ = "null";
                     break;
                  case "give_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("remove_rights").visible = true;
                     this._data.hasFlatControl = true;
                     _loc4_ = "null";
                     break;
                  case "remove_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("give_rights").visible = true;
                     this._data.hasFlatControl = false;
                     _loc4_ = "null";
                     break;
                  case "trade":
                     _loc4_ = "null";
                     break;
                  case "report":
                     _loc4_ = "null";
               }
            }
            else
            {
               switch(param2.name)
               {
                  case "link_moderate":
                     this.var_331 = const_984;
                     this.var_1315 = true;
                     break;
                  case "link_show_actions":
                     this.var_331 = const_366;
                     this.var_1315 = true;
                     break;
                  case "link_more_actions":
                     this.var_331 = const_366;
                     this.var_1315 = true;
               }
            }
            if(_loc4_ != null)
            {
               _loc6_ = new RoomWidgetUserActionMessage(_loc4_,_userId);
               _widget.messageListener.processWidgetMessage(_loc6_);
               HabboTracking.getInstance().trackConversionPoint("InfoStand","click",_loc4_);
            }
            this.updateButtons();
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            if(param2.name == "button")
            {
               param2.color = const_1340;
            }
            else if(param2.tags.indexOf("link") > -1)
            {
               if(param2.tags.indexOf("actions") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1338;
               }
               else if(param2.tags.indexOf("moderate") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1341;
               }
            }
         }
         else if(param1.type == WindowMouseEvent.const_25)
         {
            if(param2.name == "button")
            {
               param2.color = const_1336;
            }
            else if(param2.tags.indexOf("link") > -1)
            {
               if(param2.tags.indexOf("actions") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1337;
               }
               else if(param2.tags.indexOf("moderate") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1339;
               }
            }
         }
         if(_loc3_)
         {
            _widget.removeView();
         }
      }
      
      protected function onMouseHoverEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            var_1316 = true;
         }
         else if(param1.type == WindowMouseEvent.const_25)
         {
            if(!_window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               var_1316 = false;
            }
         }
      }
   }
}
