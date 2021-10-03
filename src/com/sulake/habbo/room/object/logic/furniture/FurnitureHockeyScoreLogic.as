package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class FurnitureHockeyScoreLogic extends FurnitureLogic
   {
       
      
      public function FurnitureHockeyScoreLogic()
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
                  case "off":
                     _loc5_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.const_65,_loc3_,_loc4_,3);
               }
               break;
            case MouseEvent.CLICK:
               switch(param1.spriteTag)
               {
                  case "inc":
                     _loc5_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.const_65,_loc3_,_loc4_,2);
                     break;
                  case "dec":
                     _loc5_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.const_65,_loc3_,_loc4_,1);
               }
         }
         if(eventDispatcher != null && _loc5_ != null)
         {
            eventDispatcher.dispatchEvent(_loc5_);
         }
         else
         {
            super.mouseEvent(param1,param2);
         }
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
            _loc3_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.const_65,_loc1_,_loc2_,3);
            if(eventDispatcher != null)
            {
               eventDispatcher.dispatchEvent(_loc3_);
            }
         }
      }
   }
}
