package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import flash.display.BitmapData;
   
   public class GraphicAsset implements IGraphicAsset
   {
       
      
      private var var_1804:String;
      
      private var var_2820:String;
      
      private var var_463:BitmapDataAsset;
      
      private var var_1466:Boolean;
      
      private var var_1467:Boolean;
      
      private var var_2819:Boolean;
      
      private var _offsetX:int;
      
      private var var_1105:int;
      
      private var var_259:int;
      
      private var _height:int;
      
      private var var_759:Boolean;
      
      public function GraphicAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:Boolean = false)
      {
         super();
         this.var_1804 = param1;
         this.var_2820 = param2;
         var _loc9_:BitmapDataAsset = param3 as BitmapDataAsset;
         if(_loc9_ != null)
         {
            this.var_463 = _loc9_;
            this.var_759 = false;
         }
         else
         {
            this.var_463 = null;
            this.var_759 = true;
         }
         this.var_1466 = param4;
         this.var_1467 = param5;
         this._offsetX = param6;
         this.var_1105 = param7;
         this.var_2819 = param8;
      }
      
      public function dispose() : void
      {
         this.var_463 = null;
      }
      
      private function initialize() : void
      {
         var _loc1_:* = null;
         if(!this.var_759 && this.var_463 != null)
         {
            _loc1_ = this.var_463.content as BitmapData;
            if(_loc1_ != null)
            {
               this.var_259 = _loc1_.width;
               this._height = _loc1_.height;
            }
            this.var_759 = true;
         }
      }
      
      public function get flipV() : Boolean
      {
         return this.var_1467;
      }
      
      public function get flipH() : Boolean
      {
         return this.var_1466;
      }
      
      public function get width() : int
      {
         this.initialize();
         return this.var_259;
      }
      
      public function get height() : int
      {
         this.initialize();
         return this._height;
      }
      
      public function get assetName() : String
      {
         return this.var_1804;
      }
      
      public function get libraryAssetName() : String
      {
         return this.var_2820;
      }
      
      public function get asset() : IAsset
      {
         return this.var_463;
      }
      
      public function get usesPalette() : Boolean
      {
         return this.var_2819;
      }
      
      public function get offsetX() : int
      {
         if(!this.var_1466)
         {
            return this._offsetX;
         }
         return -(this.width + this._offsetX);
      }
      
      public function get offsetY() : int
      {
         if(!this.var_1467)
         {
            return this.var_1105;
         }
         return -(this.height + this.var_1105);
      }
      
      public function get originalOffsetX() : int
      {
         return this._offsetX;
      }
      
      public function get originalOffsetY() : int
      {
         return this.var_1105;
      }
   }
}
