package com.sulake.habbo.room.object.logic.room
{
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
   import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.RoomPlaneBitmapMaskData;
   import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
   import com.sulake.habbo.room.object.RoomPlaneData;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.object.logic.ObjectLogicBase;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class RoomLogic extends ObjectLogicBase
   {
       
      
      protected var _planeParser:RoomPlaneParser = null;
      
      private var var_542:RoomPlaneBitmapMaskParser = null;
      
      private var _color:uint = 16777215;
      
      private var var_1620:int = 255;
      
      private var var_1338:uint = 16777215;
      
      private var var_1617:int = 255;
      
      private var var_1079:uint = 16777215;
      
      private var var_1619:int = 255;
      
      private var var_1078:int = 0;
      
      private var var_1618:int = 1500;
      
      public function RoomLogic()
      {
         super();
         this._planeParser = new RoomPlaneParser();
         this.var_542 = new RoomPlaneBitmapMaskParser();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = [RoomObjectMouseEvent.const_480,RoomObjectMouseEvent.const_156];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this._planeParser != null)
         {
            this._planeParser.dispose();
            this._planeParser = null;
         }
         if(this.var_542 != null)
         {
            this.var_542.dispose();
            this.var_542 = null;
         }
      }
      
      override public function initialize(param1:XML) : void
      {
         if(param1 == null || object == null)
         {
            return;
         }
         if(!this._planeParser.initializeFromXML(param1))
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc2_ != null)
         {
            _loc2_.setString(RoomObjectVariableEnum.const_1130,param1.toString(),true);
            _loc2_.setNumber(RoomObjectVariableEnum.const_746,16777215);
            _loc2_.setNumber(RoomObjectVariableEnum.const_688,1);
            _loc2_.setNumber(RoomObjectVariableEnum.const_949,1);
            _loc2_.setNumber(RoomObjectVariableEnum.const_978,1);
         }
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         this.updateBackgroundColor(param1);
      }
      
      private function updateBackgroundColor(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:Number = NaN;
         if(object == null)
         {
            return;
         }
         if(this.var_1078)
         {
            _loc2_ = param1;
            _loc3_ = this._color;
            _loc4_ = this.var_1620;
            if(_loc2_ - this.var_1078 >= this.var_1618)
            {
               _loc3_ = this.var_1079;
               _loc4_ = this.var_1619;
               this.var_1078 = 0;
            }
            else
            {
               _loc7_ = this.var_1338 >> 16 & 255;
               _loc8_ = this.var_1338 >> 8 & 255;
               _loc9_ = this.var_1338 & 255;
               _loc10_ = this.var_1079 >> 16 & 255;
               _loc11_ = this.var_1079 >> 8 & 255;
               _loc12_ = this.var_1079 & 255;
               _loc13_ = (_loc2_ - this.var_1078) / this.var_1618;
               _loc7_ += (_loc10_ - _loc7_) * _loc13_;
               _loc8_ += (_loc11_ - _loc8_) * _loc13_;
               _loc9_ += (_loc12_ - _loc9_) * _loc13_;
               _loc3_ = (_loc7_ << 16) + (_loc8_ << 8) + _loc9_;
               _loc4_ = this.var_1617 + (this.var_1619 - this.var_1617) * _loc13_;
               this._color = _loc3_;
               this.var_1620 = _loc4_;
            }
            _loc5_ = ColorConverter.rgbToHSL(_loc3_);
            _loc5_ = (_loc5_ & 16776960) + _loc4_;
            _loc3_ = ColorConverter.hslToRGB(_loc5_);
            _loc6_ = object.getModel() as IRoomObjectModelController;
            if(_loc6_ == null)
            {
               return;
            }
            _loc6_.setNumber(RoomObjectVariableEnum.const_746,_loc3_);
         }
      }
      
      private function updatePlaneTypes(param1:RoomObjectRoomUpdateMessage, param2:IRoomObjectModelController) : void
      {
         switch(param1.type)
         {
            case RoomObjectRoomUpdateMessage.const_692:
               param2.setString(RoomObjectVariableEnum.const_193,param1.value);
               break;
            case RoomObjectRoomUpdateMessage.const_869:
               param2.setString(RoomObjectVariableEnum.const_209,param1.value);
               break;
            case RoomObjectRoomUpdateMessage.const_713:
               param2.setString(RoomObjectVariableEnum.const_219,param1.value);
         }
      }
      
      private function updatePlaneMasks(param1:RoomObjectRoomMaskUpdateMessage, param2:IRoomObjectModelController) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:Boolean = false;
         switch(param1.type)
         {
            case RoomObjectRoomMaskUpdateMessage.const_611:
               _loc5_ = "null";
               if(param1.maskCategory == RoomObjectRoomMaskUpdateMessage.const_263)
               {
                  _loc5_ = "null";
               }
               this.var_542.addMask(param1.maskId,param1.maskType,param1.maskLocation,_loc5_);
               _loc4_ = true;
               break;
            case RoomObjectRoomMaskUpdateMessage.const_975:
               _loc4_ = this.var_542.removeMask(param1.maskId);
         }
         if(_loc4_)
         {
            _loc6_ = this.var_542.getXML();
            _loc7_ = _loc6_.toXMLString();
            param2.setString(RoomObjectVariableEnum.const_1293,_loc7_);
         }
      }
      
      private function updatePlaneVisibilities(param1:RoomObjectRoomPlaneVisibilityUpdateMessage, param2:IRoomObjectModelController) : void
      {
         var _loc3_:int = 0;
         if(param1.visible)
         {
            _loc3_ = 1;
         }
         switch(param1.type)
         {
            case RoomObjectRoomPlaneVisibilityUpdateMessage.const_1180:
               param2.setNumber(RoomObjectVariableEnum.const_688,_loc3_);
               break;
            case RoomObjectRoomPlaneVisibilityUpdateMessage.const_1112:
               param2.setNumber(RoomObjectVariableEnum.const_949,_loc3_);
               param2.setNumber(RoomObjectVariableEnum.const_978,_loc3_);
         }
      }
      
      private function updatePlaneProperties(param1:RoomObjectRoomPlanePropertyUpdateMessage, param2:IRoomObjectModelController) : void
      {
         switch(param1.type)
         {
            case RoomObjectRoomPlanePropertyUpdateMessage.const_1075:
               param2.setNumber(RoomObjectVariableEnum.const_1158,param1.value);
               break;
            case RoomObjectRoomPlanePropertyUpdateMessage.const_1100:
               param2.setNumber(RoomObjectVariableEnum.const_1243,param1.value);
         }
      }
      
      private function updateColors(param1:RoomObjectRoomColorUpdateMessage, param2:IRoomObjectModelController) : void
      {
         var _loc3_:int = param1.color;
         var _loc4_:int = param1.light;
         param2.setNumber(RoomObjectVariableEnum.const_1246,int(param1.bgOnly));
         this.var_1338 = this._color;
         this.var_1617 = this.var_1620;
         this.var_1079 = _loc3_;
         this.var_1619 = _loc4_;
         this.var_1078 = getTimer();
         this.var_1618 = 1500;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:RoomObjectRoomUpdateMessage = param1 as RoomObjectRoomUpdateMessage;
         if(_loc3_ != null)
         {
            this.updatePlaneTypes(_loc3_,_loc2_);
            return;
         }
         var _loc4_:RoomObjectRoomMaskUpdateMessage = param1 as RoomObjectRoomMaskUpdateMessage;
         if(_loc4_ != null)
         {
            this.updatePlaneMasks(_loc4_,_loc2_);
            return;
         }
         var _loc5_:RoomObjectRoomPlaneVisibilityUpdateMessage = param1 as RoomObjectRoomPlaneVisibilityUpdateMessage;
         if(_loc5_ != null)
         {
            this.updatePlaneVisibilities(_loc5_,_loc2_);
            return;
         }
         var _loc6_:RoomObjectRoomPlanePropertyUpdateMessage = param1 as RoomObjectRoomPlanePropertyUpdateMessage;
         if(_loc6_ != null)
         {
            this.updatePlaneProperties(_loc6_,_loc2_);
            return;
         }
         var _loc7_:RoomObjectRoomColorUpdateMessage = param1 as RoomObjectRoomColorUpdateMessage;
         if(_loc7_ != null)
         {
            this.updateColors(_loc7_,_loc2_);
            return;
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc25_:* = null;
         var _loc26_:* = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:RoomSpriteMouseEvent = param1;
         if(_loc3_ == null)
         {
            return;
         }
         if(object == null || param1 == null)
         {
            return;
         }
         var _loc4_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc6_:String = _loc3_.spriteTag;
         if(_loc6_.indexOf("@") >= 0)
         {
            _loc5_ = parseInt(_loc6_.substr(_loc6_.indexOf("@") + 1));
         }
         if(_loc5_ < 1 || _loc5_ > this._planeParser.planeCount)
         {
            if(param1.type == MouseEvent.ROLL_OUT)
            {
               _loc4_.setNumber(RoomObjectVariableEnum.const_534,0);
            }
            return;
         }
         _loc5_--;
         var _loc7_:* = null;
         var _loc8_:IVector3d = this._planeParser.getPlaneLocation(_loc5_);
         var _loc9_:IVector3d = this._planeParser.getPlaneLeftSide(_loc5_);
         var _loc10_:IVector3d = this._planeParser.getPlaneRightSide(_loc5_);
         var _loc11_:IVector3d = this._planeParser.getPlaneNormalDirection(_loc5_);
         var _loc12_:int = this._planeParser.getPlaneType(_loc5_);
         if(_loc8_ == null || _loc9_ == null || _loc10_ == null || _loc11_ == null)
         {
            return;
         }
         var _loc13_:Number = _loc9_.length;
         var _loc14_:Number = _loc10_.length;
         if(_loc13_ == 0 || _loc14_ == 0)
         {
            return;
         }
         var _loc15_:Number = _loc3_.screenX;
         var _loc16_:Number = _loc3_.screenY;
         var _loc17_:Point = new Point(_loc15_,_loc16_);
         _loc7_ = param2.getPlanePosition(_loc17_,_loc8_,_loc9_,_loc10_);
         if(_loc7_ == null)
         {
            _loc4_.setNumber(RoomObjectVariableEnum.const_534,0);
            return;
         }
         var _loc18_:Vector3d = Vector3d.product(_loc9_,_loc7_.x / _loc13_);
         _loc18_.add(Vector3d.product(_loc10_,_loc7_.y / _loc14_));
         _loc18_.add(_loc8_);
         var _loc19_:Number = _loc18_.x;
         var _loc20_:Number = _loc18_.y;
         var _loc21_:Number = _loc18_.z;
         if(_loc7_.x >= 0 && _loc7_.x < _loc13_ && _loc7_.y >= 0 && _loc7_.y < _loc14_)
         {
            _loc4_.setNumber(RoomObjectVariableEnum.const_1642,_loc19_);
            _loc4_.setNumber(RoomObjectVariableEnum.const_1862,_loc20_);
            _loc4_.setNumber(RoomObjectVariableEnum.const_1610,_loc21_);
            _loc4_.setNumber(RoomObjectVariableEnum.const_534,_loc5_ + 1);
            var _loc22_:String = "";
            var _loc23_:int = 0;
            var _loc24_:* = null;
            switch(param1.type)
            {
               case MouseEvent.MOUSE_MOVE:
               case MouseEvent.ROLL_OVER:
               case MouseEvent.CLICK:
                  _loc25_ = "";
                  if(param1.type == MouseEvent.MOUSE_MOVE || param1.type == MouseEvent.ROLL_OVER)
                  {
                     _loc25_ = "null";
                  }
                  else if(param1.type == MouseEvent.CLICK)
                  {
                     _loc25_ = "null";
                  }
                  _loc23_ = object.getId();
                  _loc22_ = object.getType();
                  if(eventDispatcher != null)
                  {
                     if(_loc12_ == RoomPlaneData.const_265)
                     {
                        _loc24_ = new RoomObjectTileMouseEvent(_loc25_,param1.eventId,_loc23_,_loc22_,_loc19_,_loc20_,_loc21_);
                     }
                     else if(_loc12_ == RoomPlaneData.const_283 || _loc12_ == RoomPlaneData.const_375)
                     {
                        _loc26_ = 90;
                        if(_loc11_ != null)
                        {
                           _loc26_ = Number(_loc11_.x + 90);
                           if(_loc26_ > 360)
                           {
                              _loc26_ -= 360;
                           }
                        }
                        _loc27_ = _loc9_.length * _loc7_.x / _loc13_;
                        _loc28_ = _loc10_.length * _loc7_.y / _loc14_;
                        _loc24_ = new RoomObjectWallMouseEvent(_loc25_,param1.eventId,_loc23_,_loc22_,_loc8_,_loc9_,_loc10_,_loc27_,_loc28_,_loc26_);
                     }
                     if(_loc24_ != null)
                     {
                        eventDispatcher.dispatchEvent(_loc24_);
                     }
                  }
            }
            return;
         }
         _loc4_.setNumber(RoomObjectVariableEnum.const_534,0);
      }
   }
}
