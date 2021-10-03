package com.sulake.habbo.ui
{
   import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;
   import com.sulake.habbo.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserNotificationEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetGetUserNotificationMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class UserNotificationWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function UserNotificationWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this._container = null;
            this._disposed = true;
         }
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_128;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
         this._container.roomSession.sendGetUserNotifications();
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetGetUserNotificationMessage.const_1118);
         return _loc1_;
      }
      
      public function getProcessedEvents() : Array
      {
         return [RoomSessionUserNotificationEvent.const_128];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:* = param1.type;
         switch(0)
         {
         }
         Logger.log(param1.type);
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         switch(param1.type)
         {
            case RoomSessionUserNotificationEvent.const_128:
               _loc2_ = param1 as RoomSessionUserNotificationEvent;
               _loc3_ = new RoomWidgetUserNotificationEvent(RoomWidgetUserNotificationEvent.const_639);
               _loc3_.title = _loc2_.title;
               _loc3_.message = _loc2_.message;
               _loc3_.parameters = _loc2_.parameters;
               this._container.events.dispatchEvent(_loc3_);
         }
      }
      
      public function update() : void
      {
      }
   }
}
