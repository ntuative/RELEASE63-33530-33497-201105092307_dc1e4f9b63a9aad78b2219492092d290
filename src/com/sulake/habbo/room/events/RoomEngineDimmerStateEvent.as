package com.sulake.habbo.room.events
{
   public class RoomEngineDimmerStateEvent extends RoomEngineEvent
   {
      
      public static const const_67:String = "REDSE_ROOM_COLOR";
       
      
      private var _state:int;
      
      private var var_2751:int;
      
      private var var_1225:int;
      
      private var _color:uint;
      
      private var var_1226:int;
      
      public function RoomEngineDimmerStateEvent(param1:int, param2:int, param3:int, param4:int, param5:int, param6:uint, param7:uint, param8:Boolean = false, param9:Boolean = false)
      {
         super(const_67,param1,param2,param8,param9);
         this._state = param3;
         this.var_2751 = param4;
         this.var_1225 = param5;
         this._color = param6;
         this.var_1226 = param7;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function get presetId() : int
      {
         return this.var_2751;
      }
      
      public function get effectId() : int
      {
         return this.var_1225;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function get brightness() : uint
      {
         return this.var_1226;
      }
   }
}
