package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class FurnitureTeaserLogic extends FurnitureLogic
   {
       
      
      private const const_2168:String = "TYPE_INJECTED";
      
      public function FurnitureTeaserLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = [RoomObjectWidgetRequestEvent.const_154,RoomObjectFurnitureActionEvent.const_623];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         if(param1.type != MouseEvent.CLICK && param1.type != MouseEvent.DOUBLE_CLICK && param1.type != MouseEvent.MOUSE_DOWN && param1.type != MouseEvent.MOUSE_UP)
         {
            return;
         }
         var _loc3_:IRoomObjectModelController = object.getModelController();
         var _loc4_:String = _loc3_.getString(RoomObjectVariableEnum.const_94);
         var _loc5_:String = _loc4_;
         if(_loc4_)
         {
            if(_loc4_.indexOf("+") > -1)
            {
               _loc5_ = _loc4_.substring(0,_loc4_.indexOf("+"));
            }
         }
         if(_loc5_ == this.const_2168)
         {
            if(param1.type == MouseEvent.MOUSE_UP)
            {
               if(eventDispatcher != null)
               {
                  _loc7_ = object.getId();
                  _loc8_ = object.getType();
                  _loc9_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.const_154,_loc7_,_loc8_);
                  eventDispatcher.dispatchEvent(_loc9_);
                  object.setVisualization(null);
               }
            }
            else
            {
               super.mouseEvent(param1,param2);
            }
         }
         else if(param1.type == MouseEvent.DOUBLE_CLICK)
         {
            this.useObject();
         }
         else if(param1.type == MouseEvent.MOUSE_DOWN || param1.type == MouseEvent.CLICK)
         {
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
            _loc3_ = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.const_623,_loc1_,_loc2_);
            eventDispatcher.dispatchEvent(_loc3_);
         }
      }
   }
}
