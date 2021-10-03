package com.sulake.core.communication.handshake
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.utils.ErrorReportStorage;
   
   public class DiffieHellman implements IKeyExchange
   {
       
      
      private var var_1006:BigInteger;
      
      private var var_2585:BigInteger;
      
      private var var_1872:BigInteger;
      
      private var var_2586:BigInteger;
      
      private var var_1481:BigInteger;
      
      private var var_1871:BigInteger;
      
      public function DiffieHellman(param1:BigInteger, param2:BigInteger)
      {
         super();
         this.var_1481 = param1;
         this.var_1871 = param2;
      }
      
      public function init(param1:String, param2:uint = 16) : Boolean
      {
         ErrorReportStorage.addDebugData("DiffieHellman","Prime: " + this.var_1481.toString() + ",generator: " + this.var_1871.toString() + ",secret: " + param1);
         this.var_1006 = new BigInteger();
         this.var_1006.fromRadix(param1,param2);
         this.var_2585 = this.var_1871.modPow(this.var_1006,this.var_1481);
         return true;
      }
      
      public function generateSharedKey(param1:String, param2:uint = 16) : String
      {
         this.var_1872 = new BigInteger();
         this.var_1872.fromRadix(param1,param2);
         this.var_2586 = this.var_1872.modPow(this.var_1006,this.var_1481);
         return this.getSharedKey(param2);
      }
      
      public function getPublicKey(param1:uint = 16) : String
      {
         return this.var_2585.toRadix(param1);
      }
      
      public function getSharedKey(param1:uint = 16) : String
      {
         return this.var_2586.toRadix(param1);
      }
   }
}
