package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementShareIdMessageParser;
   
   public class HabboAchievementShareIdMessageEvent extends MessageEvent implements IMessageEvent
   {
       
      
      public function HabboAchievementShareIdMessageEvent(param1:Function)
      {
         super(param1,HabboAchievementShareIdMessageParser);
      }
      
      public function get badgeID() : String
      {
         return (var_10 as HabboAchievementShareIdMessageParser).badgeID;
      }
      
      public function get shareID() : String
      {
         return (var_10 as HabboAchievementShareIdMessageParser).shareID;
      }
   }
}
