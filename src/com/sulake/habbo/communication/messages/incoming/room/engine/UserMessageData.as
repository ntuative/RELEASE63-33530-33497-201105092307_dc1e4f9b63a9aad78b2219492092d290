package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserMessageData
   {
      
      public static const const_1329:String = "M";
      
      public static const const_1804:String = "F";
       
      
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var var_152:Number = 0;
      
      private var var_151:Number = 0;
      
      private var var_461:int = 0;
      
      private var _name:String = "";
      
      private var var_1600:int = 0;
      
      private var var_919:String = "";
      
      private var var_692:String = "";
      
      private var var_2270:String = "";
      
      private var var_2269:int;
      
      private var var_2271:int = 0;
      
      private var var_2267:String = "";
      
      private var var_2268:int = 0;
      
      private var var_2266:int = 0;
      
      private var var_2265:String = "";
      
      private var var_176:Boolean = false;
      
      public function UserMessageData(param1:int)
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
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         if(!this.var_176)
         {
            this._name = param1;
         }
      }
      
      public function get userType() : int
      {
         return this.var_1600;
      }
      
      public function set userType(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_1600 = param1;
         }
      }
      
      public function get sex() : String
      {
         return this.var_919;
      }
      
      public function set sex(param1:String) : void
      {
         if(!this.var_176)
         {
            this.var_919 = param1;
         }
      }
      
      public function get figure() : String
      {
         return this.var_692;
      }
      
      public function set figure(param1:String) : void
      {
         if(!this.var_176)
         {
            this.var_692 = param1;
         }
      }
      
      public function get custom() : String
      {
         return this.var_2270;
      }
      
      public function set custom(param1:String) : void
      {
         if(!this.var_176)
         {
            this.var_2270 = param1;
         }
      }
      
      public function get achievementScore() : int
      {
         return this.var_2269;
      }
      
      public function set achievementScore(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_2269 = param1;
         }
      }
      
      public function get webID() : int
      {
         return this.var_2271;
      }
      
      public function set webID(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_2271 = param1;
         }
      }
      
      public function get groupID() : String
      {
         return this.var_2267;
      }
      
      public function set groupID(param1:String) : void
      {
         if(!this.var_176)
         {
            this.var_2267 = param1;
         }
      }
      
      public function get groupStatus() : int
      {
         return this.var_2268;
      }
      
      public function set groupStatus(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_2268 = param1;
         }
      }
      
      public function get xp() : int
      {
         return this.var_2266;
      }
      
      public function set xp(param1:int) : void
      {
         if(!this.var_176)
         {
            this.var_2266 = param1;
         }
      }
      
      public function get subType() : String
      {
         return this.var_2265;
      }
      
      public function set subType(param1:String) : void
      {
         if(!this.var_176)
         {
            this.var_2265 = param1;
         }
      }
   }
}
