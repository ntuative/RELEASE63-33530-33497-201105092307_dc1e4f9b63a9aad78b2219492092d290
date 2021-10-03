package com.hurlant.crypto.prng
{
   import com.hurlant.util.Memory;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.text.Font;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class Random
   {
       
      
      private var state:IPRNG;
      
      private var ready:Boolean = false;
      
      private var var_168:ByteArray;
      
      private var psize:int;
      
      private var var_124:int;
      
      private var var_2813:Boolean = false;
      
      public function Random(param1:Class = null)
      {
         var _loc2_:* = 0;
         super();
         if(param1 == null)
         {
            param1 = ARC4;
         }
         this.state = new param1() as IPRNG;
         this.psize = this.state.getPoolSize();
         this.var_168 = new ByteArray();
         this.var_124 = 0;
         while(this.var_124 < this.psize)
         {
            _loc2_ = uint(65536 * Math.random());
            var _loc3_:* = this.var_124++;
            this.var_168[_loc3_] = _loc2_ >>> 8;
            var _loc4_:*;
            this.var_168[_loc4_ = this.var_124++] = _loc2_ & 255;
         }
         this.var_124 = 0;
         this.seed();
      }
      
      public function seed(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            param1 = new Date().getTime();
         }
         var _loc2_:* = this.var_124++;
         this.var_168[_loc2_] ^= param1 & 255;
         var _loc3_:* = this.var_124++;
         this.var_168[_loc3_] ^= param1 >> 8 & 255;
         var _loc4_:*;
         this.var_168[_loc4_ = this.var_124++] = this.var_168[_loc4_] ^ param1 >> 16 & 255;
         var _loc5_:*;
         this.var_168[_loc5_ = this.var_124++] = this.var_168[_loc5_] ^ param1 >> 24 & 255;
         this.var_124 %= this.psize;
         this.var_2813 = true;
      }
      
      public function autoSeed() : void
      {
         var _loc3_:* = null;
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeUnsignedInt(System.totalMemory);
         _loc1_.writeUTF(Capabilities.serverString);
         _loc1_.writeUnsignedInt(getTimer());
         _loc1_.writeUnsignedInt(new Date().getTime());
         var _loc2_:Array = Font.enumerateFonts(true);
         for each(_loc3_ in _loc2_)
         {
            _loc1_.writeUTF(_loc3_.fontName);
            _loc1_.writeUTF(_loc3_.fontStyle);
            _loc1_.writeUTF(_loc3_.fontType);
         }
         _loc1_.position = 0;
         while(_loc1_.bytesAvailable >= 4)
         {
            this.seed(_loc1_.readUnsignedInt());
         }
      }
      
      public function nextBytes(param1:ByteArray, param2:int) : void
      {
         while(param2--)
         {
            param1.writeByte(this.nextByte());
         }
      }
      
      public function nextByte() : int
      {
         if(!this.ready)
         {
            if(!this.var_2813)
            {
               this.autoSeed();
            }
            this.state.init(this.var_168);
            this.var_168.length = 0;
            this.var_124 = 0;
            this.ready = true;
         }
         return this.state.next();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.var_168.length)
         {
            this.var_168[_loc1_] = Math.random() * 256;
            _loc1_++;
         }
         this.var_168.length = 0;
         this.var_168 = null;
         this.state.dispose();
         this.state = null;
         this.psize = 0;
         this.var_124 = 0;
         Memory.gc();
      }
      
      public function toString() : String
      {
         return "random-" + this.state.toString();
      }
   }
}
