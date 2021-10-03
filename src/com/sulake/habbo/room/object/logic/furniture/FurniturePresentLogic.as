package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class FurniturePresentLogic extends FurnitureLogic
   {
       
      
      public function FurniturePresentLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = [RoomObjectWidgetRequestEvent.const_151];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               _loc3_ = object.getId();
               _loc4_ = object.getType();
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.const_258,_loc3_,_loc4_));
               super.mouseEvent(param1,param2);
               break;
            case MouseEvent.ROLL_OUT:
               _loc3_ = object.getId();
               _loc4_ = object.getType();
               eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.const_354,_loc3_,_loc4_));
               super.mouseEvent(param1,param2);
               break;
            case MouseEvent.DOUBLE_CLICK:
               this.useObject();
               break;
            default:
               super.mouseEvent(param1,param2);
         }
      }
      
      override public function useObject() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = object.getId();
            _loc2_ = object.getType();
            _loc3_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.const_151,_loc1_,_loc2_);
            eventDispatcher.dispatchEvent(_loc3_);
         }
      }
   }
}
