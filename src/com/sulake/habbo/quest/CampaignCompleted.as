package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   
   public class CampaignCompleted implements IDisposable
   {
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IFrameWindow;
      
      public function CampaignCompleted(param1:HabboQuestEngine)
      {
         super();
         this._questEngine = param1;
      }
      
      public function dispose() : void
      {
         this._questEngine = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._questEngine == null;
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      private function close() : void
      {
         if(this._window)
         {
            this._window.visible = false;
         }
      }
      
      public function show(param1:QuestMessageData) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(this._window == null)
         {
            this._window = IFrameWindow(this._questEngine.getXmlWindow("CampaignCompletedDialog"));
            this._window.findChildByTag("close").procedure = this.onWindowClose;
            this._window.center();
            _loc3_ = this._questEngine.questController.questsList.createListEntry();
            _loc3_.x = 8;
            _loc3_.y = 8;
            this._window.content.addChild(_loc3_);
         }
         _loc3_ = IWindowContainer(this._window.findChildByName("entry_container"));
         this._questEngine.questController.questsList.refreshEntryDetails(_loc3_,param1);
         this._questEngine.questController.questsList.setEntryHeight(_loc3_);
         var _loc2_:IWindow = _loc3_.findChildByName("more_quests_button");
         _loc2_.visible = true;
         _loc2_.procedure = this.onMoreQuests;
         this._window.visible = true;
         this._window.activate();
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this._window.visible = false;
         }
      }
      
      private function onMoreQuests(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this._window.visible = false;
            this._questEngine.send(new GetQuestsMessageComposer());
         }
      }
   }
}
