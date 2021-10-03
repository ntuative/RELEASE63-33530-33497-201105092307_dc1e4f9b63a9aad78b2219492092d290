package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
   import com.sulake.habbo.help.WelcomeNotification;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.utils.IAlertDialog;
   
   public class QuestsList implements IDisposable
   {
      
      private static const const_1473:int = 5;
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IFrameWindow;
      
      private var _list:IItemListWindow;
      
      private var var_566:IScrollbarWindow;
      
      private var var_1889:Boolean = true;
      
      private var var_1890:Boolean;
      
      private var var_783:WindowToggle;
      
      public function QuestsList(param1:HabboQuestEngine)
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
         if(this.var_783)
         {
            this.var_783.dispose();
            this.var_783 = null;
         }
         this._list = null;
         this.var_566 = null;
      }
      
      public function get disposed() : Boolean
      {
         return this._questEngine == null;
      }
      
      public function isVisible() : Boolean
      {
         return this._window && this._window.visible;
      }
      
      public function close() : void
      {
         if(this._window)
         {
            this._window.visible = false;
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(!this._questEngine.isQuestingEnabled())
         {
            this._questEngine.windowManager.alert("${quests.workinprogress.title}","${quests.workinprogress.text}",0,this.onAlert);
            return;
         }
         if(!this._window)
         {
            this.requestQuests();
            return;
         }
         if(!this.var_783 || this.var_783.disposed)
         {
            this.var_783 = new WindowToggle(this._window,this._window.desktop,this.requestQuests,this.close);
         }
         this.var_783.toggle();
         this.var_1889 = false;
      }
      
      private function requestQuests() : void
      {
         this._questEngine.send(new GetQuestsMessageComposer());
      }
      
      public function onQuests(param1:Array, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(!this.isVisible() && !param2)
         {
            return;
         }
         this.refresh(param1);
         this._window.visible = true;
         this._window.activate();
         this.var_1890 = false;
         for each(_loc3_ in param1)
         {
            if(_loc3_.accepted)
            {
               this.var_1890 = true;
            }
         }
      }
      
      private function refresh(param1:Array) : void
      {
         var _loc3_:Boolean = false;
         this.prepareWindow();
         this._list.autoArrangeItems = false;
         var _loc2_:int = 0;
         while(true)
         {
            if(_loc2_ < param1.length)
            {
               this.refreshEntry(true,_loc2_,param1[_loc2_]);
            }
            else
            {
               _loc3_ = this.refreshEntry(false,_loc2_,null);
               if(_loc3_)
               {
                  break;
               }
            }
            _loc2_++;
         }
         this._list.autoArrangeItems = true;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         this._window = IFrameWindow(this._questEngine.getXmlWindow("Quests"));
         this._window.findChildByTag("close").procedure = this.onWindowClose;
         this._list = IItemListWindow(this._window.findChildByName("quest_list"));
         this.var_566 = IScrollbarWindow(this._window.findChildByName("scroller"));
         this._window.center();
         this._list.spacing = 10;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:QuestMessageData) : Boolean
      {
         var _loc4_:IWindowContainer = IWindowContainer(this._list.getListItemAt(param2));
         var _loc5_:Boolean = false;
         if(_loc4_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc4_ = this.createListEntry();
            this._list.addListItem(_loc4_);
            _loc5_ = true;
         }
         if(param1)
         {
            this.refreshEntryDetails(_loc4_,param3);
            _loc4_.visible = true;
         }
         else
         {
            _loc4_.visible = false;
         }
         return false;
      }
      
      public function createListEntry() : IWindowContainer
      {
         var _loc1_:IWindowContainer = IWindowContainer(this._questEngine.getXmlWindow("QuestEntry"));
         var _loc2_:IWindowContainer = IWindowContainer(this._questEngine.getXmlWindow("Campaign"));
         var _loc3_:IWindowContainer = IWindowContainer(this._questEngine.getXmlWindow("Quest"));
         var _loc4_:IWindowContainer = IWindowContainer(this._questEngine.getXmlWindow("EntryArrows"));
         var _loc5_:IWindowContainer = IWindowContainer(this._questEngine.getXmlWindow("CampaignCompleted"));
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc5_);
         _loc1_.addChild(_loc4_);
         _loc3_.findChildByName("accept_button").procedure = this.onAcceptQuest;
         _loc3_.findChildByName("cancel_region").procedure = this.onCancelQuest;
         _loc1_.findChildByName("hint_txt").visible = false;
         _loc1_.findChildByName("catalog_link_region").visible = false;
         var _loc6_:IWindow = _loc1_.findChildByName("cancel_region");
         var _loc7_:IWindow = _loc1_.findChildByName("cancel_txt");
         _loc6_.width = _loc7_.width;
         _loc6_.x = _loc3_.width - _loc6_.width - 10;
         new PendingImage(this._questEngine,IBitmapWrapperWindow(_loc4_.findChildByName("arrow_0")),"quest_arrow1");
         new PendingImage(this._questEngine,IBitmapWrapperWindow(_loc4_.findChildByName("arrow_1")),"quest_arrow2");
         new PendingImage(this._questEngine,IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_red_bitmap")),"quest_counterbkg");
         new PendingImage(this._questEngine,IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_green_bitmap")),"quest_counterbkg2");
         new PendingImage(this._questEngine,IBitmapWrapperWindow(_loc5_.findChildByName("completed_pic_bitmap")),"category_completed");
         _loc3_.x = _loc2_.x + _loc2_.width + const_1473;
         _loc1_.width = _loc3_.x + _loc3_.width;
         _loc5_.x = _loc3_.x;
         this.setEntryHeight(_loc1_);
         return _loc1_;
      }
      
      public function setEntryHeight(param1:IWindowContainer) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(param1.findChildByName("campaign_container"));
         var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("quest_container"));
         var _loc4_:IWindowContainer = IWindowContainer(param1.findChildByName("entry_arrows_cont"));
         _loc2_.height = _loc3_.height;
         param1.height = _loc3_.height;
         _loc4_.x = _loc2_.x + _loc2_.width - 2;
         _loc4_.y = Math.floor((_loc2_.height - _loc4_.height) / 2) + 1;
         _loc2_.findChildByName("completion_txt").y = _loc2_.height - 30;
         var _loc6_:IWindow = _loc2_.findChildByName("bg_bottom");
         _loc6_.height = Math.floor((_loc2_.height - 2 * 2) / 2);
         _loc6_.y = 2 + _loc6_.height;
      }
      
      public function refreshEntryDetails(param1:IWindowContainer, param2:QuestMessageData) : void
      {
         param1.findChildByName("campaign_header_txt").caption = this._questEngine.getCampaignName(param2);
         param1.findChildByName("completion_txt").caption = param2.completedQuestsInCampaign + "/" + param2.questCountInCampaign;
         this._questEngine.setupCampaignImage(param1,param2);
         this.setColor(param1,"bg",param2.accepted,4290944315,4284769380);
         this.setColor(param1,"bg_top",param2.accepted,4294956936,4290427578);
         this.setColor(param1,"bg_bottom",param2.accepted,4294952792,4289440683);
         param1.findChildByName("completion_bg_red_bitmap").visible = !param2.completedCampaign;
         param1.findChildByName("completion_bg_green_bitmap").visible = param2.completedCampaign;
         param1.findChildByName("arrow_0").visible = !param2.accepted;
         param1.findChildByName("arrow_1").visible = param2.accepted;
         param1.findChildByName("quest_container").visible = !param2.completedCampaign;
         param1.findChildByName("campaign_completed_container").visible = param2.completedCampaign;
         param1.findChildByName("more_quests_button").visible = false;
         if(!param2.completedCampaign)
         {
            this.refreshEntryQuestDetails(IWindowContainer(param1.findChildByName("quest_container")),param2);
         }
      }
      
      private function refreshEntryQuestDetails(param1:IWindowContainer, param2:QuestMessageData) : void
      {
         param1.findChildByName("quest_header_txt").caption = this._questEngine.getQuestRowTitle(param2);
         param1.findChildByName("desc_txt").caption = this._questEngine.getQuestDesc(param2);
         param1.findChildByName("cancel_txt").visible = param2.accepted;
         param1.findChildByName("cancel_region").visible = param2.accepted;
         param1.findChildByName("accept_button").visible = !param2.accepted;
         param1.findChildByName("accept_button").id = param2.id;
         this.setColor(param1,null,param2.accepted,15982264,13158600);
         this.setColor(param1,"quest_header",param2.accepted,15577658,9276813);
         ITextWindow(param1.findChildByName("quest_header_txt")).textColor = !!param2.accepted ? 4294967295 : uint(4281808695);
         this._questEngine.setupQuestImage(param1,param2);
         this._questEngine.refreshReward(param1,param2.activityPointType,param2.rewardCurrencyAmount);
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Boolean = false;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this.close();
            _loc3_ = Boolean(parseInt(this._questEngine.configuration.getKey("new.identity","0")));
            if(_loc3_ && this.var_1889 && !this.var_1890)
            {
               this.var_1889 = false;
               this._questEngine.habboHelp.showWelcomeScreen(new WelcomeNotification(HabboToolbarIconEnum.QUESTS,"quests.rejectnotification"));
            }
         }
      }
      
      private function onAcceptQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("Accept quest: " + _loc3_);
         this._questEngine.send(new AcceptQuestMessageComposer(_loc3_));
         this._window.visible = false;
      }
      
      private function onCancelQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Reject quest");
         this._questEngine.send(new RejectQuestMessageComposer());
      }
      
      private function setColor(param1:IWindowContainer, param2:String, param3:Boolean, param4:uint, param5:uint) : void
      {
         (param2 == null ? param1 : param1.findChildByName(param2)).color = !!param3 ? param4 : param5;
      }
      
      public function onAlert(param1:IAlertDialog, param2:WindowEvent) : void
      {
         if(param2.type == WindowEvent.const_183 || param2.type == WindowEvent.const_545)
         {
            param1.dispose();
         }
      }
   }
}
