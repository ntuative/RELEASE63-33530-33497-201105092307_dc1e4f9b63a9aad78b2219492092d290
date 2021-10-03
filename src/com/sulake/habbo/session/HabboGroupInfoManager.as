package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class HabboGroupInfoManager
   {
       
      
      private var _sessionManager:SessionDataManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _events:IEventDispatcher;
      
      private var var_186:Map;
      
      private var var_245:Map;
      
      private var var_1431:Dictionary;
      
      public function HabboGroupInfoManager(param1:SessionDataManager, param2:IEventDispatcher)
      {
         this.var_1431 = new Dictionary();
         super();
         this._sessionManager = param1;
         this.var_245 = new Map();
         this.var_186 = new Map();
         this._events = param2;
      }
      
      public function dispose() : void
      {
         this._communication = null;
         this.var_1431 = null;
      }
      
      public function set communication(param1:IHabboCommunicationManager) : void
      {
         this._communication = param1;
         this._communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(this.onRoomReady) as IMessageEvent);
         this._communication.addHabboConnectionMessageEvent(new HabboGroupBadgesMessageEvent(this.onHabboGroupBadges));
         this._communication.addHabboConnectionMessageEvent(new HabboGroupDetailsMessageEvent(this.onGroupDetails));
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         this._communication.getHabboMainConnection(null).send(new GetHabboGroupBadgesMessageComposer());
      }
      
      private function onHabboGroupBadges(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:HabboGroupBadgesMessageEvent = param1 as HabboGroupBadgesMessageEvent;
         var _loc3_:Map = _loc2_.badges;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc4_ = _loc3_.getKey(_loc6_);
            if(this.var_245.getValue(_loc4_) != null)
            {
               this.var_245.remove(_loc4_);
            }
            this.var_245.add(_loc4_,_loc3_.getWithIndex(_loc6_));
            _loc6_++;
         }
      }
      
      private function onGroupDetails(param1:IMessageEvent) : void
      {
         var _loc2_:HabboGroupDetailsMessageEvent = param1 as HabboGroupDetailsMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:HabboGroupDetails = new HabboGroupDetails(_loc2_.groupId);
         _loc3_.name = _loc2_.name;
         _loc3_.description = _loc2_.description;
         _loc3_.roomId = _loc2_.roomId;
         _loc3_.roomName = _loc2_.roomName;
         _loc3_.badgeId = this.var_245.getValue(_loc2_.groupId);
         this.var_1431[_loc2_.groupId] = _loc3_;
         this._sessionManager.showGroupBadgeInfo(_loc2_.groupId);
      }
      
      public function getBadgeId(param1:int) : String
      {
         return this.var_245.getValue(param1);
      }
      
      public function getGroupDetails(param1:int) : HabboGroupDetails
      {
         var _loc2_:HabboGroupDetails = this.var_1431[param1];
         if(_loc2_ == null)
         {
            this._communication.getHabboMainConnection(null).send(new GetHabboGroupDetailsMessageComposer(param1));
         }
         return _loc2_;
      }
   }
}
