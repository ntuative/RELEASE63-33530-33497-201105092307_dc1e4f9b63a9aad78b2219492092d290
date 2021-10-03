package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   public class QuestController implements IDisposable, IUpdateReceiver
   {
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_644:QuestsList;
      
      private var var_531:QuestDetails;
      
      private var _questCompleted:QuestCompleted;
      
      private var var_364:QuestTracker;
      
      private var var_974:CampaignCompleted;
      
      public function QuestController(param1:HabboQuestEngine)
      {
         super();
         this._questEngine = param1;
         this.var_364 = new QuestTracker(this._questEngine);
         this.var_644 = new QuestsList(this._questEngine);
         this.var_531 = new QuestDetails(this._questEngine);
         this._questCompleted = new QuestCompleted(this._questEngine);
         this.var_974 = new CampaignCompleted(this._questEngine);
      }
      
      public function onToolbarClick() : void
      {
         this.var_644.onToolbarClick();
      }
      
      public function onQuests(param1:Array, param2:Boolean) : void
      {
         this.var_644.onQuests(param1,param2);
      }
      
      public function onQuest(param1:QuestMessageData) : void
      {
         this.var_364.onQuest(param1);
         this.var_531.onQuest(param1);
         this._questCompleted.onQuest(param1);
      }
      
      public function onQuestCompleted(param1:QuestMessageData) : void
      {
         this.var_364.onQuestCompleted(param1);
         this.var_531.onQuestCompleted(param1);
         this._questCompleted.onQuestCompleted(param1);
      }
      
      public function onQuestCancelled() : void
      {
         this.var_364.onQuestCancelled();
         this.var_531.onQuestCancelled();
         this._questCompleted.onQuestCancelled();
      }
      
      public function onRoomEnter() : void
      {
         this.var_364.onRoomEnter();
      }
      
      public function onRoomExit() : void
      {
         this.var_644.onRoomExit();
         this.var_364.onRoomExit();
         this.var_531.onRoomExit();
         this.var_974.onRoomExit();
      }
      
      public function update(param1:uint) : void
      {
         this._questCompleted.update(param1);
         this.var_364.update(param1);
      }
      
      public function dispose() : void
      {
         this._questEngine = null;
         if(this.var_644)
         {
            this.var_644.dispose();
            this.var_644 = null;
         }
         if(this.var_364)
         {
            this.var_364.dispose();
            this.var_364 = null;
         }
         if(this.var_531)
         {
            this.var_531.dispose();
            this.var_531 = null;
         }
         if(this._questCompleted)
         {
            this._questCompleted.dispose();
            this._questCompleted = null;
         }
         if(this.var_974)
         {
            this.var_974.dispose();
            this.var_974 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._questEngine == null;
      }
      
      public function get questsList() : QuestsList
      {
         return this.var_644;
      }
      
      public function get questDetails() : QuestDetails
      {
         return this.var_531;
      }
      
      public function get questTracker() : QuestTracker
      {
         return this.var_364;
      }
      
      public function get campaignCompleted() : CampaignCompleted
      {
         return this.var_974;
      }
   }
}
