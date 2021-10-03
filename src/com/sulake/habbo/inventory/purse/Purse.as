package com.sulake.habbo.inventory.purse
{
   public class Purse
   {
       
      
      private var var_1824:int = 0;
      
      private var var_1825:int = 0;
      
      private var var_2351:int = 0;
      
      private var var_2349:Boolean = false;
      
      private var var_2350:Boolean = false;
      
      public function Purse()
      {
         super();
      }
      
      public function set clubDays(param1:int) : void
      {
         this.var_1824 = Math.max(0,param1);
      }
      
      public function set clubPeriods(param1:int) : void
      {
         this.var_1825 = Math.max(0,param1);
      }
      
      public function set clubPastPeriods(param1:int) : void
      {
         this.var_2351 = Math.max(0,param1);
      }
      
      public function set clubHasEverBeenMember(param1:Boolean) : void
      {
         this.var_2349 = param1;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         this.var_2350 = param1;
      }
      
      public function get clubDays() : int
      {
         return this.var_1824;
      }
      
      public function get clubPeriods() : int
      {
         return this.var_1825;
      }
      
      public function get clubPastPeriods() : int
      {
         return this.var_2351;
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return this.var_2349;
      }
      
      public function get isVIP() : Boolean
      {
         return this.var_2350;
      }
   }
}
