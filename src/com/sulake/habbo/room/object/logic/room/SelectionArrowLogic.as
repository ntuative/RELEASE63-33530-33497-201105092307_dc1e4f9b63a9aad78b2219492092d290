package com.sulake.habbo.room.object.logic.room
{
   import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.object.logic.ObjectLogicBase;
   
   public class SelectionArrowLogic extends ObjectLogicBase
   {
       
      
      public function SelectionArrowLogic()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc2_:* = null;
         if(object != null)
         {
            _loc2_ = object.getModelController();
            if(_loc2_ != null)
            {
               _loc2_.setNumber(RoomObjectVariableEnum.const_363,1);
               object.setState(1,0);
            }
         }
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectVisibilityUpdateMessage = param1 as RoomObjectVisibilityUpdateMessage;
         if(_loc2_ != null)
         {
            if(_loc2_.type == RoomObjectVisibilityUpdateMessage.const_504)
            {
               if(object != null)
               {
                  object.setState(0,0);
               }
            }
            else if(_loc2_.type == RoomObjectVisibilityUpdateMessage.const_609)
            {
               if(object != null)
               {
                  object.setState(1,0);
               }
            }
         }
      }
   }
}
