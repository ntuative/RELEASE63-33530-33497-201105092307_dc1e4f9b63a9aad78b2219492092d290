package com.sulake.habbo.widget.messages
{
   public class RoomWidgetOpenCatalogMessage extends RoomWidgetMessage
   {
      
      public static const const_386:String = "RWGOI_MESSAGE_OPEN_CATALOG";
      
      public static const const_1233:String = "RWOCM_CLUB_MAIN";
      
      public static const const_1192:String = "RWOCM_PIXELS";
      
      public static const const_1250:String = "RWOCM_CREDITS";
       
      
      private var var_2389:String = "";
      
      public function RoomWidgetOpenCatalogMessage(param1:String)
      {
         super(const_386);
         this.var_2389 = param1;
      }
      
      public function get pageKey() : String
      {
         return this.var_2389;
      }
   }
}
