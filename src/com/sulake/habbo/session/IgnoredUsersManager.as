package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;
   
   public class IgnoredUsersManager
   {
       
      
      private var var_30:SessionDataManager;
      
      private var _ignoredUsers:Array;
      
      private var var_1507:Array;
      
      public function IgnoredUsersManager(param1:SessionDataManager)
      {
         this._ignoredUsers = [];
         this.var_1507 = [];
         super();
         this.var_30 = param1;
      }
      
      public function dispose() : void
      {
         this.var_30 = null;
      }
      
      public function registerMessageEvents() : void
      {
         var _loc1_:IConnection = this.var_30.communication.getHabboMainConnection(null);
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.addMessageEvent(new IgnoreResultMessageEvent(this.onIgnoreResult));
         _loc1_.addMessageEvent(new IgnoredUsersMessageEvent(this.onIgnoreList));
      }
      
      public function initIgnoreList() : void
      {
         var _loc1_:IConnection = this.var_30.communication.getHabboMainConnection(null);
         _loc1_.send(new GetIgnoredUsersMessageComposer(this.var_30.userName));
      }
      
      private function onIgnoreList(param1:IMessageEvent) : void
      {
         var _loc2_:IgnoredUsersMessageEvent = param1 as IgnoredUsersMessageEvent;
         this._ignoredUsers = _loc2_.ignoredUsers;
      }
      
      private function onIgnoreResult(param1:IMessageEvent) : void
      {
         var _loc2_:IgnoreResultMessageEvent = param1 as IgnoreResultMessageEvent;
         var _loc3_:String = String(this.var_1507.shift());
         switch(_loc2_.result)
         {
            case 0:
               break;
            case 1:
               this.addUserToIgnoreList(_loc3_);
               break;
            case 2:
               this.addUserToIgnoreList(_loc3_);
               this._ignoredUsers.shift();
               break;
            case 3:
               this.removeUserFromIgnoreList(_loc3_);
         }
      }
      
      private function addUserToIgnoreList(param1:String) : void
      {
         if(this._ignoredUsers.indexOf(param1) < 0)
         {
            this._ignoredUsers.push(param1);
         }
      }
      
      private function removeUserFromIgnoreList(param1:String) : void
      {
         var _loc2_:int = this._ignoredUsers.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this._ignoredUsers.splice(_loc2_,1);
         }
      }
      
      public function ignoreUser(param1:String) : void
      {
         this.var_1507.push(param1);
         var _loc2_:IConnection = this.var_30.communication.getHabboMainConnection(null);
         _loc2_.send(new IgnoreUserMessageComposer(param1));
      }
      
      public function unignoreUser(param1:String) : void
      {
         this.var_1507.push(param1);
         var _loc2_:IConnection = this.var_30.communication.getHabboMainConnection(null);
         _loc2_.send(new UnignoreUserMessageComposer(param1));
      }
      
      public function isIgnored(param1:String) : Boolean
      {
         return this._ignoredUsers.indexOf(param1) >= 0;
      }
   }
}
