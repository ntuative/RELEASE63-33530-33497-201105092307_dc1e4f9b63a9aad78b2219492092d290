package com.sulake.habbo.widget.poll
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetPollUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class PollWidget extends RoomWidgetBase
   {
       
      
      private var var_307:Map;
      
      public function PollWidget(param1:IHabboWindowManager, param2:IAssetLibrary = null, param3:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3);
         this.var_307 = new Map();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(this.var_307)
         {
            _loc1_ = this.var_307.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this.var_307.getWithIndex(0) as PollSession;
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               _loc2_++;
            }
            this.var_307 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetPollUpdateEvent.const_164,this.showPollOffer);
         param1.addEventListener(RoomWidgetPollUpdateEvent.const_68,this.showPollError);
         param1.addEventListener(RoomWidgetPollUpdateEvent.const_146,this.showPollContent);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetPollUpdateEvent.const_164,this.showPollOffer);
         param1.removeEventListener(RoomWidgetPollUpdateEvent.const_68,this.showPollError);
         param1.removeEventListener(RoomWidgetPollUpdateEvent.const_146,this.showPollContent);
      }
      
      private function showPollOffer(param1:Event) : void
      {
         var _loc2_:int = RoomWidgetPollUpdateEvent(param1).id;
         var _loc3_:PollSession = this.var_307.getValue(_loc2_) as PollSession;
         var _loc4_:String = RoomWidgetPollUpdateEvent(param1).summary;
         if(!_loc3_)
         {
            _loc3_ = new PollSession(_loc2_,this);
            this.var_307.add(_loc2_,_loc3_);
            _loc3_.showOffer(_loc4_);
         }
         else
         {
            Logger.log("Poll with given id already exists!");
            _loc3_.showOffer(_loc4_);
         }
      }
      
      private function showPollError(param1:Event) : void
      {
         var e:Event = param1;
         windowManager.alert("${win_error}",RoomWidgetPollUpdateEvent(e).summary,0,function(param1:IAlertDialog, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      private function showPollContent(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:RoomWidgetPollUpdateEvent = param1 as RoomWidgetPollUpdateEvent;
         if(_loc2_)
         {
            _loc3_ = _loc2_.id;
            _loc4_ = this.var_307.getValue(_loc3_) as PollSession;
            if(_loc4_)
            {
               _loc4_.showContent(_loc2_.startMessage,_loc2_.endMessage,_loc2_.questionArray);
            }
         }
      }
      
      public function pollFinished(param1:int) : void
      {
         var _loc2_:PollSession = this.var_307.getValue(param1) as PollSession;
         if(_loc2_)
         {
            _loc2_.showThanks();
            _loc2_.dispose();
            this.var_307.remove(param1);
         }
      }
      
      public function pollCancelled(param1:int) : void
      {
         var _loc2_:PollSession = this.var_307.getValue(param1) as PollSession;
         if(_loc2_)
         {
            _loc2_.dispose();
            this.var_307.remove(param1);
         }
      }
   }
}
