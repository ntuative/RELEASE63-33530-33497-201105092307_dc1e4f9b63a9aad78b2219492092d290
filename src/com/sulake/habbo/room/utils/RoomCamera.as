package com.sulake.habbo.room.utils
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomCamera
   {
      
      private static const const_1510:Number = 12;
       
      
      private var var_2718:int = -1;
      
      private var var_2717:int = -2;
      
      private var var_211:Vector3d = null;
      
      private var var_1245:Number = 0;
      
      private var var_1534:Number = 0;
      
      private var var_1974:Boolean = false;
      
      private var var_187:Vector3d = null;
      
      private var var_1975:Vector3d;
      
      private var var_2721:Boolean = false;
      
      private var var_2724:Boolean = false;
      
      private var var_2722:Boolean = false;
      
      private var var_2723:Boolean = false;
      
      private var var_2726:int = 0;
      
      private var var_2720:int = 0;
      
      private var _scale:int = 0;
      
      private var var_2719:int = 0;
      
      private var var_2725:int = 0;
      
      private var var_1724:int = -1;
      
      private var var_1976:int = 0;
      
      private var var_1973:Boolean = false;
      
      public function RoomCamera()
      {
         this.var_1975 = new Vector3d();
         super();
      }
      
      public function get location() : IVector3d
      {
         return this.var_187;
      }
      
      public function get targetId() : int
      {
         return this.var_2718;
      }
      
      public function get targetCategory() : int
      {
         return this.var_2717;
      }
      
      public function get targetObjectLoc() : IVector3d
      {
         return this.var_1975;
      }
      
      public function get limitedLocationX() : Boolean
      {
         return this.var_2721;
      }
      
      public function get limitedLocationY() : Boolean
      {
         return this.var_2724;
      }
      
      public function get centeredLocX() : Boolean
      {
         return this.var_2722;
      }
      
      public function get centeredLocY() : Boolean
      {
         return this.var_2723;
      }
      
      public function get screenWd() : int
      {
         return this.var_2726;
      }
      
      public function get screenHt() : int
      {
         return this.var_2720;
      }
      
      public function get scale() : int
      {
         return this._scale;
      }
      
      public function get roomWd() : int
      {
         return this.var_2719;
      }
      
      public function get roomHt() : int
      {
         return this.var_2725;
      }
      
      public function get geometryUpdateId() : int
      {
         return this.var_1724;
      }
      
      public function get isMoving() : Boolean
      {
         if(this.var_211 != null && this.var_187 != null)
         {
            return true;
         }
         return false;
      }
      
      public function set targetId(param1:int) : void
      {
         this.var_2718 = param1;
      }
      
      public function set targetObjectLoc(param1:IVector3d) : void
      {
         this.var_1975.assign(param1);
      }
      
      public function set targetCategory(param1:int) : void
      {
         this.var_2717 = param1;
      }
      
      public function set limitedLocationX(param1:Boolean) : void
      {
         this.var_2721 = param1;
      }
      
      public function set limitedLocationY(param1:Boolean) : void
      {
         this.var_2724 = param1;
      }
      
      public function set centeredLocX(param1:Boolean) : void
      {
         this.var_2722 = param1;
      }
      
      public function set centeredLocY(param1:Boolean) : void
      {
         this.var_2723 = param1;
      }
      
      public function set screenWd(param1:int) : void
      {
         this.var_2726 = param1;
      }
      
      public function set screenHt(param1:int) : void
      {
         this.var_2720 = param1;
      }
      
      public function set scale(param1:int) : void
      {
         if(this._scale != param1)
         {
            this._scale = param1;
            this.var_1973 = true;
         }
      }
      
      public function set roomWd(param1:int) : void
      {
         this.var_2719 = param1;
      }
      
      public function set roomHt(param1:int) : void
      {
         this.var_2725 = param1;
      }
      
      public function set geometryUpdateId(param1:int) : void
      {
         this.var_1724 = param1;
      }
      
      public function set target(param1:IVector3d) : void
      {
         var _loc2_:* = null;
         if(this.var_211 == null)
         {
            this.var_211 = new Vector3d();
         }
         if(this.var_211.x != param1.x || this.var_211.y != param1.y || this.var_211.z != param1.z)
         {
            this.var_211.assign(param1);
            this.var_1976 = 0;
            _loc2_ = Vector3d.dif(this.var_211,this.var_187);
            this.var_1245 = _loc2_.length;
            this.var_1974 = true;
         }
      }
      
      public function dispose() : void
      {
         this.var_211 = null;
         this.var_187 = null;
      }
      
      public function initializeLocation(param1:IVector3d) : void
      {
         if(this.var_187 != null)
         {
            return;
         }
         this.var_187 = new Vector3d();
         this.var_187.assign(param1);
      }
      
      public function method_10(param1:IVector3d) : void
      {
         if(this.var_187 == null)
         {
            this.var_187 = new Vector3d();
         }
         this.var_187.assign(param1);
      }
      
      public function update(param1:uint, param2:Number) : void
      {
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.var_211 != null && this.var_187 != null)
         {
            ++this.var_1976;
            if(this.var_1973)
            {
               this.var_1973 = false;
               this.var_187 = this.var_211;
               this.var_211 = null;
               return;
            }
            _loc3_ = Vector3d.dif(this.var_211,this.var_187);
            if(_loc3_.length > this.var_1245)
            {
               this.var_1245 = _loc3_.length;
            }
            if(_loc3_.length <= param2)
            {
               this.var_187 = this.var_211;
               this.var_211 = null;
               this.var_1534 = 0;
            }
            else
            {
               _loc4_ = Math.sin(0 * _loc3_.length / this.var_1245);
               _loc5_ = param2 * 0.5;
               _loc6_ = this.var_1245 / const_1510;
               _loc7_ = _loc5_ + (_loc6_ - _loc5_) * _loc4_;
               if(this.var_1974)
               {
                  if(_loc7_ < this.var_1534)
                  {
                     _loc7_ = this.var_1534;
                     if(_loc7_ > _loc3_.length)
                     {
                        _loc7_ = _loc3_.length;
                     }
                  }
                  else
                  {
                     this.var_1974 = false;
                  }
               }
               this.var_1534 = _loc7_;
               _loc3_.div(_loc3_.length);
               _loc3_.mul(_loc7_);
               this.var_187 = Vector3d.sum(this.var_187,_loc3_);
            }
         }
      }
      
      public function reset() : void
      {
         this.var_1724 = -1;
      }
   }
}
