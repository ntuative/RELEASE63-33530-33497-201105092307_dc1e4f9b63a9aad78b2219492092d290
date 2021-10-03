package com.sulake.habbo.widget.avatarinfo
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectTypeEnum;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetAvatarInfoEvent;
   import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomEngineUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectNameEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserDataUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetGetUserLocationMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AvatarInfoWidget extends RoomWidgetBase implements IUpdateReceiver
   {
       
      
      private var var_21:Component;
      
      private var var_182:IHabboConfigurationManager;
      
      private var _view:AvatarInfoView;
      
      private var var_192:Boolean = false;
      
      private var var_1888:Boolean = false;
      
      private var var_1206:Timer;
      
      private var var_2942:int = 3000;
      
      private var var_1493:Boolean;
      
      private var var_983:Boolean;
      
      private var _blend:Number;
      
      private var var_1492:int;
      
      private var var_2943:int = 500;
      
      private var var_311:AvatarInfoData;
      
      private var var_2622:Boolean;
      
      private var var_1886:Boolean;
      
      private var var_1887:int = -1;
      
      private var var_2941:Boolean;
      
      private var var_781:AvatarInfoView;
      
      private var var_782:AvatarMenuView;
      
      public function AvatarInfoWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboConfigurationManager, param4:IHabboLocalizationManager, param5:Component)
      {
         super(param1,param2,param4);
         this.var_21 = param5;
         this.var_182 = param3;
         this.var_1493 = false;
         this.var_983 = false;
         this.var_1206 = new Timer(this.var_2942,1);
         this.var_1206.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this.var_311 = new AvatarInfoData();
         this.var_2622 = Boolean(this.var_182.getBoolean("menu.avatar.enabled",false));
         this.var_1886 = Boolean(this.var_182.getBoolean("hover.name.enabled",false));
      }
      
      public function get configuration() : IHabboConfigurationManager
      {
         return this.var_182;
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this.var_983 = true;
         this.var_1492 = 0;
      }
      
      private function getOwnCharacterInfo() : void
      {
         messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_882,0,0));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(this.var_21)
         {
            this.var_21.removeUpdateReceiver(this);
            this.var_21 = null;
         }
         if(this.var_781)
         {
            this.var_781.dispose();
            this.var_781 = null;
         }
         if(this.var_782)
         {
            this.var_782.dispose();
            this.var_782 = null;
         }
         this._view = null;
         this.var_182 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener(RoomWidgetAvatarInfoEvent.const_133,this.updateEventHandler);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_126,this.updateEventHandler);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_112,this.updateEventHandler);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_111,this.updateEventHandler);
         param1.addEventListener(RoomWidgetFurniInfoUpdateEvent.const_336,this.updateEventHandler);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT,this.updateEventHandler);
         param1.addEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO,this.updateEventHandler);
         param1.addEventListener(RoomWidgetUserDataUpdateEvent.const_136,this.updateEventHandler);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_186,this.updateEventHandler);
         param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.const_99,this.updateEventHandler);
         param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.const_396,this.updateEventHandler);
         param1.addEventListener(RoomWidgetRoomObjectNameEvent.const_506,this.updateEventHandler);
         if(this.var_1886)
         {
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_690,this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_395,this.updateEventHandler);
         }
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetAvatarInfoEvent.const_133,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_126,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_112,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_111,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.const_336,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetUserDataUpdateEvent.const_136,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_186,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.const_99,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.const_396,this.updateEventHandler);
         param1.removeEventListener(RoomWidgetRoomObjectNameEvent.const_506,this.updateEventHandler);
         if(this.var_1886)
         {
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_395,this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_395,this.updateEventHandler);
         }
      }
      
      private function updateEventHandler(param1:RoomWidgetUpdateEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         switch(param1.type)
         {
            case RoomWidgetAvatarInfoEvent.const_133:
               _loc2_ = param1 as RoomWidgetAvatarInfoEvent;
               this.updateView(_loc2_.userId,_loc2_.userName,_loc2_.roomIndex,RoomObjectTypeEnum.const_147,_loc2_.allowNameChange,null);
               this.var_192 = true;
               break;
            case RoomWidgetRoomObjectNameEvent.const_506:
               if(RoomWidgetRoomObjectNameEvent(param1).category == RoomObjectCategoryEnum.const_33)
               {
                  this.updateView(RoomWidgetRoomObjectNameEvent(param1).userId,RoomWidgetRoomObjectNameEvent(param1).userName,RoomWidgetRoomObjectNameEvent(param1).roomIndex,RoomObjectTypeEnum.const_147,false,null);
               }
               break;
            case RoomWidgetRoomObjectUpdateEvent.const_111:
            case RoomWidgetFurniInfoUpdateEvent.const_336:
               this.removeView();
               break;
            case RoomWidgetUserInfoUpdateEvent.const_126:
               this.getOwnCharacterInfo();
               break;
            case RoomWidgetRoomObjectUpdateEvent.const_690:
               if(!(this._view is AvatarMenuView))
               {
                  this.var_1887 = RoomWidgetRoomObjectUpdateEvent(param1).id;
                  messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_727,RoomWidgetRoomObjectUpdateEvent(param1).id,RoomWidgetRoomObjectUpdateEvent(param1).category));
               }
               break;
            case RoomWidgetRoomObjectUpdateEvent.const_395:
               if(!(this._view is AvatarMenuView))
               {
                  if(RoomWidgetRoomObjectUpdateEvent(param1).id == this.var_1887)
                  {
                     if(this._view && !this._view.allowNameChange)
                     {
                        this.removeView();
                        this.var_1887 = -1;
                     }
                  }
               }
               break;
            case RoomWidgetUserInfoUpdateEvent.const_112:
               _loc3_ = param1 as RoomWidgetUserInfoUpdateEvent;
               this.var_311.amIAnyRoomController = _loc3_.amIAnyRoomController;
               this.var_311.amIController = _loc3_.amIController;
               this.var_311.amIOwner = _loc3_.amIOwner;
               this.var_311.canBeAskedAsFriend = _loc3_.canBeAskedAsFriend;
               this.var_311.canBeKicked = _loc3_.canBeKicked;
               this.var_311.canTrade = _loc3_.canTrade;
               this.var_311.canTradeReason = _loc3_.canTradeReason;
               this.var_311.hasFlatControl = _loc3_.hasFlatControl;
               this.var_311.isIgnored = _loc3_.isIgnored;
               this.var_311.respectLeft = _loc3_.respectLeft;
               this.updateView(_loc3_.webID,_loc3_.name,_loc3_.userRoomId,RoomObjectTypeEnum.const_147,false,!!_loc3_.isSpectatorMode ? null : this.var_311);
               break;
            case RoomWidgetUserInfoUpdateEvent.BOT:
               _loc4_ = param1 as RoomWidgetUserInfoUpdateEvent;
               this.updateView(_loc4_.webID,_loc4_.name,_loc4_.userRoomId,RoomObjectTypeEnum.const_628,false,null);
               break;
            case RoomWidgetPetInfoUpdateEvent.PET_INFO:
               _loc5_ = param1 as RoomWidgetPetInfoUpdateEvent;
               this.updateView(_loc5_.id,_loc5_.name,_loc5_.roomIndex,RoomObjectTypeEnum.const_223,false,null);
               break;
            case RoomWidgetUserDataUpdateEvent.const_136:
               if(!this.var_192)
               {
                  this.getOwnCharacterInfo();
               }
               break;
            case RoomWidgetRoomObjectUpdateEvent.const_186:
               _loc6_ = param1 as RoomWidgetRoomObjectUpdateEvent;
               if(this._view && this._view.roomIndex == _loc6_.id)
               {
                  this.disposeView();
               }
               break;
            case RoomWidgetRoomEngineUpdateEvent.const_99:
               this.var_1888 = false;
               break;
            case RoomWidgetRoomEngineUpdateEvent.const_396:
               this.var_1888 = true;
         }
         this.checkUpdateNeed();
      }
      
      private function updateView(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:AvatarInfoData) : void
      {
         this.var_983 = false;
         if(this.var_1206.running)
         {
            this.var_1206.stop();
         }
         var _loc7_:Boolean = param6 != null && this.var_2622;
         if(_loc7_ && !(this._view is AvatarMenuView))
         {
            this.disposeView();
         }
         if(this._view == null || this._view.userId != param1 || this._view.userName != param2 || this._view.roomIndex != param3 || this._view.userType != param4 || param5)
         {
            if(this._view)
            {
               this.disposeView();
            }
            if(!this.var_1888)
            {
               if(_loc7_)
               {
                  if(!this.var_782)
                  {
                     this.var_782 = new AvatarMenuView(this);
                  }
                  this._view = this.var_782;
                  AvatarMenuView.setup(this._view as AvatarMenuView,param1,param2,param3,param4,param6);
               }
               else
               {
                  if(!this.var_781)
                  {
                     this.var_781 = new AvatarInfoView(this);
                  }
                  this._view = this.var_781;
                  AvatarInfoView.setup(this._view,param1,param2,param3,param4,param5);
               }
            }
         }
         else if(this._view is AvatarMenuView)
         {
            if(this._view.userName == param2)
            {
               this.disposeView();
            }
         }
      }
      
      public function disposeView() : void
      {
         if(this._view)
         {
            if(this.var_2941)
            {
               this._view.hide();
            }
            else
            {
               this._view.dispose();
               this.var_781 = null;
               this.var_782 = null;
            }
            this._view = null;
            this.var_1493 = true;
            this.var_983 = false;
         }
      }
      
      public function removeView() : void
      {
         if(!this.var_1493)
         {
            this.var_1493 = true;
            this.var_1206.start();
         }
         else if(!this.var_983)
         {
            this.disposeView();
         }
      }
      
      public function checkUpdateNeed() : void
      {
         if(!this.var_21)
         {
            return;
         }
         if(this._view)
         {
            this.var_21.registerUpdateReceiver(this,10);
         }
         else
         {
            this.var_21.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = null;
         if(!this._view)
         {
            return;
         }
         _loc2_ = messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(this._view.userId,this._view.userType)) as RoomWidgetUserLocationUpdateEvent;
         if(!_loc2_)
         {
            return;
         }
         if(this.var_983)
         {
            this.var_1492 += param1;
            this._blend = 1 - this.var_1492 / Number(this.var_2943);
         }
         else
         {
            this._blend = 1;
         }
         if(this._blend <= 0)
         {
            this.disposeView();
            return;
         }
         this._view.update(_loc2_.rectangle,_loc2_.screenLocation,this._blend);
      }
   }
}
