package com.sulake.habbo.widget.messages
{
   public class RoomWidgetUserActionMessage extends RoomWidgetMessage
   {
      
      public static const const_522:String = "RWUAM_WHISPER_USER";
      
      public static const const_620:String = "RWUAM_IGNORE_USER";
      
      public static const const_474:String = "RWUAM_UNIGNORE_USER";
      
      public static const const_431:String = "RWUAM_KICK_USER";
      
      public static const const_638:String = "RWUAM_BAN_USER";
      
      public static const const_625:String = "RWUAM_SEND_FRIEND_REQUEST";
      
      public static const const_502:String = "RWUAM_RESPECT_USER";
      
      public static const const_599:String = "RWUAM_GIVE_RIGHTS";
      
      public static const const_582:String = "RWUAM_TAKE_RIGHTS";
      
      public static const const_548:String = "RWUAM_START_TRADING";
      
      public static const const_696:String = "RWUAM_OPEN_HOME_PAGE";
      
      public static const const_633:String = "RWUAM_KICK_BOT";
      
      public static const const_618:String = "RWUAM_REPORT";
      
      public static const const_540:String = "RWUAM_PICKUP_PET";
      
      public static const const_1573:String = "RWUAM_TRAIN_PET";
      
      public static const const_558:String = " RWUAM_RESPECT_PET";
      
      public static const const_441:String = "RWUAM_REQUEST_PET_UPDATE";
      
      public static const const_840:String = "RWUAM_START_NAME_CHANGE";
       
      
      private var _userId:int = 0;
      
      public function RoomWidgetUserActionMessage(param1:String, param2:int = 0)
      {
         super(param1);
         this._userId = param2;
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
   }
}
