package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class FurniturePushableLogic extends FurnitureMultiStateLogic
   {
      
      private static const const_1049:int = 0;
      
      private static const const_1928:int = 1;
      
      private static const const_1048:int = 10;
       
      
      private var var_1841:Vector3d = null;
      
      public function FurniturePushableLogic()
      {
         super();
         moveUpdateInterval = const_782;
         this.var_1841 = new Vector3d();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:RoomObjectMoveUpdateMessage = param1 as RoomObjectMoveUpdateMessage;
         if(object != null && _loc2_ == null)
         {
            if(param1.loc != null)
            {
               _loc4_ = object.getLocation();
               _loc5_ = Vector3d.dif(param1.loc,_loc4_);
               if(_loc5_ != null)
               {
                  if(Math.abs(_loc5_.x) < 2 && Math.abs(_loc5_.y) < 2)
                  {
                     _loc6_ = _loc4_;
                     if(Math.abs(_loc5_.x) > 1 || Math.abs(_loc5_.y) > 1)
                     {
                        _loc6_ = Vector3d.sum(_loc4_,Vector3d.product(_loc5_,0.5));
                     }
                     _loc2_ = new RoomObjectMoveUpdateMessage(_loc6_,param1.loc,param1.dir);
                     super.processUpdateMessage(_loc2_);
                     return;
                  }
               }
            }
         }
         if(param1.loc != null && _loc2_ == null)
         {
            _loc2_ = new RoomObjectMoveUpdateMessage(param1.loc,param1.loc,param1.dir);
            super.processUpdateMessage(_loc2_);
         }
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            if(_loc3_.state > 0)
            {
               moveUpdateInterval = const_782 / this.getUpdateIntervalValue(_loc3_.state);
            }
            else
            {
               moveUpdateInterval = 1;
            }
            this.handleDataUpdateMessage(_loc3_);
            return;
         }
         if(_loc2_ && _loc2_.isSlideUpdate)
         {
            moveUpdateInterval = const_782;
         }
         super.processUpdateMessage(param1);
      }
      
      protected function getUpdateIntervalValue(param1:int) : int
      {
         return param1 / const_1048;
      }
      
      protected function getAnimationValue(param1:int) : int
      {
         return param1 % const_1048;
      }
      
      private function handleDataUpdateMessage(param1:RoomObjectDataUpdateMessage) : void
      {
         var _loc2_:int = this.getAnimationValue(param1.state);
         if(_loc2_ != param1.state)
         {
            param1 = new RoomObjectDataUpdateMessage(_loc2_,String(_loc2_),param1.extra);
         }
         super.processUpdateMessage(param1);
      }
      
      override public function update(param1:int) : void
      {
         if(object != null)
         {
            this.var_1841.assign(object.getLocation());
            super.update(param1);
            if(Vector3d.dif(object.getLocation(),this.var_1841).length == 0)
            {
               if(object.getState(0) != const_1049)
               {
                  object.setState(const_1049,0);
               }
            }
         }
      }
   }
}
