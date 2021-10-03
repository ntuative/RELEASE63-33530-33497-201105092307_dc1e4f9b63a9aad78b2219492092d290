package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class PlaneVisualizationLayer implements IDisposable
   {
      
      public static const const_1215:int = 0;
      
      public static const const_130:int = 1;
      
      public static const const_238:int = 2;
      
      public static const ALIGN_DEFAULT:int = const_130;
       
      
      private var _material:PlaneMaterial = null;
      
      private var _color:uint = 0;
      
      private var _offset:int = 0;
      
      private var _align:int = 1;
      
      private var _bitmapData:BitmapData = null;
      
      private var var_1076:Boolean = false;
      
      public function PlaneVisualizationLayer(param1:PlaneMaterial, param2:uint, param3:int, param4:int = 0)
      {
         super();
         this._material = param1;
         this._offset = param4;
         this._align = param3;
         this._color = param2;
      }
      
      public function get offset() : int
      {
         return this._offset;
      }
      
      public function get align() : int
      {
         return this._align;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1076;
      }
      
      public function dispose() : void
      {
         this.var_1076 = true;
         this._material = null;
         if(this._bitmapData != null)
         {
            this._bitmapData.dispose();
            this._bitmapData = null;
         }
      }
      
      public function clearCache() : void
      {
         if(this._bitmapData != null)
         {
            this._bitmapData.dispose();
            this._bitmapData = null;
         }
      }
      
      public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean) : BitmapData
      {
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null;
         var _loc6_:uint = this._color >> 16;
         var _loc7_:uint = this._color >> 8 & 255;
         var _loc8_:uint = this._color & 255;
         var _loc9_:Boolean = false;
         if(_loc6_ < 255 || _loc7_ < 255 || _loc8_ < 255)
         {
            _loc9_ = true;
         }
         if(param1 == null || param1.width != param2 || param1.height != param3)
         {
            param1 = null;
         }
         var _loc10_:* = null;
         if(this._material != null)
         {
            if(_loc9_)
            {
               _loc10_ = this._material.render(null,param2,param3,param4,param5,this.offset,this.align == const_130);
            }
            else
            {
               _loc10_ = this._material.render(param1,param2,param3,param4,param5,this.offset,this.align == const_130);
            }
            if(_loc10_ != null && _loc10_ != param1)
            {
               if(this._bitmapData != null)
               {
                  this._bitmapData.dispose();
               }
               this._bitmapData = _loc10_.clone();
               _loc10_ = this._bitmapData;
            }
         }
         else if(param1 == null)
         {
            if(this._bitmapData != null && this._bitmapData.width == param2 && this._bitmapData.height == param3)
            {
               return this._bitmapData;
            }
            if(this._bitmapData != null)
            {
               this._bitmapData.dispose();
            }
            this._bitmapData = new BitmapData(param2,param3,true,4294967295);
            _loc10_ = this._bitmapData;
         }
         else
         {
            param1.fillRect(param1.rect,4294967295);
            _loc10_ = param1;
         }
         if(_loc10_ != null)
         {
            if(_loc9_)
            {
               _loc11_ = _loc6_ / 255;
               _loc12_ = _loc7_ / 255;
               _loc13_ = _loc8_ / 255;
               _loc14_ = new ColorTransform(_loc11_,_loc12_,_loc13_);
               _loc10_.colorTransform(_loc10_.rect,_loc14_);
               if(param1 != null && _loc10_ != param1)
               {
                  param1.copyPixels(_loc10_,_loc10_.rect,new Point(0,0),null,null,true);
                  _loc10_ = param1;
               }
            }
         }
         return _loc10_;
      }
   }
}
