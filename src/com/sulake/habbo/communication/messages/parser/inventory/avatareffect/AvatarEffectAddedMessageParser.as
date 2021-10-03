package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class AvatarEffectAddedMessageParser implements IMessageParser
   {
       
      
      private var _type:int;
      
      private var var_1836:int;
      
      public function AvatarEffectAddedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this._type = 0;
         this.var_1836 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._type = param1.readInteger();
         this.var_1836 = param1.readInteger();
         return true;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get duration() : int
      {
         return this.var_1836;
      }
   }
}
