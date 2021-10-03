package com.sulake.habbo.inventory.events
{
   import flash.events.Event;
   
   public class HabboInventoryItemAddedEvent extends Event
   {
      
      public static const HABBO_INVENTORY_ITEM_ADDED:String = "HABBO_INVENTORY_ITEM_ADDED";
       
      
      private var var_1639:int;
      
      private var var_2534:int;
      
      private var _category:int;
      
      public function HabboInventoryItemAddedEvent(param1:int, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(HABBO_INVENTORY_ITEM_ADDED,param4,param5);
         this.var_1639 = param1;
         this.var_2534 = param2;
         this._category = param3;
      }
      
      public function get classId() : int
      {
         return this.var_1639;
      }
      
      public function get stripId() : int
      {
         return this.var_2534;
      }
      
      public function get category() : int
      {
         return this._category;
      }
   }
}
