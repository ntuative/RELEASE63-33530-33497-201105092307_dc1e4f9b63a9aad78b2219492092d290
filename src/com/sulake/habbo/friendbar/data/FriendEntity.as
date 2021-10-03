package com.sulake.habbo.friendbar.data
{
   public class FriendEntity implements IFriendEntity
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var var_1060:int;
      
      private var var_744:Boolean;
      
      private var var_1791:Boolean;
      
      private var var_692:String;
      
      private var var_1560:int;
      
      private var var_1790:String;
      
      private var var_1731:String;
      
      private var var_1730:String;
      
      public function FriendEntity(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:String, param9:int, param10:String)
      {
         super();
         this._id = param1;
         this._name = param2;
         this.var_1730 = param3;
         this.var_1790 = param4;
         this.var_1060 = param5;
         this.var_744 = param6;
         this.var_1791 = param7;
         this.var_692 = param8;
         this.var_1560 = param9;
         this.var_1731 = param10;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get gender() : int
      {
         return this.var_1060;
      }
      
      public function get online() : Boolean
      {
         return this.var_744;
      }
      
      public function get allowFollow() : Boolean
      {
         return this.var_1791;
      }
      
      public function get figure() : String
      {
         return this.var_692;
      }
      
      public function get categoryId() : int
      {
         return this.var_1560;
      }
      
      public function get motto() : String
      {
         return this.var_1790;
      }
      
      public function get lastAccess() : String
      {
         return this.var_1731;
      }
      
      public function get realName() : String
      {
         return this.var_1730;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function set gender(param1:int) : void
      {
         this.var_1060 = param1;
      }
      
      public function set online(param1:Boolean) : void
      {
         this.var_744 = param1;
      }
      
      public function set allowFollow(param1:Boolean) : void
      {
         this.var_1791 = param1;
      }
      
      public function set figure(param1:String) : void
      {
         this.var_692 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         this.var_1560 = param1;
      }
      
      public function set motto(param1:String) : void
      {
         this.var_1790 = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         this.var_1731 = param1;
      }
      
      public function set realName(param1:String) : void
      {
         this.var_1730 = param1;
      }
   }
}
