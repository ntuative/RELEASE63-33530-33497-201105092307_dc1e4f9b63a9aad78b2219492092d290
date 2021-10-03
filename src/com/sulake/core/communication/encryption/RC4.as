package com.sulake.core.communication.encryption
{
   import flash.utils.ByteArray;
   
   public class RC4 implements IEncryption
   {
       
      
      private var i:uint = 0;
      
      private var j:uint = 0;
      
      private var var_132:Array;
      
      public function RC4()
      {
         super();
         this.var_132 = new Array(256);
      }
      
      public function init(param1:ByteArray) : void
      {
         var _loc2_:uint = param1.length;
         this.i = 0;
         while(this.i < 256)
         {
            this.var_132[this.i] = this.i;
            ++this.i;
         }
         this.j = 0;
         this.i = 0;
         while(this.i < 256)
         {
            this.j = (this.j + this.var_132[this.i] + param1[this.i % _loc2_]) % 256;
            this.swap(this.i,this.j);
            ++this.i;
         }
         this.i = 0;
         this.j = 0;
      }
      
      public function initFromState(param1:IEncryption) : void
      {
         var _loc2_:RC4 = param1 as RC4;
         this.var_132 = _loc2_.var_132.concat();
         this.i = _loc2_.i;
         this.j = _loc2_.j;
      }
      
      public function encipher(param1:ByteArray, param2:Boolean = false) : ByteArray
      {
         var _loc4_:* = 0;
         var _loc3_:ByteArray = new ByteArray();
         param1.position = 0;
         while(param1.bytesAvailable)
         {
            this.i = (this.i + 1) % 256;
            this.j = (this.j + this.var_132[this.i]) % 256;
            this.swap(this.i,this.j);
            if(param2)
            {
               this.customHackScramble(this.var_132,this.i,this.j);
            }
            _loc4_ = uint((this.var_132[this.i] + this.var_132[this.j]) % 256);
            _loc3_.writeByte(this.var_132[_loc4_] ^ param1.readByte());
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      protected function customHackScramble(param1:Array, param2:int, param3:int) : void
      {
      }
      
      public function decipher(param1:ByteArray) : ByteArray
      {
         var _loc3_:* = 0;
         var _loc2_:ByteArray = new ByteArray();
         param1.position = 0;
         while(param1.bytesAvailable)
         {
            this.i = (this.i + 1) % 256;
            this.j = (this.j + this.var_132[this.i]) % 256;
            this.swap(this.i,this.j);
            _loc3_ = uint((this.var_132[this.i] + this.var_132[this.j]) % 256);
            _loc2_.writeByte(param1.readUnsignedByte() ^ this.var_132[_loc3_]);
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      protected function swap(param1:uint, param2:uint) : void
      {
         var _loc3_:Object = this.var_132[param1];
         this.var_132[param1] = this.var_132[param2];
         this.var_132[param2] = _loc3_;
      }
   }
}
