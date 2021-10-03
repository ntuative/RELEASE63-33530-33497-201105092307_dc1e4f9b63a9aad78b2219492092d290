package com.sulake.habbo.widget.messages
{
   public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage
   {
      
      public static const const_836:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
      
      public static const const_1289:String = "inventory_effects";
      
      public static const const_1104:String = "inventory_badges";
      
      public static const const_1753:String = "inventory_clothes";
      
      public static const const_1674:String = "inventory_furniture";
       
      
      private var var_2190:String;
      
      public function RoomWidgetOpenInventoryMessage(param1:String)
      {
         super(const_836);
         this.var_2190 = param1;
      }
      
      public function get inventoryType() : String
      {
         return this.var_2190;
      }
   }
}
