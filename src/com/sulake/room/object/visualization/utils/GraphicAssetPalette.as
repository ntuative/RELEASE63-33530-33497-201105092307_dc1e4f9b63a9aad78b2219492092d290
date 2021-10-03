package com.sulake.room.object.visualization.utils
{
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   public class GraphicAssetPalette
   {
      
      private static var name_2:Array = [];
       
      
      private var var_890:Array;
      
      private var var_2264:int = 0;
      
      private var var_2263:int = 0;
      
      public function GraphicAssetPalette(param1:ByteArray, param2:int, param3:int)
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         this.var_890 = [];
         super();
         param1.position = 0;
         while(param1.bytesAvailable >= 3)
         {
            _loc4_ = uint(param1.readUnsignedByte());
            _loc5_ = uint(param1.readUnsignedByte());
            _loc6_ = uint(param1.readUnsignedByte());
            _loc7_ = uint(-16777216 | _loc4_ << 16 | _loc5_ << 8 | _loc6_);
            this.var_890.push(_loc7_);
         }
         while(this.var_890.length < 256)
         {
            this.var_890.push(0);
         }
         while(true)
         {
            name_2.push(0);
         }
         this.var_2264 = param2;
         this.var_2263 = param3;
      }
      
      public function get primaryColor() : int
      {
         return this.var_2264;
      }
      
      public function get secondaryColor() : int
      {
         return this.var_2263;
      }
      
      public function dispose() : void
      {
         this.var_890 = [];
      }
      
      public function colorizeBitmap(param1:BitmapData) : void
      {
         var _loc2_:BitmapData = param1.clone();
         param1.paletteMap(param1,param1.rect,new Point(0,0),name_2,this.var_890,name_2,name_2);
         param1.copyChannel(_loc2_,param1.rect,new Point(0,0),BitmapDataChannel.ALPHA,BitmapDataChannel.ALPHA);
         _loc2_.dispose();
      }
   }
}
