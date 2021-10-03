package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class FurnitureClothingChangeLogic extends FurnitureLogic
   {
       
      
      public function FurnitureClothingChangeLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = [RoomObjectWidgetRequestEvent.const_157];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(object == null || object.getModel() == null)
         {
            return;
         }
         var _loc2_:String = object.getModel().getString(RoomObjectVariableEnum.const_94);
         this.updateClothingData(_loc2_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null)
         {
            this.updateClothingData(_loc2_.data);
         }
      }
      
      private function updateClothingData(param1:String) : void
      {
         var _loc2_:* = null;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = param1.split(",");
            if(_loc2_.length > 0)
            {
               object.getModelController().setString(RoomObjectVariableEnum.const_1247,_loc2_[0]);
            }
            if(_loc2_.length > 1)
            {
               object.getModelController().setString(RoomObjectVariableEnum.const_1197,_loc2_[1]);
            }
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
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
            _loc3_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.const_157,_loc1_,_loc2_);
            eventDispatcher.dispatchEvent(_loc3_);
         }
      }
   }
}
