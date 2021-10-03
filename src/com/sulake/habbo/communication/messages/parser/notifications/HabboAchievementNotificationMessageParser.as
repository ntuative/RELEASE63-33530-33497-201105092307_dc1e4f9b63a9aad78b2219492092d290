package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class HabboAchievementNotificationMessageParser implements IMessageParser
   {
       
      
      private var _type:int;
      
      private var var_1437:int;
      
      private var var_2040:int;
      
      private var var_2250:int;
      
      private var var_1809:int;
      
      private var var_1438:int;
      
      private var var_2247:String = "";
      
      private var var_2249:String = "";
      
      private var var_2248:int;
      
      public function HabboAchievementNotificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._type = param1.readInteger();
         this.var_1437 = param1.readInteger();
         this.var_2247 = param1.readString();
         this.var_2040 = param1.readInteger();
         this.var_2250 = param1.readInteger();
         this.var_1809 = param1.readInteger();
         this.var_1438 = param1.readInteger();
         this.var_2248 = param1.readInteger();
         this.var_2249 = param1.readString();
         return true;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get level() : int
      {
         return this.var_1437;
      }
      
      public function get points() : int
      {
         return this.var_2040;
      }
      
      public function get levelRewardPoints() : int
      {
         return this.var_2250;
      }
      
      public function get levelRewardPointType() : int
      {
         return this.var_1809;
      }
      
      public function get bonusPoints() : int
      {
         return this.var_1438;
      }
      
      public function get badgeID() : String
      {
         return this.var_2247;
      }
      
      public function get achievementID() : int
      {
         return this.var_2248;
      }
      
      public function get removedBadgeID() : String
      {
         return this.var_2249;
      }
   }
}
