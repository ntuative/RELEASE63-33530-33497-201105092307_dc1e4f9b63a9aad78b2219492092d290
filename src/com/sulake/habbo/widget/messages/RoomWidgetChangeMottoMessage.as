package com.sulake.habbo.widget.messages
{
   public class RoomWidgetChangeMottoMessage extends RoomWidgetMessage
   {
      
      public static const const_724:String = "RWVM_CHANGE_MOTTO_MESSAGE";
       
      
      private var var_1790:String;
      
      public function RoomWidgetChangeMottoMessage(param1:String)
      {
         super(const_724);
         this.var_1790 = param1;
      }
      
      public function get motto() : String
      {
         return this.var_1790;
      }
   }
}
