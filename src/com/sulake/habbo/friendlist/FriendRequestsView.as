package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.AcceptBuddyMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.DeclineBuddyMessageComposer;
   import com.sulake.habbo.friendlist.domain.FriendListTab;
   import com.sulake.habbo.friendlist.domain.FriendRequest;
   import com.sulake.habbo.friendlist.events.FriendRequestEvent;
   
   public class FriendRequestsView implements ITabView, IFriendRequestsView
   {
      
      private static const const_1922:String = "no_reqs_info";
       
      
      private var _friendList:HabboFriendList;
      
      private var _list:IItemListWindow;
      
      private var var_1780:IContainerButtonWindow;
      
      private var var_1779:IContainerButtonWindow;
      
      public function FriendRequestsView()
      {
         super();
      }
      
      public function init(param1:HabboFriendList) : void
      {
         this._friendList = param1;
      }
      
      public function getEntryCount() : int
      {
         return this._friendList.friendRequests.getCountOfOpenRequests();
      }
      
      public function fillFooter(param1:IWindowContainer) : void
      {
         this.var_1780 = IContainerButtonWindow(param1.findChildByName("accept_all_but"));
         this.var_1779 = IContainerButtonWindow(param1.findChildByName("reject_all_but"));
         this.var_1779.procedure = this.onDismissAllButtonClick;
         this.var_1780.procedure = this.onAcceptAllButtonClick;
         this.refreshButtons();
      }
      
      public function fillList(param1:IItemListWindow) : void
      {
         var _loc2_:* = null;
         this._list = param1;
         for each(_loc2_ in this._friendList.friendRequests.requests)
         {
            this.getRequestEntry(_loc2_);
            this.refreshRequestEntry(_loc2_);
            param1.addListItem(_loc2_.view);
         }
         this._friendList.friendRequests.refreshShading();
      }
      
      public function tabClicked(param1:int) : void
      {
         if(this._list == null)
         {
            return;
         }
         this._friendList.friendRequests.clearAndUpdateView(true);
      }
      
      public function refreshShading(param1:FriendRequest, param2:Boolean) : void
      {
         if(this._list == null)
         {
            return;
         }
         param1.view.color = this._friendList.laf.getRowShadingColor(FriendListTab.const_93,param2);
         this.setButtonBg(param1.view,"reject");
         this.setButtonBg(param1.view,"accept");
      }
      
      public function refreshRequestEntry(param1:FriendRequest) : void
      {
         if(this._list == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = param1.view;
         Util.hideChildren(_loc2_);
         this._friendList.refreshText(_loc2_,"requester_name_text",true,param1.requesterName);
         if(param1.state == FriendRequest.const_173)
         {
            this._friendList.refreshIcon(_loc2_,"accept",true,this.onAcceptButtonClick,param1.requestId);
            this._friendList.refreshIcon(_loc2_,"reject",true,this.onDeclineButtonClick,param1.requestId);
         }
         else if(param1.state == FriendRequest.const_412)
         {
            this._friendList.refreshText(_loc2_,"info_text",true,"${friendlist.request.accepted}");
         }
         else if(param1.state == FriendRequest.const_407)
         {
            this._friendList.refreshText(_loc2_,"info_text",true,"${friendlist.request.declined}");
         }
         else if(param1.state == FriendRequest.const_1306)
         {
            this._friendList.refreshText(_loc2_,"info_text",true,"${friendlist.request.failed}");
         }
      }
      
      private function setButtonBg(param1:IWindowContainer, param2:String) : void
      {
         var _loc3_:IWindow = param1.findChildByName(param2);
         if(_loc3_ != null)
         {
            _loc3_.color = param1.color;
         }
      }
      
      public function addRequest(param1:FriendRequest) : void
      {
         if(this._list == null)
         {
            return;
         }
         this.getRequestEntry(param1);
         this.refreshRequestEntry(param1);
         this._list.addListItem(param1.view);
         this._friendList.friendRequests.refreshShading();
         this.refreshButtons();
      }
      
      public function removeRequest(param1:FriendRequest) : void
      {
         if(this._list == null)
         {
            return;
         }
         this._list.removeListItem(param1.view);
         this.refreshButtons();
      }
      
      private function getRequestEntry(param1:FriendRequest) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow("friend_request_entry"));
         param1.view = _loc2_;
      }
      
      private function onAcceptButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         this._friendList.view.showInfo(param1,"${friendlist.tip.accept}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("accept clicked: " + _loc3_);
         this.acceptRequest(_loc3_);
      }
      
      public function acceptRequest(param1:int) : void
      {
         var _loc2_:FriendRequest = this._friendList.friendRequests.getRequest(param1);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.state = FriendRequest.const_412;
         if(this._friendList.categories.getFriendCount(false) >= this._friendList.friendRequests.limit)
         {
            this._friendList.showLimitReachedAlert();
            return;
         }
         var _loc3_:AcceptBuddyMessageComposer = new AcceptBuddyMessageComposer();
         _loc3_.addAcceptedRequest(_loc2_.requestId);
         this._friendList.send(_loc3_);
         this.refreshRequestEntry(_loc2_);
         this.refresh();
         if(this._friendList && this._friendList.events)
         {
            this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.const_61,param1));
         }
      }
      
      private function onDeclineButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         this._friendList.view.showInfo(param1,"${friendlist.tip.decline}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("decline clicked: " + _loc3_);
         this.declineRequest(_loc3_);
      }
      
      public function declineRequest(param1:int) : void
      {
         var _loc2_:FriendRequest = this._friendList.friendRequests.getRequest(param1);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.state = FriendRequest.const_407;
         var _loc3_:DeclineBuddyMessageComposer = new DeclineBuddyMessageComposer();
         _loc3_.addDeclinedRequest(param1);
         this._friendList.send(_loc3_);
         this.refreshRequestEntry(_loc2_);
         this.refresh();
         if(this._friendList && this._friendList.events)
         {
            this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.const_317,param1));
         }
      }
      
      private function onDismissAllButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         this._friendList.view.showInfo(param1,"${friendlist.tip.declineall}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Dismiss all clicked");
         var _loc3_:DeclineBuddyMessageComposer = new DeclineBuddyMessageComposer();
         this._friendList.send(_loc3_);
         for each(_loc4_ in this._friendList.friendRequests.requests)
         {
            if(_loc4_.state != FriendRequest.const_412 && _loc4_.state != FriendRequest.const_407)
            {
               _loc4_.state = FriendRequest.const_407;
               this.refreshRequestEntry(_loc4_);
               if(this._friendList && this._friendList.events)
               {
                  this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.const_317,_loc4_.requestId));
               }
            }
         }
         this.refresh();
      }
      
      private function onAcceptAllButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         this._friendList.view.showInfo(param1,"${friendlist.tip.acceptall}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Accept all clicked");
         if(this._friendList.categories.getFriendCount(false) + this._friendList.friendRequests.requests.length > this._friendList.friendRequests.limit)
         {
            this._friendList.showLimitReachedAlert();
            return;
         }
         var _loc3_:AcceptBuddyMessageComposer = new AcceptBuddyMessageComposer();
         for each(_loc4_ in this._friendList.friendRequests.requests)
         {
            if(_loc4_.state != FriendRequest.const_412 && _loc4_.state != FriendRequest.const_407)
            {
               _loc3_.addAcceptedRequest(_loc4_.requestId);
               _loc4_.state = FriendRequest.const_412;
               this.refreshRequestEntry(_loc4_);
               if(this._friendList && this._friendList.events)
               {
                  this._friendList.events.dispatchEvent(new FriendRequestEvent(FriendRequestEvent.const_61,_loc4_.requestId));
               }
            }
         }
         this._friendList.send(_loc3_);
         this.refresh();
      }
      
      private function refresh() : void
      {
         this.refreshButtons();
         this._friendList.refreshToolBarIcon();
      }
      
      private function refreshButtons() : void
      {
         var _loc1_:* = this._friendList.friendRequests.getCountOfOpenRequests() > 0;
         this.setEnabled(this.var_1780,_loc1_);
         this.setEnabled(this.var_1779,_loc1_);
      }
      
      private function setEnabled(param1:IContainerButtonWindow, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
   }
}
