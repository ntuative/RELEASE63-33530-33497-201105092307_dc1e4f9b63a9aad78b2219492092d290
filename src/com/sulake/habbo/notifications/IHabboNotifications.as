package com.sulake.habbo.notifications
{
   import com.sulake.core.runtime.IUnknown;
   
   public interface IHabboNotifications extends IUnknown
   {
       
      
      function showGenericNotification(param1:String) : void;
      
      function addOnlineNotification(param1:String, param2:String, param3:String = "") : void;
      
      function addOfflineNotification(param1:String, param2:String = "") : void;
      
      function addSongPlayingNotification(param1:String, param2:String) : void;
      
      function setQuestTrackerVisible(param1:Boolean) : void;
   }
}
