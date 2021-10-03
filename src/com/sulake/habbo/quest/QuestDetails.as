package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   public class QuestDetails implements IDisposable
   {
      
      private static const const_1571:Array = ["PLACE_ITEM","PLACE_FLOOR","PLACE_WALLPAPER"];
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IFrameWindow;
      
      private var var_2047:Boolean;
      
      private var var_344:QuestMessageData;
      
      public function QuestDetails(param1:HabboQuestEngine)
      {
         super();
         this._questEngine = param1;
      }
      
      public function dispose() : void
      {
         this._questEngine = null;
         this.var_344 = null;
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
      
      public function onQuest(param1:QuestMessageData) : void
      {
         if(this.var_2047)
         {
            this.var_2047 = false;
            this.showDetails(param1);
         }
         else if(this.var_344 == null || this.var_344.id != param1.id)
         {
            this.close();
         }
      }
      
      public function onQuestCompleted(param1:QuestMessageData) : void
      {
         this.close();
      }
      
      public function onQuestCancelled() : void
      {
         this.close();
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
      
      public function showDetails(param1:QuestMessageData) : void
      {
         if(this._window && this._window.visible)
         {
            this._window.visible = false;
            return;
         }
         this.openDetails(param1);
      }
      
      private function openDetails(param1:QuestMessageData) : void
      {
         var _loc10_:* = null;
         this.var_344 = param1;
         if(param1 == null)
         {
            return;
         }
         if(this._window == null)
         {
            this._window = IFrameWindow(this._questEngine.getXmlWindow("QuestDetails"));
            this._window.findChildByTag("close").procedure = this.onDetailsWindowClose;
            this._window.center();
            _loc10_ = this._questEngine.questController.questsList.createListEntry();
            _loc10_.x = 8;
            _loc10_.y = 8;
            this._window.content.addChild(_loc10_);
            this._window.findChildByName("catalog_link_region").procedure = this.onCatalogLink;
         }
         _loc10_ = IWindowContainer(this._window.findChildByName("entry_container"));
         this._questEngine.questController.questsList.refreshEntryDetails(_loc10_,param1);
         var _loc2_:ITextWindow = ITextWindow(_loc10_.findChildByName("hint_txt"));
         var _loc3_:int = _loc2_.height;
         _loc2_.caption = this._questEngine.getQuestHint(param1);
         _loc2_.height = _loc2_.textHeight + 5;
         var _loc4_:int = _loc2_.height - _loc3_ + (!!_loc2_.visible ? 0 : 30);
         _loc2_.visible = true;
         var _loc5_:IRegionWindow = IRegionWindow(this._window.findChildByName("catalog_link_region"));
         var _loc6_:* = const_1571.indexOf(param1.type) > -1;
         _loc5_.y = _loc2_.y + _loc2_.height + 5;
         var _loc8_:int = 0;
         if(_loc6_ && !_loc5_.visible)
         {
            _loc8_ = 5 + _loc5_.height;
         }
         if(!_loc6_ && _loc5_.visible)
         {
            _loc8_ = -5 - _loc5_.height;
         }
         _loc5_.visible = _loc6_;
         var _loc9_:IWindowContainer = IWindowContainer(_loc10_.findChildByName("quest_container"));
         _loc9_.height += _loc4_ + _loc8_;
         this._questEngine.questController.questsList.setEntryHeight(_loc10_);
         this._window.height = _loc10_.height + 56;
         this._window.visible = true;
         this._window.activate();
      }
      
      private function onDetailsWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this._window.visible = false;
         }
      }
      
      public function set openForNextQuest(param1:Boolean) : void
      {
         this.var_2047 = param1;
      }
      
      private function onCatalogLink(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this._questEngine.openCatalog(this.var_344);
         }
      }
   }
}
