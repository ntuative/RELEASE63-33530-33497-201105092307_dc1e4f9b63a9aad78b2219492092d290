package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   public class RoomSettingsData
   {
      
      public static const const_491:int = 0;
      
      public static const const_217:int = 1;
      
      public static const const_124:int = 2;
      
      public static const const_783:Array = ["open","closed","password"];
       
      
      private var _roomId:int;
      
      private var _name:String;
      
      private var var_1700:String;
      
      private var var_2153:int;
      
      private var var_1560:int;
      
      private var var_2152:int;
      
      private var var_2169:int;
      
      private var var_860:Array;
      
      private var var_2156:Array;
      
      private var var_2170:int;
      
      private var var_2148:Boolean;
      
      private var var_2151:Boolean;
      
      private var var_2150:Boolean;
      
      private var var_2155:Boolean;
      
      public function RoomSettingsData()
      {
         super();
      }
      
      public function get allowPets() : Boolean
      {
         return this.var_2148;
      }
      
      public function set allowPets(param1:Boolean) : void
      {
         this.var_2148 = param1;
      }
      
      public function get allowFoodConsume() : Boolean
      {
         return this.var_2151;
      }
      
      public function set allowFoodConsume(param1:Boolean) : void
      {
         this.var_2151 = param1;
      }
      
      public function get allowWalkThrough() : Boolean
      {
         return this.var_2150;
      }
      
      public function set allowWalkThrough(param1:Boolean) : void
      {
         this.var_2150 = param1;
      }
      
      public function get hideWalls() : Boolean
      {
         return this.var_2155;
      }
      
      public function set hideWalls(param1:Boolean) : void
      {
         this.var_2155 = param1;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function set roomId(param1:int) : void
      {
         this._roomId = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get description() : String
      {
         return this.var_1700;
      }
      
      public function set description(param1:String) : void
      {
         this.var_1700 = param1;
      }
      
      public function get doorMode() : int
      {
         return this.var_2153;
      }
      
      public function set doorMode(param1:int) : void
      {
         this.var_2153 = param1;
      }
      
      public function get categoryId() : int
      {
         return this.var_1560;
      }
      
      public function set categoryId(param1:int) : void
      {
         this.var_1560 = param1;
      }
      
      public function get maximumVisitors() : int
      {
         return this.var_2152;
      }
      
      public function set maximumVisitors(param1:int) : void
      {
         this.var_2152 = param1;
      }
      
      public function get maximumVisitorsLimit() : int
      {
         return this.var_2169;
      }
      
      public function set maximumVisitorsLimit(param1:int) : void
      {
         this.var_2169 = param1;
      }
      
      public function get tags() : Array
      {
         return this.var_860;
      }
      
      public function set tags(param1:Array) : void
      {
         this.var_860 = param1;
      }
      
      public function get controllers() : Array
      {
         return this.var_2156;
      }
      
      public function set controllers(param1:Array) : void
      {
         this.var_2156 = param1;
      }
      
      public function get controllerCount() : int
      {
         return this.var_2170;
      }
      
      public function set controllerCount(param1:int) : void
      {
         this.var_2170 = param1;
      }
   }
}
