package com.sulake.habbo.avatar.palette
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   public class PaletteMap
   {
       
      
      private var var_589:Array;
      
      private var _blank:Array;
      
      public function PaletteMap(param1:ByteArray)
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         super();
         this.var_589 = new Array();
         param1.position = 0;
         while(param1.bytesAvailable >= 3)
         {
            _loc2_ = uint(param1.readUnsignedByte());
            _loc3_ = uint(param1.readUnsignedByte());
            _loc4_ = uint(param1.readUnsignedByte());
            _loc5_ = uint(_loc2_ << 16 | _loc3_ << 8 | _loc4_);
            this.var_589.push(_loc5_);
         }
         this._blank = new Array();
         while(this._blank.length < 256)
         {
            this._blank.push(0);
         }
      }
      
      public function getIndex(param1:uint) : int
      {
         var _loc2_:int = this.var_589.indexOf(param1);
         return _loc2_ < 0 ? 0 : int(_loc2_);
      }
      
      public function colorizeBitmap(param1:BitmapData) : void
      {
         param1.paletteMap(param1,param1.rect,new Point(0,0),this._blank,this.var_589,this._blank,this._blank);
      }
      
      public function colorize(param1:ByteArray) : ByteArray
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:ByteArray = new ByteArray();
         param1.position = 0;
         while(param1.bytesAvailable >= 4)
         {
            _loc3_ = uint(param1.readUnsignedByte());
            _loc4_ = uint(param1.readUnsignedByte());
            _loc5_ = uint(param1.readUnsignedByte());
            _loc6_ = uint(param1.readUnsignedByte());
            _loc7_ = uint(this.var_589[_loc5_] as uint);
            _loc2_.writeUnsignedInt(_loc3_ << 24 | _loc7_);
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public function invert() : void
      {
         var _loc1_:Array = new Array();
         while(this.var_589.length > 0)
         {
            _loc1_.push(this.var_589.pop());
         }
         this.var_589 = _loc1_;
      }
   }
}
