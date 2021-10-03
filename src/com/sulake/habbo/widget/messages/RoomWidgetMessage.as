package com.sulake.habbo.widget.messages
{
   public class RoomWidgetMessage
   {
      
      public static const const_2120:String = "RWM_MESSAGE_TEST";
       
      
      private var _type:String = "";
      
      public function RoomWidgetMessage(param1:String)
      {
         super();
         this._type = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
   }
}
