package com.sulake.room.object.logic
{
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.IEventDispatcher;
   
   public class ObjectLogicBase implements IRoomObjectEventHandler
   {
       
      
      private var _events:IEventDispatcher;
      
      private var var_366:IRoomObjectController;
      
      public function ObjectLogicBase()
      {
         super();
      }
      
      public function get eventDispatcher() : IEventDispatcher
      {
         return this._events;
      }
      
      public function set eventDispatcher(param1:IEventDispatcher) : void
      {
         this._events = param1;
      }
      
      public function getEventTypes() : Array
      {
         return [];
      }
      
      protected function getAllEventTypes(param1:Array, param2:Array) : Array
      {
         var _loc4_:* = null;
         var _loc3_:Array = param1.concat();
         for each(_loc4_ in param2)
         {
            if(_loc3_.indexOf(_loc4_) < 0)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         this.var_366 = null;
      }
      
      public function set object(param1:IRoomObjectController) : void
      {
         if(this.var_366 == param1)
         {
            return;
         }
         if(this.var_366 != null)
         {
            this.var_366.setEventHandler(null);
         }
         if(param1 == null)
         {
            this.dispose();
            this.var_366 = null;
         }
         else
         {
            this.var_366 = param1;
            this.var_366.setEventHandler(this);
         }
      }
      
      public function get object() : IRoomObjectController
      {
         return this.var_366;
      }
      
      public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
      }
      
      public function initialize(param1:XML) : void
      {
      }
      
      public function update(param1:int) : void
      {
      }
      
      public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 != null)
         {
            if(this.var_366 != null)
            {
               this.var_366.setLocation(param1.loc);
               this.var_366.setDirection(param1.dir);
            }
         }
      }
      
      public function useObject() : void
      {
      }
   }
}
