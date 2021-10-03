package com.sulake.habbo.widget.events
{
   public class RoomWidgetStickieDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_847:String = "RWSDUE_STICKIE_DATA";
       
      
      private var var_194:int = -1;
      
      private var var_863:String;
      
      private var _text:String;
      
      private var var_333:String;
      
      private var _controller:Boolean;
      
      public function RoomWidgetStickieDataUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param7,param8);
         this.var_194 = param2;
         this.var_863 = param3;
         this._text = param4;
         this.var_333 = param5;
         this._controller = param6;
      }
      
      public function get objectId() : int
      {
         return this.var_194;
      }
      
      public function get objectType() : String
      {
         return this.var_863;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get colorHex() : String
      {
         return this.var_333;
      }
      
      public function get controller() : Boolean
      {
         return this._controller;
      }
   }
}
