package com.sulake.habbo.ui
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageParser;
   import com.sulake.habbo.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetSpamWallPostItEditEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
   import flash.events.Event;
   
   public class SpamWallPostItWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var _connection:IConnection = null;
      
      private var var_1914:IMessageEvent;
      
      public function SpamWallPostItWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_482;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
      }
      
      public function set connection(param1:IConnection) : void
      {
         this.var_1914 = new RequestSpamWallPostItMessageEvent(this.onSpamWallPostItRequest);
         this._connection = param1;
         this._connection.addMessageEvent(this.var_1914);
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this._disposed = true;
            this._connection.removeMessageEvent(this.var_1914);
            this._connection = null;
         }
      }
      
      private function onSpamWallPostItRequest(param1:RequestSpamWallPostItMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:RequestSpamWallPostItMessageParser = param1.getParser();
         var _loc3_:int = _loc2_.itemId;
         var _loc4_:String = _loc2_.location;
         if(this._container != null)
         {
            if(this._container.events != null)
            {
               this._container.events.dispatchEvent(new RoomWidgetSpamWallPostItEditEvent(RoomWidgetSpamWallPostItEditEvent.const_598,_loc3_,_loc4_));
            }
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetSpamWallPostItEditEvent.const_598,RoomWidgetSpamWallPostItFinishEditingMessage.const_945];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         switch(param1.type)
         {
            case RoomWidgetSpamWallPostItFinishEditingMessage.const_945:
               _loc2_ = param1 as RoomWidgetSpamWallPostItFinishEditingMessage;
               if(_loc2_ != null)
               {
                  if(this._connection != null)
                  {
                     _loc3_ = new AddSpamWallPostItMessageComposer(_loc2_.objectId,_loc2_.location,_loc2_.colorHex + " " + _loc2_.text);
                     this._connection.send(_loc3_);
                  }
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}
