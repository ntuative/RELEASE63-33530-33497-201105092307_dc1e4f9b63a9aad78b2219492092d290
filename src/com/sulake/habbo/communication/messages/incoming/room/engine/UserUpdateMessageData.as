package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserUpdateMessageData
   {
       
      
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var var_152:Number = 0;
      
      private var var_151:Number = 0;
      
      private var var_2616:Number = 0;
      
      private var var_2617:Number = 0;
      
      private var var_2620:Number = 0;
      
      private var var_2618:Number = 0;
      
      private var var_461:int = 0;
      
      private var var_2262:int = 0;
      
      private var var_334:Array;
      
      private var var_2619:Boolean = false;
      
      public function UserUpdateMessageData(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Array)
      {
         this.var_334 = [];
         super();
         this._id = param1;
         this._x = param2;
         this.var_152 = param3;
         this.var_151 = param4;
         this.var_2616 = param5;
         this.var_461 = param6;
         this.var_2262 = param7;
         this.var_2617 = param8;
         this.var_2620 = param9;
         this.var_2618 = param10;
         this.var_2619 = param11;
         this.var_334 = param12;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this.var_152;
      }
      
      public function get z() : Number
      {
         return this.var_151;
      }
      
      public function get localZ() : Number
      {
         return this.var_2616;
      }
      
      public function get targetX() : Number
      {
         return this.var_2617;
      }
      
      public function get targetY() : Number
      {
         return this.var_2620;
      }
      
      public function get targetZ() : Number
      {
         return this.var_2618;
      }
      
      public function get dir() : int
      {
         return this.var_461;
      }
      
      public function get dirHead() : int
      {
         return this.var_2262;
      }
      
      public function get isMoving() : Boolean
      {
         return this.var_2619;
      }
      
      public function get actions() : Array
      {
         return this.var_334.slice();
      }
   }
}
