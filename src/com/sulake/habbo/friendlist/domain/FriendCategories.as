package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
   import com.sulake.habbo.friendlist.Util;
   import flash.utils.Dictionary;
   
   public class FriendCategories
   {
       
      
      private var var_409:IFriendCategoriesDeps;
      
      private var var_100:Array;
      
      private var _friendsById:Dictionary;
      
      public function FriendCategories(param1:IFriendCategoriesDeps)
      {
         this.var_100 = new Array();
         this._friendsById = new Dictionary();
         super();
         this.var_409 = param1;
      }
      
      public function addFriend(param1:Friend) : FriendCategory
      {
         var _loc2_:int = !!param1.online ? int(param1.categoryId) : int(FriendCategory.const_402);
         var _loc3_:FriendCategory = this.findCategory(_loc2_);
         if(_loc3_ != null)
         {
            _loc3_.addFriend(param1);
            this._friendsById[param1.id] = param1;
            return _loc3_;
         }
         Logger.log("No category " + _loc2_ + " found for friend " + param1.id + ". Ignoring");
         return null;
      }
      
      public function getSelectedFriends() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.var_100)
         {
            _loc2_.getSelectedFriends(_loc1_);
         }
         return _loc1_;
      }
      
      public function getSelectedFriend() : Friend
      {
         var _loc1_:Array = this.getSelectedFriends();
         return _loc1_.length == 1 ? _loc1_[0] : null;
      }
      
      public function getAllFriends() : Dictionary
      {
         return this._friendsById;
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean = false) : int
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         for each(_loc4_ in this.var_100)
         {
            _loc3_ += _loc4_.getFriendCount(param1,param2);
         }
         return _loc3_;
      }
      
      public function getCategories() : Array
      {
         return this.var_100;
      }
      
      public function addCategory(param1:FriendCategory) : void
      {
         this.var_100.push(param1);
      }
      
      public function findFriend(param1:int) : Friend
      {
         return this._friendsById[param1];
      }
      
      public function findCategory(param1:int) : FriendCategory
      {
         var _loc2_:* = null;
         for each(_loc2_ in this.var_100)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var status:int = 0;
         var p:FriendListUpdateMessageParser = null;
         var removedFriendId:int = 0;
         var updatedFriend:FriendData = null;
         var addedFriend:FriendData = null;
         var currentlyOnline:Boolean = false;
         var wasSelected:Boolean = false;
         var friend:Friend = null;
         var event:IMessageEvent = param1;
         Logger.log("Received friend list update");
         status = 0;
         try
         {
            p = (event as FriendListUpdateEvent).getParser();
            status = 1;
            this.updateCategories(p.cats);
            status = 2;
            for each(removedFriendId in p.removedFriendIds)
            {
               this.removeFriend(removedFriendId,true);
            }
            status = 3;
            for each(updatedFriend in p.updatedFriends)
            {
               Logger.log("Got UPDATE: " + updatedFriend.id + ", " + updatedFriend.online + ", " + updatedFriend.name + ", " + updatedFriend.followingAllowed);
               this.var_409.messenger.setFollowingAllowed(updatedFriend.id,updatedFriend.followingAllowed && updatedFriend.online);
               currentlyOnline = this.isFriendOnline(updatedFriend.id);
               if(currentlyOnline && !updatedFriend.online)
               {
                  this.var_409.messenger.setOnlineStatus(updatedFriend.id,updatedFriend.online);
                  this.var_409.notifications.addOfflineNotification(updatedFriend.name,updatedFriend.realName);
               }
               if(!currentlyOnline && updatedFriend.online)
               {
                  this.var_409.messenger.setOnlineStatus(updatedFriend.id,updatedFriend.online);
                  this.var_409.view.setNewMessageArrived();
                  this.var_409.notifications.addOnlineNotification(updatedFriend.name,updatedFriend.figure,updatedFriend.realName);
               }
               wasSelected = this.removeFriend(updatedFriend.id,true);
               friend = new Friend(updatedFriend);
               friend.selected = wasSelected;
               this.addFriend(friend);
            }
            status = 4;
            for each(addedFriend in p.addedFriends)
            {
               Logger.log("Got INSERT: " + addedFriend.id + ", " + addedFriend.name);
               this.removeFriend(addedFriend.id,true);
               this.addFriend(new Friend(addedFriend));
            }
            status = 5;
            this.var_409.view.refreshList();
            status = 6;
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("FriendCategories","onFriendListUpdate crashed, status = " + String(status) + "!");
            throw e;
         }
      }
      
      private function updateCategories(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         this.flushReceivedStatus();
         this.findCategory(FriendCategory.const_402).received = true;
         this.findCategory(FriendCategory.const_1320).received = true;
         for each(_loc2_ in param1)
         {
            _loc4_ = this.findCategory(_loc2_.id);
            if(_loc4_ != null)
            {
               _loc4_.received = true;
               if(_loc4_.name != _loc2_.name)
               {
                  _loc4_.name = _loc2_.name;
               }
            }
            else
            {
               _loc5_ = new FriendCategory(_loc2_.id,_loc2_.name);
               _loc5_.received = true;
               this.addCategory(_loc5_);
            }
         }
         for each(_loc3_ in this.getCategoriesNotReceived())
         {
            if(_loc3_.friends.length <= 0)
            {
               Util.remove(this.var_100,_loc3_);
               _loc3_.dispose();
            }
         }
      }
      
      private function removeFriend(param1:int, param2:Boolean) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param2)
         {
            this._friendsById[param1] = null;
         }
         var _loc3_:Boolean = false;
         for each(_loc4_ in this.var_100)
         {
            _loc5_ = _loc4_.removeFriend(param1);
            if(_loc5_ != null)
            {
               _loc3_ = _loc5_.selected;
               if(param2)
               {
                  _loc5_.dispose();
               }
            }
         }
         return _loc3_;
      }
      
      private function flushReceivedStatus() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in this.var_100)
         {
            _loc1_.received = false;
         }
      }
      
      private function getCategoriesNotReceived() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.var_100)
         {
            if(!_loc2_.received)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function isFriendOnline(param1:int) : Boolean
      {
         var _loc2_:Friend = this.findFriend(param1);
         return _loc2_ == null ? false : Boolean(_loc2_.online);
      }
      
      public function getFriendNames() : Array
      {
         var _loc2_:* = null;
         if(this._friendsById == null)
         {
            return [];
         }
         var _loc1_:* = [];
         for each(_loc2_ in this._friendsById)
         {
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_.name);
            }
         }
         return _loc1_;
      }
   }
}
