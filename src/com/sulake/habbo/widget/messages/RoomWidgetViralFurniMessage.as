package com.sulake.habbo.widget.messages
{
   public class RoomWidgetViralFurniMessage extends RoomWidgetMessage
   {
      
      public static const const_953:String = "RWVFM_VIRAL_FOUND";
      
      public static const const_185:String = "RWVFM_OPEN_PRESENT";
       
      
      private var var_194:int;
      
      public function RoomWidgetViralFurniMessage(param1:String)
      {
         super(param1);
      }
      
      public function get objectId() : int
      {
         return this.var_194;
      }
      
      public function set objectId(param1:int) : void
      {
         this.var_194 = param1;
      }
   }
}
