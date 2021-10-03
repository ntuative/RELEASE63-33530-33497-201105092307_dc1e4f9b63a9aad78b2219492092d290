package com.sulake.habbo.widget.messages
{
   public class RoomWidgetChatSelectAvatarMessage extends RoomWidgetMessage
   {
      
      public static const const_734:String = "RWCSAM_MESSAGE_SELECT_AVATAR";
       
      
      private var var_194:int;
      
      private var _userName:String;
      
      private var _roomId:int;
      
      private var _roomCategory:int;
      
      public function RoomWidgetChatSelectAvatarMessage(param1:String, param2:int, param3:String, param4:int, param5:int)
      {
         super(param1);
         this.var_194 = param2;
         this._roomId = param4;
         this._userName = param3;
         this._roomCategory = param5;
      }
      
      public function get objectId() : int
      {
         return this.var_194;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
   }
}
