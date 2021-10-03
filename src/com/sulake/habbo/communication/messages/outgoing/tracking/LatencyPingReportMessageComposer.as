package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class LatencyPingReportMessageComposer implements IMessageComposer
   {
       
      
      private var var_2279:int;
      
      private var var_2280:int;
      
      private var var_2278:int;
      
      public function LatencyPingReportMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         this.var_2279 = param1;
         this.var_2280 = param2;
         this.var_2278 = param3;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2279,this.var_2280,this.var_2278];
      }
      
      public function dispose() : void
      {
      }
   }
}
