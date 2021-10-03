package com.sulake.habbo.messenger.domain
{
   public class Message
   {
      
      public static const const_813:int = 1;
      
      public static const const_737:int = 2;
      
      public static const const_817:int = 3;
      
      public static const const_1110:int = 4;
      
      public static const const_903:int = 5;
      
      public static const const_1139:int = 6;
       
      
      private var _type:int;
      
      private var var_1198:int;
      
      private var var_2355:String;
      
      private var var_2356:String;
      
      public function Message(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         this._type = param1;
         this.var_1198 = param2;
         this.var_2355 = param3;
         this.var_2356 = param4;
      }
      
      public function get messageText() : String
      {
         return this.var_2355;
      }
      
      public function get time() : String
      {
         return this.var_2356;
      }
      
      public function get senderId() : int
      {
         return this.var_1198;
      }
      
      public function get type() : int
      {
         return this._type;
      }
   }
}
