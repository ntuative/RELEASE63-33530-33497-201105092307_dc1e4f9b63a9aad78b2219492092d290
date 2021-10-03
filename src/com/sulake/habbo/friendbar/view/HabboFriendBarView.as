package com.sulake.habbo.friendbar.view
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.friendbar.HabboFriendBar;
   import com.sulake.habbo.friendbar.data.IFriendEntity;
   import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
   import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
   import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
   import com.sulake.habbo.friendbar.events.FriendRequestEvent;
   import com.sulake.habbo.friendbar.events.NewMessageEvent;
   import com.sulake.habbo.friendbar.iid.IIDHabboFriendBarData;
   import com.sulake.habbo.friendbar.view.tabs.AddFriendsTab;
   import com.sulake.habbo.friendbar.view.tabs.FriendEntityTab;
   import com.sulake.habbo.friendbar.view.tabs.ITab;
   import com.sulake.habbo.friendbar.view.tabs.Tab;
   import com.sulake.habbo.friendbar.view.utils.FriendListIcon;
   import com.sulake.habbo.friendbar.view.utils.Icon;
   import com.sulake.habbo.friendbar.view.utils.MessengerIcon;
   import com.sulake.habbo.friendbar.view.utils.TextCropper;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboAlertDialogFlag;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.iid.IIDAvatarRenderManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import iid.IIDHabboWindowManager;
   
   public class HabboFriendBarView extends Component implements IHabboFriendBarView, IAvatarImageListener
   {
      
      private static const const_1373:int = 127;
      
      private static const const_452:int = 1;
      
      private static const const_1374:int = 2;
      
      private static const const_656:int = 3;
      
      private static const const_1011:int = 3;
      
      private static const const_1378:Boolean = false;
      
      private static const const_655:int = 3;
      
      private static const const_1375:String = "bar_xml";
      
      private static const const_1372:String = "toggle_xml";
      
      private static const const_77:String = "container";
      
      private static const const_1377:String = "border";
      
      private static const const_451:String = "list";
      
      private static const const_668:String = "header";
      
      private static const const_667:String = "canvas";
      
      private static const const_1014:String = "icon";
      
      private static const const_1008:String = "button_left";
      
      private static const const_1012:String = "button_right";
      
      private static const const_1007:String = "button_left_page";
      
      private static const const_1009:String = "button_right_page";
      
      private static const const_1015:String = "button_left_end";
      
      private static const const_1013:String = "button_right_end";
      
      private static const const_1335:String = "button_close";
      
      private static const const_1371:String = "button_open";
      
      private static const const_1376:String = "messenger";
      
      private static const const_1010:String = "friendlist";
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1080:IAvatarRenderManager;
      
      private var var_101:IHabboFriendBarData;
      
      private var var_34:IWindowContainer;
      
      private var var_196:IWindowContainer;
      
      private var var_98:Vector.<ITab>;
      
      private var var_1371:ITab;
      
      private var var_893:int = -1;
      
      private var _startIndex:int = 0;
      
      private var var_1370:TextCropper;
      
      private var var_725:FriendListIcon;
      
      private var var_495:MessengerIcon;
      
      private var var_1124:Boolean = false;
      
      public function HabboFriendBarView(param1:HabboFriendBar, param2:uint, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
         this.var_1370 = new TextCropper();
         this.var_98 = new Vector.<ITab>();
         if(param1 is HabboFriendBar)
         {
            this.var_1124 = HabboFriendBar(param1).findFriendsEnabled;
         }
         queueInterface(new IIDAvatarRenderManager(),this.onAvatarRendererAvailable);
         queueInterface(new IIDHabboWindowManager(),this.onWindowManagerAvailable);
         queueInterface(new IIDHabboFriendBarData(),this.onFriendBarDataAvailable);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            this._windowManager.getWindowContext(const_452).getDesktopWindow().removeEventListener(WindowEvent.const_41,this.onDesktopResized);
            if(this.var_495)
            {
               this.var_495.dispose();
               this.var_495 = null;
            }
            if(this.var_725)
            {
               this.var_725.dispose();
               this.var_725 = null;
            }
            if(this.var_196)
            {
               this.var_196.dispose();
               this.var_196 = null;
            }
            if(this.var_34)
            {
               this.var_34.dispose();
               this.var_34 = null;
            }
            while(this.var_98.length > 0)
            {
               ITab(this.var_98.pop()).dispose();
            }
            if(this.var_101)
            {
               this.var_101.events.removeEventListener(FriendBarUpdateEvent.const_972,this.onRefreshView);
               this.var_101 = null;
               release(new IIDHabboFriendBarData());
            }
            if(this._windowManager)
            {
               this._windowManager = null;
               release(new IIDHabboWindowManager());
            }
            if(this.var_1080)
            {
               this.var_1080 = null;
               release(new IIDAvatarRenderManager());
            }
            this.var_1370.dispose();
            this.var_1370 = null;
            super.dispose();
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(this.var_34)
         {
            this.var_34.visible = param1;
            this.var_34.activate();
         }
         if(this.var_196)
         {
            this.var_196.visible = !param1;
            if(this.var_34)
            {
               this.var_196.x = this.var_34.x;
               this.var_196.y = this.var_34.y;
               this.var_196.activate();
            }
         }
      }
      
      public function get visible() : Boolean
      {
         return this.var_34 && this.var_34.visible;
      }
      
      public function populate() : void
      {
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc1_:int = this.var_893;
         this.deSelect();
         var _loc2_:IWindowContainer = this.var_34.findChildByName(const_77) as IWindowContainer;
         var _loc3_:IItemListWindow = _loc2_.findChildByName(const_451) as IItemListWindow;
         _loc3_.autoArrangeItems = false;
         var _loc4_:int = _loc3_.numListItems;
         _loc5_ = _loc4_;
         while(_loc5_ > 0)
         {
            _loc3_.removeListItemAt(_loc5_ - 1);
            _loc5_--;
         }
         while(this.var_98.length > 0)
         {
            this.var_98.pop().recycle();
         }
         var _loc6_:int = this.var_101.numFriends + (!!this.var_1124 ? 1 : 0);
         var _loc7_:int = Math.min(this.maxNumOfTabsVisible,_loc6_);
         if(this._startIndex + _loc7_ > _loc6_)
         {
            this._startIndex = Math.max(0,this._startIndex - (this._startIndex + _loc7_ - _loc6_));
         }
         _loc4_ = Math.min(this.var_101.numFriends,this._startIndex + _loc7_);
         _loc5_ = this._startIndex;
         while(_loc5_ < _loc4_)
         {
            _loc8_ = this.var_101.getFriendAt(_loc5_);
            _loc9_ = FriendEntityTab.allocate(_loc8_);
            this.var_98.push(_loc9_);
            _loc3_.addListItem(_loc9_.window);
            _loc5_++;
         }
         if(this.var_1124)
         {
            _loc10_ = this.maxNumOfTabsVisible;
            if(this.var_98.length < _loc10_)
            {
               _loc11_ = 1;
               if(this.var_98.length + _loc11_ < const_655)
               {
                  _loc11_ = Math.min(_loc10_ - this.var_98.length,const_655 - this.var_98.length);
               }
               while(_loc11_-- > 0)
               {
                  _loc12_ = AddFriendsTab.allocate();
                  _loc3_.addListItem(_loc12_.window);
                  this.var_98.push(_loc12_);
               }
            }
         }
         _loc3_.autoArrangeItems = true;
         if(_loc1_ > -1)
         {
            this.selectFriendEntity(_loc1_);
         }
         _loc2_.visible = this.var_98.length > 0;
         this.toggleArrowButtons(this.var_98.length < _loc6_);
      }
      
      private function getFriendEntityTabByID(param1:int) : FriendEntityTab
      {
         var _loc2_:* = null;
         var _loc3_:int = this.var_98.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this.var_98[_loc4_] as FriendEntityTab;
            if(_loc2_)
            {
               if(_loc2_.friend.id == param1)
               {
                  return _loc2_;
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      private function onFriendBarDataAvailable(param1:IID, param2:IUnknown) : void
      {
         this.var_101 = param2 as IHabboFriendBarData;
         this.var_101.events.addEventListener(FriendBarUpdateEvent.const_972,this.onRefreshView);
         this.var_101.events.addEventListener(FindFriendsNotificationEvent.TYPE,this.onFindFriendsNotification);
         this.var_101.events.addEventListener(FriendRequestEvent.const_1206,this.onFriendRequestUpdate);
         this.var_101.events.addEventListener(NewMessageEvent.const_1185,this.onNewInstantMessage);
      }
      
      private function onWindowManagerAvailable(param1:IID, param2:IUnknown) : void
      {
         this._windowManager = param2 as IHabboWindowManager;
      }
      
      private function isUserInterfaceReady() : Boolean
      {
         return this.var_34 && !this.var_34.disposed;
      }
      
      private function buildUserInterface() : void
      {
         var _loc2_:* = null;
         Tab.var_1063 = this.var_101;
         Tab.var_1596 = this;
         Tab.var_853 = assets;
         Tab.var_1312 = this._windowManager;
         Tab.var_2083 = this.var_1370;
         var _loc1_:IAsset = assets.getAssetByName(const_1375);
         this.var_34 = this._windowManager.buildFromXML(_loc1_.content as XML,const_452) as IWindowContainer;
         this.var_34.x = const_656;
         this.var_34.y = this.var_34.parent.height - (this.var_34.height + const_1374);
         this.var_34.width = this.var_34.parent.width - (const_656 + const_1011);
         this.var_34.setParamFlag(WindowParam.const_235,true);
         this.var_34.procedure = this.barWindowEventProc;
         if(const_1378)
         {
            _loc1_ = assets.getAssetByName(const_1372);
            this.var_196 = this._windowManager.buildFromXML(_loc1_.content as XML,const_452) as IWindowContainer;
            this.var_196.x = this.var_34.x;
            this.var_196.y = this.var_34.y;
            this.var_196.setParamFlag(WindowParam.const_235,true);
            this.var_196.visible = false;
            this.var_196.procedure = this.toggleWindowEventProc;
         }
         _loc2_ = IWindowContainer(this.var_34.findChildByName(const_1010));
         _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onIconMouseEvent);
         _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onIconMouseEvent);
         _loc2_.addEventListener(WindowMouseEvent.const_25,this.onIconMouseEvent);
         this.var_725 = new FriendListIcon(assets,_loc2_.getChildByName(const_1014) as IBitmapWrapperWindow);
         _loc2_ = IWindowContainer(this.var_34.findChildByName(const_1376));
         _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onIconMouseEvent);
         _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onIconMouseEvent);
         _loc2_.addEventListener(WindowMouseEvent.const_25,this.onIconMouseEvent);
         this.var_495 = new MessengerIcon(assets,_loc2_.getChildByName(const_1014) as IBitmapWrapperWindow);
         this.var_495.enable(false);
         this.visible = true;
         this._windowManager.getWindowContext(const_452).getDesktopWindow().addEventListener(WindowEvent.const_41,this.onDesktopResized);
      }
      
      private function onAvatarRendererAvailable(param1:IID, param2:IUnknown) : void
      {
         this.var_1080 = param2 as IAvatarRenderManager;
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!_loc2_)
         {
            if(this.var_1080)
            {
               _loc3_ = this.var_1080.createAvatarImage(param1,AvatarScaleType.const_56,null,this);
               if(_loc3_)
               {
                  _loc2_ = _loc3_.getCroppedImage(AvatarSetType.const_51);
                  _loc3_.dispose();
               }
            }
         }
         return _loc2_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc3_:IItemListWindow = this.var_34.findChildByName(const_451) as IItemListWindow;
         var _loc4_:int = this.var_101.numFriends;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = this.var_101.getFriendAt(_loc5_);
            if(_loc2_.figure == param1)
            {
               _loc6_ = this.getAvatarFaceBitmap(_loc2_.figure);
               if(_loc6_)
               {
                  _loc7_ = _loc3_.getListItemByID(_loc2_.id) as IWindowContainer;
                  if(_loc7_)
                  {
                     _loc8_ = _loc7_.getChildByName(const_451) as IItemListWindow;
                     if(_loc8_)
                     {
                        _loc9_ = IWindowContainer(_loc8_.getListItemByName(const_668));
                        if(_loc9_)
                        {
                           _loc10_ = _loc9_.findChildByName(const_667) as IBitmapWrapperWindow;
                           _loc10_.bitmap = _loc6_;
                           _loc10_.width = _loc6_.width;
                           _loc10_.height = _loc6_.height;
                        }
                     }
                  }
               }
            }
            _loc5_++;
         }
      }
      
      public function faceBookImageReady(param1:BitmapData) : void
      {
      }
      
      private function isFriendSelected(param1:IFriendEntity) : Boolean
      {
         return this.var_893 == param1.id;
      }
      
      public function selectTab(param1:ITab) : void
      {
         if(!param1.selected)
         {
            if(this.var_1371)
            {
               this.deSelect();
            }
            param1.select();
            this.var_1371 = param1;
            if(param1 is FriendEntityTab)
            {
               this.var_893 = FriendEntityTab(param1).friend.id;
            }
         }
      }
      
      public function selectFriendEntity(param1:int) : void
      {
         if(this.var_893 == param1)
         {
            return;
         }
         var _loc2_:FriendEntityTab = this.getFriendEntityTabByID(param1);
         if(_loc2_)
         {
            this.selectTab(_loc2_);
            this.var_893 = param1;
         }
      }
      
      public function deSelect() : void
      {
         if(this.var_1371)
         {
            this.var_1371.deselect();
            this.var_893 = -1;
         }
      }
      
      private function onRefreshView(param1:Event) : void
      {
         if(!this.isUserInterfaceReady())
         {
            this.buildUserInterface();
         }
         this.resizeAndPopulate(true);
      }
      
      private function onFindFriendsNotification(param1:FindFriendsNotificationEvent) : void
      {
         var event:FindFriendsNotificationEvent = param1;
         var title:String = !!event.success ? "${friendbar.find.success.title}" : "${friendbar.find.error.title}";
         var text:String = !!event.success ? "${friendbar.find.success.text}" : "${friendbar.find.error.text}";
         this._windowManager.notify(title,text,function(param1:IAlertDialog, param2:WindowEvent):void
         {
            param1.dispose();
         },HabboAlertDialogFlag.const_527);
      }
      
      private function onFriendRequestUpdate(param1:FriendRequestEvent) : void
      {
         if(this.var_725)
         {
            this.var_725.notify(this.var_101.numFriendRequests > 0);
         }
      }
      
      private function onNewInstantMessage(param1:NewMessageEvent) : void
      {
         if(this.var_495)
         {
            if(param1.notify)
            {
               this.var_495.notify(true);
            }
            else
            {
               this.var_495.enable(true);
            }
         }
      }
      
      private function barWindowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.type == WindowMouseEvent.const_42)
         {
            _loc3_ = this._startIndex;
            _loc4_ = this.var_101.numFriends + (!!this.var_1124 ? 1 : 0);
            switch(param2.name)
            {
               case const_1008:
                  _loc3_ = Math.max(0,this._startIndex - 1);
                  break;
               case const_1007:
                  _loc3_ = Math.max(0,this._startIndex - this.maxNumOfTabsVisible);
                  break;
               case const_1015:
                  _loc3_ = 0;
                  break;
               case const_1012:
                  _loc3_ = Math.max(0,Math.min(_loc4_ - this.maxNumOfTabsVisible,this._startIndex + 1));
                  break;
               case const_1009:
                  _loc3_ = Math.max(0,Math.min(_loc4_ - this.maxNumOfTabsVisible,this._startIndex + this.maxNumOfTabsVisible));
                  break;
               case const_1013:
                  _loc3_ = Math.max(0,_loc4_ - this.maxNumOfTabsVisible);
                  break;
               case const_1335:
                  this.visible = false;
                  break;
               case const_1377:
                  this.deSelect();
            }
            if(_loc3_ != this._startIndex)
            {
               this.deSelect();
               this._startIndex = _loc3_;
               this.resizeAndPopulate(true);
            }
         }
         if(param1.type == WindowEvent.const_543)
         {
            this.deSelect();
         }
      }
      
      private function onIconMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:Icon = param1.window.name == const_1010 ? this.var_725 : this.var_495;
         switch(param1.type)
         {
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
               if(_loc2_ is FriendListIcon)
               {
                  this.var_101.toggleFriendList();
                  _loc2_.notify(false);
               }
               else if(_loc2_ is MessengerIcon)
               {
                  this.var_101.toggleMessenger();
                  _loc2_.notify(false);
               }
               break;
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
               _loc2_.hover(true);
               break;
            case WindowMouseEvent.const_25:
               _loc2_.hover(false);
         }
      }
      
      private function toggleWindowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(this.var_196.visible)
         {
            if(param1.type == WindowMouseEvent.const_42)
            {
               switch(param2.name)
               {
                  case const_1371:
                     this.visible = true;
               }
            }
         }
      }
      
      private function toggleArrowButtons(param1:Boolean) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.var_34.findChildByName(const_1012);
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = this.var_34.findChildByName(const_1009);
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = this.var_34.findChildByName(const_1013);
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = this.var_34.findChildByName(const_1008);
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = this.var_34.findChildByName(const_1007);
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
         _loc2_ = this.var_34.findChildByName(const_1015);
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      private function resizeAndPopulate(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         if(!disposed)
         {
            if(this.var_34)
            {
               this.var_34.width = this.var_34.parent.width - (const_656 + const_1011);
               if(!param1)
               {
                  _loc2_ = this.maxNumOfTabsVisible;
                  if(_loc2_ < this.var_98.length)
                  {
                     param1 = true;
                  }
                  else if(_loc2_ > this.var_98.length)
                  {
                     if(this.var_98.length < const_655)
                     {
                        param1 = true;
                     }
                     else if(this.var_98.length < this.var_101.numFriends + (!!this.var_1124 ? 1 : 0))
                     {
                        param1 = true;
                     }
                     else if(this.numFriendEntityTabsVisible < this.var_101.numFriends)
                     {
                        param1 = true;
                     }
                  }
               }
               if(param1)
               {
                  this.populate();
               }
            }
         }
      }
      
      private function get numFriendEntityTabsVisible() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.var_98.length;
         while(_loc2_-- > 0)
         {
            if(this.var_98[_loc2_] is FriendEntityTab)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function get maxNumOfTabsVisible() : int
      {
         var _loc1_:IWindowContainer = this.var_34.findChildByName(const_77) as IWindowContainer;
         var _loc2_:IWindowContainer = _loc1_.getChildByName("wrapper") as IWindowContainer;
         var _loc3_:IItemListWindow = _loc2_.findChildByName(const_451) as IItemListWindow;
         var _loc4_:int = _loc2_.width - _loc3_.width;
         return (_loc1_.width - _loc4_) / (const_1373 + _loc3_.spacing);
      }
      
      private function onDesktopResized(param1:WindowEvent) : void
      {
         this.resizeAndPopulate(false);
      }
   }
}
