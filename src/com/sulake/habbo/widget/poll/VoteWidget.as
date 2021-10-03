package com.sulake.habbo.widget.poll
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetVoteUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetVoteMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class VoteWidget extends RoomWidgetBase
   {
       
      
      private var _window:IFrameWindow;
      
      private var _list:IItemListWindow;
      
      private var _config:IHabboConfigurationManager;
      
      private var var_2017:int = -1;
      
      private var var_1567:int = 30000;
      
      private var var_2016:int;
      
      private var var_158:Timer;
      
      public function VoteWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager)
      {
         super(param1,param2,param3);
         this._config = param4;
         if(this._config != null)
         {
            this.var_1567 = int(this._config.getKey("vote.time.limit","30000"));
         }
      }
      
      override public function dispose() : void
      {
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
         if(this.var_158)
         {
            this.var_158.reset();
            this.var_158.removeEventListener(TimerEvent.TIMER,this.updateEvent);
            this.var_158 = null;
         }
         this._config = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetVoteUpdateEvent.const_152,this.showVoteQuestion);
         param1.addEventListener(RoomWidgetVoteUpdateEvent.const_161,this.showVoteResult);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetVoteUpdateEvent.const_152,this.showVoteQuestion);
         param1.removeEventListener(RoomWidgetVoteUpdateEvent.const_161,this.showVoteResult);
      }
      
      private function showVoteQuestion(param1:RoomWidgetVoteUpdateEvent) : void
      {
         var _loc6_:* = null;
         var _loc12_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(!this.createWindow())
         {
            return;
         }
         var _loc2_:ITextWindow = this._window.findChildByName("question") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IWindowContainer = this._window.findChildByName("list_container") as IWindowContainer;
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_.text = param1.question;
         var _loc4_:int = Math.max(_loc2_.textHeight + 10 - _loc2_.height,0);
         _loc2_.scale(0,_loc4_);
         _loc3_.offset(0,_loc4_);
         var _loc5_:Array = param1.choices;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = this.createChoice(_loc7_,_loc5_[_loc7_]);
            if(_loc6_ == null)
            {
               return;
            }
            this._list.addListItem(_loc6_);
            _loc7_++;
         }
         var _loc8_:int = Math.max(this._list.scrollableRegion.height - this._list.height,0);
         _loc3_.scale(0,_loc8_);
         this._window.scale(0,_loc4_ + _loc8_);
         var _loc9_:IWindow = this._window.findChildByName("waiting_text");
         if(_loc9_ != null)
         {
            _loc9_.visible = false;
         }
         var _loc10_:IDesktopWindow = this._window.desktop;
         if(_loc10_ != null)
         {
            _loc12_ = new Point(_loc10_.width - this._window.width,_loc10_.height - this._window.height);
            _loc12_.offset(-10,-10);
            this._window.setGlobalPosition(_loc12_);
         }
         this._window.visible = true;
         this.var_2017 = -1;
         if(this.var_158 == null)
         {
            this.var_158 = new Timer(1000);
            this.var_158.addEventListener(TimerEvent.TIMER,this.updateEvent);
         }
         this.var_2016 = getTimer();
         this.var_158.reset();
         this.var_158.start();
         var _loc11_:IWindow = this._window.findChildByName("timer");
         if(_loc11_ != null)
         {
            _loc11_.visible = true;
         }
      }
      
      private function createWindow() : Boolean
      {
         if(this._window != null)
         {
            this._window.dispose();
         }
         var _loc1_:XmlAsset = assets.getAssetByName("vote_question") as XmlAsset;
         this._window = windowManager.buildFromXML(_loc1_.content as XML) as IFrameWindow;
         if(this._window == null)
         {
            return false;
         }
         this._list = this._window.findChildByName("choices") as IItemListWindow;
         if(this._list == null)
         {
            return false;
         }
         this._window.visible = false;
         var _loc2_:IWindow = this._window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.close);
         }
         var _loc3_:IWindow = this._window.findChildByName("timer");
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
         return true;
      }
      
      private function createChoice(param1:int, param2:String) : IWindow
      {
         var _loc3_:XmlAsset = assets.getAssetByName("vote_choice") as XmlAsset;
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:IWindowContainer = windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc5_:ITextWindow = _loc4_.findChildByName("text") as ITextWindow;
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:IButtonWindow = _loc4_.findChildByName("button") as IButtonWindow;
         if(_loc6_ == null)
         {
            return null;
         }
         _loc6_.id = param1;
         _loc6_.caption = String.fromCharCode(97 + param1);
         _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onChoiceClicked);
         _loc5_.text = param2;
         var _loc7_:IWindowContainer = _loc4_.findChildByName("bg") as IWindowContainer;
         if(_loc7_ != null)
         {
            _loc7_.visible = false;
         }
         return _loc4_;
      }
      
      private function onChoiceClicked(param1:WindowMouseEvent) : void
      {
         if(param1 == null || param1.window == null)
         {
            return;
         }
         this.vote(param1.window.id);
      }
      
      private function vote(param1:int = -1) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         this.var_2017 = param1;
         if(param1 >= 0)
         {
            if(messageListener == null)
            {
               return;
            }
            messageListener.processWidgetMessage(new RoomWidgetVoteMessage(param1 + 1));
         }
         if(this._window == null || this._list == null)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._list.numListItems)
         {
            _loc2_ = this._list.getListItemAt(_loc4_) as IBorderWindow;
            if(_loc2_ == null)
            {
               return;
            }
            if(_loc4_ != this.var_2017)
            {
               _loc2_.blend = 0.5;
            }
            _loc3_ = _loc2_.findChildByName("button") as IButtonWindow;
            if(_loc3_ == null)
            {
               return;
            }
            _loc3_.disable();
            _loc4_++;
         }
         var _loc5_:IWindow = this._window.findChildByName("timer");
         if(_loc5_ != null)
         {
            _loc5_.visible = false;
         }
         var _loc6_:IWindow = this._window.findChildByName("waiting_text");
         if(_loc6_ != null)
         {
            _loc6_.visible = true;
         }
         this.var_158.reset();
      }
      
      private function close(param1:WindowEvent = null) : void
      {
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
      }
      
      private function updateTimerView() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(this._window == null)
         {
            return;
         }
         var _loc1_:int = getTimer() - this.var_2016;
         var _loc2_:IBitmapWrapperWindow = this._window.findChildByName("timer_bar") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc4_ = Number(_loc1_) / this.var_1567;
            _loc5_ = new BitmapData(_loc2_.width,_loc2_.height,true,4281571584);
            if(_loc4_ > 0)
            {
               _loc5_.fillRect(new Rectangle(0,0,_loc5_.width,int(_loc5_.height * _loc4_)),4292006610);
            }
            _loc2_.bitmap = _loc5_;
         }
         var _loc3_:ITextWindow = this._window.findChildByName("timer_text") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc6_ = Math.max((this.var_1567 - _loc1_) / 1000,0);
            _loc3_.text = _loc6_ + " s";
         }
      }
      
      private function updateEvent(param1:TimerEvent) : void
      {
         var _loc2_:int = getTimer() - this.var_2016;
         if(_loc2_ > this.var_1567)
         {
            this.vote();
            return;
         }
         this.updateTimerView();
      }
      
      private function showVoteResult(param1:RoomWidgetVoteUpdateEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         if(this._window == null || this._list == null)
         {
            return;
         }
         _loc2_ = this._window.findChildByName("timer");
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
         _loc2_ = this._window.findChildByName("waiting_text");
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
         if(this._list.numListItems != param1.votes.length)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._list.numListItems)
         {
            _loc4_ = this._list.getListItemAt(_loc3_) as IWindowContainer;
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.findChildByName("vote_bar") as IBitmapWrapperWindow;
               if(_loc5_ != null)
               {
                  _loc9_ = new BitmapData(_loc5_.width,_loc5_.height,true,0);
                  _loc10_ = int(Number(param1.votes[_loc3_]) / param1.totalVotes * _loc9_.width);
                  if(_loc10_ > 0)
                  {
                     _loc9_.fillRect(new Rectangle(0,0,_loc10_,_loc9_.height),4281571584);
                     _loc5_.bitmap = _loc9_;
                  }
               }
               _loc6_ = _loc4_.findChildByName("bg") as IWindowContainer;
               if(_loc6_ != null)
               {
                  _loc6_.visible = true;
               }
               _loc7_ = _loc4_.findChildByName("text") as ITextWindow;
               if(_loc7_ != null)
               {
                  _loc7_.text = _loc7_.text + " ( " + param1.votes[_loc3_] + "/" + param1.totalVotes + " )";
               }
               _loc8_ = _loc4_.findChildByName("button") as IButtonWindow;
               if(_loc8_ != null)
               {
                  _loc8_.disable();
               }
            }
            _loc3_++;
         }
      }
   }
}
