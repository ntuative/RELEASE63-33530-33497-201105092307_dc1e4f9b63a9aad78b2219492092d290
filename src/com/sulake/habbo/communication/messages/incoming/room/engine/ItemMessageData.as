package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class ItemMessageData
   {
       
      
      private var _id:int = 0;
      
      private var var_2757:Boolean = false;
      
      private var var_2756:int = 0;
      
      private var var_2755:int = 0;
      
      private var var_2207:int = 0;
      
      private var var_2210:int = 0;
      
      private var var_152:Number = 0;
      
      private var var_151:Number = 0;
      
      private var var_461:String = "";
      
      private var _type:int = 0;
      
      private var var_2976:String = "";
      
      private var var_1499:int = 0;
      
      private var _state:int = 0;
      
      private var _data:String = "";
      
      private var var_176:Boolean = false;
      
      public function ItemMessageData(param1:int, param2:int, param3:Boolean)
      {
         super();
         this._id = param1;
         this._type = param2;
         this.var_2757 = param3;
      }
      
      public function setReadOnly() : void
      {
         this.var_176 = true;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get isOldFormat() : Boolean
      {
         return this.var_2757;
      }
      
      public function get wallX() : Number
      {
         return this.var_2756;
      }
      
      public function set wallX(param1:Number) : void
      {
         if(!this.var_176)
         {
            this.var_2756 = param1;
         }
      }
      
      public function get wallY() : Number
      {
         return this.var_2755;
      }
      
      public function set wallY(param1:Number) : void
      {
         if(!this.var_176)
         {
            this.var_2755 = param1;
         }
      }
      
      public function get localX() : Number
      {
         return this.var_2207;
      }
      
      public function set localX(param1:Number) : void
      {
         if(!this.var_176)
         {
            this.var_2207 = param1;
         }
      }
      
      public function get localY() : Number
      {
         return this.var_2210;
      }
      
      public function set localY(param1:Number) : void
      {
         if(!this.var_176)
         {
            this.var_2210 = param1;
         }
      }
      
      public function get y() : Number
      {
         return this.var_152;
      }
      
      public function set y(param1:Number) : void
      {
         if(!this.var_176)
         {
            this.var_152 = param1;
         }
      }
      
      public function get z() : Number
      {
         return this.var_151;
      }
      
      public function set z(param1:Number) : void
      {
         if(!this.var_176)
         {
            this.var_151 = param1;
         }
      }
      
      public function get dir() : String
      {
         return this.var_461;
      }
      
      public function set dir(param1:String) : void
      {
         if(!this.var_176)
         {
            this.var_461 = param1;
         }
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(param1:int) : void
      {
         if(!this.var_176)
         {
            this._type = param1;
         }
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         if(!this.var_176)
         {
            this._state = param1;
         }
      }
      
      public function get data() : String
      {
         return this._data;
      }
      
      public function set data(param1:String) : void
      {
         if(!this.var_176)
         {
            this._data = param1;
         }
      }
   }
}
