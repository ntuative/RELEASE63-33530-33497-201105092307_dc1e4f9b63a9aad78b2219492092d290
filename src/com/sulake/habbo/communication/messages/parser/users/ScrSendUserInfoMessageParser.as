package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ScrSendUserInfoMessageParser implements IMessageParser
   {
      
      public static const const_2123:int = 1;
      
      public static const const_1704:int = 2;
       
      
      private var var_1048:String;
      
      private var var_2885:int;
      
      private var var_2889:int;
      
      private var var_2884:int;
      
      private var var_2890:int;
      
      private var var_2888:Boolean;
      
      private var var_2350:Boolean;
      
      private var var_2482:int;
      
      private var var_2483:int;
      
      private var var_2886:Boolean;
      
      private var var_2891:int;
      
      private var var_2887:int;
      
      public function ScrSendUserInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1048 = param1.readString();
         this.var_2885 = param1.readInteger();
         this.var_2889 = param1.readInteger();
         this.var_2884 = param1.readInteger();
         this.var_2890 = param1.readInteger();
         this.var_2888 = param1.readBoolean();
         this.var_2350 = param1.readBoolean();
         this.var_2482 = param1.readInteger();
         this.var_2483 = param1.readInteger();
         this.var_2886 = param1.readBoolean();
         this.var_2891 = param1.readInteger();
         this.var_2887 = param1.readInteger();
         return true;
      }
      
      public function get productName() : String
      {
         return this.var_1048;
      }
      
      public function get daysToPeriodEnd() : int
      {
         return this.var_2885;
      }
      
      public function get memberPeriods() : int
      {
         return this.var_2889;
      }
      
      public function get periodsSubscribedAhead() : int
      {
         return this.var_2884;
      }
      
      public function get responseType() : int
      {
         return this.var_2890;
      }
      
      public function get hasEverBeenMember() : Boolean
      {
         return this.var_2888;
      }
      
      public function get isVIP() : Boolean
      {
         return this.var_2350;
      }
      
      public function get pastClubDays() : int
      {
         return this.var_2482;
      }
      
      public function get pastVipDays() : int
      {
         return this.var_2483;
      }
      
      public function get isShowBasicPromo() : Boolean
      {
         return this.var_2886;
      }
      
      public function get basicNormalPrice() : int
      {
         return this.var_2891;
      }
      
      public function get basicPromoPrice() : int
      {
         return this.var_2887;
      }
   }
}
