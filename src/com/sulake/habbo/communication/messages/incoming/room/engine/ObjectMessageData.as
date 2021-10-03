package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class ObjectMessageData
   {
       
      
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var var_152:Number = 0;
      
      private var var_151:Number = 0;
      
      private var var_461:int = 0;
      
      private var var_501:int = 0;
      
      private var var_605:int = 0;
      
      private var _type:int = 0;
      
      private var var_2976:String = "";
      
      private var var_1499:int = -1;
      
      private var _state:int = 0;
      
      private var _data:String = "";
      
      private var var_2595:int = 0;
      
      private var var_2658:String = null;
      
      private var var_176:Boolean = false;
      
      public function ObjectMessageData(param1:int)
      {
         super();
         this._id = param1;
      }
      
      public function setReadOnly() : void
      {
         this.var_176 = true;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         if(!this.var_176)
         {
            this._x = param1;
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
      
      public function get dir() : int
      {
         return this.var_461;
      }
      
      public function set dir(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_461 = param1;
         }
      }
      
      public function get sizeX() : int
      {
         return this.var_501;
      }
      
      public function set sizeX(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_501 = param1;
         }
      }
      
      public function get sizeY() : int
      {
         return this.var_605;
      }
      
      public function set sizeY(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_605 = param1;
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
      
      public function get staticClass() : String
      {
         return this.var_2658;
      }
      
      public function set staticClass(param1:String) : void
      {
         if(!this.var_176)
         {
            this.var_2658 = param1;
         }
      }
      
      public function get extra() : int
      {
         return this.var_1499;
      }
      
      public function set extra(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_1499 = param1;
         }
      }
      
      public function get expiryTime() : int
      {
         return this.var_2595;
      }
      
      public function set expiryTime(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_2595 = param1;
         }
      }
   }
}
