package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ChargeInfo
   {
       
      
      private var var_2568:int;
      
      private var var_2566:int;
      
      private var var_1291:int;
      
      private var var_1290:int;
      
      private var var_2050:int;
      
      private var var_2567:int;
      
      public function ChargeInfo(param1:IMessageDataWrapper)
      {
         super();
         this.var_2568 = param1.readInteger();
         this.var_2566 = param1.readInteger();
         this.var_1291 = param1.readInteger();
         this.var_1290 = param1.readInteger();
         this.var_2050 = param1.readInteger();
         this.var_2567 = param1.readInteger();
      }
      
      public function get stuffId() : int
      {
         return this.var_2568;
      }
      
      public function get charges() : int
      {
         return this.var_2566;
      }
      
      public function get priceInCredits() : int
      {
         return this.var_1291;
      }
      
      public function get priceInActivityPoints() : int
      {
         return this.var_1290;
      }
      
      public function get chargePatchSize() : int
      {
         return this.var_2567;
      }
      
      public function get activityPointType() : int
      {
         return this.var_2050;
      }
   }
}
