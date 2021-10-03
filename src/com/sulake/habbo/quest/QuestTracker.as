package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class QuestTracker implements IDisposable
   {
      
      private static const const_988:Array = [-2,-3,-2,0,2,3,2,0,2,1,0,1];
      
      private static const const_991:Array = [1,1,2,2,3,3,4,4,5,5,6,6,4];
      
      private static const const_992:int = 6;
      
      private static const const_1348:int = 4;
      
      private static const const_648:int = 2;
      
      private static const const_989:int = 200;
      
      private static const const_298:Array = ["a","b","c","d"];
      
      private static const const_990:int = 10000;
      
      private static const const_1349:int = 0;
      
      private static const const_647:int = -1;
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_216:QuestMessageData;
      
      private var _window:IWindowContainer;
      
      private var var_483:Timer;
      
      private var var_288:int = 0;
      
      private var var_871:int = 0;
      
      private var var_1342:int = 0;
      
      private var var_1082:int = -1;
      
      private var var_709:int = -1;
      
      private var var_872:int = -1;
      
      private var var_1081:int;
      
      private var var_1341:int;
      
      private var var_2159:Boolean;
      
      private const const_450:int = 0;
      
      private const const_1892:int = 1;
      
      private const const_1895:int = 2;
      
      private const const_1897:int = 3;
      
      private const const_1894:int = 4;
      
      private const const_1896:int = 5;
      
      private const const_1893:int = 6;
      
      public function QuestTracker(param1:HabboQuestEngine)
      {
         super();
         this._questEngine = param1;
      }
      
      public function dispose() : void
      {
         this._questEngine = null;
         this.var_216 = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
         if(this.var_483)
         {
            this.var_483.stop();
            this.var_483 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._questEngine == null;
      }
      
      public function onQuestCompleted(param1:QuestMessageData) : void
      {
         if(this._window)
         {
            this.clearPrompt();
            this.var_216 = param1;
            this.var_871 = 0;
            this.refreshTrackerDetails();
            this.var_1082 = 0;
            this.var_288 = this.const_1897;
         }
      }
      
      public function onQuestCancelled() : void
      {
         this.var_216 = null;
         if(this._window)
         {
            this.clearPrompt();
            this.var_288 = this.const_1895;
         }
      }
      
      public function onRoomEnter() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = Boolean(parseInt(this._questEngine.configuration.getKey("new.identity","0")));
         var _loc2_:String = this.getDefaultCampaign();
         if(this.var_483 == null && _loc1_ && _loc2_ != "" && this._questEngine.isQuestingEnabled())
         {
            _loc3_ = int(this._questEngine.configuration.getKey("questing.startQuestDelayInSeconds","30"));
            this.var_483 = new Timer(_loc3_ * 1000,1);
            this.var_483.addEventListener(TimerEvent.TIMER,this.onStartQuestTimer);
            this.var_483.start();
            Logger.log("Initialized start quest timer with period: " + _loc3_);
         }
      }
      
      public function onRoomExit() : void
      {
         if(this._window != null && this._window.visible)
         {
            this._window.findChildByName("more_info_txt").visible = false;
            this._window.findChildByName("more_info_region").visible = false;
         }
      }
      
      public function onQuest(param1:QuestMessageData) : void
      {
         var _loc2_:Boolean = this._window && this._window.visible;
         this.var_216 = param1;
         this.prepareTrackerWindow();
         this.refreshTrackerDetails();
         this.refreshPromptFrames();
         this.hideSuccessFrames();
         if(_loc2_)
         {
            this.startNudge();
            this.setupPrompt(this.var_709,const_1348,false);
         }
         else
         {
            this._window.x = this._window.desktop.width;
            this.var_288 = this.const_1892;
            this.setupPrompt(const_1349,const_648,false);
         }
         this._window.visible = true;
         this._questEngine.notifications.setQuestTrackerVisible(true);
      }
      
      private function refreshPromptFrames() : void
      {
         if(!this._questEngine.isQuestWithPrompts(this.var_216))
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < const_298.length)
         {
            this._questEngine.setupPromptFrameImage(this._window,this.var_216,const_298[_loc1_]);
            _loc1_++;
         }
      }
      
      private function prepareTrackerWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         this._window = IWindowContainer(this._questEngine.getXmlWindow("QuestTracker"));
         this._window.y = 75;
         this._window.findChildByName("more_info_region").procedure = this.onMoreInfo;
         new PendingImage(this._questEngine,this._window.findChildByName("quest_tracker_bg"),"questtrackerbkg");
         var _loc1_:int = 1;
         while(_loc1_ <= const_992)
         {
            new PendingImage(this._questEngine,this.getSuccessFrame(_loc1_),"checkanim" + _loc1_);
            _loc1_++;
         }
         this.hideSuccessFrames();
      }
      
      private function hideSuccessFrames() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= const_992)
         {
            this.getSuccessFrame(_loc1_).visible = false;
            _loc1_++;
         }
      }
      
      private function hidePromptFrames() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < const_298.length)
         {
            this.getPromptFrame(const_298[_loc1_]).visible = false;
            _loc1_++;
         }
      }
      
      private function getSuccessFrame(param1:int) : IBitmapWrapperWindow
      {
         return IBitmapWrapperWindow(this._window.findChildByName("success_pic_" + param1));
      }
      
      private function getPromptFrame(param1:String) : IBitmapWrapperWindow
      {
         return IBitmapWrapperWindow(this._window.findChildByName("prompt_pic_" + param1));
      }
      
      private function refreshTrackerDetails() : void
      {
         this._questEngine.localization.registerParameter("quests.tracker.caption","quest_name",this._questEngine.getQuestName(this.var_216));
         this._window.findChildByName("desc_txt").caption = this._questEngine.getQuestDesc(this.var_216);
         this._window.findChildByName("more_info_txt").visible = true;
         this._window.findChildByName("more_info_region").visible = true;
         var _loc1_:int = Math.round(100 * this.var_216.completedSteps / this.var_216.totalSteps);
         this._questEngine.localization.registerParameter("quests.tracker.progress","progress","" + _loc1_);
         this._questEngine.setupQuestImage(this._window,this.var_216);
      }
      
      private function onMoreInfo(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this._questEngine.questController.questDetails.showDetails(this.var_216);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._window == null)
         {
            return;
         }
         switch(this.var_288)
         {
            case this.const_1892:
               _loc2_ = this.getDefaultLocationX();
               _loc3_ = this._window.x - _loc2_;
               if(_loc3_ > 0)
               {
                  _loc4_ = Math.max(1,Math.round(_loc3_ * param1 * 0.01));
                  this._window.x -= _loc4_;
               }
               else
               {
                  this.var_288 = this.const_450;
                  this._window.x = _loc2_;
               }
               break;
            case this.const_1895:
               _loc2_ = this._window.desktop.width;
               _loc3_ = _loc2_ - this._window.x;
               if(_loc3_ > 0)
               {
                  _loc4_ = Math.max(1,Math.round(param1 * 100 / _loc3_));
                  this._window.x += _loc4_;
               }
               else
               {
                  this.var_288 = this.const_450;
                  this._window.x = _loc2_;
                  this._window.visible = false;
                  this._questEngine.notifications.setQuestTrackerVisible(false);
               }
               break;
            case this.const_1897:
               this.hideSuccessFrames();
               this.getSuccessFrame(const_991[this.var_1082]).visible = true;
               ++this.var_1082;
               if(this.var_1082 >= const_991.length)
               {
                  this.var_288 = this.const_1896;
                  this.var_1342 = 1000;
               }
               break;
            case this.const_1893:
               this.setQuestImageVisible(false);
               this.hidePromptFrames();
               this.var_1081 -= param1;
               this.getPromptFrame(const_298[this.var_872]).visible = true;
               if(this.var_1081 < 0)
               {
                  this.var_1081 = const_989;
                  ++this.var_872;
                  if(this.var_872 >= const_298.length)
                  {
                     this.var_872 = 0;
                     --this.var_1341;
                     if(this.var_1341 < 1)
                     {
                        this.setupPrompt(const_990,const_648,true);
                        this.var_288 = this.const_450;
                     }
                  }
               }
               break;
            case this.const_1894:
               if(this.var_871 >= -1)
               {
                  this._window.x = this.getDefaultLocationX();
                  this.var_288 = this.const_450;
                  this.setupPrompt(const_990,const_648,false);
               }
               else
               {
                  this._window.x = this.getDefaultLocationX() + const_988[this.var_871];
                  ++this.var_871;
               }
               break;
            case this.const_1896:
               this.var_1342 -= param1;
               if(this.var_1342 < 0)
               {
                  this.var_288 = this.const_450;
                  this._window.visible = false;
               }
               break;
            case this.const_450:
               if(this.var_709 != const_647)
               {
                  this.var_709 -= param1;
                  if(this.var_709 < 0)
                  {
                     this.var_709 = const_647;
                     if(this.var_216 != null && this._questEngine.isQuestWithPrompts(this.var_216))
                     {
                        if(this.var_2159)
                        {
                           this.startNudge();
                        }
                        else
                        {
                           this.var_288 = this.const_1893;
                           this.var_872 = 0;
                           this.var_1081 = const_989;
                        }
                     }
                  }
               }
         }
      }
      
      private function getDefaultLocationX() : int
      {
         return this._window.desktop.width - this._window.width - 4;
      }
      
      public function isVisible() : Boolean
      {
         return this._window && this._window.visible;
      }
      
      private function onStartQuestTimer(param1:TimerEvent) : void
      {
         if(this.hasBlockingWindow())
         {
            Logger.log("Quest start blocked. Waiting some more");
            this.var_483.reset();
            this.var_483.start();
         }
         else
         {
            this._questEngine.questController.questDetails.openForNextQuest = this._questEngine.configuration.getKey("questing.showDetailsForNextQuest") == "true";
            this._questEngine.send(new StartCampaignMessageComposer(this.getDefaultCampaign()));
         }
      }
      
      private function getDefaultCampaign() : String
      {
         var _loc1_:String = this._questEngine.configuration.getKey("questing.defaultCampaign");
         return _loc1_ == null ? "" : _loc1_;
      }
      
      private function hasBlockingWindow() : Boolean
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         while(_loc1_ <= 2)
         {
            _loc2_ = this._questEngine.windowManager.getDesktop(_loc1_);
            if(_loc2_ != null && this.hasBlockingWindowInLayer(_loc2_))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      private function hasBlockingWindowInLayer(param1:IWindowContainer) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_ != null && _loc3_.visible)
            {
               if(_loc3_ as IFrameWindow != null)
               {
                  if(_loc3_.name != "mod_start_panel")
                  {
                     return true;
                  }
               }
               else if(_loc3_.name == "welcome_screen")
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      private function setQuestImageVisible(param1:Boolean) : void
      {
         this._window.findChildByName("quest_pic_bitmap").visible = param1;
      }
      
      private function clearPrompt() : void
      {
         this.setupPrompt(const_647,0,false);
      }
      
      private function setupPrompt(param1:int, param2:int, param3:Boolean) : void
      {
         this.setQuestImageVisible(true);
         this.hidePromptFrames();
         this.var_709 = param1;
         this.var_1341 = param2;
         this.var_2159 = param3;
      }
      
      private function startNudge() : void
      {
         this.var_871 = 0;
         this.var_288 = this.const_1894;
      }
   }
}
