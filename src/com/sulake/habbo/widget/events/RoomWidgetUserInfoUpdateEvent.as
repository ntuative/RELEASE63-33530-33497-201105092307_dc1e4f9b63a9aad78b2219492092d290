package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_126:String = "RWUIUE_OWN_USER";
      
      public static const BOT:String = "RWUIUE_BOT";
      
      public static const const_112:String = "RWUIUE_PEER";
      
      public static const TRADE_REASON_OK:int = 0;
      
      public static const const_888:int = 2;
      
      public static const const_686:int = 3;
      
      public static const const_1650:String = "BOT";
       
      
      private var _name:String = "";
      
      private var var_1790:String = "";
      
      private var var_2269:int;
      
      private var var_2271:int = 0;
      
      private var var_2266:int = 0;
      
      private var var_692:String = "";
      
      private var var_46:BitmapData = null;
      
      private var var_245:Array;
      
      private var var_1582:int = 0;
      
      private var var_2602:String = "";
      
      private var var_2604:int = 0;
      
      private var var_2603:int = 0;
      
      private var var_1673:Boolean = false;
      
      private var var_1730:String = "";
      
      private var var_2637:Boolean = false;
      
      private var var_2633:Boolean = true;
      
      private var _respectLeft:int = 0;
      
      private var var_2632:Boolean = false;
      
      private var var_2639:Boolean = false;
      
      private var var_2634:Boolean = false;
      
      private var var_2636:Boolean = false;
      
      private var var_2638:Boolean = false;
      
      private var var_2640:Boolean = false;
      
      private var var_2635:int = 0;
      
      private var var_1672:Boolean = false;
      
      public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         this.var_245 = [];
         super(param1,param2,param3);
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set motto(param1:String) : void
      {
         this.var_1790 = param1;
      }
      
      public function get motto() : String
      {
         return this.var_1790;
      }
      
      public function set achievementScore(param1:int) : void
      {
         this.var_2269 = param1;
      }
      
      public function get achievementScore() : int
      {
         return this.var_2269;
      }
      
      public function set webID(param1:int) : void
      {
         this.var_2271 = param1;
      }
      
      public function get webID() : int
      {
         return this.var_2271;
      }
      
      public function set xp(param1:int) : void
      {
         this.var_2266 = param1;
      }
      
      public function get xp() : int
      {
         return this.var_2266;
      }
      
      public function set figure(param1:String) : void
      {
         this.var_692 = param1;
      }
      
      public function get figure() : String
      {
         return this.var_692;
      }
      
      public function set image(param1:BitmapData) : void
      {
         this.var_46 = param1;
      }
      
      public function get image() : BitmapData
      {
         return this.var_46;
      }
      
      public function set badges(param1:Array) : void
      {
         this.var_245 = param1;
      }
      
      public function get badges() : Array
      {
         return this.var_245;
      }
      
      public function set groupId(param1:int) : void
      {
         this.var_1582 = param1;
      }
      
      public function get groupId() : int
      {
         return this.var_1582;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         this.var_2602 = param1;
      }
      
      public function get groupBadgeId() : String
      {
         return this.var_2602;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         this.var_2637 = param1;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return this.var_2637;
      }
      
      public function set respectLeft(param1:int) : void
      {
         this._respectLeft = param1;
      }
      
      public function get respectLeft() : int
      {
         return this._respectLeft;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         this.var_2632 = param1;
      }
      
      public function get isIgnored() : Boolean
      {
         return this.var_2632;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         this.var_2639 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return this.var_2639;
      }
      
      public function set amIController(param1:Boolean) : void
      {
         this.var_2634 = param1;
      }
      
      public function get amIController() : Boolean
      {
         return this.var_2634;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         this.var_2636 = param1;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return this.var_2636;
      }
      
      public function set hasFlatControl(param1:Boolean) : void
      {
         this.var_2638 = param1;
      }
      
      public function get hasFlatControl() : Boolean
      {
         return this.var_2638;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         this.var_2640 = param1;
      }
      
      public function get canTrade() : Boolean
      {
         return this.var_2640;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         this.var_2635 = param1;
      }
      
      public function get canTradeReason() : int
      {
         return this.var_2635;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         this.var_2633 = param1;
      }
      
      public function get canBeKicked() : Boolean
      {
         return this.var_2633;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         this.var_1672 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return this.var_1672;
      }
      
      public function set carryItem(param1:int) : void
      {
         this.var_2604 = param1;
      }
      
      public function get carryItem() : int
      {
         return this.var_2604;
      }
      
      public function set userRoomId(param1:int) : void
      {
         this.var_2603 = param1;
      }
      
      public function get userRoomId() : int
      {
         return this.var_2603;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         this.var_1673 = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return this.var_1673;
      }
      
      public function set realName(param1:String) : void
      {
         this.var_1730 = param1;
      }
      
      public function get realName() : String
      {
         return this.var_1730;
      }
   }
}
