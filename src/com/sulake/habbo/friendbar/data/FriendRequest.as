package com.sulake.habbo.friendbar.data
{
   public class FriendRequest
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      public function FriendRequest(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}
