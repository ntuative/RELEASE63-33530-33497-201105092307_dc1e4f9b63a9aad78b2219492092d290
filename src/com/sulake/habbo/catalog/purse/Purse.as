package com.sulake.habbo.catalog.purse
{
   import flash.utils.Dictionary;
   
   public class Purse implements IPurse
   {
      
      public static const const_202:int = 0;
       
      
      private var var_1698:int = 0;
      
      private var var_1447:Dictionary;
      
      private var var_1824:int = 0;
      
      private var var_1825:int = 0;
      
      private var var_2350:Boolean = false;
      
      private var var_2482:int = 0;
      
      private var var_2483:int = 0;
      
      public function Purse()
      {
         this.var_1447 = new Dictionary();
         super();
      }
      
      public function get credits() : int
      {
         return this.var_1698;
      }
      
      public function set credits(param1:int) : void
      {
         this.var_1698 = param1;
      }
      
      public function get clubDays() : int
      {
         return this.var_1824;
      }
      
      public function set clubDays(param1:int) : void
      {
         this.var_1824 = param1;
      }
      
      public function get clubPeriods() : int
      {
         return this.var_1825;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         this.var_1825 = param1;
      }
      
      public function get hasClubLeft() : Boolean
      {
         return this.var_1824 > 0 || this.var_1825 > 0;
      }
      
      public function get isVIP() : Boolean
      {
         return this.var_2350;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         this.var_2350 = param1;
      }
      
      public function get pastClubDays() : int
      {
         return this.var_2482;
      }
      
      public function set pastClubDays(param1:int) : void
      {
         this.var_2482 = param1;
      }
      
      public function get pastVipDays() : int
      {
         return this.var_2483;
      }
      
      public function set pastVipDays(param1:int) : void
      {
         this.var_2483 = param1;
      }
      
      public function get activityPoints() : Dictionary
      {
         return this.var_1447;
      }
      
      public function set activityPoints(param1:Dictionary) : void
      {
         this.var_1447 = param1;
      }
      
      public function getActivityPointsForType(param1:int) : int
      {
         return this.var_1447[param1];
      }
   }
}
