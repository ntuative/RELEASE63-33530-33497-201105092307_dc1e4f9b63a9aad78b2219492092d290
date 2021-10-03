package com.sulake.room.events
{
   public class RoomSpriteMouseEvent
   {
       
      
      private var _type:String = "";
      
      private var var_2003:String = "";
      
      private var var_1676:String = "";
      
      private var var_2211:String = "";
      
      private var var_2212:Number = 0;
      
      private var var_2205:Number = 0;
      
      private var var_2207:Number = 0;
      
      private var var_2210:Number = 0;
      
      private var var_2208:Boolean = false;
      
      private var var_2209:Boolean = false;
      
      private var var_2213:Boolean = false;
      
      private var var_2206:Boolean = false;
      
      public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:Number, param7:Number = 0, param8:Number = 0, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false)
      {
         super();
         this._type = param1;
         this.var_2003 = param2;
         this.var_1676 = param3;
         this.var_2211 = param4;
         this.var_2212 = param5;
         this.var_2205 = param6;
         this.var_2207 = param7;
         this.var_2210 = param8;
         this.var_2208 = param9;
         this.var_2209 = param10;
         this.var_2213 = param11;
         this.var_2206 = param12;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get eventId() : String
      {
         return this.var_2003;
      }
      
      public function get canvasId() : String
      {
         return this.var_1676;
      }
      
      public function get spriteTag() : String
      {
         return this.var_2211;
      }
      
      public function get screenX() : Number
      {
         return this.var_2212;
      }
      
      public function get screenY() : Number
      {
         return this.var_2205;
      }
      
      public function get localX() : Number
      {
         return this.var_2207;
      }
      
      public function get localY() : Number
      {
         return this.var_2210;
      }
      
      public function get ctrlKey() : Boolean
      {
         return this.var_2208;
      }
      
      public function get altKey() : Boolean
      {
         return this.var_2209;
      }
      
      public function get shiftKey() : Boolean
      {
         return this.var_2213;
      }
      
      public function get buttonDown() : Boolean
      {
         return this.var_2206;
      }
   }
}
