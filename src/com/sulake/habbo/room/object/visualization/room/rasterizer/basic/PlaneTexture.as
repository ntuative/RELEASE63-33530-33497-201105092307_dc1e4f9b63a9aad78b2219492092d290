package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   
   public class PlaneTexture
   {
      
      public static const const_58:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
       
      
      private var var_585:Array;
      
      public function PlaneTexture()
      {
         this.var_585 = [];
         super();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(this.var_585 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.var_585.length)
            {
               _loc2_ = this.var_585[_loc1_] as PlaneTextureBitmap;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            this.var_585 = null;
         }
      }
      
      public function addBitmap(param1:BitmapData, param2:Number = -1.0, param3:Number = 1.0, param4:Number = -1.0, param5:Number = 1.0) : void
      {
         var _loc6_:PlaneTextureBitmap = new PlaneTextureBitmap(param1,param2,param3,param4,param5);
         this.var_585.push(_loc6_);
      }
      
      public function getBitmap(param1:IVector3d) : BitmapData
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.var_585.length)
         {
            _loc3_ = this.var_585[_loc2_] as PlaneTextureBitmap;
            if(_loc3_ != null)
            {
               if(param1.x >= _loc3_.normalMinX && param1.x <= _loc3_.normalMaxX && param1.y >= _loc3_.normalMinY && param1.y <= _loc3_.normalMaxY)
               {
                  return _loc3_.bitmap;
               }
            }
            _loc2_++;
         }
         return null;
      }
   }
}
