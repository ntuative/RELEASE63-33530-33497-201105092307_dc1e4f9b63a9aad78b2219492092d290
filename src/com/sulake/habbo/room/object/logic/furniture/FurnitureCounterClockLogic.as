package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class FurnitureCounterClockLogic extends FurnitureLogic
   {
       
      
      public function FurnitureCounterClockLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = [RoomObjectStateChangeEvent.const_65];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc5_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc3_:int = object.getId();
         var _loc4_:String = object.getType();
         switch(param1.type)
         {
            case MouseEvent.DOUBLE_CLICK:
               switch(param1.spriteTag)
               {
                  case "start_stop":
                     _loc5_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.const_65,_loc3_,_loc4_,1);
                     break;
                  case "reset":
                     _loc5_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.const_65,_loc3_,_loc4_,2);
               }
               if(eventDispatcher != null && _loc5_ != null)
               {
                  eventDispatcher.dispatchEvent(_loc5_);
                  return;
               }
               break;
         }
         super.mouseEvent(param1,param2);
      }
      
      override public function useObject() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(object != null)
         {
            _loc1_ = object.getId();
            _loc2_ = object.getType();
            _loc3_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.const_65,_loc1_,_loc2_,1);
            if(eventDispatcher != null)
            {
               eventDispatcher.dispatchEvent(_loc3_);
            }
         }
      }
   }
}
