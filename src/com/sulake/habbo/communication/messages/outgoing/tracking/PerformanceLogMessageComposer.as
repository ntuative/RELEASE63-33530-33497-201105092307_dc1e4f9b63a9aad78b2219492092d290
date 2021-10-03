package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class PerformanceLogMessageComposer implements IMessageComposer
   {
       
      
      private var var_2254:int = 0;
      
      private var var_1486:String = "";
      
      private var var_1881:String = "";
      
      private var var_2256:String = "";
      
      private var var_2255:String = "";
      
      private var var_1679:int = 0;
      
      private var var_2257:int = 0;
      
      private var var_2259:int = 0;
      
      private var var_1488:int = 0;
      
      private var var_2258:int = 0;
      
      private var var_1487:int = 0;
      
      public function PerformanceLogMessageComposer(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int)
      {
         super();
         this.var_2254 = param1;
         this.var_1486 = param2;
         this.var_1881 = param3;
         this.var_2256 = param4;
         this.var_2255 = param5;
         if(param6)
         {
            this.var_1679 = 1;
         }
         else
         {
            this.var_1679 = 0;
         }
         this.var_2257 = param7;
         this.var_2259 = param8;
         this.var_1488 = param9;
         this.var_2258 = param10;
         this.var_1487 = param11;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2254,this.var_1486,this.var_1881,this.var_2256,this.var_2255,this.var_1679,this.var_2257,this.var_2259,this.var_1488,this.var_2258,this.var_1487];
      }
   }
}
