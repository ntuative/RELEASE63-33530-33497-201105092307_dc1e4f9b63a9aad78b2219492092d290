package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer;
   import com.sulake.habbo.friendlist.domain.Friend;
   import flash.ui.Keyboard;
   
   public class RoomInviteView extends AlertView
   {
       
      
      private var _selected:Array;
      
      private var var_939:ITextFieldWindow;
      
      public function RoomInviteView(param1:HabboFriendList)
      {
         super(param1,"room_invite_confirm");
         this._selected = param1.categories.getSelectedFriends();
      }
      
      override public function dispose() : void
      {
         this._selected = null;
         this.var_939 = null;
         super.dispose();
      }
      
      override function setupContent(param1:IWindowContainer) : void
      {
         friendList.registerParameter("friendlist.invite.summary","count","" + this._selected.length);
         this.var_939 = ITextFieldWindow(param1.findChildByName("message_input"));
         this.var_939.addEventListener(WindowKeyboardEvent.const_175,this.onMessageInput);
         param1.findChildByName("cancel").procedure = onClose;
         param1.findChildByName("ok").procedure = this.onInvite;
      }
      
      private function onInvite(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Invite Ok clicked");
         this.sendMsg();
         this.dispose();
      }
      
      private function onMessageInput(param1:WindowKeyboardEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:IWindow = IWindow(param1.target);
         Logger.log("Test key event " + param1 + ", " + param1.type + " " + _loc2_.name);
         if(param1.charCode == Keyboard.ENTER)
         {
            this.sendMsg();
         }
         else
         {
            _loc3_ = 120;
            _loc4_ = this.var_939.text;
            if(_loc4_.length > _loc3_)
            {
               this.var_939.text = _loc4_.substring(0,_loc3_);
            }
         }
      }
      
      private function sendMsg() : void
      {
         var _loc3_:* = null;
         var _loc1_:String = this.var_939.text;
         Logger.log("Send msg: " + _loc1_);
         if(_loc1_ == "")
         {
            new SimpleAlertView(friendList,"${friendlist.invite.emptyalert.title}","${friendlist.invite.emptyalert.text}").show();
            return;
         }
         var _loc2_:SendRoomInviteMessageComposer = new SendRoomInviteMessageComposer(_loc1_);
         for each(_loc3_ in this._selected)
         {
            _loc2_.addInvitedFriend(_loc3_.id);
         }
         friendList.send(_loc2_);
         this.dispose();
      }
   }
}
