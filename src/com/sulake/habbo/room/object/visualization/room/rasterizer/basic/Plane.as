package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class Plane
   {
       
      
      private var var_380:Map;
      
      private var _sizes:Array;
      
      private var var_1247:PlaneVisualization = null;
      
      private var var_2189:int = -1;
      
      public function Plane()
      {
         this._sizes = [];
         super();
         this.var_380 = new Map();
      }
      
      public function isStatic(param1:int) : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(this.var_380 != null)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < this.var_380.length)
            {
               _loc1_ = this.var_380.getWithIndex(_loc2_) as PlaneVisualization;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            this.var_380.dispose();
            this.var_380 = null;
         }
         this.var_1247 = null;
         this._sizes = null;
      }
      
      public function clearCache() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.var_380.length)
         {
            _loc2_ = this.var_380.getWithIndex(_loc1_) as PlaneVisualization;
            if(_loc2_ != null)
            {
               _loc2_.clearCache();
            }
            _loc1_++;
         }
      }
      
      public function createPlaneVisualization(param1:int, param2:int, param3:IRoomGeometry) : PlaneVisualization
      {
         if(this.var_380.getValue(String(param1)) != null)
         {
            return null;
         }
         var _loc4_:PlaneVisualization = new PlaneVisualization(param1,param2,param3);
         this.var_380.add(String(param1),_loc4_);
         this._sizes.push(param1);
         this._sizes.sort();
         return _loc4_;
      }
      
      private function getSizeIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 1;
         while(_loc3_ < this._sizes.length)
         {
            if(this._sizes[_loc3_] > param1)
            {
               if(this._sizes[_loc3_] - param1 < param1 - this._sizes[_loc3_ - 1])
               {
                  _loc2_ = _loc3_;
               }
               break;
            }
            _loc2_ = _loc3_;
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function getPlaneVisualization(param1:int) : PlaneVisualization
      {
         if(param1 == this.var_2189)
         {
            return this.var_1247;
         }
         var _loc2_:int = this.getSizeIndex(param1);
         if(_loc2_ < this._sizes.length)
         {
            this.var_1247 = this.var_380.getValue(String(this._sizes[_loc2_])) as PlaneVisualization;
         }
         else
         {
            this.var_1247 = null;
         }
         this.var_2189 = param1;
         return this.var_1247;
      }
   }
}
