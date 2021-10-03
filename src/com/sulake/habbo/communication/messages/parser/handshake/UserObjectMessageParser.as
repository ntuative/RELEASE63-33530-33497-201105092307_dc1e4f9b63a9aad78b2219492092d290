package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class UserObjectMessageParser implements IMessageParser
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var var_692:String;
      
      private var var_919:String;
      
      private var var_2499:String;
      
      private var var_1730:String;
      
      private var var_2497:int;
      
      private var var_2495:String;
      
      private var var_2496:int;
      
      private var var_2500:int;
      
      private var var_2498:int;
      
      private var _respectLeft:int;
      
      private var var_730:int;
      
      private var var_2307:int;
      
      public function UserObjectMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._id = int(param1.readString());
         this._name = param1.readString();
         this.var_692 = param1.readString();
         this.var_919 = param1.readString();
         this.var_2499 = param1.readString();
         this.var_1730 = param1.readString();
         this.var_2497 = param1.readInteger();
         this.var_2495 = param1.readString();
         this.var_2496 = param1.readInteger();
         this.var_2500 = param1.readInteger();
         this.var_2498 = param1.readInteger();
         this._respectLeft = param1.readInteger();
         this.var_730 = param1.readInteger();
         this.var_2307 = param1.readInteger();
         return true;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get figure() : String
      {
         return this.var_692;
      }
      
      public function get sex() : String
      {
         return this.var_919;
      }
      
      public function get customData() : String
      {
         return this.var_2499;
      }
      
      public function get realName() : String
      {
         return this.var_1730;
      }
      
      public function get tickets() : int
      {
         return this.var_2497;
      }
      
      public function get poolFigure() : String
      {
         return this.var_2495;
      }
      
      public function get photoFilm() : int
      {
         return this.var_2496;
      }
      
      public function get directMail() : int
      {
         return this.var_2500;
      }
      
      public function get respectTotal() : int
      {
         return this.var_2498;
      }
      
      public function get respectLeft() : int
      {
         return this._respectLeft;
      }
      
      public function get petRespectLeft() : int
      {
         return this.var_730;
      }
      
      public function get identityId() : int
      {
         return this.var_2307;
      }
   }
}
