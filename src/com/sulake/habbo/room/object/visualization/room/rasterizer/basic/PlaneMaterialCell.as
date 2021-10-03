package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class PlaneMaterialCell
   {
       
      
      private var var_29:BitmapData = null;
      
      private var var_686:PlaneTexture;
      
      private var _extraItemOffsets:Array;
      
      private var var_1049:Array;
      
      private var var_1287:int = 0;
      
      public function PlaneMaterialCell(param1:PlaneTexture, param2:Array = null, param3:Array = null, param4:int = 0)
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         this._extraItemOffsets = [];
         this.var_1049 = [];
         super();
         this.var_686 = param1;
         if(param2 != null && param2.length > 0 && param4 > 0)
         {
            _loc5_ = 0;
            _loc5_ = 0;
            while(_loc5_ < param2.length)
            {
               _loc6_ = param2[_loc5_] as IGraphicAsset;
               if(_loc6_ != null)
               {
                  this.var_1049.push(_loc6_);
               }
               _loc5_++;
            }
            if(this.var_1049.length > 0)
            {
               if(param3 != null)
               {
                  _loc5_ = 0;
                  while(_loc5_ < param3.length)
                  {
                     _loc7_ = param3[_loc5_] as Point;
                     if(_loc7_ != null)
                     {
                        this._extraItemOffsets.push(new Point(_loc7_.x,_loc7_.y));
                     }
                     _loc5_++;
                  }
               }
               this.var_1287 = param4;
            }
         }
      }
      
      public function get isStatic() : Boolean
      {
         return this.var_1287 == 0;
      }
      
      public function dispose() : void
      {
         if(this.var_686 != null)
         {
            this.var_686.dispose();
            this.var_686 = null;
         }
         if(this.var_29 != null)
         {
            this.var_29.dispose();
            this.var_29 = null;
         }
         this.var_1049 = null;
         this._extraItemOffsets = null;
      }
      
      public function clearCache() : void
      {
         if(this.var_29 != null)
         {
            this.var_29.dispose();
            this.var_29 = null;
         }
      }
      
      public function getHeight(param1:IVector3d) : int
      {
         var _loc2_:* = null;
         if(this.var_686 != null)
         {
            _loc2_ = this.var_686.getBitmap(param1);
            if(_loc2_ != null)
            {
               return _loc2_.height;
            }
         }
         return 0;
      }
      
      public function render(param1:IVector3d) : BitmapData
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:* = NaN;
         var _loc16_:* = NaN;
         var _loc17_:* = 0;
         if(this.var_686 != null)
         {
            _loc2_ = this.var_686.getBitmap(param1);
            if(_loc2_ != null)
            {
               if(!this.isStatic)
               {
                  if(this.var_29 != null)
                  {
                     if(this.var_29.width != _loc2_.width || this.var_29.height != _loc2_.height)
                     {
                        this.var_29.dispose();
                        this.var_29 = null;
                     }
                     else
                     {
                        this.var_29.copyPixels(_loc2_,_loc2_.rect,new Point(0,0));
                     }
                  }
                  if(this.var_29 == null)
                  {
                     this.var_29 = _loc2_.clone();
                  }
                  _loc3_ = Math.min(this.var_1287,this._extraItemOffsets.length);
                  _loc4_ = Math.max(this.var_1287,this._extraItemOffsets.length);
                  _loc5_ = Randomizer.getArray(this.var_1287,_loc4_);
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_)
                  {
                     _loc7_ = this._extraItemOffsets[_loc5_[_loc6_]] as Point;
                     _loc8_ = this.var_1049[_loc6_ % this.var_1049.length] as IGraphicAsset;
                     if(_loc7_ != null && _loc8_ != null)
                     {
                        _loc9_ = _loc8_.asset as BitmapDataAsset;
                        if(_loc9_ != null)
                        {
                           _loc10_ = _loc9_.content as BitmapData;
                           if(_loc10_ != null)
                           {
                              _loc11_ = new Point(_loc7_.x + _loc8_.offsetX,_loc7_.y + _loc8_.offsetY);
                              _loc12_ = new Matrix();
                              _loc13_ = 1;
                              _loc14_ = 1;
                              _loc15_ = 0;
                              _loc16_ = 0;
                              if(_loc8_.flipH)
                              {
                                 _loc13_ = -1;
                                 _loc15_ = Number(_loc10_.width);
                              }
                              if(_loc8_.flipV)
                              {
                                 _loc14_ = -1;
                                 _loc16_ = Number(_loc10_.height);
                              }
                              _loc17_ = int(_loc11_.x + _loc15_);
                              _loc17_ = _loc17_ >> 1 << 1;
                              _loc12_.scale(_loc13_,_loc14_);
                              _loc12_.translate(_loc17_,_loc11_.y + _loc16_);
                              this.var_29.draw(_loc10_,_loc12_);
                           }
                        }
                     }
                     _loc6_++;
                  }
                  return this.var_29;
               }
               return _loc2_;
            }
         }
         return null;
      }
   }
}
