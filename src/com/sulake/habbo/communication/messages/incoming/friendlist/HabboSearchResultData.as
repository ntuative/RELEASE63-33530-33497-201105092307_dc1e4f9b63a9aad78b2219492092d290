package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HabboSearchResultData
   {
       
      
      private var var_2237:int;
      
      private var var_1729:String;
      
      private var var_2236:String;
      
      private var var_2240:Boolean;
      
      private var var_2239:Boolean;
      
      private var var_2238:int;
      
      private var var_2234:String;
      
      private var var_2235:String;
      
      private var var_1730:String;
      
      public function HabboSearchResultData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2237 = param1.readInteger();
         this.var_1729 = param1.readString();
         this.var_2236 = param1.readString();
         this.var_2240 = param1.readBoolean();
         this.var_2239 = param1.readBoolean();
         param1.readString();
         this.var_2238 = param1.readInteger();
         this.var_2234 = param1.readString();
         this.var_2235 = param1.readString();
         this.var_1730 = param1.readString();
      }
      
      public function get avatarId() : int
      {
         return this.var_2237;
      }
      
      public function get avatarName() : String
      {
         return this.var_1729;
      }
      
      public function get avatarMotto() : String
      {
         return this.var_2236;
      }
      
      public function get isAvatarOnline() : Boolean
      {
         return this.var_2240;
      }
      
      public function get canFollow() : Boolean
      {
         return this.var_2239;
      }
      
      public function get avatarGender() : int
      {
         return this.var_2238;
      }
      
      public function get avatarFigure() : String
      {
         return this.var_2234;
      }
      
      public function get lastOnlineDate() : String
      {
         return this.var_2235;
      }
      
      public function get realName() : String
      {
         return this.var_1730;
      }
   }
}
