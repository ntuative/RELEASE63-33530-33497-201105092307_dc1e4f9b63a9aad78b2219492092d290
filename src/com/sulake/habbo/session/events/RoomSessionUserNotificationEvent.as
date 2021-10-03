package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionUserNotificationEvent extends RoomSessionEvent
   {
      
      public static const const_128:String = "RSUN_USER_NOTIFICATION";
       
      
      private var _title:String = "";
      
      private var _message:String = "";
      
      private var var_1444:Array;
      
      public function RoomSessionUserNotificationEvent(param1:String, param2:IRoomSession, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function get parameters() : Array
      {
         return this.var_1444;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function set message(param1:String) : void
      {
         this._message = param1;
      }
      
      public function set parameters(param1:Array) : void
      {
         this.var_1444 = param1;
      }
   }
}
