package com.sulake.habbo.ui
{
   import com.sulake.habbo.friendlist.events.FriendRequestEvent;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
   import com.sulake.habbo.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetFriendRequestUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetFriendRequestMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetGetUserLocationMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FriendRequestWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FriendRequestWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_424;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetGetUserLocationMessage.const_804);
         _loc1_.push(RoomWidgetFriendRequestMessage.const_961);
         _loc1_.push(RoomWidgetFriendRequestMessage.const_788);
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(!param1 || !this._container)
         {
            return null;
         }
         switch(param1.type)
         {
            case RoomWidgetGetUserLocationMessage.const_804:
               _loc2_ = param1 as RoomWidgetGetUserLocationMessage;
               if(!_loc2_)
               {
                  return null;
               }
               _loc3_ = this._container.roomSession;
               if(!_loc3_ || !_loc3_.userDataManager)
               {
                  return null;
               }
               _loc4_ = _loc3_.userDataManager.getUserDataByType(_loc2_.userId,_loc2_.userType);
               if(_loc4_)
               {
                  _loc5_ = this._container.roomEngine.getRoomObjectBoundingRectangle(_loc3_.roomId,_loc3_.roomCategory,_loc4_.id,RoomObjectCategoryEnum.const_33,this._container.getFirstCanvasId());
                  _loc6_ = this._container.roomEngine.getRoomObjectScreenLocation(_loc3_.roomId,_loc3_.roomCategory,_loc4_.id,RoomObjectCategoryEnum.const_33,this._container.getFirstCanvasId());
                  _loc9_ = this._container.getRoomViewRect();
                  if(_loc5_ && _loc9_ && _loc6_)
                  {
                     _loc5_.offset(_loc9_.x,_loc9_.y);
                     _loc6_.offset(_loc9_.x,_loc9_.y);
                  }
               }
               return new RoomWidgetUserLocationUpdateEvent(_loc2_.userId,_loc5_,_loc6_);
               break;
            case RoomWidgetFriendRequestMessage.const_961:
               _loc7_ = param1 as RoomWidgetFriendRequestMessage;
               if(!_loc7_ || !this._container.friendList)
               {
                  return null;
               }
               this._container.friendList.acceptFriendRequest(_loc7_.requestId);
               break;
            case RoomWidgetFriendRequestMessage.const_788:
               _loc8_ = param1 as RoomWidgetFriendRequestMessage;
               if(!_loc8_ || !this._container.friendList)
               {
                  return null;
               }
               this._container.friendList.declineFriendRequest(_loc8_.requestId);
               break;
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomSessionFriendRequestEvent.const_139);
         _loc1_.push(FriendRequestEvent.const_61);
         _loc1_.push(FriendRequestEvent.const_317);
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(this._container == null || this._container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomSessionFriendRequestEvent.const_139:
               _loc4_ = param1 as RoomSessionFriendRequestEvent;
               if(!_loc4_)
               {
                  return;
               }
               _loc3_ = "null";
               _loc2_ = new RoomWidgetFriendRequestUpdateEvent(_loc3_,_loc4_.requestId,_loc4_.userId,_loc4_.userName);
               break;
            case FriendRequestEvent.const_61:
            case FriendRequestEvent.const_317:
               _loc5_ = param1 as FriendRequestEvent;
               if(!_loc5_)
               {
                  return;
               }
               _loc3_ = "null";
               _loc2_ = new RoomWidgetFriendRequestUpdateEvent(_loc3_,_loc5_.requestId);
               break;
         }
         if(_loc2_)
         {
            this._container.events.dispatchEvent(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
   }
}
