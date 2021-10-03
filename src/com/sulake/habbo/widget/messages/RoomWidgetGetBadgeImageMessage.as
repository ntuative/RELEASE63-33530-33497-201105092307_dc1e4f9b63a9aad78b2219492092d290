package com.sulake.habbo.widget.messages
{
   public class RoomWidgetGetBadgeImageMessage extends RoomWidgetMessage
   {
      
      public static const const_761:String = "RWGOI_MESSAGE_GET_BADGE_IMAGE";
       
      
      private var var_304:String = "";
      
      public function RoomWidgetGetBadgeImageMessage(param1:String)
      {
         super(const_761);
         this.var_304 = param1;
      }
      
      public function get badgeId() : String
      {
         return this.var_304;
      }
   }
}
