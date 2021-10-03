package com.sulake.habbo.room.object.visualization.data
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.XMLValidator;
   
   public class SizeData
   {
      
      public static const const_428:int = 1000;
      
      public static const const_1759:int = 0;
       
      
      private var var_670:int = 0;
      
      private var var_1348:int = 360;
      
      private var var_713:DirectionData = null;
      
      private var var_242:Map;
      
      private var _colors:Map;
      
      private var var_1089:DirectionData = null;
      
      private var var_1638:int = -1;
      
      public function SizeData(param1:int, param2:int)
      {
         super();
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > const_428)
         {
            param1 = const_428;
         }
         this.var_670 = param1;
         if(param2 < 1)
         {
            param2 = 1;
         }
         if(param2 > 360)
         {
            param2 = 360;
         }
         this.var_1348 = param2;
         this.var_713 = new DirectionData(param1);
         this.var_242 = new Map();
         this._colors = new Map();
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(this.var_713 != null)
         {
            this.var_713.dispose();
            this.var_713 = null;
         }
         var _loc1_:int = 0;
         if(this.var_242 != null)
         {
            _loc2_ = null;
            _loc1_ = 0;
            while(_loc1_ < this.var_242.length)
            {
               _loc2_ = this.var_242.getWithIndex(_loc1_) as DirectionData;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            this.var_242.dispose();
            this.var_242 = null;
         }
         this.var_1089 = null;
         if(this._colors != null)
         {
            _loc3_ = null;
            _loc1_ = 0;
            while(_loc1_ < this._colors.length)
            {
               _loc3_ = this._colors.getWithIndex(_loc1_) as ColorData;
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               _loc1_++;
            }
            this._colors.dispose();
            this._colors = null;
         }
      }
      
      public function get layerCount() : int
      {
         return this.var_670;
      }
      
      public function defineLayers(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:XMLList = param1.layer;
         return this.defineDirection(this.var_713,_loc2_);
      }
      
      public function defineDirections(param1:XML) : Boolean
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:* = ["id"];
         var _loc3_:* = null;
         var _loc4_:XMLList = param1.direction;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length())
         {
            _loc6_ = _loc4_[_loc5_];
            if(!XMLValidator.checkRequiredAttributes(_loc6_,_loc2_))
            {
               return false;
            }
            _loc7_ = int(_loc6_.@id);
            _loc8_ = _loc6_.layer;
            if(this.var_242.getValue(String(_loc7_)) != null)
            {
               return false;
            }
            _loc3_ = new DirectionData(this.layerCount);
            _loc3_.copyValues(this.var_713);
            this.defineDirection(_loc3_,_loc8_);
            this.var_242.add(String(_loc7_),_loc3_);
            this.var_1638 = -1;
            this.var_1089 = null;
            _loc5_++;
         }
         return true;
      }
      
      private function defineDirection(param1:DirectionData, param2:XMLList) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc3_:* = ["id"];
         var _loc4_:int = 0;
         while(_loc4_ < param2.length())
         {
            _loc5_ = param2[_loc4_];
            if(!XMLValidator.checkRequiredAttributes(_loc5_,_loc3_))
            {
               return false;
            }
            _loc6_ = int(_loc5_.@id);
            if(_loc6_ < 0 || _loc6_ >= this.layerCount)
            {
               return false;
            }
            _loc7_ = _loc5_.@tag;
            if(_loc7_.length > 0)
            {
               param1.setTag(_loc6_,_loc7_);
            }
            _loc8_ = _loc5_.@ink;
            switch(_loc8_)
            {
               case "ADD":
                  param1.setInk(_loc6_,LayerData.const_1218);
                  break;
               case "SUBTRACT":
                  param1.setInk(_loc6_,LayerData.const_1152);
                  break;
               case "DARKEN":
                  param1.setInk(_loc6_,LayerData.INK_DARKEN);
                  break;
            }
            _loc7_ = _loc5_.@alpha;
            if(_loc7_.length > 0)
            {
               param1.setAlpha(_loc6_,int(_loc7_));
            }
            _loc7_ = _loc5_.@ignoreMouse;
            if(_loc7_.length > 0)
            {
               _loc9_ = int(_loc7_);
               param1.setIgnoreMouse(_loc6_,_loc9_ != 0);
            }
            _loc7_ = _loc5_.@x;
            if(_loc7_.length > 0)
            {
               param1.setXOffset(_loc6_,int(_loc7_));
            }
            _loc7_ = _loc5_.@y;
            if(_loc7_.length > 0)
            {
               param1.setYOffset(_loc6_,int(_loc7_));
            }
            _loc7_ = _loc5_.@z;
            if(_loc7_.length > 0)
            {
               _loc10_ = int(_loc7_);
               param1.setZOffset(_loc6_,Number(_loc10_) / -1000);
            }
            _loc4_++;
         }
         return true;
      }
      
      public function defineColors(param1:XML) : Boolean
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(param1 == null)
         {
            return true;
         }
         var _loc2_:* = null;
         var _loc3_:* = ["id"];
         var _loc4_:* = ["id","color"];
         var _loc5_:XMLList = param1.color;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc7_ = _loc5_[_loc6_];
            if(!XMLValidator.checkRequiredAttributes(_loc7_,_loc3_))
            {
               return false;
            }
            _loc8_ = _loc7_.@id;
            if(this._colors.getValue(_loc8_) != null)
            {
               return false;
            }
            _loc2_ = new ColorData(this.layerCount);
            _loc9_ = _loc7_.colorLayer;
            _loc10_ = 0;
            while(_loc10_ < _loc9_.length())
            {
               _loc11_ = _loc9_[_loc10_];
               if(!XMLValidator.checkRequiredAttributes(_loc11_,_loc4_))
               {
                  _loc2_.dispose();
                  return false;
               }
               _loc12_ = int(_loc11_.@id);
               _loc13_ = parseInt(_loc11_.@color,16);
               _loc2_.setColor(_loc13_,_loc12_);
               _loc10_++;
            }
            if(_loc2_ != null)
            {
               this._colors.add(_loc8_,_loc2_);
            }
            _loc6_++;
         }
         return true;
      }
      
      public function getDirectionValue(param1:int) : int
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = (param1 % 360 + 360 + this.var_1348 / 2) % 360 / this.var_1348;
         if(this.var_242.getValue(String(_loc2_)) != null)
         {
            return _loc2_;
         }
         _loc2_ = (param1 % 360 + 360) % 360;
         var _loc3_:int = -1;
         var _loc4_:int = -1;
         var _loc5_:int = 0;
         while(_loc5_ < this.var_242.length)
         {
            _loc6_ = int(this.var_242.getKey(_loc5_)) * this.var_1348;
            _loc7_ = (_loc6_ - _loc2_ + 360) % 360;
            if(_loc7_ > 180)
            {
               _loc7_ = 360 - _loc7_;
            }
            if(_loc7_ < _loc3_ || _loc3_ < 0)
            {
               _loc3_ = _loc7_;
               _loc4_ = _loc5_;
            }
            _loc5_++;
         }
         if(_loc4_ >= 0)
         {
            return int(this.var_242.getKey(_loc4_));
         }
         return const_1759;
      }
      
      private function getDirectionData(param1:int) : DirectionData
      {
         if(param1 == this.var_1638)
         {
            return this.var_1089;
         }
         var _loc2_:* = null;
         _loc2_ = this.var_242.getValue(String(param1)) as DirectionData;
         if(_loc2_ == null)
         {
            _loc2_ = this.var_713;
         }
         this.var_1638 = param1;
         this.var_1089 = _loc2_;
         return this.var_1089;
      }
      
      public function getTag(param1:int, param2:int) : String
      {
         var _loc3_:* = null;
         _loc3_ = this.getDirectionData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getTag(param2);
         }
         return LayerData.const_710;
      }
      
      public function getInk(param1:int, param2:int) : int
      {
         var _loc3_:* = null;
         _loc3_ = this.getDirectionData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getInk(param2);
         }
         return LayerData.const_445;
      }
      
      public function getAlpha(param1:int, param2:int) : int
      {
         var _loc3_:* = null;
         _loc3_ = this.getDirectionData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getAlpha(param2);
         }
         return LayerData.const_494;
      }
      
      public function getColor(param1:int, param2:int) : uint
      {
         var _loc3_:ColorData = this._colors.getValue(String(param2)) as ColorData;
         if(_loc3_ != null)
         {
            return _loc3_.getColor(param1);
         }
         return ColorData.const_73;
      }
      
      public function getIgnoreMouse(param1:int, param2:int) : Boolean
      {
         var _loc3_:* = null;
         _loc3_ = this.getDirectionData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getIgnoreMouse(param2);
         }
         return LayerData.const_968;
      }
      
      public function getXOffset(param1:int, param2:int) : int
      {
         var _loc3_:* = null;
         _loc3_ = this.getDirectionData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getXOffset(param2);
         }
         return LayerData.const_526;
      }
      
      public function getYOffset(param1:int, param2:int) : int
      {
         var _loc3_:* = null;
         _loc3_ = this.getDirectionData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getYOffset(param2);
         }
         return LayerData.const_520;
      }
      
      public function getZOffset(param1:int, param2:int) : Number
      {
         var _loc3_:* = null;
         _loc3_ = this.getDirectionData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getZOffset(param2);
         }
         return LayerData.const_398;
      }
   }
}
