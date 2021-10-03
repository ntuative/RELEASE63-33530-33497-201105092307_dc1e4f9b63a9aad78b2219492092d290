package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FriendData
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var var_1060:int;
      
      private var var_744:Boolean;
      
      private var var_1898:Boolean;
      
      private var var_692:String;
      
      private var var_1560:int;
      
      private var var_1790:String;
      
      private var var_1731:String;
      
      private var var_1730:String;
      
      private var var_2453:String;
      
      public function FriendData(param1:IMessageDataWrapper)
      {
         super();
         this._id = param1.readInteger();
         this._name = param1.readString();
         this.var_1060 = param1.readInteger();
         this.var_744 = param1.readBoolean();
         this.var_1898 = param1.readBoolean();
         this.var_692 = param1.readString();
         this.var_1560 = param1.readInteger();
         this.var_1790 = param1.readString();
         this.var_1731 = param1.readString();
         this.var_1730 = param1.readString();
         this.var_2453 = param1.readString();
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
      
      public function get followingAllowed() : Boolean
      {
         return this.var_1898;
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
      
      public function get facebookId() : String
      {
         return this.var_2453;
      }
   }
}
