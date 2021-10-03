package com.sulake.habbo.communication.messages.parser.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
   
   public class WardrobeMessageParser implements IMessageParser
   {
       
      
      private var _state:int;
      
      private var var_2038:Array;
      
      public function WardrobeMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this._state = 0;
         this.var_2038 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:* = null;
         this._state = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new OutfitData(param1);
            this.var_2038.push(_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function get outfits() : Array
      {
         return this.var_2038;
      }
      
      public function get state() : int
      {
         return this._state;
      }
   }
}
