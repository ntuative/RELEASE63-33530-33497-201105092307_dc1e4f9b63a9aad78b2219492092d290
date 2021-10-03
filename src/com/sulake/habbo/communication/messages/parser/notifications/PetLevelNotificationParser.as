package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetLevelNotificationParser implements IMessageParser
   {
       
      
      private var var_1765:int;
      
      private var var_2171:String;
      
      private var var_1437:int;
      
      private var var_1209:int;
      
      private var var_1844:int;
      
      private var _color:String;
      
      public function PetLevelNotificationParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1765 = param1.readInteger();
         this.var_2171 = param1.readString();
         this.var_1437 = param1.readInteger();
         this.var_1209 = param1.readInteger();
         this.var_1844 = param1.readInteger();
         this._color = param1.readString();
         return true;
      }
      
      public function get petId() : int
      {
         return this.var_1765;
      }
      
      public function get petName() : String
      {
         return this.var_2171;
      }
      
      public function get level() : int
      {
         return this.var_1437;
      }
      
      public function get petType() : int
      {
         return this.var_1209;
      }
      
      public function get breed() : int
      {
         return this.var_1844;
      }
      
      public function get color() : String
      {
         return this._color;
      }
   }
}
