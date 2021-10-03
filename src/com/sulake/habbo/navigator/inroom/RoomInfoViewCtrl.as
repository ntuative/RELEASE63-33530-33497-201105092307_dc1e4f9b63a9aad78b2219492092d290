package com.sulake.habbo.navigator.inroom
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateEventMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateNavigatorSettingsMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.SimpleAlertView;
   import com.sulake.habbo.navigator.TagRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
   import com.sulake.habbo.navigator.roomsettings.IRoomSettingsCtrlOwner;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailCtrl;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomInfoViewCtrl implements IRoomSettingsCtrlOwner
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var _window:IWindowContainer;
      
      private var var_175:IWindowContainer;
      
      private var var_2950:int;
      
      private var var_382:RoomEventViewCtrl;
      
      private var var_271:Timer;
      
      private var var_188:RoomSettingsCtrl;
      
      private var var_270:RoomThumbnailCtrl;
      
      private var var_1280:TagRenderer;
      
      private var var_325:IWindowContainer;
      
      private var var_453:IWindowContainer;
      
      private var var_813:IWindowContainer;
      
      private var var_2737:IWindowContainer;
      
      private var var_2734:IWindowContainer;
      
      private var var_1545:IWindowContainer;
      
      private var var_975:ITextWindow;
      
      private var var_1253:ITextWindow;
      
      private var _ownerName:ITextWindow;
      
      private var var_1022:ITextWindow;
      
      private var var_1551:ITextWindow;
      
      private var var_1250:ITextWindow;
      
      private var var_1025:ITextWindow;
      
      private var var_1992:ITextWindow;
      
      private var var_272:IWindowContainer;
      
      private var var_1026:IWindowContainer;
      
      private var var_1990:IWindowContainer;
      
      private var var_2232:ITextWindow;
      
      private var var_812:ITextWindow;
      
      private var var_2735:IWindow;
      
      private var var_1546:IContainerButtonWindow;
      
      private var var_1544:IContainerButtonWindow;
      
      private var var_1547:IContainerButtonWindow;
      
      private var var_1548:IContainerButtonWindow;
      
      private var var_1550:IContainerButtonWindow;
      
      private var var_1993:IButtonWindow;
      
      private var var_1991:IButtonWindow;
      
      private var var_1994:IButtonWindow;
      
      private var var_1024:IWindowContainer;
      
      private var var_1549:ITextWindow;
      
      private var var_1251:ITextFieldWindow;
      
      private var _buttons:IWindowContainer;
      
      private var var_1252:IButtonWindow;
      
      private var var_1023:IButtonWindow;
      
      private var var_2736:String;
      
      private var var_2733:String;
      
      private var var_454:Boolean = true;
      
      private const const_511:int = 75;
      
      private const const_531:int = 3;
      
      private const const_635:int = 45;
      
      public function RoomInfoViewCtrl(param1:HabboNavigator)
      {
         super();
         this._navigator = param1;
         this.var_382 = new RoomEventViewCtrl(this._navigator);
         this.var_188 = new RoomSettingsCtrl(this._navigator,this,true);
         this.var_270 = new RoomThumbnailCtrl(this._navigator);
         this.var_1280 = new TagRenderer(this._navigator);
         this._navigator.roomSettingsCtrls.push(this.var_188);
         this.var_271 = new Timer(6000,1);
         this.var_271.addEventListener(TimerEvent.TIMER,this.hideInfo);
      }
      
      public function dispose() : void
      {
         if(this._navigator.toolbar)
         {
            this._navigator.toolbar.events.removeEventListener(HabboToolbarSetIconEvent.const_110,this.onToolbarIconState);
         }
         if(this.var_271)
         {
            this.var_271.removeEventListener(TimerEvent.TIMER,this.hideInfo);
            this.var_271.reset();
            this.var_271 = null;
         }
      }
      
      public function roomSettingsRefreshNeeded() : void
      {
         this.refresh();
      }
      
      public function startEventEdit() : void
      {
         this.var_271.reset();
         this.var_382.active = true;
         this.var_188.active = false;
         this.var_270.active = false;
         this.reload();
      }
      
      public function startRoomSettingsEdit(param1:int) : void
      {
         this.var_271.reset();
         this.var_188.load(param1);
         this.var_188.active = true;
         this.var_382.active = false;
         this.var_270.active = false;
         this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
      }
      
      public function backToRoomSettings() : void
      {
         this.var_188.active = true;
         this.var_382.active = false;
         this.var_270.active = false;
         this.reload();
         this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
      }
      
      public function startThumbnailEdit() : void
      {
         this.var_271.reset();
         this.var_188.active = false;
         this.var_382.active = false;
         this.var_270.active = true;
         this.reload();
         this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS));
      }
      
      public function close() : void
      {
         if(this.var_454)
         {
            this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_1227,HabboToolbarIconEnum.ROOMINFO,this._window,false));
         }
         if(this._window == null)
         {
            return;
         }
         this._window.visible = false;
         this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED));
      }
      
      public function reload() : void
      {
         if(this._window != null && this._window.visible)
         {
            this.refresh();
         }
      }
      
      public function open(param1:Boolean) : void
      {
         this.var_271.reset();
         this.var_382.active = false;
         this.var_188.active = false;
         this.var_270.active = false;
         if(param1)
         {
            this.startRoomSettingsEdit(this._navigator.data.enteredGuestRoom.flatId);
         }
         this.refresh();
         this._window.visible = true;
         if(this.var_454)
         {
            this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_62,HabboToolbarIconEnum.ROOMINFO,this._window,false));
         }
         this._window.parent.activate();
         this._window.activate();
         if(!param1)
         {
            this.var_271.start();
         }
      }
      
      public function toggle() : void
      {
         this.var_271.reset();
         this.var_382.active = false;
         this.var_188.active = false;
         this.var_270.active = false;
         this.refresh();
         if(this.var_454)
         {
            if(!this._window.visible)
            {
               this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_62,HabboToolbarIconEnum.ROOMINFO,this._window,false));
               this._window.parent.activate();
            }
            else
            {
               this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_694,HabboToolbarIconEnum.ROOMINFO,this._window,false));
            }
         }
         else
         {
            this._window.visible = !this._window.visible;
            this._window.x = this._window.desktop.width - this._window.width - this.const_531;
            this._window.y = this.const_511;
            if(this._window.visible)
            {
               this._window.activate();
            }
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         this.prepareWindow();
         this.refreshRoom();
         this.refreshEvent();
         this.refreshEmbed();
         this.refreshButtons();
         if(this.var_454)
         {
            Util.moveChildrenToColumn(this._window,["room_info","event_info","embed_info","buttons_container"],0,2);
            this._window.height = Util.getLowestPoint(this._window);
            this._window.y = this._window.desktop.height - this._window.height - 5;
            Logger.log("MAIN: " + this.var_325.rectangle + ", " + this.var_272.rectangle + ", " + this._window.rectangle);
         }
         else
         {
            Util.moveChildrenToColumn(this.var_175,["room_info","event_info","embed_info","buttons_container"],0,2);
            this.var_175.height = Util.getLowestPoint(this.var_175);
            _loc1_ = this._window.desktop.height - this._window.height - this.const_635;
            if(this._window.y > _loc1_)
            {
               this._window.y = _loc1_ < 0 ? 0 : int(_loc1_);
            }
         }
      }
      
      private function refreshRoom() : void
      {
         Util.hideChildren(this.var_325);
         if(this.var_454)
         {
            this.var_325.findChildByName("close").visible = true;
         }
         var _loc1_:GuestRoomData = this._navigator.data.enteredGuestRoom;
         var _loc2_:Boolean = _loc1_ != null && _loc1_.flatId == this._navigator.data.homeRoomId;
         this.refreshRoomDetails(_loc1_,_loc2_);
         this.refreshPublicSpaceDetails(this._navigator.data.enteredPublicSpace);
         this.refreshRoomButtons(_loc2_);
         this.var_188.refresh(this.var_325);
         this.var_270.refresh(this.var_325);
         Util.moveChildrenToColumn(this.var_325,["room_details","room_buttons"],0,2);
         this.var_325.height = Util.getLowestPoint(this.var_325);
         this.var_325.visible = true;
         Logger.log("XORP: " + this.var_453.visible + ", " + this.var_1545.visible + ", " + this.var_813.visible + ", " + this.var_813.rectangle + ", " + this.var_325.rectangle);
      }
      
      private function refreshEvent() : void
      {
         Util.hideChildren(this.var_272);
         var _loc1_:RoomEventData = this._navigator.data.roomEventData;
         this.refreshEventDetails(_loc1_);
         this.refreshEventButtons(_loc1_);
         this.var_382.refresh(this.var_272);
         if(Util.hasVisibleChildren(this.var_272) && !(this.var_188.active || this.var_270.active))
         {
            Util.moveChildrenToColumn(this.var_272,["event_details","event_buttons"],0,2);
            this.var_272.height = Util.getLowestPoint(this.var_272);
            this.var_272.visible = true;
         }
         else
         {
            this.var_272.visible = false;
         }
         Logger.log("EVENT: " + this.var_272.visible + ", " + this.var_272.rectangle);
      }
      
      private function refreshEmbed() : void
      {
         var _loc1_:* = this._navigator.configuration.getKey("embed.showInRoomInfo","false") == "true";
         var _loc2_:* = this._navigator.data.enteredGuestRoom != null;
         if(_loc2_ && _loc1_ && !this.var_188.active && !this.var_270.active && !this.var_382.active)
         {
            this.var_1024.visible = true;
            this.var_1251.text = this.getEmbedData();
         }
         else
         {
            this.var_1024.visible = false;
         }
      }
      
      private function refreshButtons() : void
      {
         var _loc1_:* = false;
         if(!this._buttons)
         {
            return;
         }
         if(this.var_188.active)
         {
            this._buttons.visible = false;
            return;
         }
         this._buttons.visible = true;
         if(this.var_1252)
         {
            if(this.var_2736 == "exit_homeroom")
            {
               this.var_1252.caption = "${navigator.homeroom}";
            }
            else
            {
               this.var_1252.caption = "${navigator.hotelview}";
            }
         }
         if(this.var_1023)
         {
            _loc1_ = this._navigator.data.enteredGuestRoom != null;
            this.var_1023.visible = _loc1_;
            if(this.var_2733 == "0")
            {
               this.var_1023.caption = "${navigator.zoom.in}";
            }
            else
            {
               this.var_1023.caption = "${navigator.zoom.out}";
            }
         }
      }
      
      private function refreshRoomDetails(param1:GuestRoomData, param2:Boolean) : void
      {
         if(param1 == null || this.var_188.active || this.var_270.active)
         {
            return;
         }
         this.var_975.text = param1.roomName;
         this.var_975.height = this.var_975.textHeight + 5;
         this._ownerName.text = param1.ownerName;
         this.var_1022.text = param1.description;
         this.var_1280.refreshTags(this.var_453,param1.tags);
         this.var_1022.visible = false;
         if(param1.description != "")
         {
            this.var_1022.height = this.var_1022.textHeight + 5;
            this.var_1022.visible = true;
         }
         var _loc3_:Boolean = Boolean(this._navigator.configuration.getKey("client.allow.facebook.like") == "1");
         this._navigator.refreshButton(this.var_1544,"facebook_logo_small",_loc3_,null,0);
         this.var_1544.visible = _loc3_;
         var _loc4_:* = this._navigator.data.currentRoomRating == -1;
         this._navigator.refreshButton(this.var_1546,"thumb_up",_loc4_,null,0);
         this.var_1546.visible = _loc4_;
         this.var_1025.visible = !_loc4_;
         this.var_1992.visible = !_loc4_;
         this.var_1992.text = "" + this._navigator.data.currentRoomRating;
         this.refreshStuffPick();
         this._navigator.refreshButton(this.var_453,"home",param2,null,0);
         this._navigator.refreshButton(this.var_453,"favourite",!param2 && this._navigator.data.isCurrentRoomFavourite(),null,0);
         Util.moveChildrenToColumn(this.var_453,["room_name","owner_name_cont","tags","room_desc","rating_cont","staff_pick_button"],this.var_975.y,0);
         this.var_453.visible = true;
         this.var_453.height = Util.getLowestPoint(this.var_453);
      }
      
      private function refreshStuffPick() : void
      {
         var _loc1_:IWindow = this.var_453.findChildByName("staff_pick_button");
         if(!this._navigator.data.roomPicker)
         {
            _loc1_.visible = false;
            return;
         }
         _loc1_.visible = true;
         _loc1_.caption = this._navigator.getText(!!this._navigator.data.currentRoomIsStaffPick ? "navigator.staffpicks.unpick" : "navigator.staffpicks.pick");
      }
      
      private function refreshPublicSpaceDetails(param1:PublicRoomShortData) : void
      {
         if(param1 == null || this.var_188.active || this.var_270.active)
         {
            return;
         }
         this.var_1253.text = this._navigator.getPublicSpaceName(param1.unitPropertySet,param1.worldId);
         this.var_1253.height = this.var_1253.textHeight + 5;
         this.var_1551.text = this._navigator.getPublicSpaceDesc(param1.unitPropertySet,param1.worldId);
         this.var_1551.height = this.var_1551.textHeight + 5;
         Util.moveChildrenToColumn(this.var_813,["public_space_name","public_space_desc"],this.var_1253.y,0);
         this.var_813.visible = true;
         this.var_813.height = Math.max(86,Util.getLowestPoint(this.var_813));
      }
      
      private function refreshEventDetails(param1:RoomEventData) : void
      {
         if(param1 == null || this.var_382.active)
         {
            return;
         }
         this.var_2232.text = param1.eventName;
         this.var_812.text = param1.eventDescription;
         this.var_1280.refreshTags(this.var_1026,[this._navigator.getText("roomevent_type_" + param1.eventType),param1.tags[0],param1.tags[1]]);
         this.var_812.visible = false;
         if(param1.eventDescription != "")
         {
            this.var_812.height = this.var_812.textHeight + 5;
            this.var_812.y = Util.getLowestPoint(this.var_1026) + 2;
            this.var_812.visible = true;
         }
         this.var_1026.visible = true;
         this.var_1026.height = Util.getLowestPoint(this.var_1026);
      }
      
      private function refreshRoomButtons(param1:Boolean) : void
      {
         if(this._navigator.data.enteredGuestRoom == null || this.var_188.active || this.var_270.active)
         {
            return;
         }
         this.var_1993.visible = this._navigator.data.canEditRoomSettings;
         var _loc2_:Boolean = this._navigator.data.isCurrentRoomFavourite();
         this.var_1547.visible = this._navigator.data.canAddFavourite && !_loc2_;
         this.var_1548.visible = this._navigator.data.canAddFavourite && _loc2_;
         this.var_1550.visible = this._navigator.data.canEditRoomSettings && !param1;
         this.var_1545.visible = Util.hasVisibleChildren(this.var_1545);
      }
      
      private function refreshEventButtons(param1:RoomEventData) : void
      {
         if(this.var_382.active)
         {
            return;
         }
         this.var_1991.visible = param1 == null && this._navigator.data.currentRoomOwner;
         this.var_1994.visible = param1 != null && (this._navigator.data.currentRoomOwner || this._navigator.data.eventMod);
         this.var_1990.visible = Util.hasVisibleChildren(this.var_1990);
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         if(this.var_454)
         {
            this._window = IWindowContainer(this._navigator.getXmlWindow("iro_room_details"));
            this._window.setParamFlag(HabboWindowParam.const_64,false);
            this._window.setParamFlag(HabboWindowParam.const_1646,true);
         }
         else
         {
            this._window = IWindowContainer(this._navigator.getXmlWindow("iro_room_details_framed"));
            this.var_175 = this._window.findChildByName("content") as IWindowContainer;
         }
         this._window.visible = false;
         this.var_325 = IWindowContainer(this.find("room_info"));
         this.var_453 = IWindowContainer(this.find("room_details"));
         this.var_813 = IWindowContainer(this.find("public_space_details"));
         this.var_2737 = IWindowContainer(this.find("owner_name_cont"));
         this.var_2734 = IWindowContainer(this.find("rating_cont"));
         this.var_1545 = IWindowContainer(this.find("room_buttons"));
         this.var_975 = ITextWindow(this.find("room_name"));
         this.var_1253 = ITextWindow(this.find("public_space_name"));
         this._ownerName = ITextWindow(this.find("owner_name"));
         this.var_1022 = ITextWindow(this.find("room_desc"));
         this.var_1551 = ITextWindow(this.find("public_space_desc"));
         this.var_1250 = ITextWindow(this.find("owner_caption"));
         this.var_1025 = ITextWindow(this.find("rating_caption"));
         this.var_1992 = ITextWindow(this.find("rating_txt"));
         this.var_272 = IWindowContainer(this.find("event_info"));
         this.var_1026 = IWindowContainer(this.find("event_details"));
         this.var_1990 = IWindowContainer(this.find("event_buttons"));
         this.var_2232 = ITextWindow(this.find("event_name"));
         this.var_812 = ITextWindow(this.find("event_desc"));
         this.var_1544 = IContainerButtonWindow(this.find("facebook_like_button"));
         this.var_1546 = IContainerButtonWindow(this.find("rate_up_button"));
         this.var_2735 = this.find("staff_pick_button");
         this.var_1547 = IContainerButtonWindow(this.find("add_favourite_button"));
         this.var_1548 = IContainerButtonWindow(this.find("rem_favourite_button"));
         this.var_1550 = IContainerButtonWindow(this.find("make_home_button"));
         this.var_1993 = IButtonWindow(this.find("room_settings_button"));
         this.var_1991 = IButtonWindow(this.find("create_event_button"));
         this.var_1994 = IButtonWindow(this.find("edit_event_button"));
         this.var_1024 = IWindowContainer(this.find("embed_info"));
         this.var_1549 = ITextWindow(this.find("embed_info_txt"));
         this.var_1251 = ITextFieldWindow(this.find("embed_src_txt"));
         this._buttons = IWindowContainer(this.find("buttons_container"));
         this.var_1252 = IButtonWindow(this.find("exit_room_button"));
         this.var_1023 = IButtonWindow(this.find("zoom_button"));
         Util.setProcDirectly(this.var_1547,this.onAddFavouriteClick);
         Util.setProcDirectly(this.var_1548,this.onRemoveFavouriteClick);
         Util.setProcDirectly(this.var_1993,this.onRoomSettingsClick);
         Util.setProcDirectly(this.var_1550,this.onMakeHomeClick);
         Util.setProcDirectly(this.var_1991,this.onEventSettingsClick);
         Util.setProcDirectly(this.var_1994,this.onEventSettingsClick);
         Util.setProcDirectly(this.var_1251,this.onEmbedSrcClick);
         Util.setProcDirectly(this.var_1546,this.onThumbUp);
         Util.setProcDirectly(this.var_2735,this.onStaffPick);
         Util.setProcDirectly(this.var_1544,this.onFacebookLike);
         Util.setProcDirectly(this.var_1023,this.onZoomClick);
         Util.setProcDirectly(this.var_1252,this.onExitRoomClick);
         this._navigator.refreshButton(this.var_1547,"favourite",true,null,0);
         this._navigator.refreshButton(this.var_1548,"favourite",true,null,0);
         this._navigator.refreshButton(this.var_1550,"home",true,null,0);
         if(this.var_454)
         {
            this._window.findChildByName("close").procedure = this.onCloseButtonClick;
         }
         else
         {
            this._window.findChildByTag("close").procedure = this.onCloseButtonClick;
         }
         Util.setProcDirectly(this.var_325,this.onHover);
         Util.setProcDirectly(this.var_272,this.onHover);
         this.var_1250.width = this.var_1250.textWidth;
         Util.moveChildrenToRow(this.var_2737,["owner_caption","owner_name"],this.var_1250.x,this.var_1250.y,3);
         this.var_1025.width = this.var_1025.textWidth;
         Util.moveChildrenToRow(this.var_2734,["rating_caption","rating_txt"],this.var_1025.x,this.var_1025.y,3);
         this.var_1549.height = this.var_1549.textHeight + 5;
         Util.moveChildrenToColumn(this.var_1024,["embed_info_txt","embed_src_txt"],this.var_1549.y,2);
         this.var_1024.height = Util.getLowestPoint(this.var_1024) + 5;
         this.var_2950 = this._window.y + this._window.height;
      }
      
      private function find(param1:String) : IWindow
      {
         var _loc2_:IWindow = this._window.findChildByName(param1);
         if(_loc2_ == null)
         {
            throw new Error("Window element with name: " + param1 + " cannot be found!");
         }
         return _loc2_;
      }
      
      private function getButtonsMinHeight() : int
      {
         return !!this._navigator.data.currentRoomOwner ? 0 : 21;
      }
      
      private function getRoomInfoMinHeight() : int
      {
         return 37;
      }
      
      private function getEventInfoMinHeight() : int
      {
         return 18;
      }
      
      public function onAddFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(this._navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         if(this._navigator.data.isFavouritesFull())
         {
            _loc3_ = new SimpleAlertView(this._navigator,"${navigator.favouritesfull.title}","${navigator.favouritesfull.body}");
            _loc3_.show();
         }
         else
         {
            this._navigator.send(new AddFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
         }
      }
      
      public function onRemoveFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(this._navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         this._navigator.send(new DeleteFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
      }
      
      private function onEventSettingsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(this._navigator.data.roomEventData == null)
         {
            if(this._navigator.data.currentRoomOwner)
            {
               this._navigator.send(new CanCreateEventMessageComposer());
            }
         }
         else
         {
            this.startEventEdit();
         }
      }
      
      private function onRoomSettingsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:GuestRoomData = this._navigator.data.enteredGuestRoom;
         if(_loc3_ == null)
         {
            Logger.log("No entered room data?!");
            return;
         }
         this.startRoomSettingsEdit(_loc3_.flatId);
      }
      
      private function onMakeHomeClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:GuestRoomData = this._navigator.data.enteredGuestRoom;
         if(_loc3_ == null)
         {
            Logger.log("No entered room data?!");
            return;
         }
         Logger.log("SETTING HOME ROOM TO: " + _loc3_.flatId);
         this._navigator.send(new UpdateNavigatorSettingsMessageComposer(_loc3_.flatId));
      }
      
      private function onCloseButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.hideInfo(null);
      }
      
      private function onThumbUp(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this._navigator.send(new RateFlatMessageComposer(1));
      }
      
      private function onStaffPick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this._navigator.send(new ToggleStaffPickMessageComposer(this._navigator.data.enteredGuestRoom.flatId,this._navigator.data.currentRoomIsStaffPick));
      }
      
      private function onThumbDown(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this._navigator.send(new RateFlatMessageComposer(-1));
      }
      
      private function onFacebookLike(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         HabboWebTools.facebookLike(this._navigator.data.enteredGuestRoom.flatId);
      }
      
      private function onEmbedSrcClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.var_1251.setSelection(0,this.var_1251.text.length);
      }
      
      private function onZoomClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:HabboToolbarEvent = new HabboToolbarEvent(HabboToolbarEvent.const_36);
         _loc3_.iconId = HabboToolbarIconEnum.ZOOM;
         _loc3_.iconName = "ZOOM";
         this._navigator.toolbar.events.dispatchEvent(_loc3_);
      }
      
      private function onExitRoomClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:HabboToolbarEvent = new HabboToolbarEvent(HabboToolbarEvent.const_36);
         _loc3_.iconId = HabboToolbarIconEnum.EXITROOM;
         _loc3_.iconName = "EXITROOM";
         this._navigator.toolbar.events.dispatchEvent(_loc3_);
      }
      
      private function onToolbarIconState(param1:HabboToolbarSetIconEvent) : void
      {
         if(param1.type != HabboToolbarSetIconEvent.const_110)
         {
            return;
         }
         switch(param1.iconId)
         {
            case HabboToolbarIconEnum.ZOOM:
               this.var_2733 = param1.iconState;
               this.refreshButtons();
               break;
            case HabboToolbarIconEnum.EXITROOM:
               this.var_2736 = param1.iconState;
               this.refreshButtons();
         }
      }
      
      private function onHover(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            return;
         }
         this.var_271.reset();
      }
      
      private function hideInfo(param1:Event) : void
      {
         if(this.var_454)
         {
            this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_694,HabboToolbarIconEnum.ROOMINFO,this._window,false));
         }
         else
         {
            this._window.visible = false;
         }
      }
      
      private function getEmbedData() : String
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this._navigator.data.enteredGuestRoom != null)
         {
            _loc1_ = "private";
            _loc2_ = "" + this._navigator.data.enteredGuestRoom.flatId;
         }
         else
         {
            _loc1_ = "public";
            _loc2_ = "" + this._navigator.data.publicSpaceNodeId;
            Logger.log("Node id is: " + _loc2_);
         }
         var _loc3_:String = this._navigator.configuration.getKey("user.hash","");
         this._navigator.registerParameter("navigator.embed.src","roomType",_loc1_);
         this._navigator.registerParameter("navigator.embed.src","embedCode",_loc3_);
         this._navigator.registerParameter("navigator.embed.src","roomId",_loc2_);
         return this._navigator.getText("navigator.embed.src");
      }
      
      public function registerToolbarEvents() : void
      {
         if(this._navigator.toolbar)
         {
            this._navigator.toolbar.events.addEventListener(HabboToolbarSetIconEvent.const_110,this.onToolbarIconState);
         }
      }
      
      public function handleToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type != HabboToolbarEvent.const_36)
         {
            return;
         }
         switch(param1.iconId)
         {
            case HabboToolbarIconEnum.MEMENU:
               if(this.useToolbar)
               {
                  this.close();
               }
               break;
            case HabboToolbarIconEnum.ROOMINFO:
               this.toggle();
         }
      }
      
      public function configure() : void
      {
         if(this._navigator.configuration)
         {
            this.var_454 = this._navigator.configuration.getKey("roominfo.widget.enabled") != "1";
         }
      }
      
      public function get useToolbar() : Boolean
      {
         return this.var_454;
      }
   }
}
