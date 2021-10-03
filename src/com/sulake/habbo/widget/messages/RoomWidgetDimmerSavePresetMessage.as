package com.sulake.habbo.widget.messages
{
   public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage
   {
      
      public static const const_880:String = "RWSDPM_SAVE_PRESET";
       
      
      private var var_2184:int;
      
      private var var_2185:int;
      
      private var _color:uint;
      
      private var var_1226:int;
      
      private var var_2186:Boolean;
      
      public function RoomWidgetDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean)
      {
         super(const_880);
         this.var_2184 = param1;
         this.var_2185 = param2;
         this._color = param3;
         this.var_1226 = param4;
         this.var_2186 = param5;
      }
      
      public function get presetNumber() : int
      {
         return this.var_2184;
      }
      
      public function get effectTypeId() : int
      {
         return this.var_2185;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function get brightness() : int
      {
         return this.var_1226;
      }
      
      public function get apply() : Boolean
      {
         return this.var_2186;
      }
   }
}
