package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class IssueListView
   {
      
      private static const const_658:int = 20;
       
      
      private var _issueManager:IssueManager;
      
      private var var_639:IssueBrowser;
      
      private var _list:IItemListWindow;
      
      private var var_1804:String;
      
      private var var_1714:IWindowContainer;
      
      private var var_2964:BitmapData;
      
      private var var_2965:BitmapData;
      
      public function IssueListView(param1:IssueManager, param2:IssueBrowser, param3:IItemListWindow, param4:String)
      {
         super();
         this._issueManager = param1;
         this.var_639 = param2;
         this._list = param3;
         this.var_1804 = param4;
         this.var_1714 = this.var_639.createWindow(param4) as IWindowContainer;
      }
      
      public function update(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         if(this._list == null)
         {
            return;
         }
         if(param1 == null || param1.length == 0)
         {
            this._list.destroyListItems();
            return;
         }
         param1.sortOn("prioritySum",0 | 0);
         var _loc4_:int = this._list.numListItems;
         var _loc5_:int = param1.length;
         if(_loc5_ > const_658)
         {
            _loc5_ = const_658;
         }
         if(_loc4_ < _loc5_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc5_ - _loc4_)
            {
               _loc3_ = this.var_1714.clone() as IWindowContainer;
               this._list.addListItem(_loc3_);
               _loc2_++;
            }
         }
         else if(_loc4_ > _loc5_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc4_ - _loc5_)
            {
               _loc9_ = this._list.removeListItemAt(0);
               _loc9_.dispose();
               _loc2_++;
            }
         }
         _loc2_ = 1;
         var _loc8_:int = getTimer();
         for each(_loc7_ in param1)
         {
            if(_loc2_ > const_658)
            {
               break;
            }
            if(_loc7_ == null || this.var_1714 == null)
            {
               return;
            }
            _loc3_ = this._list.getListItemAt(_loc2_ - 1) as IWindowContainer;
            if(_loc3_ == null)
            {
               return;
            }
            _loc3_.width = this._list.width;
            _loc3_.color = !!(_loc2_++ % 2) ? 4289914618 : uint(4294967295);
            _loc6_ = _loc3_.findChildByName("score");
            if(_loc6_ != null)
            {
               _loc6_.caption = _loc7_.prioritySum.toString();
            }
            _loc10_ = _loc7_.getHighestPriorityIssue();
            if(_loc10_ == null)
            {
               return;
            }
            _loc6_ = _loc3_.findChildByName("category");
            if(_loc6_ != null)
            {
               _loc6_.caption = IssueCategoryNames.getCategoryName(_loc10_.reportedCategoryId);
            }
            _loc6_ = _loc3_.findChildByName("target_name");
            if(_loc6_ != null)
            {
               if(_loc10_.reportedUserId != 0)
               {
                  _loc6_.caption = _loc10_.reportedUserName;
               }
               else
               {
                  _loc6_.caption = _loc10_.roomName;
               }
            }
            _loc11_ = _loc3_.findChildByName("target_icon") as IBitmapWrapperWindow;
            if(_loc11_ != null)
            {
               _loc12_ = !!_loc10_.reportedUserId ? "user_icon_png" : "room_icon_png";
               _loc13_ = this.var_639.assets.getAssetByName(_loc12_) as BitmapDataAsset;
               if(_loc13_ != null && _loc13_.content as BitmapData != null)
               {
                  _loc14_ = _loc13_.content as BitmapData;
                  if(_loc14_ != null)
                  {
                     _loc11_.bitmap = _loc14_.clone();
                  }
               }
            }
            _loc6_ = _loc3_.findChildByName("time");
            if(_loc6_ != null)
            {
               _loc6_.caption = _loc7_.getOpenTime(_loc8_);
            }
            _loc6_ = _loc3_.findChildByName("msgs");
            if(_loc6_ != null)
            {
               _loc6_.caption = _loc7_.getMessageCount().toString();
            }
            _loc6_ = _loc3_.findChildByName("picker");
            if(_loc6_ != null)
            {
               _loc6_.caption = _loc7_.pickerName;
            }
            _loc6_ = _loc3_.findChildByName("pick_button");
            if(_loc6_ != null)
            {
               _loc6_.id = _loc7_.id;
               _loc6_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onPick);
               _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onPick);
            }
            _loc6_ = _loc3_.findChildByName("handle_button");
            if(_loc6_ != null)
            {
               _loc6_.id = _loc7_.id;
               _loc6_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onHandle);
               _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onHandle);
            }
            _loc6_ = _loc3_.findChildByName("release_button");
            if(_loc6_ != null)
            {
               _loc6_.id = _loc7_.id;
               _loc6_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onRelease);
               _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onRelease);
            }
         }
      }
      
      private function onPick(param1:WindowMouseEvent) : void
      {
         if(this._issueManager == null)
         {
            return;
         }
         this._issueManager.pickBundle(param1.window.id);
      }
      
      private function onHandle(param1:WindowMouseEvent) : void
      {
         if(this.var_639 == null)
         {
            return;
         }
         this._issueManager.handleBundle(param1.window.id);
      }
      
      private function onRelease(param1:WindowMouseEvent) : void
      {
         if(this._issueManager == null)
         {
            return;
         }
         this._issueManager.releaseBundle(param1.window.id);
      }
   }
}
