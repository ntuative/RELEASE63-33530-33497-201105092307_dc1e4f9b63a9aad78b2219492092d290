package com.sulake.habbo.room.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class LegacyWallGeometry implements IDisposable
   {
      
      private static const const_1026:String = "l";
      
      private static const DIRECTION_RIGHT:String = "r";
       
      
      private var var_1076:Boolean = false;
      
      private var _scale:int = 64;
      
      private var _heightMap:Array;
      
      private var var_259:int = 0;
      
      private var _height:int = 0;
      
      private var var_920:int = 0;
      
      public function LegacyWallGeometry()
      {
         this._heightMap = [];
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1076;
      }
      
      public function get scale() : int
      {
         return this._scale;
      }
      
      public function set scale(param1:int) : void
      {
         this._scale = param1;
      }
      
      public function dispose() : void
      {
         this.reset();
         this.var_1076 = true;
      }
      
      public function initialize(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param1 <= this.var_259 && param2 <= this._height)
         {
            this.var_259 = param1;
            this._height = param2;
            this.var_920 = param3;
            return;
         }
         this.reset();
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = [];
            this._heightMap.push(_loc5_);
            _loc6_ = 0;
            while(_loc6_ < param1)
            {
               _loc5_.push(0);
               _loc6_++;
            }
            _loc4_++;
         }
         this.var_259 = param1;
         this._height = param2;
         this.var_920 = param3;
      }
      
      private function reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(this._heightMap != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._heightMap.length)
            {
               _loc2_ = this._heightMap[_loc1_] as Array;
               _loc1_++;
            }
            this._heightMap = [];
         }
      }
      
      public function setTileHeight(param1:int, param2:int, param3:Number) : Boolean
      {
         if(param1 < 0 || param1 >= this.var_259 || param2 < 0 || param2 >= this._height)
         {
            return false;
         }
         var _loc4_:Array = this._heightMap[param2] as Array;
         if(_loc4_ != null)
         {
            _loc4_[param1] = param3;
            return true;
         }
         return false;
      }
      
      public function getTileHeight(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= this.var_259 || param2 < 0 || param2 >= this._height)
         {
            return 0;
         }
         var _loc3_:Array = this._heightMap[param2] as Array;
         if(_loc3_ != null)
         {
            return _loc3_[param1] as Number;
         }
         return 0;
      }
      
      public function getLocation(param1:int, param2:int, param3:int, param4:int, param5:String) : IVector3d
      {
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 == 0 && param2 == 0)
         {
            param1 = this.var_259;
            param2 = this._height;
            _loc12_ = Math.round(this.scale / 10);
            if(param5 == DIRECTION_RIGHT)
            {
               _loc7_ = this.var_259 - 1;
               while(_loc7_ >= 0)
               {
                  _loc6_ = 1;
                  while(_loc6_ < this._height)
                  {
                     if(this.getTileHeight(_loc7_,_loc6_) <= this.var_920)
                     {
                        if(_loc6_ - 1 < param2)
                        {
                           param1 = _loc7_;
                           param2 = _loc6_ - 1;
                        }
                        break;
                     }
                     _loc6_++;
                  }
                  _loc7_--;
               }
               param4 += this.scale / 4 - _loc12_ / 2;
               param3 += this.scale / 2;
            }
            else
            {
               _loc6_ = this._height - 1;
               while(_loc6_ >= 0)
               {
                  _loc7_ = 1;
                  while(_loc7_ < this.var_259)
                  {
                     if(this.getTileHeight(_loc7_,_loc6_) <= this.var_920)
                     {
                        if(_loc7_ - 1 < param1)
                        {
                           param1 = _loc7_ - 1;
                           param2 = _loc6_;
                        }
                        break;
                     }
                     _loc7_++;
                  }
                  _loc6_--;
               }
               param4 += this.scale / 4 - _loc12_ / 2;
               param3 -= _loc12_;
            }
         }
         var _loc8_:Number = Number(param1);
         var _loc9_:Number = Number(param2);
         var _loc10_:Number = this.getTileHeight(param1,param2);
         if(param5 == DIRECTION_RIGHT)
         {
            _loc8_ += param3 / Number(this._scale / 2) - 0.5;
            _loc9_ += 0.5;
            _loc10_ -= (param4 - param3 / 2) / Number(this._scale / 2);
         }
         else
         {
            _loc9_ += (this._scale / 2 - param3) / Number(this._scale / 2) - 0.5;
            _loc8_ += 0.5;
            _loc10_ -= (param4 - (this._scale / 2 - param3) / 2) / Number(this._scale / 2);
         }
         return new Vector3d(_loc8_,_loc9_,_loc10_);
      }
      
      public function getLocationOldFormat(param1:Number, param2:Number, param3:String) : IVector3d
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc5_ = Math.ceil(param1);
         _loc6_ = Number(_loc5_ - param1);
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < this.var_259)
         {
            if(_loc5_ >= 0 && _loc5_ < this._height)
            {
               if(this.getTileHeight(_loc4_,_loc5_) <= this.var_920)
               {
                  _loc8_ = _loc4_ - 1;
                  _loc9_ = _loc5_;
                  _loc7_ = Number(_loc4_);
                  param3 = const_1026;
                  break;
               }
               if(this.getTileHeight(_loc4_,_loc5_ + 1) <= this.var_920)
               {
                  _loc8_ = _loc4_;
                  _loc9_ = _loc5_;
                  _loc7_ = Number(_loc9_ - param1);
                  param3 = DIRECTION_RIGHT;
                  break;
               }
            }
            _loc5_++;
            _loc4_++;
         }
         _loc10_ = this.scale / 2 * _loc6_;
         var _loc13_:Number = -_loc7_ * this.scale / 2;
         _loc13_ += -param2 * 18 / 32 * this.scale / 2;
         _loc12_ = Number(this.getTileHeight(_loc8_,_loc9_));
         _loc11_ = _loc12_ * this.scale / 2 + _loc13_;
         if(param3 == DIRECTION_RIGHT)
         {
            _loc11_ += _loc6_ * this.scale / 4;
         }
         else
         {
            _loc11_ += (1 - _loc6_) * this.scale / 4;
         }
         return this.getLocation(_loc8_,_loc9_,_loc10_,_loc11_,param3);
      }
      
      public function getOldLocation(param1:IVector3d, param2:Number) : Array
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:String = "";
         var _loc8_:* = 0;
         if(param2 == 90)
         {
            _loc3_ = Number(Math.floor(param1.x - 0.5));
            _loc4_ = Number(Math.floor(param1.y + 0.5));
            _loc8_ = Number(this.getTileHeight(_loc3_,_loc4_));
            _loc5_ = Number(this._scale / 2 - (param1.y - _loc4_ + 0.5) * Number(this._scale / 2));
            _loc6_ = Number((_loc8_ - param1.z) * Number(this._scale / 2) + (this._scale / 2 - _loc5_) / 2);
            _loc7_ = const_1026;
         }
         else
         {
            if(param2 != 180)
            {
               return null;
            }
            _loc3_ = Number(Math.floor(param1.x + 0.5));
            _loc4_ = Number(Math.floor(param1.y - 0.5));
            _loc8_ = Number(this.getTileHeight(_loc3_,_loc4_));
            _loc5_ = Number((param1.x + 0.5 - _loc3_) * Number(this._scale / 2));
            _loc6_ = Number((_loc8_ - param1.z) * Number(this._scale / 2) + _loc5_ / 2);
            _loc7_ = DIRECTION_RIGHT;
         }
         return [_loc3_,_loc4_,_loc5_,_loc6_,_loc7_];
      }
      
      public function getOldLocationString(param1:IVector3d, param2:Number) : String
      {
         var _loc3_:Array = this.getOldLocation(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:int = int(_loc3_[0]);
         var _loc5_:int = int(_loc3_[1]);
         var _loc6_:int = int(_loc3_[2]);
         var _loc7_:int = int(_loc3_[3]);
         var _loc8_:String = _loc3_[4];
         return ":w=" + _loc4_ + "," + _loc5_ + " l=" + _loc6_ + "," + _loc7_ + " " + _loc8_;
      }
      
      public function getDirection(param1:String) : Number
      {
         if(param1 == DIRECTION_RIGHT)
         {
            return 180;
         }
         return 90;
      }
   }
}
